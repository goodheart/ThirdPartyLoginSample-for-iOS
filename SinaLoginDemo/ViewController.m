//
//  ViewController.m
//  SinaLoginDemo
//
//  Created by vimfung on 13-8-18.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>
#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView *bgImgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundLogin.png"]] autorelease];
    [self.view addSubview:bgImgView];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"LoginButton.png"] forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake((self.view.frame.size.width - 173.0) / 2, (self.view.frame.size.height - 32.0) / 2, 173.0, 32.0);
    loginBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [loginBtn addTarget:self action:@selector(loginBtnClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:loginBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginBtnClickHandler:(id)sender
{
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               
                               if (result)
                               {
                                   NSLog(@"uid = %@",[userInfo uid]);
                                   NSLog(@"name = %@",[userInfo nickname]);
                                   NSLog(@"icon = %@",[userInfo profileImage]);
                                   
                                   //将信息保存到parse上
#if 0
                                   PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
                                   [query whereKey:@"uid" equalTo:[userInfo uid]];
                                   [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                       
                                       if ([objects count] == 0)
                                       {
                                           PFObject *newUser = [PFObject objectWithClassName:@"UserInfo"];
                                           [newUser setObject:[userInfo uid] forKey:@"uid"];
                                           [newUser setObject:[userInfo nickname] forKey:@"name"];
                                           [newUser setObject:[userInfo profileImage] forKey:@"icon"];
                                           [newUser saveInBackground];
                                           
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"欢迎注册" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                                           [alertView show];
                                           [alertView release];
                                       }
                                       else
                                       {
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"欢迎回来" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                                           [alertView show];
                                           [alertView release];
                                       }
                                   }];
#endif
                                   MainViewController *mainVC = [[[MainViewController alloc] init] autorelease];
                                   [self.navigationController pushViewController:mainVC animated:YES];
                                   
                               }
        
    }];
}

@end
