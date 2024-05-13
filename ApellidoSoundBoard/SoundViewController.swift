//
//  SoundViewController.swift
//  ApellidoSoundBoard
//
//  Created by Piero Valentino Noa Chahuayo on 13/05/24.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    //*********OUTLETS*********
    @IBOutlet weak var grabarButton: UIButton!
    @IBOutlet weak var reproducirButton: UIButton!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var agregarButton: UIButton!
    
    //*********ACTIONS*********
    @IBAction func grabarTapped(_ sender: Any) {
        if grabarAudio!.isRecording{
            grabarAudio?.stop()
            grabarButton.setTitle("Grabar", for: .normal
            )
        }else{
            grabarAudio!.record()
            grabarButton.setTitle("Detener", for: .normal)
        }
    }
    @IBAction func reproducirTapped(_ sender: Any) {
        do{
            try reproducirAudio = AVAudioPlayer(contentsOf: audioURL!)
            reproducirAudio!.play()
            print("Reproduciendo Audio")
        }catch{}
    }
    @IBAction func agregarTapped(_ sender: Any) {
    }
    
    //RECORD
    var grabarAudio : AVAudioRecorder?
    //PLAY AN AUDIO
    var reproducirAudio : AVAudioPlayer?
    var audioURL:URL?
    
    func configurarGrabacion(){
        do{
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: [])
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            let basePath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            print("*******************+")
            print(audioURL!)
            print("*******************+")
            
            var settings:[String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            grabarAudio  = try AVAudioRecorder(url: audioURL!, settings: settings)
            grabarAudio!.prepareToRecord()
        }catch let error as NSError{
            print(error)
            configurarGrabacion()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarGrabacion()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
