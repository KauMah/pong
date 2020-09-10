//
//  Menuscene.swift
//  Pong Ultimate
//
//  Created by Alex Heinzel on 8/18/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import SpriteKit

class Menuscene: SKScene {

    var playButton = SKSpriteNode()
    var playText = SKLabelNode()
    
    override func didMove(to view: SKView) {
        playButton = self.childNode(withName: "playButton") as! SKSpriteNode
        playText = self.childNode(withName: "playText") as! SKLabelNode
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if touch.location(in: playButton) == location {
                
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene)
                
            }
            
            
        }
    }


}
