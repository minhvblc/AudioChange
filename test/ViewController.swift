//
//  ViewController.swift
//  test
//
//  Created by Nguyễn Minh on 02/04/2021.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder : AVAudioRecorder!
    @IBOutlet weak var stopRecordButton: UIButton!
    @IBOutlet weak var recordLAbel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordButton.isEnabled = false

    }
    
    
    @IBAction func record(_ sender: Any) {
        recordLAbel.text = "Recording"
        recordButton.isEnabled = false
        stopRecordButton.isEnabled = true
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = true
        stopRecordButton.isEnabled = false
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
            print("Can't save file")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "stopRecording"){
            let vc = segue.destination as! PlayAudioViewController
            let url = sender as! URL
            vc.audioURl = url
        }
    }
}

