//
//  ViewController.swift
//  Kayak
//
//  Created by Jacqueline Palevich on 3/21/19.
//  Copyright © 2019 Jacqueline Palevich. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

public class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    var timer: Timer?
    var counter = 0
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = ARSCNView(frame: .zero)
        self.view = sceneView
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        
        
        timer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
            self.updateGame()}
        
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/Kayak.dae")!
       
        let seagull = SCNScene(named: "art.scnassets/Seagull.dae")!.rootNode
        let seagullParent = SCNNode()
        
        scene.rootNode.addChildNode(seagullParent)
        
        seagullParent.addChildNode(seagull)
        
        seagullParent.simdPosition = float3(-1, 1, -1)
        seagull.simdPosition = float3(0, 0, 1)
        
        let rotationAction = SCNAction.rotate(by: -CGFloat.pi*2, around: SCNVector3(0, 1, 0), duration: 5)
        let rotateForever = SCNAction.repeatForever(rotationAction)
        
        seagullParent.runAction(rotateForever)
        
        // Set the scene to the view
        sceneView.scene = scene
        
        let oceanSound = SCNAudioSource(fileNamed: "art.scnassets/OceanSounds.wav")!
        oceanSound.loops = true
        let audioPlayer1 = SCNAudioPlayer(source: oceanSound)
        scene.rootNode.addAudioPlayer(audioPlayer1)
        
        let musicSound = SCNAudioSource(fileNamed: "art.scnassets/Music.wav")!
        oceanSound.loops = true
        let audioPlayer2 = SCNAudioPlayer(source: musicSound)
        scene.rootNode.addAudioPlayer(audioPlayer2)
        
        
        
    }
    
    func updateGame(){
        if(counter%15 == 0){
            let dolphinsound = SCNAudioSource(fileNamed: "art.scnassets/Dolphins.wav")!
            let audioPlayer3 = SCNAudioPlayer(source: dolphinsound)
            sceneView.scene.rootNode.addAudioPlayer(audioPlayer3)
        }
        counter = counter + 1

    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    public func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    public func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    public func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
   
    
}
