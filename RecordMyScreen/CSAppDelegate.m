//
//  CSAppDelegate.m
//  RecordMyScreen
//
//  Created by @coolstarorg on 12/29/12.
//  Copyright (c) 2012 CoolStar Organization. All rights reserved.
//

#import "CSAppDelegate.h"
#import "CSRecordViewController.h"
#import "CSRecordingListViewController.h"
#import "IASKAppSettingsViewController.h"

@implementation CSAppDelegate

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [_appAction release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UINavigationController *savedNavVC,*settingsNavVC;
    UIViewController *recordVC,*savedVC;
    IASKAppSettingsViewController *settingsVC;
    
    // Check for iPad
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        recordVC = [[[CSRecordViewController alloc] initWithNibName:@"CSRecordViewController" bundle:nil] autorelease];
    } else {
        recordVC = [[[CSRecordViewController alloc] initWithNibName:@"CSRecordViewController_iPad" bundle:nil] autorelease];
    }
    
    savedVC = [[[CSRecordingListViewController alloc] init] autorelease];
    savedNavVC = [[[UINavigationController alloc] initWithRootViewController:savedVC] autorelease];
    savedNavVC.navigationBar.barStyle = UIBarStyleBlack;
    
    settingsVC = [[[IASKAppSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    settingsVC.title = NSLocalizedString(@"Settings", @"");
    settingsVC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:settingsVC.title image:[UIImage imageNamed:@"settings"] tag:0] autorelease];
    settingsVC.showDoneButton = NO;
    settingsNavVC = [[[UINavigationController alloc] initWithRootViewController:settingsVC] autorelease];
    settingsNavVC.navigationBar.barStyle = UIBarStyleBlack;
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = @[recordVC,savedNavVC,settingsNavVC];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if (!url) { return NO; }
    
    self.appAction =  [url host];
  
    if ([self.appAction isEqualToString:@"record"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"record" object:nil];
    } else if ([self.appAction isEqualToString:@"stop"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stop" object:nil];
    }
    
    return YES;
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
