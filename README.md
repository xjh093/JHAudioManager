# JHAudioManager
应用启动播放短音频

使用 & Use:
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //播放启动音频
    [JHAudioManager jh_play_audio];
    
    return YES;
}
```


.h

```
#import <Foundation/Foundation.h>

@interface JHAudioManager : NSObject
+ (void)jh_play_audio;
@end

```


.m
```
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

```
