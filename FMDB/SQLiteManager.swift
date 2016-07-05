//
//  SQLiteManager.swift
//  FMDB
//
//  Created by 刘高晖 on 16/7/5.
//  Copyright © 2016年 刘高晖. All rights reserved.
//

import UIKit

//工具类
class SQLiteManager: NSObject {
    //FMDatabase:一个FMDatabase对象就代表一个单独的SQLite数据库
//    用来执行SQL语句
    
    /// FMResultSet
//    使用FMDatabase执行查询后的结果集
    
    //FMDatabaseQueue,用于在多线程中执行多个查询或更新，它是线程安全的
    
    
//    Swift中建议使用单例创建工具类的方法
 static let manager:SQLiteManager = SQLiteManager()
    private override init(){
    }
    var dbqueue:FMDatabaseQueue?
    
    
    //在工具类中实现创建并打开数据库的方法
    
    
    //1.创建表
    private func createStatusTable(){
        // 1.编写SQL语句 数据库名大写 前面加T_
        let sql =  "CREATE TABLE IF NOT EXISTS T_Status( \n" +
            "statusId INTEGER PRIMARY KEY, \n" +
            "statusText TEXT, \n" +
            "userId INTEGER \n" +
        "); \n"
        //建表 在sqlite中除了查询都是update
        dbqueue!.inDatabase { (db) -> Void in
            if db!.executeUpdate(sql, withArgumentsInArray: nil){
                print("建表成功")
            }else{
                print("建表失败")
            }
        }
    }
    
    
    //2.打开表
    func openDB(DBName:String)
    {
        //根据传入的数据库名字拼接数据库路径
        let path = DBName.documentDir()
        print(path)
        //创建数据库对象
        dbqueue = FMDatabaseQueue(path: path)
        //打开数据库
        
        //创建微博表
        createStatusTable()
        //创建信息表
        
    }
    
    
}
