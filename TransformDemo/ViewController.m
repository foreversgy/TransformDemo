//
//  ViewController.m
//  TransformDemo
//
//  Created by ShiMac on 15/7/23.
//  Copyright © 2015年 guoyan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{

    UIImageView *imageView;
    UIImageView *bottomView;
}

@property(nonatomic,assign)CGFloat offsetY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.offsetY=0;
    
    imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    imageView.center=self.view.center;
    
    CATransform3D trans=CATransform3DIdentity;
    trans.m34=-1.25/1000.0;
    imageView.layer.transform=trans;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    imageView.layer.cornerRadius=10;
    imageView.layer.masksToBounds=YES;
    imageView.image=[UIImage imageNamed:@"bg2.jpg"];
//    imageView.layer.anchorPoint=CGPointMake(0.5, 1);
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    
    shapeLayer.path=[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, imageView.bounds.size.width, imageView.bounds.size.height/2)].CGPath;
    
    shapeLayer.bounds=CGRectMake(0, 0, imageView.layer.frame.size.width, imageView.layer.frame.size.height/2);
    shapeLayer.position=CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/4);

    imageView.layer.mask=shapeLayer;

    
    
    bottomView=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    bottomView.center=self.view.center;
    bottomView.clipsToBounds=YES;
    bottomView.layer.cornerRadius=10;
    bottomView.layer.masksToBounds=YES;
    bottomView.image=[UIImage imageNamed:@"bg2.jpg"];
    bottomView.contentMode=UIViewContentModeScaleAspectFill;

    
    CAShapeLayer *bottomLayer=[CAShapeLayer layer];
    
    bottomLayer.path=[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, imageView.bounds.size.width, imageView.bounds.size.height/2)].CGPath;
    
    bottomLayer.bounds=CGRectMake(0, 0, imageView.layer.frame.size.width, imageView.layer.frame.size.height/2);
    bottomLayer.position=CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height*3/4);

    bottomView.layer.mask=bottomLayer;

    [self.view addSubview:bottomView];
    
    
    
    
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(PanAnimation:)];
    imageView.userInteractionEnabled=YES;
    [imageView addGestureRecognizer:panGesture];
    
    
    
    [self.view addSubview:imageView];

    
}

-(void)PanAnimation:(UIPanGestureRecognizer *)gesture
{
    
    
    CGFloat gestureY=[gesture locationInView:imageView].y;
 
    
    CGFloat factor=-M_PI/imageView.bounds.size.height;  //比例系数
    
    CALayer *layer=[imageView.layer presentationLayer];
    
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        
        self.offsetY=gestureY;
    }else if(gesture.state==UIGestureRecognizerStateChanged){
    
        
        if (gestureY<imageView.bounds.size.height/4) {
            //在指定区域内旋转
            
            
            
            
            CABasicAnimation *basi=[CABasicAnimation animationWithKeyPath:@"transform"];
            basi.duration=0.07;
            basi.fromValue=[NSValue valueWithCATransform3D:layer.transform];
            basi.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate(imageView.layer.transform, factor *gestureY, 1, 0, 0)];
            
            basi.removedOnCompletion=NO;
            basi.fillMode=kCAFillModeForwards;
            [imageView.layer addAnimation:basi forKey:@"dd"];
            
            
        }else{
            
            CABasicAnimation *basi=[CABasicAnimation animationWithKeyPath:@"transform"];
            basi.duration=0.5;
            basi.fromValue=[NSValue valueWithCATransform3D:layer.transform];
            basi.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate(imageView.layer.transform, -M_PI, 1, 0, 0)];
            
            basi.removedOnCompletion=NO;
            basi.fillMode=kCAFillModeForwards;
            [imageView.layer addAnimation:basi forKey:@"dd"];
            
        }
        
    }else if(gesture.state==UIGestureRecognizerStateEnded && gestureY<imageView.bounds.size.height/4){
        
        
        CABasicAnimation *basi=[CABasicAnimation animationWithKeyPath:@"transform"];
        basi.duration=0.5;
        basi.fromValue=[NSValue valueWithCATransform3D:layer.transform];
        basi.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 1, 0, 0)];
        
        basi.removedOnCompletion=NO;
        basi.fillMode=kCAFillModeForwards;
        [imageView.layer addAnimation:basi forKey:@"dd"];
        
    }
    
  
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
