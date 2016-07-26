//
//  ViewController.m
//  testframework
//
//  Created by michael on 17/7/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "ViewController.h"
#import "GiftViewController.h"
#import "ChatViewController.h"


#import <IJKMediaFramework/IJKMediaFramework.h>

@interface ViewController ()


@property (atomic, strong) NSURL *url;
@property (atomic, retain) id <IJKMediaPlayback> player;
@property (weak, nonatomic) UIView *PlayerView;

@property (weak, nonatomic) UIView *overlapView;

/*  礼物视图 */
@property (weak, nonatomic) UIView *giftView;
/* 聊天视图 */
@property (weak, nonatomic) UIView *chatView;

/* 礼物视图控制器 */
@property  GiftViewController * myGiftViewController;

/* 聊天视图控制器 */
@property  ChatViewController * myChatViewController;


@property  BOOL statusBarIsHidden;

- (IBAction)play_btn:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /** 加载网络视频 **/
   // [self initVideo];
    
    
    UIView *tempOverlapView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-380, self.view.bounds.size.width, 380)];
    self.overlapView = tempOverlapView;
    self.overlapView.backgroundColor = [UIColor lightGrayColor];
    
   //  _overlapView.backgroundColor = [UIColor clearColor];
    
   //  [overlapView setCenter: self.view.center];
    
    [self.view addSubview:self.overlapView];

    /* 增加操作按钮 */
     [self addActionButton];
     
    [self loadChatViewFromXIB];
}

-(void)addChatWindow{
    
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     //取消键盘输入
    [self.view endEditing:YES];

}

