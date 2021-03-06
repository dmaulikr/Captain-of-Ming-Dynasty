//
//  HnsMapHandle.swift
//  Captain_of_Ming_Dynasty
//
//  Created by 黄纽舒 on 17/1/5.
//  Copyright © 2017年 hns. All rights reserved.
//

import Foundation
import SpriteKit

class HnsMapHandle
{
    var position: CGPoint? = nil
    
    //in accordance with touch.location, return the direction, 1 means left, 2 means right, 3 means up, 4 means down, 0 means don't move
    func calculateDirection(location: CGPoint) -> Int
    {
        var x: CGFloat = location.x
        var y: CGFloat = location.y
        x -= 368
        y -= 207
        //touch center of screen, stop moving.
        if (abs(x) < 50)&&(abs(y) < 50)
        {
            return 0
        }
        if (x / y > 1)||(x / y < -1)
        {
            if x > 0
            {
                return 1    //left
            }
            else
            {
                return -1   //right
            }
        }
        else
        {
            if y > 0
            {
                return 3    //up
            }
            else
            {
                return -3   //down
            }
        }
    }
    
    func getAlertText(textID: Int) -> String
    {
        let filePath: String = Bundle.main.path(forResource: "alert", ofType: "plist")!
        let arr = NSArray(contentsOfFile: filePath)
        return arr![textID] as! String
    }
    
    func getPosition() -> CGPoint
    {
        if position == nil
        {
            let filePath: String = NSHomeDirectory() + "/Documents/save.plist"
            print(filePath)
            var dic = NSDictionary(contentsOfFile: filePath)
            
            if dic == nil
            {
                reset()
                dic = NSDictionary(contentsOfFile: filePath)
            }
            
            let positionDic = dic!.object(forKey: "position") as! NSDictionary
            
            let x = positionDic["x"] as! CGFloat
            let y = positionDic["y"] as! CGFloat
            
            position = CGPoint(x: x, y: y)
        }
        return position!
    }
    
    func getTexture(direction: String) -> SKTexture
    {
        let filePath = Bundle.main.path(forResource: "caption", ofType: "plist")!
        let dic = NSDictionary(contentsOfFile: filePath)
        
        let str = "caption_" + direction + "0.png"
        let frameStr = dic?.object(forKey: str) as! String
        let charset = CharacterSet(charactersIn:"{,} ")
        let array = frameStr.components(separatedBy: charset)
        let yNum = 120 - Double(array[4])! as Double
        
        let rect = CGRect.init(x: (Double(array[2])! / 177),
                               y: yNum / 177,
                               width: (Double(array[8])! / 177),
                               height: (Double(array[10])! / 177))

        return SKTexture.init(rect: rect, in: hnsTexture)
    }
    
    func getTextureArray(direction: String) -> Array<SKTexture>
    {
        let filePath = Bundle.main.path(forResource: "caption", ofType: "plist")!
        let dic = NSDictionary(contentsOfFile: filePath)
        
        let str1 = "caption_" + direction + "1.png"
        let frameStr1 = dic?.object(forKey: str1) as! String
        let charset1 = CharacterSet(charactersIn:"{,} ")
        let array1 = frameStr1.components(separatedBy: charset1)
        let yNum1 = 120 - Double(array1[4])! as Double
        
        let rect1 = CGRect.init(x: (Double(array1[2])! / 177),
                               y: yNum1 / 177,
                               width: (Double(array1[8])! / 177),
                               height: (Double(array1[10])! / 177))
        
        let t1 = SKTexture.init(rect: rect1, in: hnsTexture)
        
        let str2 = "caption_" + direction + "2.png"
        let frameStr2 = dic?.object(forKey: str2) as! String
        let charset2 = CharacterSet(charactersIn:"{,} ")
        let array2 = frameStr2.components(separatedBy: charset2)
        let yNum2 = 120 - Double(array2[4])! as Double
        
        let rect2 = CGRect.init(x: (Double(array2[2])! / 177),
                               y: yNum2 / 177,
                               width: (Double(array2[8])! / 177),
                               height: (Double(array2[10])! / 177))
        
        let t2 = SKTexture.init(rect: rect2, in: hnsTexture)
        
        return [t1, t2]
    }
    
    func reset()
    {
        let filePath1 = Bundle.main.path(forResource: "save", ofType: "plist")!
        let dic = NSDictionary(contentsOfFile: filePath1)
        
        let filePath2 = NSHomeDirectory() + "/Documents/save.plist"
        dic?.write(toFile: filePath2, atomically:true)
    }
    
    func save()
    {
        let filePath: String = NSHomeDirectory() + "/Documents/save.plist"
        
        let arry = ["x": self.position?.x, "y": self.position?.y]
        let time = HnsTimeLabel.timeDic
        
        var dic: NSDictionary? = nil
        if HnsTask.task.progress == 0
        {
            let task = ["tid": HnsTask.task.tid - 1, "progress": 0]
            dic = [ "position": arry,
                    "time": time,
                    "task": task,
                    "good": HnsTask.goodDic]
        }
        else
        {
            let task = ["tid": HnsTask.task.tid, "progress": 1]
            dic = [ "position": arry,
                    "time": time,
                    "task": task,
                    "good": HnsTask.goodDic]
        }
        dic?.write(toFile: filePath, atomically:true)
    }
    
