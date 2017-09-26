//
//  ViewController.m
//  SceneKitDemo
//
//  Created by 欧阳云慧 on 2017/9/22.
//  Copyright © 2017年 欧阳云慧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)SCNView *scnView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *background = [[UIImageView alloc]initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"backGround"];
    [self.view addSubview:background];
    [self createSceneView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 构建场景
- (void) createSceneView {
    _scnView = [[SCNView alloc]initWithFrame:self.view.bounds];
    _scnView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scnView];
    _scnView.scene = [SCNScene scene];

    //添加摄像机
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(-10,0,50);
    [_scnView.scene.rootNode addChildNode:cameraNode];

    [self createSnow:1 height:1 postionX:50 positionY:0 moveX:0 moveY:-15 speed:8 moveUpY: 30];
    [self createSnow:2 height:2 postionX:0 positionY:10 moveX:-10 moveY:-10 speed:10 moveUpY: 35];
    [self createSnow:3 height:3 postionX:5 positionY:55 moveX:-30 moveY:-16 speed:13 moveUpY: 40];
    [self createSnow:3.5 height:3.5 postionX:5 positionY:5 moveX:-20 moveY:-12 speed:25 moveUpY: 50];
    [self createSnow:4 height:4 postionX:5 positionY:7 moveX:-30 moveY:-10 speed:30 moveUpY: 80];

}

- (void) createSnow:(CGFloat )with height:(CGFloat )height postionX:(float )postionX positionY:(float )postionY moveX:(float)moveX moveY:(float)moveY speed:(float)speed moveUpY:(float)moveUpY {

    //添加图形
    SCNBox *snow = [SCNBox boxWithWidth:with height:height length:0 chamferRadius:0];
    snow.firstMaterial.diffuse.contents = [UIImage imageNamed:@"snow.png"];
    SCNNode *snowNode = [SCNNode node];
    snowNode.position = SCNVector3Make(postionX,postionY , 0);
    snowNode.geometry = snow;
    [_scnView.scene.rootNode addChildNode:snowNode];

    //添加动画行为
    SCNAction *rotation = [SCNAction rotateByAngle:10 aroundAxis:SCNVector3Make(0, 0, 1) duration:speed];
    SCNAction *moveDown = [SCNAction moveTo:SCNVector3Make(moveX, moveY, 0) duration:speed];
    SCNAction *moveUp = [SCNAction moveTo:SCNVector3Make(0, moveUpY, 0) duration:0];

    //执行动画
    SCNAction *sequence = [SCNAction sequence:@[moveUp,moveDown]];
    SCNAction *group = [SCNAction group:@[sequence,rotation]];
    [snowNode runAction:[SCNAction repeatActionForever:group]];

}
@end
