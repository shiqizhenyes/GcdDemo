//
//  ViewController.swift
//  GcdDemo
//
//  Created by zack on 2018/10/30.
//  Copyright © 2018 zack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var serialQune: DispatchQueue!
    var conCurrentQune: DispatchQueue!
    var mainQune:DispatchQueue!
    var globleQune:DispatchQueue!
    var dispatchGroup:DispatchGroup!
    
    let serialQuneKey = DispatchSpecificKey<String>()
    let conCurrentKey = DispatchSpecificKey<String>()
    let mainQuneKey = DispatchSpecificKey<String>()
    let globleQuneKey = DispatchSpecificKey<String>()
    
    func initQune() {
        
        serialQune.setSpecific(key: serialQuneKey, value: DispatchTaskType.serial.rawValue)
        conCurrentQune.setSpecific(key: conCurrentKey, value: DispatchTaskType.concurrent.rawValue)
        mainQune.setSpecific(key: mainQuneKey, value: DispatchTaskType.main.rawValue)
        globleQune.setSpecific(key: globleQuneKey, value: DispatchTaskType.globle.rawValue)
        
    }
    
    func testIsTaskInQune(_ quneType: DispatchTaskType,_ dispatchKey: DispatchSpecificKey<String>) {
//        var isInTask = false
        let value = DispatchQueue.getSpecific(key: dispatchKey)
        let opnValue: String? = quneType.rawValue
        print("Is task in \(quneType.rawValue) qune:\(value == opnValue)")
//        isInTask = (value == opnValue)
//        return isInTask
    }
    
    func printCurrentThread(with des: String, _ terminator: String = "") {
        print("\(des) at thread: \(Thread.current), this is \(Thread.isMainThread ? "" : "not ")main thread\(terminator)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printCurrentThread(with: "ui")
        serialQune = DispatchQueue.init(label: "mobi.zack.gcdDemo.serialQune")
        conCurrentQune = DispatchQueue.init(label: "mobi.zack.gcdDemo.concurrent", qos: .background, attributes: .concurrent)
        mainQune = DispatchQueue.main
        globleQune = DispatchQueue.global()
        initQune()
//        conCurrentQune.async {
//
//            while true {
//                self.printCurrentThread(with: "conCurrentQune while")
//                Thread.sleep(forTimeInterval: 1.0)
//            }
//        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        testSyncTaskInSerialQune()
        //        testSyncTashNestedInTheSameSerialQune()
        //        testSyncTaskNestedInTheConcurrentQune()
        //        testAsyncTaskNestedInTheConcurrentQune()
        //        testSyncTaskNestedInOtherSerialQune()
//        testAsyncTaskInConcurrentQune()
//        testAsyncTaskInSerialQune()
        testAsyncTashNestedInTheSameSerialQune()
    }
    
    
    /// 串行队列新增同步任务
    func testSyncTaskInSerialQune() {
        self.printCurrentThread(with: "START test")
        self.serialQune.sync {
            self.printCurrentThread(with: "testSyncTaskInSerial")
            self.testIsTaskInQune(.serial, serialQuneKey)
        }
        self.printCurrentThread(with: "END test")
    }
    
    /// 串行队列嵌套本队列的同步任务
    func testSyncTashNestedInTheSameSerialQune() {
        self.printCurrentThread(with: "START test")
        self.serialQune.async {
            self.printCurrentThread(with: "serialQune.sync") //不在主线程
            self.testIsTaskInQune(.serial, self.serialQuneKey)
            self.serialQune.sync {//会死锁
                self.printCurrentThread(with: "testSyncTashNestedInTheSameSerialQune")
                self.testIsTaskInQune(.serial, self.serialQuneKey)
            }
        }
        self.printCurrentThread(with: "END test")
    }
    
    
    /// 并行队列嵌套本队列的同步任务
    func testSyncTaskNestedInTheConcurrentQune() {
        printCurrentThread(with: "\nSTART test")
        conCurrentQune.async {
            self.printCurrentThread(with: "async stask in conCurrentQune")
            self.testIsTaskInQune(.concurrent, self.conCurrentKey)
            self.conCurrentQune.sync {
                self.printCurrentThread(with: "sync stask nested in conCurrentQune")
                self.testIsTaskInQune(.concurrent, self.conCurrentKey)
            }
            
        }
        self.printCurrentThread(with: "\nEND test")
    }
    
    /// 并行队列嵌套本队列的异步任务
    func testAsyncTaskNestedInTheConcurrentQune() {
        printCurrentThread(with: "\nSTART test")
        conCurrentQune.async {
            self.printCurrentThread(with: "async stask in conCurrentQune")
            self.testIsTaskInQune(.concurrent, self.conCurrentKey)
            self.conCurrentQune.async {
                self.printCurrentThread(with: "async stask nested in conCurrentQune")
                self.testIsTaskInQune(.concurrent, self.conCurrentKey)
            }
        }
        self.printCurrentThread(with: "\nEND test")
    }
    
    
    /// 串行队列嵌套其他串行队列同步任务
    func testSyncTaskNestedInOtherSerialQune() {
        printCurrentThread(with: "\nSTART test")
        let otherSerialQune = DispatchQueue.init(label: "mobi.zack.gcdDemo.otherSerialQune")
        let otherSerialQuneKey = DispatchSpecificKey<String>()
        otherSerialQune.setSpecific(key: otherSerialQuneKey, value: DispatchTaskType.serial.rawValue)
        serialQune.async {
            self.printCurrentThread(with: "async task in serialQune")
            self.testIsTaskInQune(.serial, self.serialQuneKey)
            otherSerialQune.sync {
                self.printCurrentThread(with: "sync task nested in serialQune")
                self.testIsTaskInQune(.serial, otherSerialQuneKey)
            }
        }
        printCurrentThread(with: "\nEND test")
    }
    
    /// 并行队列新增异步任务
    func testAsyncTaskInConcurrentQune() {
        printCurrentThread(with: "\nSTART test")
        conCurrentQune.async {
            self.printCurrentThread(with: "async task in conCurrentQune")
            self.testIsTaskInQune(.concurrent, self.conCurrentKey)
        }
        printCurrentThread(with: "\nEND test")
    }
    
    
    /// 串行队列新增异步任务
    func testAsyncTaskInSerialQune() {
        printCurrentThread(with: "\nSTART test")
        serialQune.async {
            self.printCurrentThread(with: "async task in serialQune")
            self.testIsTaskInQune(.serial, self.serialQuneKey)
        }
        printCurrentThread(with: "\nEND test")
    }
    
    
    /// <#Description#>
    func testAsyncTashNestedInTheSameSerialQune() {
        self.printCurrentThread(with: "START test")
        self.serialQune.sync {
            self.printCurrentThread(with: "async task in serialQune") //不在主线程
            self.testIsTaskInQune(.serial, self.serialQuneKey)
            self.serialQune.async {
                self.printCurrentThread(with: "Async task nested in the same serialQune")
                self.testIsTaskInQune(.serial, self.serialQuneKey)
            }
        }
        self.printCurrentThread(with: "END test")
    }
    
    
}

