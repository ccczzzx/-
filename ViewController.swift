//
//  ViewController.swift
//  boring game
//
//  Created by maschinist on 2019/1/17.
//  Copyright © 2019 maschinist. All rights reserved.
//
import AVFoundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var _slider:UISlider!
    var currentValue:Int = 0
    @IBOutlet weak var targetLabel:UILabel!
    @IBOutlet weak var targetLabel1:UILabel!
    @IBOutlet weak var roundLabel:UILabel!
    var targetValue:Int = 0
    var score=0
    var round=0
    var audioPlayer:AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //currentValue=lroundf(_slider.value)
        //targetValue = Int.random(in: 1...100)
        let image1=UIImage(named: "SliderThumb-Normal")!
        _slider.setThumbImage(image1,for: .normal)
        let image2=UIImage(named: "SliderThumb-Highlighted")!
        _slider.setThumbImage(image2, for: .highlighted)
        let insets=UIEdgeInsets(top:0,left:14,bottom:0,right:14)
        let image3=UIImage(named: "SliderTrackLeft")!
        let image3rec=image3.resizableImage(withCapInsets: insets)
        _slider.setMinimumTrackImage(image3rec, for: .normal)
        let image5=UIImage(named:"SliderTrackRight")!
        let image5rec=image5.resizableImage(withCapInsets: insets)
        _slider.setMaximumTrackImage(image5rec, for: .normal)
        startNewgame()
        playBGMusic()
    }
    @IBAction func showAlert(){
        var difference=currentValue-targetValue
       if difference<0
       {
        difference *= -1
        }
        var points=100-difference
        
        //round += 1
        let title:String
        if difference == 0
        {
            title = "老弟，运气贼好，2019怕是天选之子！！！"
            points += 100
        }
        else if difference < 5
        {
            title = "哇哦，差一点点哦！！"
            points += 50
        }
        else if difference < 10
        {
            title = "可以可以，下一把加油！！"
        }
        else
        {
            title = "差的有点远哦，简直是：妹妹你在船头，哥哥在岸上走～～"
        }
        score += points
        let message="\n老弟的得分是：\(points)分"/*"滑动条当前的数值为：\(currentValue)"+"\n目标数值为：\(targetValue)"+"\n两者的差值为：\(difference)"*/
        let alert = UIAlertController(title:title,message:message,preferredStyle:.alert)
        let action = UIAlertAction(title:"happy everyday in 2019",style:.default,handler:{
            _ in self.startNewRound()
        })
        alert.addAction(action)
        present(alert,animated:true,completion:nil)
       // startNewRound()
    }
    @IBAction func slidermoved(_slider:UISlider){
        //print("滑动条当前的数值为：\(_slider.value)")
        currentValue=lroundf(_slider.value)
    }
    @IBAction func startOver()
    {
        startNewgame()
    }
    func startNewRound()
    {
        round += 1
        targetValue=Int.random(in: 1...100)
        currentValue=50
        _slider.value=Float(currentValue)
        updateLabels()
    }
    func startNewgame()
    {
        score = 0
        round = 0
        startNewRound()
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition,forKey: nil)
        
        }
    func updateLabels()
    {
        targetLabel.text=String(targetValue)
        targetLabel1.text=String(score)
        roundLabel.text=String(round)
    }
    func playBGMusic()
    {
        let musicPath = Bundle.main.path(forResource: "Clouds", ofType: "mp3")
        let url=URL.init(fileURLWithPath: musicPath!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        }catch _{
            audioPlayer = nil
        }
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
}
