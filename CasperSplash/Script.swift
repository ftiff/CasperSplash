//
//  Script.swift
//  CasperSplash
//
//  Created by testpilotfinal on 04/08/16.
//  Copyright © 2016 François Levaux-Tiffreau. All rights reserved.
//

import Cocoa

class Script {
    let absolutePath: String
    
    init(absolutePath: String) {
        self.absolutePath = absolutePath
    }
    
    func execute(completionHandler: (isSuccessful: Bool) -> ()) {
        
        let taskQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        
        dispatch_async(taskQueue) {
            let task: NSTask = NSTask()
            task.launchPath = "/bin/bash"
            task.arguments = [self.absolutePath]
            task.terminationHandler = { task in dispatch_async(dispatch_get_main_queue(), {
                if task.terminationStatus == 0 {
                    completionHandler(isSuccessful: true)
                } else {
                    completionHandler(isSuccessful: false)
                }
            })
            }
        }
    }
    
}