//
//  BaseViewController.h
//  ASDKTestOn4S
//
//  Created by CambriaYang on 16/3/27.
//  Copyright © 2016年 CambriaYang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TESTNOTIFICATIONINSUBTHREAD @"TESTNOTIFICATIONINSUBTHREAD"

@interface BaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *baseTableView;

@end
