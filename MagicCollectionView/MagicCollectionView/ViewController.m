//
//  ViewController.m
//  MagicCollectionView
//
//  Created by gdy on 16/3/17.
//  Copyright © 2016年 gdy. All rights reserved.
//

#import "ViewController.h"
#import "MagicCollectionView.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    MagicCollectionView* _magicCollectionView;
}
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
}

- (void)setupCollectionView{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    _magicCollectionView = [[MagicCollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    _magicCollectionView.delegate = self;
    _magicCollectionView.dataSource = self;
    [_magicCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_magicCollectionView];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50,30)];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    [cell addSubview:label];
    label.center = CGPointMake(cell.frame.size.width/2, cell.frame.size.height/2);
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
