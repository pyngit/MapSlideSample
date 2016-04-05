//
//  GameViewController.swift
//  MapSlideSample
//
//  Created by pyngit on 2016/04/01.
//  Copyright (c) 2016年 pyngit. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let scene = GameScene(fileNamed:"MapScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            scene.size = self.view.frame.size
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .ResizeFill
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
    override func viewDidAppear(animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onOrientationChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    // 端末の向きがかわったら呼び出される.
    func onOrientationChange(notification: NSNotification){
        
        // 現在のデバイスの向きを取得.
        let deviceOrientation: UIDeviceOrientation!  = UIDevice.currentDevice().orientation
        
        // 向きの判定.
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            //ランドスケープ　横向き
            print("Landscape");
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            //ポートレイト　縦向き
            print("Portrait");
        }
        
    }
}
