//
//  InitPlugin.m
//  PluginTest
//
//  Created by gecc on 2018/10/01.
//
//

#import "InitPlugin.h"
#import <UserNotifications/UserNotifications.h>

@interface InitPlugin()<UNUserNotificationCenterDelegate>

{
        UNUserNotificationCenter *_notificationCenter;
}

@end

@implementation InitPlugin

-(void)onNotificationClick:(CDVInvokedUrlCommand *)cmd{
    [self notifyClick:^(NSString *jsonnotify) {
        CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonnotify];
        result.keepCallback=[NSNumber numberWithInt:1];
        [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
    }];
}

-(void)notifyClick:(RomoteNotificationOpen)callback{
    _notifycallback=callback;
}

-(void)onMessageRes:(CDVInvokedUrlCommand *)cmd{
//    CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self msgRes:^(NSString *jsonmsg) {
        CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonmsg];
        result.keepCallback=[NSNumber numberWithInt:1];
        [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
    }];
}
-(void)msgRes:(MessageCallBack )callback{
    _messagecallback=callback;
}

-(void)removeAlias:(CDVInvokedUrlCommand *)cmd{
    if(cmd.arguments.count<1){
        CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"args error"];
        [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        return;
    }
    [CloudPushSDK removeAlias:(NSString *)[cmd.arguments objectAtIndex:0] withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
            [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        }else{
            CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
            [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
            
        }
    }];
}

