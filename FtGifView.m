//
//  FtGifView.m
//  QiTalk
//
//  Created by 程建良 on 2017/8/1.
//  Copyright © 2017年 keylert.com. All rights reserved.
//

#import "FtGifView.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>

@interface FtGifView ()

@property (nonatomic,weak)WKWebView *webView;

@property (nonatomic,weak)UIImageView *imageView;

@property (nonatomic,copy)NSString *gifPath;

@property (nonatomic,strong)UIImage *firstImage;

@property (nonatomic,strong)UIImage *lastImage;

@property (nonatomic,assign)double gifTime;

@end

@implementation FtGifView

-(instancetype)initWithGifPath:(NSString *)gifpath andFirstImage:(UIImage *)firstImage andLastImage:(UIImage *)lastImage andGifTime:(double)gifTime{
    if (self = [super init]) {
        self.gifPath = gifpath;
        self.firstImage = firstImage;
        self.lastImage = lastImage;
        self.gifTime = gifTime;
        [self setupUI];
        [self loadGif];
    }
    return self;
}

-(void)setupUI{
    if (!(self.firstImage == nil && self.lastImage == nil)) {
        [self setupImageView];
    }
    [self setupWebView];
}

-(void)setupWebView{
    WKWebView *webView = [[WKWebView alloc]init];
    self.webView = webView;
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    webView.userInteractionEnabled = NO;
    [self addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(self);
    }];
}

-(void)setupImageView{
    UIImageView *gifImageView = [[UIImageView alloc] init];
    gifImageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView = gifImageView;
    [self addSubview:gifImageView];
    [gifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(self);
    }];
    if (self.firstImage) {
        self.imageView.image = self.firstImage;
    }
}
-(void)loadGif{
    NSString *filePath = self.gifPath;
    NSData *gifData = [NSData dataWithContentsOfFile:filePath];
    
    [self.webView loadData:gifData MIMEType:@"image/gif" characterEncodingName:nil baseURL:nil];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.gifTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.webView.hidden = YES;
        if (self.lastImage) {
            self.imageView.image = self.lastImage;
            self.imageView.hidden = NO;
        }
        [self.webView removeFromSuperview];
    });
    

}
-(void)dealloc{
    NSLog(@"FtGifView dealloc");
}
@end
