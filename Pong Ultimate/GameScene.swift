//
//  GameScene.swift
//  Pong Game
//
//  Created by Alex Heinzel on 7/17/20.
//  Copyright © 2020 Alex. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {


    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()


    var playButton = SKSpriteNode()
    var playText = SKLabelNode()

    var ball = SKSpriteNode()
    var player = SKSpriteNode()
    var computer = SKSpriteNode()

    // TIMER
    var timer = Timer()

    var count = 0
    var clock = SKLabelNode()

    // Creating all the variables I need in the game scene.
    
    // game started boolean
    var isGameStarted = false;

    override func didMove(to view: SKView) {

        playButton = self.childNode(withName: "playButton") as! SKSpriteNode
        playButton.isUserInteractionEnabled = true
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        player = self.childNode(withName: "player") as! SKSpriteNode
        computer = self.childNode(withName: "computer") as! SKSpriteNode
        clock = self.childNode(withName: "clock") as! SKLabelNode
        playText = self.childNode(withName: "playText") as! SKLabelNode
        // Making the ball move automatically.

        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border

        // CONTAINS TIMER

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name {
            if name == "playText" && !isGa  meStarted {
                startGame()
            }
        }
//        for touch in touches {
//            let location = touch.location(in: self)
//            player.run(SKAction.moveTo(x: location.x, duration: 0.1))
//        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            player.run(SKAction.moveTo(x: location.x, duration: 0.1))
        }
    }

    override func update(_ currentTime: TimeInterval) {

        computer.run(SKAction.moveTo(x: ball.position.x, duration: 0.1))
        //  Making the computer paddle move the direction of the ball, (and adding a little bit of lag).
        if ball.position.y <= player.position.y {
            reset(winner: computer)

        }
        else if ball.position.y >= computer.position.y {
            reset(winner: player)

        }
    }
    func reset (winner: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        let updateForce = SKAction.applyForce(CGVector(dx: 1500, dy: 1500), duration: 0.1)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        ball.run(updateForce)

    }

    func startGame() {
        isGameStarted = true
        let force = SKAction.applyForce(CGVector(dx: 1500, dy: 1500), duration: 0.1)
        ball.run(force)

        // TIMER
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)

    }

    // UPDATE TIMER LABEL
    @objc func updateClock() {
        self.count += 1
        self.clock.text = String(self.count)
    }
}
