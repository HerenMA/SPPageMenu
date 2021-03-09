//
//  ViewController.m
//  SPPageMenu
//
//  Created by 乐升平 on 17/10/26.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ViewController.h"
#import "ParentViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
    
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    tableView.sectionFooterHeight = CGFLOAT_MIN;
    
    self.titles = @[@"跟踪器样式专区",@"排列方式专区",@"其余功能专区",@"属性和方法的测试",@"特别属性说明"];
    self.dataSource = @[@[@"下划线与item等宽(默认)",@"下划线比item略长",@"下划线“依恋”样式",@"缩放",@"圆角矩形",@"矩形"],@[@"可滑动的自适应内容排列",@"不可滑动的等宽排列",@"不可滑动的自适应内容排列"],@[@"显示功能按钮(显示在最右侧)",@"给功能按钮设置图片和文字", @"含有图片的item",@"指定item携带图片,或同时携带图片和文字,可以设置图片的位置",@"关闭跟踪器的随时跟踪效果"],@[@"在示例15中，你可以设置你想要的属性和方法来测试显示效果"],@[@"bridgeScrollView属性"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 2) {
        return 60;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ParentViewController *parentVc = [[ParentViewController alloc] init];
    NSInteger testNumber = indexPath.row;
    int i = 1;
    while (i <= indexPath.section) {
        testNumber += [self.dataSource[indexPath.section-i] count];
        i++;
    }
    parentVc.testNumber = testNumber;
    [self.navigationController pushViewController:parentVc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = self.titles[section];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}


@end
