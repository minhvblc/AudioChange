//
//  PlayAudioViewController.swift
//  test
//
//  Created by Nguyễn Minh on 02/04/2021.
//

import UIKit
import AVFoundation
class PlayAudioViewController: UIViewController {
    var audioURl : URL!
    @IBOutlet weak var slow: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var fast: UIButton!
    @IBOutlet weak var low: UIButton!
    @IBOutlet weak var high: UIButton!
    @IBOutlet weak var echo: UIButton!
    @IBOutlet weak var Reverb: UIButton!
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAudio()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    @IBAction func play(_ sender: Any) {
        switch(ButtonType(rawValue: (sender as AnyObject).tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 1.5)
            case .chipmunk:
                playSound(pitch: 1000)
            case .vader:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
            }

            configureUI(.playing)
    }
    
    
    @IBAction func stop(_ sender: Any) {
        stopAudio()
    }
    
}