-(void)listAlias:(CDVInvokedUrlCommand *)cmd{
    [CloudPushSDK listAliases:^(CloudPushCallbackResult *res) {
        if (res.success) {
            CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[[NSString alloc] initWithData:res.data encoding:NSUTF8StringEncoding]];
            [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        }else{
            CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
            [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        }
    }];
}

-(void)listTags:(CDVInvokedUrlCommand *)cmd{
    if(cmd.arguments.count<1){
        CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"args error"];
        [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        return;
    }
    NSString *jsonstr=(NSString *)[cmd.arguments objectAtIndex:1];
    NSData *jsondata=[jsonstr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableLeaves error:&error];
    if(!error){
        CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
        [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        return;
    }
    if([[cmd.arguments objectAtIndex:0]length]>0){
        [CloudPushSDK listTags:(int)[dic objectForKey:@"tag_key"] withCallback:^(CloudPushCallbackResult *res) {
            if (res.success) {
                CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[[NSString alloc] initWithData:res.data encoding:NSUTF8StringEncoding]];
                [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
            }else{
                CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
                [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
            }
        }];
    }
}

-(void)getDeviceId:(CDVInvokedUrlCommand *)cmd{
    NSString *device_id= [CloudPushSDK getDeviceId];
    CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:device_id];
    [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
}

-(void)unBindTagsandAlias:(CDVInvokedUrlCommand *)cmd{
    if(cmd.arguments.count<1){
        CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"args error"];
        [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        return;
    }
    NSString *jsonstr=(NSString *)[cmd.arguments objectAtIndex:1];
    NSData *jsondata=[jsonstr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableLeaves error:&error];
    if(!error){
        CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
        [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        return;
    }
    NSArray *tags=[dic objectForKey:@"tag_value"];
    [CloudPushSDK unbindTag:(int)[dic valueForKey:@"tag_key"] withTags:tags withAlias:(NSString *)[dic valueForKey:@"alias"] withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
            [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        }else{
            CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
            [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        }
    }];
}

-(void)unBindAccount:(CDVInvokedUrlCommand *)cmd{
        [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
            if (res.success) {
                CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
                [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
            }else{
                CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
                [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
                
            }
        }];
}

-(void)bindTagsandAlias:(CDVInvokedUrlCommand *)cmd{
    if (cmd.arguments.count<1) {
        CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"args error"];
        [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        return;
    }
    NSString *jsonstr=(NSString *)[cmd.arguments objectAtIndex:1];
    NSData *jsondata=[jsonstr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableLeaves error:&error];
    if(!error){
        CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
        [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        return;
    }
    NSArray *tags=[dic objectForKey:@"tag_value"];
    [CloudPushSDK bindTag:(int)[dic valueForKey:@"tag_key"] withTags:tags withAlias:(NSString *)[dic valueForKey:@"alias"] withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
            [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        }else{
            CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
            [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        }
    }];
}

-(void)bindAccount:(CDVInvokedUrlCommand *)cmd{
    if (cmd.arguments.count<1) {
        CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"args error"];
        [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        return;
    }
    NSString *accountid=(NSString *)[cmd.arguments objectAtIndex:0];
    if([accountid length]>0){
        [CloudPushSDK bindAccount:accountid withCallback:^(CloudPushCallbackResult *res) {
            if (res.success) {
                CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
                [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
            }else{
                CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
                [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
            }
        }];
    }
}


-(void)init:(CDVInvokedUrlCommand *)cmd{
    [self initPush:cmd];
    [self listenerOnChannelOpened];
    [self registerMessageReceive];
    [CloudPushSDK sendNotificationAck:NULL];
}

-(void)initPush:(CDVInvokedUrlCommand *)cmd{
    NSMutableDictionary *plistDict=[[NSMutableDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AliyunEmasServices-Info" ofType:@"plist"]];
    NSString *app_key=[plistDict valueForKey:@"AppKey"];
    NSString *app_secret=[plistDict valueForKey:@"AppSecret"];
    [CloudPushSDK asyncInit:app_key appSecret:app_secret callback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"success");
            CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
            [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
            [self registerAPNS:[UIApplication sharedApplication]];
        }else{
            NSLog(@"%@",res.error);
            CDVPluginResult *result=[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
            [self.commandDelegate sendPluginResult:result callbackId:cmd.callbackId];
        }
    }];

}

- (void)registerAPNS:(UIApplication *)application {
    float systemVersionNum = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersionNum >= 10.0) {
        // iOS 10 notifications
        _notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        // 创建category，并注册到通知中心
        [self createCustomNotificationCategory];
        _notificationCenter.delegate = self;
        // 请求推送权限
        [_notificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // granted
                NSLog(@"User authored notification.");
                // 向APNs注册，获取deviceToken
                dispatch_async(dispatch_get_main_queue(), ^{
                    [application registerForRemoteNotifications];
                });
            } else {
                // not granted
                NSLog(@"User denied notification.");
            }
        }];
    } else if (systemVersionNum >= 8.0) {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:
          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                           categories:nil]];
        [application registerForRemoteNotifications];
    }
    else {
        // iOS < 8 Notifications
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
}


/**
 *  主动获取设备通知是否授权(iOS 10+)
 */
- (void)getNotificationSettingStatus {
    [_notificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            NSLog(@"User authed.");
        } else {
            NSLog(@"User denied.");
        }
    }];
}

/**
 *  创建并注册通知category(iOS 10+)
 */
- (void)createCustomNotificationCategory {
    // 自定义`action1`和`action2`
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"test1" options: UNNotificationActionOptionNone];
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"action2" title:@"test2" options: UNNotificationActionOptionNone];
    // 创建id为`test_category`的category，并注册两个action到category
    // UNNotificationCategoryOptionCustomDismissAction表明可以触发通知的dismiss回调
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"test_category" actions:@[action1, action2] intentIdentifiers:@[] options:
                                        UNNotificationCategoryOptionCustomDismissAction];
    // 注册category到通知中心
    [_notificationCenter setNotificationCategories:[NSSet setWithObjects:category, nil]];
}

/**
 *    注册推送消息到来监听
 */
- (void)registerMessageReceive {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageReceived:)
                                                 name:@"CCPDidReceiveMessageNotification"
                                               object:nil];
}
/**
 *    处理到来推送消息
 *
 *    @param notification
 */
