//
//  FtGifView.h
//  QiTalk
//
//  Created by 程建良 on 2017/8/1.
//  Copyright © 2017年 keylert.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FtGifView : UIView

-(instancetype)initWithGifPath:(NSString *)gifpath andFirstImage:(UIImage *)firstImage andLastImage:(UIImage *)lastImage andGifTime:(double)gifTime;

@end
