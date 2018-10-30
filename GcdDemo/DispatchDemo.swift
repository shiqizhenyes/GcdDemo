//
//  DispatchDemo.swift
//  GcdDemo
//
//  Created by zack on 2018/10/30.
//  Copyright © 2018 zack. All rights reserved.
//
class DispatchDemo {
    
    
    init() {
//        DispatchQueue.global(qos:.userInitiated).async {
//            self.printCurrentThread(with:  "我发起的任务")
//        }
//
//        DispatchQueue.global(qos:.default).async {
//            self.printCurrentThread(with:  "我的默认任务")
//        }
//
//        DispatchQueue.global(qos:.background).async {
//            self.printCurrentThread(with:  "我的后台任务")
//        }
//        dispatchGroup = DispatchGroup()
//
//        conCurrent = DispatchQueue.init(label: "测试队列一", qos: .background, attributes: .concurrent)
//
//        conCurrent.async(group: dispatchGroup, execute: DispatchWorkItem.init(block: {
//            self.printCurrentThread(with: "DispatchWorkItem")
//        }))
//
//        qune = DispatchQueue.init(label: "测试队列二", qos: .userInitiated, attributes: .concurrent)
//
//        qune.async(group: dispatchGroup, execute: DispatchWorkItem.init(block: {
//            self.printCurrentThread(with: "测试队列二任务")
//        }))
//
//        serialQune = DispatchQueue.init(label: "测试队列三", qos: .userInitiated)
//        serialQune.sync {
//            printCurrentThread(with: "串行队列同步任务一")
//            //            self.serialQune.sync {
//            ////                串行队列添加串行任务会死锁
//            //                print("串行队列串行任务二")
//            //            }
//            self.serialQune.async {
//                self.printCurrentThread(with:  "串行队列并行任务")
//            }
//        }
//
//        dispatchGroup.notify(queue: conCurrent, work: DispatchWorkItem.init(block: {
//            print("队列组")
//
//        }))
//
//        let workItem = DispatchWorkItem.init(qos: .background, flags: .barrier) {
//            self.printCurrentThread(with: "workItem")
//        }
//
//        serialQune.async(execute: workItem)
//
//        conCurrent.async {
//            self.printCurrentThread(with: "并行队列同步任务")
//
//            self.serialQune.sync {
//                self.printCurrentThread(with: "并行队列内嵌其他队列的同步任务")
//            }
//            self.conCurrent.sync {
//                self.printCurrentThread(with: "并行队列同步任务")
//            }
//            //          并行队列内嵌并行任务 直接在当前线程运行
//            self.conCurrent.async(execute: {
//                self.printCurrentThread(with: "并行队列内嵌异步任务")
//            })
//        }
//
//        serialQune.sync {
//            self.conCurrent.sync {
//                self.printCurrentThread(with: "串行队列内嵌其他队列同步任务3")
//            }
//
//            self.conCurrent.async {
//                self.printCurrentThread(with: "串行队列内嵌其他队列异步任务3")
//            }
//
//            self.conCurrent.sync {
//                self.printCurrentThread(with: "串行队列内嵌其他队列同步任务2")
//            }
//
//            self.conCurrent.async {
//                self.printCurrentThread(with: "串行队列内嵌其他队列异步任务2")
//            }
//
//            self.conCurrent.sync {
//                self.printCurrentThread(with: "串行队列内嵌其他队列同步任务1")
//            }
//
//            self.conCurrent.async {
//                self.printCurrentThread(with: "串行队列内嵌其他队列异步任务1")
//            }
//        }
        
        //        let mainQueue = DispatchQueue.init(label: "主队列")
        //        mainQueue.async {
        //            self.printCurrentThread(with: "主队列")
        //            mainQueue.async(execute: {
        //                self.printCurrentThread(with: "主队列")
        //            })
        //        }
    }
    
    
}