- (void)onMessageReceived:(NSNotification *)notification {
    NSLog(@"Receive one message!");
    CCPSysMessage *message = [notification object];
    NSString *jstr= [NSString stringWithFormat:@"{\"msgtype\":%hhu,\"msgtitle\":\"%@\",\"msgcontent\":\"%@\"}",message.messageType, [[NSString alloc] initWithData:message.title encoding:NSUTF8StringEncoding],[[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding]];
    if (_messagecallback!=NULL) {
        _messagecallback(jstr);
    }
}

/**
 *	注册推送通道打开监听
 */
- (void)listenerOnChannelOpened {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onChannelOpened:)
                                                 name:@"CCPDidChannelConnectedSuccess"
                                               object:nil];
}


/**
 *	推送通道打开回调
 *
 *	@param 	notification
 */
- (void)onChannelOpened:(NSNotification *)notification {
    NSLog(@"通道已建立");
}


/**
 *  处理iOS 10通知(iOS 10+)
 */
- (void)handleiOS10Notification:(UNNotification *)notification setType:(NSString *)typestr{
    UNNotificationRequest *request = notification.request;
    UNNotificationContent *content = request.content;
    NSDictionary *userInfo = content.userInfo;
    // 通知时间
    NSDate *noticeDate = notification.date;
    // 标题
    NSString *title = content.title;
    // 副标题
    NSString *subtitle = content.subtitle;
    // 内容
    NSString *body = content.body;
    // 角标
    int badge = [content.badge intValue];
    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    NSString *extras = [userInfo valueForKey:@"Extras"];
    // 通知打开回执上报
    [CloudPushSDK sendNotificationAck:userInfo];
    NSString *str=[NSString stringWithFormat:@"{\"at\":%ld,\"title\":\"%@\",\"subtitle\":\"%@\",\"body\":\"%@\",\"badge\":%d,\"extras\":\"%@\",\"type\":\"%@\"}",[[NSNumber numberWithDouble:[noticeDate timeIntervalSince1970]]integerValue],title,subtitle,body,badge,extras,typestr];
    if (_notifycallback!=NULL) {
        _notifycallback(str);
    }
    NSLog(@"Notification, date: %@, title: %@, subtitle: %@, body: %@, badge: %d, extras: %@.", noticeDate, title, subtitle, body, badge, extras);
}
/**
 *  App处于前台时收到通知(iOS 10+)
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"Receive a notification in foregound.");
    [self handleiOS10Notification:notification setType:@"notification"];
    // 通知不弹出
    // completionHandler(UNNotificationPresentationOptionNone);
    // 通知弹出，且带有声音、内容和角标
    //completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
    // 通知弹出，且带有声音、内容
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

/**
 *  触发通知动作时回调，比如点击、删除通知和点击自定义action(iOS 10+)
 */
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSString *useraction=response.actionIdentifier;
    // 点击通知打开
    if([useraction isEqualToString:UNNotificationDefaultActionIdentifier]){
        NSLog(@"User opened the notification.");
        // 处理iOS 10通知，并上报通知打开回执
        [self handleiOS10Notification:response.notification setType:@"notificationOpened"];
    }
    // 通知dismiss，category创建时传入UNNotificationCategoryOptionCustomDismissAction才可以触发
    if ([userAction isEqualToString:UNNotificationDismissActionIdentifier]) {
        NSLog(@"User dismissed the notification.");
    }
    completionHandler();
}

/* 同步通知角标数到服务端 */
- (void)syncBadgeNum:(NSUInteger)badgeNum {
    [CloudPushSDK syncBadgeNum:badgeNum withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Sync badge num: [%lu] success.", (unsigned long)badgeNum);
        } else {
            NSLog(@"Sync badge num: [%lu] failed, error: %@", (unsigned long)badgeNum, res.error);
        }
    }];
}


@end
