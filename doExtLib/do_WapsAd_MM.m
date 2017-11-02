//
//  do_WapsAd_MM.m
//  DoExt_MM
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_WapsAd_MM.h"

#import "doScriptEngineHelper.h"
#import "doIScriptEngine.h"
#import "doInvokeResult.h"
#import "doServiceContainer.h"
#import "doIModuleExtManage.h"
#import "JOYConnect.h"
#import "doJsonHelper.h"
#import "doIPage.h"
@interface do_WapsAd_MM()<JOYConnectDelegate>

@end
@implementation do_WapsAd_MM

#pragma mark - 注册属性（--属性定义--）
/*
 [self RegistProperty:[[doProperty alloc]init:@"属性名" :属性类型 :@"默认值" : BOOL:是否支持代码修改属性]];
 */
-(void)OnInit
{
    [super OnInit];
    //注册属性

}

//销毁所有的全局对象
-(void)Dispose
{
    //(self)类销毁时会调用递归调用该方法，在该类中主动生成的非原生的扩展对象需要主动调该方法使其销毁
}
#pragma mark -
#pragma mark - 同步异步方法的实现
//同步
- (void)close:(NSArray *)parms
{
    [JOYConnect closeBan];
}
- (void)getHeight:(NSArray *)parms
{
//    id<doIScriptEngine> _scritEngine = [parms objectAtIndex:1];
//    CGFloat height = 100.0/_scritEngine.CurrentPage.RootView.YZoom;
    doInvokeResult *_invokeResult = [parms objectAtIndex:2];
    [_invokeResult SetResultFloat:135];
    //_invokeResult设置返回值
}
- (void)show:(NSArray *)parms
{
    NSString *wapsKey = [[doServiceContainer Instance].ModuleExtManage GetThirdAppKey:@"do_WapsAd.plist" :@"WAPSKEY"];
    [JOYConnect sharedJOYConnect].delegate=self;
    [JOYConnect getConnect:wapsKey];
    NSDictionary *_dictParas = [parms objectAtIndex:0];
    //参数字典_dictParas
    id<doIScriptEngine> _scritEngine = [parms objectAtIndex:1];
    //自己的代码实现
    int y = [doJsonHelper GetOneInteger:_dictParas :@"y" :0];
    y = y *_scritEngine.CurrentPage.RootView.YZoom;
    UIViewController *currentVC =(UIViewController *) _scritEngine.CurrentPage.PageView;
    [JOYConnect showBan:currentVC adSize:E_SIZE_768X100 showX:0 showY:y];
}
//异步
- (void)onConnectSuccess
{
    NSLog(@"onConnectSuccess");
}

- (void)onConnectFailed:(NSString *)error
{
    NSLog(@"error%@",error);
}

- (void)onBannerShow
{
    NSLog(@"onBannerShow");
}

- (void)onBannerShowFailed:(NSString *)error
{
    NSLog(@"error%@",error);
}
@end