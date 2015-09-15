//
//  RepoResultsViewController.m
//  GithubDemo
//
//  Created by Nicholas Aiwazian on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "RepoResultsViewController.h"
#import "MBProgressHUD.h"
#import "GithubRepo.h"
#import "GithubRepoSearchSettings.h"
#import "CustomTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface RepoResultsViewController ()
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) GithubRepoSearchSettings *searchSettings;
@property (nonatomic) NSArray *GithubRepo;
@end

@implementation RepoResultsViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchSettings = [[GithubRepoSearchSettings alloc] init];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchBar;
    [self doSearch];
    self.resultView.delegate = self;
    self.resultView.dataSource = self;
    
    [self.resultView reloadData];
}

- (void)doSearch {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GithubRepo fetchRepos:self.searchSettings successCallback:^(NSArray *repos) {
        self.GithubRepo =repos;
        for (GithubRepo *repo in repos) {
            NSLog(@"%@", [NSString stringWithFormat:
                   @"Name:%@\n\tStars:%ld\n\tForks:%ld,Owner:%@\n\tAvatar:%@\n\tDescription:%@\n\t",
                          repo.name,
                          repo.stars,
                          repo.forks,
                          repo.ownerHandle,
                          repo.ownerAvatarURL,
                          repo.repoDescription
                   ]);
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchSettings.searchString = searchBar.text;
    [searchBar resignFirstResponder];
    [self doSearch];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.cellone" forIndexPath:indexPath];

    cell.descriptionView.text = [self.GithubRepo[indexPath.row] repoDescription];
    cell.nameView.text = [self.GithubRepo[indexPath.row] name];
    
    cell.startCountView.text =[NSString stringWithFormat:@"%ld",[self.GithubRepo[indexPath.row] stars]];

    cell.forkCountView.text =[NSString stringWithFormat:@"%ld", [self.GithubRepo[indexPath.row] forks]];

    cell.ownerView.text =[self.GithubRepo[indexPath.row] ownerHandle];
     NSURL *Url = [NSURL URLWithString:[self.GithubRepo[indexPath.row] ownerAvatarURL]];
    
    [cell.customImageView setImageWithURL:(Url)];
    
    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
