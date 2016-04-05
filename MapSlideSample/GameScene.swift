//
//  GameScene.swift
//  MapSlideSample
//
//  Created by pyngit on 2016/04/01.
//  Copyright (c) 2016年 pyngit. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var mapNode:SKNode = SKNode()
    //前回のWorldポジション
    var preWorldPosition:CGPoint = CGPoint(x:0,y:0);

    
    override func didMoveToView(view: SKView) {
        print("SKScene size: \(self.size)) scale:\(self.xScale)")
        
        self.size = CGSize(width:self.size.width*2,height:self.size.height*3);

        //ベースのノード
        mapNode.name = "world"
        mapNode.position = CGPoint(x:0, y:0)
        self.addChild(mapNode)
        
        //画面中央
        let labelNode:SKSpriteNode = createItemNode("\(CGRectGetMidX(self.frame)):\(CGRectGetMidY(self.frame))");
        labelNode.position = CGPoint(x:CGRectGetMidX(self.frame),y:CGRectGetMidY(self.frame));
        mapNode.addChild(labelNode);

        //左下
        let labelNode0:SKSpriteNode = createItemNode("\(0):\(0)");
        labelNode0.position = CGPoint(x:0,y:0);
        mapNode.addChild(labelNode0);

        //右下
        let labelNode1:SKSpriteNode = createItemNode("\(CGRectGetMaxX(self.frame)):0");
        labelNode1.position = CGPoint(x:CGRectGetMaxX(self.frame),y:0);
        mapNode.addChild(labelNode1);
        
        //左上
        let labelNode2:SKSpriteNode = createItemNode("\(CGRectGetMinX(self.frame)):\(CGRectGetMaxY(self.frame))");
        labelNode2.position = CGPoint(x:CGRectGetMinX(self.frame),y:CGRectGetMaxY(self.frame));
        mapNode.addChild(labelNode2);

        //右上
        let labelNode3:SKSpriteNode = createItemNode("\(CGRectGetMaxX(self.frame)):\(CGRectGetMaxY(self.frame))");
        labelNode3.position = CGPoint(x:CGRectGetMaxX(self.frame),y:CGRectGetMaxY(self.frame));
        mapNode.addChild(labelNode3);
        
        //線を引く
        self.strokeLine(labelNode, toNode: labelNode0);
        self.strokeLine(labelNode, toNode: labelNode1);
        self.strokeLine(labelNode, toNode: labelNode2);
        self.strokeLine(labelNode, toNode: labelNode3);
        
        //ベースのノードを真ん中に移動する。
        mapNode.position = CGPoint(x:-CGRectGetMidX(self.frame)+CGRectGetMidX(view.frame),y:-CGRectGetMidY(self.frame)+CGRectGetMidY(view.frame));
        preWorldPosition = mapNode.position;
        print("init preWorldPosition:\(preWorldPosition)");
        
    }
    
    /**
     タッチ開始
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        print("touches count:\(touches.count)");
        if let touch:UITouch = touches.first {
            //タッチを開始した場所を取得
            let location = touch.locationInNode(self)
            print("touch start:\(location)");
            preWorldPosition = location;
        }
    }
    /**
     タッチ移動
    */
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch:UITouch = touches.first {
            let location = touch.locationInNode(self)
            print("touch move:\(location)");
            moveMapNode(location);
        }
        if(touches.count >= 2){
            print("distance:\(distanceWithPoint(Array(touches)[0].locationInNode(self),to:Array(touches)[1].locationInNode(self)))");
        }
    }
    /**
     タッチ終了
    */
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch:UITouch = touches.first {
            let location = touch.locationInNode(self)
            print("touch end:\(location)");
            moveMapNode(location);
        }
        if(touches.count >= 2){
            print("distance:\(distanceWithPoint(Array(touches)[0].locationInNode(self),to:Array(touches)[1].locationInNode(self)))");
        }
        print("moveend mapnode position:\(mapNode.position)");

    }
    /**
     サイズ変更時によばれる
    */
    override func didChangeSize(oldSize:CGSize){
        print("didChangeSize oldSize:\(oldSize)");
    }
    /**
     毎フレーム更新時
    */
    override func update(currentTime: CFTimeInterval) {
    }
    /**
     タッチで移動した時にベースのノードを移動する
    */
    private func moveMapNode(point:CGPoint){
        //前回の移動分から差分を取得
        let moveX:CGFloat = point.x - preWorldPosition.x;
        let moveY:CGFloat = point.y - preWorldPosition.y;
        
        //差分移動
        mapNode.position = CGPoint(x:mapNode.position.x + moveX, y:mapNode.position.y + moveY);
        preWorldPosition = point;
    }
    private func pinchAction(){
    }
    /**
     ２点間の距離を求める
    */
    private func distanceWithPoint(from:CGPoint,to:CGPoint) -> CGFloat{
        let dx:CGFloat = fabs( to.x - from.x );
        let dy:CGFloat = fabs( to.y - from.y );
        return sqrt(dx * dx + dy * dy);
    }
    /**
     背景付きのテキストラベルを生成する。
    */
    private func createItemNode(text:String) -> SKSpriteNode{
        let labelNode:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster");
        labelNode.text = text;
        labelNode.fontSize = 15;
        labelNode.horizontalAlignmentMode = .Center;
        labelNode.verticalAlignmentMode = .Center;
        
        let spriteNode:SKSpriteNode = SKSpriteNode();
        spriteNode.size = CGSize(width: labelNode.frame.width+3,height: labelNode.frame.height+3);
        spriteNode.color = UIColor.greenColor();
        
        spriteNode.addChild(labelNode);
        return spriteNode;
    }
    /**
     ノード間の線を引く
    */
    private func strokeLine(fromNode:SKSpriteNode,toNode:SKSpriteNode){
        
        //線を引くパスを用意
        let path:UIBezierPath = UIBezierPath();
        path.moveToPoint(fromNode.position)
        path.addLineToPoint(toNode.position);
        //線を引く用のノードを作成
        let line:SKShapeNode  = SKShapeNode();
        line.path = path.CGPath;
        line.strokeColor = SKColor.orangeColor();
        line.lineWidth = 5.0;
        
        mapNode.insertChild(line, atIndex: 0);

    }
}
