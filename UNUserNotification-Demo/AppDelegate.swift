//
//  AppDelegate.swift
//  UNUserNotification-Demo
//
//  Created by 侯逸仙 on 09/04/2018.
//  Copyright © 2018 侯逸仙. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        //注册通知中心协议
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //请求开启通知
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge]) { (granted, error) in
            if let error = error {
                print("Some unknown error happend:\(error.localizedDescription)")
            } else if granted == false {
                print("User does not allow notification")
            }
        }
        
        //注册自定义通知
        
        
        let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION", title: "Snooze", options: .init(rawValue: 0))
        let stopAction = UNNotificationAction(identifier: "STOP_ACTION", title: "Stop", options: .foreground)
        let generalCategory = UNNotificationCategory(identifier: "GENERAL", actions: [stopAction], intentIdentifiers: [], options: .customDismissAction)
        let expiredCategory = UNNotificationCategory(identifier: "TIMER_EXPIRED", actions: [snoozeAction, stopAction], intentIdentifiers: [], options: .init(rawValue: 0))
        center.setNotificationCategories([generalCategory, expiredCategory])
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: UNUserNotificationCenterDelegate method
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification.request.identifier)
        completionHandler([.sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //Handle the actions for the expired timer.
        if response.notification.request.content.categoryIdentifier == "TIMER_EXPIRED" {
            if response.actionIdentifier == "SNOOZE_ACTION" {
                print("user tapped snooze")
                //Invalidate the old timer and create a new one...
            } else if response.actionIdentifier == "STOP_ACTION" {
                print("user tapped stop")
                //Invalidate the timer...
            } else if response.actionIdentifier == UNNotificationDismissActionIdentifier {
                print("user dismiss the notification")
                //The user dismissed the notification without taking action
            } else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
                print("users opened the app")
                //The user launched the app
            }
        }
        
        //Else handle actions for other notification types...
        completionHandler()
    }
    
    
}

