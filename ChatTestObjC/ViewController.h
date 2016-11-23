//
//  ViewController.h
//  ChatTestObjC
//
//  Created by Active Mac05 on 29/12/15.
//  Copyright © 2015 techactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingTableView.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingTableView *chatTableView;
//@property (strong, nonatomic) IBOutlet UIImageView *mapImageView;
@property (nonatomic, strong) NSMutableArray* chat;
//@property (strong, nonatomic) IBOutlet UITextView *chatTextView;
//@property (strong, nonatomic) IBOutlet UIButton *submitChatMessageButton;
@property (strong, nonatomic) NSIndexPath* lastIndexpath;
@end

