//
//  ViewController.swift
//  FMDB
//
//  Created by 刘高晖 on 16/7/5.
//  Copyright © 2016年 刘高晖. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var readContent: UIButton!

    @IBOutlet var cleanContents: UIButton!
    
    @IBAction func cleanContent(sender: AnyObject) {
//        
//        // 1.获得前一天时间
//        let formatter = NSDateFormatter()
//        formatter.locale = NSLocale(localeIdentifier: "en")
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        // 取比当前时间早一天的日期
//        let date = NSDate(timeIntervalSince1970: -24 * 60 * 60)
//        let dateStr = formatter.stringFromDate(date)
//        
        // 2.定义SQL语句
        let sql = "DELETE FROM T_Status WHERE statusText = 11;"
        
        // 3.执行SQL语句
        SQLiteManager.manager.dbqueue?.inDatabase({ (db) -> Void in
            db.executeUpdate(sql)
        })
    }

    
    @IBAction func readContents(sender: UIButton) {
        let sql = "SELECT statusId, statusText, userId FROM T_Status;"
        SQLiteManager.manager.dbqueue?.inTransaction({ (db, _) in
            if let rs = db.executeQuery(sql){
                // 遍历结果
                while rs.next() {
                    let id = rs.intForColumn("statusId")
                    let name = rs.stringForColumn("statusText")
                    let age = rs.intForColumn("userId")
                    print("\(id) \(name) \(age)")
                }

            }
        })
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func insertContent(sender: AnyObject) {
        //在iOS开发中我们通常获取网络数据，并插入到数据库中
//        在网络请求之后将JSON数据插入数据库的过程：
//        tips:让本地和网络返回的数据类型保持一致, 以便于后期处理
        
        
        
        // 1.定义SQL语句
        let sql = "INSERT INTO T_Status" +
            "(statusId, statusText, userId)" +
            "VALUES" +
        "(?, ?, ?);"
        
        
        let statusId = 1
        let statusText = "11"
        let userId = 111
        let ss = [statusId,statusText,userId]
        // 2.执行SQL语句
        SQLiteManager.manager.dbqueue?.inTransaction({ (db, rollback) -> Void in
            if !db.executeUpdate(sql, withArgumentsInArray: ss as [AnyObject]){
                // 如果插入数据失败, 就回滚
                rollback.memory = true
            }
//                if !db.executeUpdate(sql, statusId, statusText, userId)
//                {
//                    // 如果插入数据失败, 就回滚
//                    rollback.memory = true
//                }
            print("我存数据了")
        })
    
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

