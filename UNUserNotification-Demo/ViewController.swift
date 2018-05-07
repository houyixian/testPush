//
//  ViewController.swift
//  UNUserNotification-Demo
//
//  Created by 侯逸仙 on 09/04/2018.
//  Copyright © 2018 侯逸仙. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ScheduleLocalNotificaiton(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "侯逸仙"
        content.body = "今天你去哪玩啊？今天你去哪玩啊？今天你去哪玩啊？今天你去哪玩啊？今天你去哪玩啊？今天你去哪玩啊？今天你去哪玩啊？今天你去哪玩啊？今天你去哪玩啊？今天你去哪玩啊？今天你去哪玩啊？"
        //666
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        //增加自定义action
        content.categoryIdentifier = "GENERAL"
        
        //设置定时器
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
        
        let request = UNNotificationRequest(identifier: "MorningAlarm", content: content, trigger: trigger)
        
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
        
    }
    
}