    func updateHouse(houseArray: Array<SKSpriteNode>)
    {
        let x = HnsMapScene.mapScene.mapNode.position.x
        let y = HnsMapScene.mapScene.mapNode.position.y
        
        var house: SKSpriteNode
        house = houseArray[0]
        house.position = CGPoint.init(x: 470 + x, y: 1020 + y)
        
        house = houseArray[1]
        house.position = CGPoint.init(x: 2500 + x, y: 1500 + y)
        
        house = houseArray[2]
        house.position = CGPoint.init(x: 1020 + x, y: 1150 + y)
        
        house = houseArray[3]
        house.position = CGPoint.init(x: 1020 + x, y: 800 + y)
        
        house = houseArray[4]
        house.position = CGPoint.init(x: 1800 + x, y: 1150 + y)
        
        house = houseArray[5]
        house.position = CGPoint.init(x: 1800 + x, y: 800 + y)
        
        house = houseArray[6]
        house.position = CGPoint.init(x: 2244 + x, y: 1150 + y)
        
        house = houseArray[7]
        house.position = CGPoint.init(x: 2244 + x, y: 800 + y)
    }
    
    func updateRiver(riverArray: Array<SKSpriteNode>)
    {
        let x = HnsMapScene.mapScene.mapNode.position.x
        let y = HnsMapScene.mapScene.mapNode.position.y
        
        var river: SKSpriteNode
        river = riverArray[0]
        river.position = CGPoint.init(x: 2400 + x, y: 1314 + y)
        
        river = riverArray[1]
        river.position = CGPoint.init(x: 1658 + x, y: 1314 + y)
        
        river = riverArray[2]
        river.position = CGPoint.init(x: 987 + x, y: 1314 + y)
        
        river = riverArray[3]
        river.position = CGPoint.init(x: 784 + x, y: 1189 + y)
        
        river = riverArray[4]
        river.position = CGPoint.init(x: 784 + x, y: 739 + y)
        
        river = riverArray[5]
        river.position = CGPoint.init(x: 987 + x, y: 600 + y)
        
        river = riverArray[6]
        river.position = CGPoint.init(x: 1658 + x, y: 600 + y)
        
        river = riverArray[7]
        river.position = CGPoint.init(x: 2400 + x, y: 600 + y)
    }
    
    func updateTimeDic()
    {
        var dic = HnsTimeLabel.timeDic
        var year = dic["year"]! - 1628
        var month = dic["month"]!
        var day = dic["day"]!
        var hour = dic["hour"]!
        
        hour += 1
        if hour > 12
        {
            if ifDie()
            {
                return
            }
            ifTask()
            hour = 1
            day += 1
            if day > 30
            {
                for i in 0...HnsInnerScene.innerScene.npcArray.count-1
                {
                    let npc = HnsInnerScene.innerScene.npcArray[i]
                    npc.wealth += 5
                }
                day = 1
                month += 1
                if month > 12
                {
                    month = 1
                    year += 1
                }
            }
        }
        if HnsTimeHandle().getTimeDicAsNumber() == 16450101
        {
            HnsIntroScene.introScene.nextScene = HnsMapScene.mapScene
            HnsIntroScene.introScene.tag = 16
            
            let doors = SKTransition.fade(withDuration: 0.7)
            HnsMapScene.mapScene.view?.presentScene(HnsIntroScene.introScene, transition: doors)
            
            die()
        }
        HnsTimeLabel.timeDic["year"]    = year + 1628
        HnsTimeLabel.timeDic["month"]   = month
        HnsTimeLabel.timeDic["day"]     = day
        HnsTimeLabel.timeDic["hour"]    = hour
    }
    
    func ifDie() -> Bool
    {
        for i in 0...HnsInnerScene.innerScene.npcArray.count-1
        {
            let npc = HnsInnerScene.innerScene.npcArray[i]
            if npc.will < 20
            {
                let scene = HnsPreFightScene()
                scene.size = HnsMapScene.mapScene.size
                HnsMapScene.mapScene.presentIntroScence(tag: 17, gotoScene: scene)
                //die()
                return true
            }
        }
        return false
    }
    
    func ifTask()
    {
        let time = HnsTimeHandle().getTimeDicAsNumber()
        let type = HnsTask.task.type
        if HnsTask.task.time == time + 1
            && HnsTask.task.progress == 0
        {
            HnsTask.task.progress = 1
            let array = ["通告:  " + HnsTask.task.intro,
                         HnsTask.task.affectPeople(type: type)+"受到影响",
                         "民心" + String (HnsTask.task.affect),
                         HnsTask.task.taskType(taskType: HnsTask.task.taskType) + "可以挽回民心"]
            HnsIntroScene.introScene.textArray = array
            HnsIntroScene.introScene.nextScene = HnsMapScene.mapScene
            HnsIntroScene.introScene.tag = -1
            
            let doors = SKTransition.fade(withDuration: 0.7)
            HnsMapScene.mapScene.view?.presentScene(HnsIntroScene.introScene, transition: doors)
        }
        if HnsTask.task.time == time - HnsTask.task.days + 1
        {
            let arr = HnsInnerScene.innerScene.npcArray
            for i in 0 ... arr.count - 1
            {
                let npc = arr[i]
                npc.dailyTask = 0
            }
            HnsTask.task.progress = 0
            HnsSqlite3.sqlHandle.loadtask(tid: HnsTask.task.tid+1, task: HnsTask.task)
        }
    }
}

