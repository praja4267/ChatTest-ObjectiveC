//
//  ViewController.m
//  ChatTestObjC
//
//  Created by Active Mac05 on 29/12/15.
//  Copyright © 2015 techactive. All rights reserved.
//

#import "ViewController.h"
#import "ImageTableViewCell.h"
#import "TextViewTableViewCell.h"

@interface NSString (AttributedStringCreation)
- (NSAttributedString *)attributedString;
@end

@implementation NSString (AttributedStringCreation)

- (NSAttributedString *)attributedString {
    return [[NSAttributedString alloc] initWithString:self];
}

@end

@interface ViewController ()


@end

@implementation ViewController

@synthesize chat = _chat;
@synthesize chatTableView = _chatTableView;
//@synthesize chatTextView = _chatTextView;
//@synthesize submitChatMessageButton = _submitChatMessageButton;
//@synthesize mapImageView = _mapImageView;
@synthesize lastIndexpath = _lastIndexpath;

- (void)viewDidLoad {
    [super viewDidLoad];
    _chatTableView.dataSource = self;
    _chatTableView.delegate = self;
    self.chat = [[NSMutableArray alloc] init];
//    [_submitChatMessageButton addTarget:self action:@selector(submitChatMessageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UINib *nib = [UINib nibWithNibName:@"ImageTableViewCell" bundle:nil];
    [[self chatTableView] registerNib:nib forCellReuseIdentifier:@"ImageTableViewCell"];
    UINib *nib1 = [UINib nibWithNibName:@"TextViewTableViewCell" bundle:nil];
    [[self chatTableView] registerNib:nib1 forCellReuseIdentifier:@"TextViewTableViewCell"];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu",(unsigned long)[_chat count]);
    return[_chat count] + 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [_chat count] + 3) {
        _lastIndexpath = indexPath;
    }
    if (indexPath.row == 0) {
        ImageTableViewCell *cell1 = (ImageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ImageTableViewCell"];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    }else if (indexPath.row == [_chat count] + 1) {
        TextViewTableViewCell *cell2 = (TextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextViewTableViewCell"];
        cell2.textViewTableViewCell.delegate = self;
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;
    } else if (indexPath.row == [_chat count] + 2) {
        static NSString *CellIdentifier1 = @"ButtonCell";
        
        UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell3 == nil) {
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        // Configure the cell.
        cell3.textLabel.text = @"Submit Message";
        cell3.textLabel.textAlignment = NSTextAlignmentCenter;
        cell3.backgroundColor = [UIColor cyanColor];
        [cell3 setNeedsLayout];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell3;
    }else if (indexPath.row == [_chat count] + 3) {
        static NSString *CellIdentifier12 = @"ButtonCell123";
        
        UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier12];
        if (cell4 == nil) {
            cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier12];
        }
        
        // Configure the cell.
        cell4.textLabel.text = @"";
        cell4.textLabel.textAlignment = NSTextAlignmentCenter;
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell4.backgroundColor = [UIColor cyanColor];
        [cell4 setNeedsLayout];
        return cell4;
    }else{
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell.
        cell.textLabel.text = [self.chat objectAtIndex:indexPath.row - 1];
        cell.textLabel.numberOfLines = 0;
        [cell setNeedsLayout];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text  isEqual: @""]) {
        return;
    }
    [_chat addObject:textView.text];
    NSLog(@"%@",_chat);
    textView.text = @"";
    [_chatTableView reloadData];
    [self tableViewScrollToBottomAnimated:YES];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSAttributedString *attrStr =  [[NSAttributedString alloc] initWithString:[_chat objectAtIndex:indexPath.row]];
//    CGFloat width = self.view.frame.size.width; // whatever your desired width is
//    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
//    return rect.size.height;
//}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [_chat count] + 2) {
        [self.view endEditing:YES];
        [_chatTableView reloadData];
        [self tableViewScrollToBottomAnimated:YES];
    } else {
        return;
    }
    
}
-(void)submitChatMessageButtonAction {
    [_chatTableView reloadData];
//    if (_lastIndexpath.row > 0) {
//       [_chatTableView scrollToRowAtIndexPath:_lastIndexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES]; 
//    }
    [self tableViewScrollToBottomAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableViewScrollToBottomAnimated:(BOOL)animated {
    
//    
//    if (_chatTableView.contentSize.height > _chatTableView.frame.size.height)
//    {
//        CGPoint offset = CGPointMake(0, _chatTableView.contentSize.height - _chatTableView.frame.size.height);
//        [self.chatTableView setContentOffset:offset animated:YES];
//    }
    
    NSInteger numberOfRows = [_chatTableView numberOfRowsInSection:0];
    if (numberOfRows) {
        [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:numberOfRows - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}


@end
