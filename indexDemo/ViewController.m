//
//  ViewController.m
//  indexDemo
//
//  Created by qingyun on 15/12/4.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,strong) NSArray *keys;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDictFromFile];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds  style:UITableViewStylePlain];
    
    
    [self.view addSubview:tableView];
    
    
    tableView.dataSource = self;
    tableView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadDictFromFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *keys = _dict.allKeys;
    
    
    _keys = [keys sortedArrayUsingSelector:@selector(compare:)];
}


//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _keys.count;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *keys = _keys[section];
    
    NSArray *array = _dict[keys];
    
    
    return array.count;
}

//行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *key = _keys[indexPath.section];
    NSArray *array = _dict[key];
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}


//section头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _keys[section];
}

//设置索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _keys;
}
//点击索引视图上的section的索引
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if (index == 0) {
        return index + 1;
    }
    return index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