-(void)addActionButton{
    
    /**  关闭按钮  **/
    UIButton *closeButton = [[UIButton alloc] init];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(self.overlapView.bounds.size.width-60, self.overlapView.bounds.size.height-60, 50, 50);
    [closeButton setTag:1 ];
    [self.overlapView addSubview:closeButton];
    
    /**   赠送礼物    **/
    UIButton *giftButton = [[UIButton alloc] init];
    [giftButton setTitle:@"礼物" forState:UIControlStateNormal];
    giftButton.frame = CGRectMake(self.overlapView.bounds.size.width-110, self.overlapView.bounds.size.height-60, 50, 50);
    [giftButton setTag:2 ];
    [self.overlapView addSubview:giftButton];
    
    /**  分享按钮    **/
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(self.overlapView.bounds.size.width-160, self.overlapView.bounds.size.height-60, 50, 50);
    [shareButton setTag:3 ];
    [self.overlapView addSubview:shareButton];
    
    
    /** 设置按钮背景图片  **/
    UIImage *closeBtnImage = [UIImage imageNamed:@"closebtn"];
    [closeButton setBackgroundImage:closeBtnImage forState:UIControlStateNormal];
    UIImage *gitBtnImage = [UIImage imageNamed:@"giftbtn"];
    [giftButton setBackgroundImage:gitBtnImage forState:UIControlStateNormal];
    UIImage *shareBtnImage = [UIImage imageNamed:@"sharebtn"];
    [shareButton setBackgroundImage:shareBtnImage forState:UIControlStateNormal];
    
    
    //按钮增加事件
    [closeButton addTarget:self action:@selector(closeRoom:) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮增加事件
    [giftButton addTarget:self action:@selector(giveGift:) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮增加事件
    [shareButton addTarget:self action:@selector(shareRoom:) forControlEvents:UIControlEventTouchUpInside];
}

/** 加载网络视频,并增加到主视图上去  **/
-(void)initVideo{
    //网络视频
    //    self.url = [NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    //    _player = [[IJKAVMoviePlayerController alloc] initWithContentURL:self.url];
    
    //直播视频
    //  self.url = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];
    
    
    /** config PlayerView **/
     UIView *displayView = [[UIView alloc] initWithFrame:self.view.bounds];
    //UIView *displayView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 180)];
    displayView.backgroundColor = [UIColor greenColor];
    self.PlayerView = displayView;
    
    /** config videoView **/
    self.url = [NSURL URLWithString:@"rtmp://192.168.0.112:1935/live1/test2"];
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];
    UIView *videoView = [self.player view];
    videoView.frame = self.PlayerView.bounds;
    videoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    
    
    /** put videoView into PlayerView   **/
    [self.PlayerView insertSubview:videoView atIndex:1];
    
    [self installMovieNotificationObservers];
    
    /**  put PlayerView into current view  **/
    [self.view addSubview:self.PlayerView];

    
}


- (IBAction)closeRoom:(id)sender {
    NSLog(@"closing room...");
    

   // UIButton *shareBtn =  (UIButton *) [self.overlapView viewWithTag:3];
    //动画 移动
   // shareBtn.transform = CGAffineTransformTranslate( shareBtn.transform, 0,-100);
    
    //隐藏状态栏
   // [self myhiddenStatusBar];
   // [self loadChatViewFromXIB];
    
 }




- (IBAction)shareRoom:(id)sender {
    NSLog(@"share room...");
   // [self myshowStatusBar];
}

- (IBAction)giveGift:(id)sender {
    NSLog(@" give gift...");
    
    
  //  [self loadGiftViewFromXIB];
  //  [self switchView];
}


/**
 从xib文件中加载新视图
 **//*
-(void)loadChatViewFromXIB{
    // BlueView.xib的File's Owner为nil
    // NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"GiftViewController" owner:nil options:nil];
    
    self.myChatViewController = [[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:[NSBundle mainBundle]];
    
    
    _chatView = _myChatViewController.view;
    
    // 从xib加载进来的View大小是确定的，但是该视图在父视图中的位置是不确定的
    // 此外，视图中的子视图也是原封不动地Load进来的
    _chatView.frame = CGRectMake(0,150, self.view.bounds.size.width, 300);
   // [_chatView setBackgroundColor: [UIColor clearColor]];
    [self.view addSubview:_chatView];
}
*/

/**
 从xib文件中加载新视图
 **/
-(void)loadGiftViewFromXIB{
        // BlueView.xib的File's Owner为nil
   // NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"GiftViewController" owner:nil options:nil];
    
    self.myGiftViewController = [[GiftViewController alloc] initWithNibName:@"GiftViewController" bundle:[NSBundle mainBundle]];

    
    _giftView = _myGiftViewController.view;
    
  // 从xib加载进来的View大小是确定的，但是该视图在父视图中的位置是不确定的
 // 此外，视图中的子视图也是原封不动地Load进来的
      _giftView.frame = CGRectMake(0,self.view.bounds.size.height-180, self.view.bounds.size.width, 180);
    [_giftView setBackgroundColor: [UIColor clearColor]];
     [self.view addSubview:_giftView];
}

/**
 从xib文件中加载新视图
 **/
-(void)loadChatViewFromXIB{
    // BlueView.xib的File's Owner为nil
    // NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"GiftViewController" owner:nil options:nil];
    
    self.myChatViewController = [[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:[NSBundle mainBundle]];
    
    
    _chatView = _myChatViewController.view;
    
    // 从xib加载进来的View大小是确定的，但是该视图在父视图中的位置是不确定的
    // 此外，视图中的子视图也是原封不动地Load进来的
    _chatView.frame = CGRectMake(0,0, _overlapView.bounds.size.width-100,_overlapView.bounds.size.height-20);
   // [_chatView setBackgroundColor: [UIColor clearColor]];
    [_overlapView addSubview:_chatView];
}



-(void)switchView{
    GiftViewController *giftViewController = [[GiftViewController alloc] initWithNibName:@"GiftViewController"  bundle:nil];
    
    //giftViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
    //giftViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
   // giftViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    giftViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    giftViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    
    [self presentModalViewController:giftViewController animated:TRUE];
    
    
    
    
    
}


/*
-(void)initGesture{
        // 实现交互操作的手势
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didClickPanGestureRecognizer:)];
        [self.navigationController.view addGestureRecognizer:panRecognizer];

}

- (void)didClickPanGestureRecognizer:(UIPanGestureRecognizer*)recognizer
{
    UIView* view = self.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 获取手势的触摸点坐标
        CGPoint location = [recognizer locationInView:view];
        // 判断,用户从右半边滑动的时候,推出下一个VC(根据实际需要是推进还是推出)
        if (location.x > CGRectGetMidX(view.bounds) && self.navigationController.viewControllers.count == 1){
            self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
            //
            [self presentViewController:_nextVC animated:YES completion:nil];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // 获取手势在视图上偏移的坐标
        CGPoint translation = [recognizer translationInView:view];
        // 根据手指拖动的距离计算一个百分比，切换的动画效果也随着这个百分比来走
        CGFloat distance = fabs(translation.x / CGRectGetWidth(view.bounds));
        // 交互控制器控制动画的进度
        [self.interactionController updateInteractiveTransition:distance];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [recognizer translationInView:view];
        // 根据手指拖动的距离计算一个百分比，切换的动画效果也随着这个百分比来走
        CGFloat distance = fabs(translation.x / CGRectGetWidth(view.bounds));
        // 移动超过一半就强制完成
        if (distance > 0.5) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        // 结束后一定要置为nil
        self.interactionController = nil;
    }
} */

/**
 状态栏隐藏
 使用方法：直接调用：[self myhiddenStatusBar];
 **/
-(void)myhiddenStatusBar{
    self.statusBarIsHidden = TRUE;
    [self setNeedsStatusBarAppearanceUpdate];
    
}

/**
 状态栏隐藏
 使用方法：直接调用：[self myhiddenStatusBar];
 **/
-(void)myshowStatusBar{
    self.statusBarIsHidden = FALSE;
    [self setNeedsStatusBarAppearanceUpdate];
    
}

/**  重写这个方法 用于隐藏状态栏 **/
-(BOOL)prefersStatusBarHidden{
    return self.statusBarIsHidden;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated{
    if (![self.player isPlaying]) {
        [self.player prepareToPlay];
    }
}

#pragma Selector func

- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    switch (_player.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

#pragma Install Notifiacation

- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    
}

- (void)removeMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}


 



- (IBAction)play_btn:(id)sender {
    if (![self.player isPlaying]) {
        [self.player play];
    }else{
        [self.player pause];
    }
}




@end
