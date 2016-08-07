//
//  ViewController.m
//  Secure Camera
//
//  Created by Nguyen Cao Cuong on 8/5/16.
//  Copyright © 2016 Cuong Nguyen. All rights reserved.
//

#import "ViewController.h"

static NSString *cellIdentifier = @"cell";

@interface ViewController () {
    Boolean animating = NO;
    NSArray *colors;
    NSMutableArray *data;
    float lastY;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    data = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        [data addObject:[NSString stringWithFormat:@"This is data at index = %d", i]];
    } // for
    [self.tableView reloadData];
    colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor], [UIColor cyanColor], nil];
} // viewDidLoad()


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
} // didReceviceMemoryWarning()


#pragma ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height) {
        animating = YES;
        NSLog(@"Scrolled to bot");
        NSArray<__kindof UITableViewCell*> *cells = self.tableView.visibleCells;
        NSInteger count = cells.count;
        float deltaY = lastY - scrollView.contentOffset.y;
        for (int i = 0; i < count; i++) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = cells[i].frame;
                frame.origin.y -= deltaY;
                cells[i].frame = frame;
            } completion:^(BOOL finished) {
                
            }];
        } // for
        lastY = scrollView.contentOffset.y;
    } // if
} // scrollViewDidScroll()


#pragma TableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    } // if
    cell.textLabel.text = [data objectAtIndex:row];
    cell.backgroundColor = colors[row < colors.count ? row : row - colors.count];
    return cell;
} // cellForRowAtIndexPath()


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
} // heightForRowAtIndexPath()


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
} // numberOfRowsInSection()


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
