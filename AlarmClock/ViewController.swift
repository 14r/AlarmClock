//
//  ViewController.swift
//  AlarmClock
//
//  Created by Arisa on 2016/06/19.
//  Copyright © 2016年 Arisa. All rights reserved.
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var soundCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 起動した時点の時刻をmyLabelに反映
        myLabel.text = getNowTime()
        _ = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "update", userInfo: nil, repeats: true)
        
        let soundFilePath = NSBundle.mainBundle().pathForResource("bell", ofType: "mp4")!
        let fileURL = NSURL(fileURLWithPath: soundFilePath)
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL: fileURL)
        }catch{
            print("音楽ファイルが読み込めませんでした")
        }
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var myDPvar: UIDatePicker!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet var stop: UIButton!
    
    private var tempTime: String!
    private var setTime: String = "00:00"
    
 
    @IBAction func MyDPFunc(sender: AnyObject) {
        // test print
        print("test: myDP moved!",myDPvar.date)
        // DPの値を成形
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm"
        // 一時的にDPの値を保持
        tempTime = format.stringFromDate(myDPvar.date)
    }
    
    @IBAction func myButtonfunc(sender: AnyObject) {
        // アラームをセット
        setTime = tempTime
        // test print
        print("test: myButton Pushed!", setTime)
    }
    
    func getNowTime()-> String {
        // 現在時刻を取得
        let nowTime: NSDate = NSDate()
        // 成形する
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm"
        let nowTimeStr = format.stringFromDate(nowTime)
        // 成形した時刻を文字列として返す
        return nowTimeStr
    }
    
    func update() {
        // 現在時刻を取得
        let str = getNowTime()
        // myLabelに反映
        myLabel.text = str
        // アラーム鳴らすか判断
        myAlarm(str)
    }
    
    func myAlarm(str: String) {
        // 現在時刻が設定時刻と一緒なら
        if str == setTime{
            //音のコード
            audioPlayer.numberOfLoops = soundCount
            audioPlayer.play()
            //画面遷移のコード
            alert()
        }
    }
    
    // アラートの表示
    func alert() {
        let myAlert = UIAlertController(title: "alert", message: "ring ding", preferredStyle: .Alert)
        let myAction = UIAlertAction(title: "dong", style: .Default) {
            action in print("foo!!")
        }
        myAlert.addAction(myAction)
        presentViewController(myAlert, animated: true, completion: nil)
        
    }    
    
}