//
//  JHAudioManager.m
//  JHKit
//
//  Created by HaoCold on 2017/9/20.
//  Copyright © 2017年 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2017 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JHAudioManager.h"
#import <AudioToolbox/AudioToolbox.h>


#define AUDIO_NAME @"Bo Bo Bo La.mp3"

@implementation JHAudioManager

+ (void)jh_play_audio
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self xx_play_once_only];
    });
}

+ (void)xx_play_once_only
{
    NSString *audio_file = [[NSBundle mainBundle] pathForResource:AUDIO_NAME ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:audio_file];
    
    //1.获得系统声音ID
    SystemSoundID soundID = 0;
    
    //参数一：音频文件url
    //参数二：声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, audio_finish_play, NULL);
    
    //2.播放音频
    AudioServicesPlaySystemSound(soundID);
    //播放并振动
    //AudioServicesPlayAlertSound(soundID);
    
}

void audio_finish_play(SystemSoundID soundID,void *client_data){
    NSLog(@"audio finish play");
    AudioServicesDisposeSystemSoundID(soundID);
}

@end
