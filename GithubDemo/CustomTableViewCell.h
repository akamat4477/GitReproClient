//
//  CustomTableViewCell.h
//  GithubDemo
//
//  Created by anjaneya kamat on 9/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIView *CustomImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *startCountView;
@property (weak, nonatomic) IBOutlet UILabel *forkCountView;
@property (weak, nonatomic) IBOutlet UILabel *ownerView;
@property (weak, nonatomic) IBOutlet UIImageView *customImageView;

@end
