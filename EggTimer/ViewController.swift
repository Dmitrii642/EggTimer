//
//  ViewController.swift
//  EggTimer
//
//  Created by Dmitrii Iakovlev on 26/01/2023.
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard": 720]
    
    var timer  = Timer()
     var totalTIme = 0
   var secondPassed = 0
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBarView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        progressBarView.isHidden = true
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTIme = eggTimes[hardness]!
        
        
        progressBarView.progress = 0.0
        progressBarView.isHidden = false
        secondPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateCounter),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    
    @objc func updateCounter() {
        
        if secondPassed < totalTIme {
            secondPassed += 1
            progressBarView.progress = Float(secondPassed) / Float(totalTIme)
            print (progressBarView.progress)
            
             timerLabel.text = String(totalTIme - secondPassed)
        }else{
            timer.invalidate()
            titleLabel.text = ("Done");
            timerLabel.isHidden = true;
            progressBarView.isHidden = true
            playSound()
            
            }
        }
        
    }
    


