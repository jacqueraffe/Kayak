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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = ARSCNView(frame: .zero)
        self.view = sceneView
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/Kayak.dae")!
        /*
        let walrusHead = scene.rootNode.childNode(withName: "WalrusHead-0", recursively: true)!
        let walrusBody = scene.rootNode.childNode(withName: "WalrusBody-0", recursively: true)!
        let simdWalrusHeadPosition = walrusHead.simdPosition
        let simdWalrusBodyPosition = walrusBody.simdPosition
        let difference = simdWalrusHeadPosition - simdWalrusBodyPosition
        walrusHead.simdPosition = difference
        walrusBody.addChildNode(walrusHead)
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = .Y
        //walrusHead.constraints = [billboardConstraint]
        //let walrusHead2 = SCNNode()
        //walrusHead2.simdPosition = walrusHead.simdPosition
        let cameraNode = sceneView.pointOfView!
        let lookAtConstraint = SCNLookAtConstraint( target: cameraNode)
        lookAtConstraint.isGimbalLockEnabled = true
        walrusHead.constraints = [lookAtConstraint]
        */
        
       
        
        
    
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


func updatePositionAndOrientationOf(_ node: SCNNode, withPosition position: SCNVector3,
relativeTo referenceNode: SCNNode)
{
    let referenceNodeTransform = matrix_float4x4(referenceNode.transform)
    
    // Setup a translation matrix with the desired position
    var translationMatrix = matrix_identity_float4x4
    translationMatrix.columns.3.x = position.x
    translationMatrix.columns.3.y = position.y
    translationMatrix.columns.3.z = position.z
    
    // Combine the configured translation matrix with the referenceNode's transform to
    //get the desired position AND orientation
    let updatedTransform = matrix_multiply(referenceNodeTransform, translationMatrix)
    node.transform = SCNMatrix4(updatedTransform)
}

