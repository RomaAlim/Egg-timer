//
//  ViewController.swift
//  Egg Timer
//
//  Created by Ramazan Kalabay on 06.04.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var proggres: UIProgressView!
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    let Eggs = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var player: AVAudioPlayer!
    var secondsPassed = 0
    var totalTime = 0
    
    @IBAction func Buttons(_ sender: UIButton) {
        let step = sender.currentTitle!
        totalTime = Eggs[step]!
        timer.invalidate()
        proggres.progress = 0.0
        secondsPassed = 0
        finishLabel.text = step
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer(){
        if secondsPassed < totalTime{
            proggres.progress = Float(secondsPassed) / Float(totalTime)
            let minut = secondsPassed / 60
            let second = secondsPassed % 60
            timerLabel.text = "\(minut)'min \(second)'s to \(totalTime)'min"
            secondsPassed += 1
        } else{
            timerLabel.text = "Finish"
            finishLabel.text = "Done"
            proggres.progress = Float(totalTime)
            timer.invalidate()
            player.play()
            
        }
    }
    
}

