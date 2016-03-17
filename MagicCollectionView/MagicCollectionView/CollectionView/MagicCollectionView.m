//
//  MagicCollectionView.m
//  MagicCollectionView
//
//  Created by gdy on 16/3/17.
//  Copyright © 2016年 gdy. All rights reserved.
//

#import "MagicCollectionView.h"

@interface MagicCollectionView (){
    UILongPressGestureRecognizer* _longPressGes;
}

@end

@implementation MagicCollectionView

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_longPressGes && ![self.gestureRecognizers containsObject:_longPressGes]) {
        _longPressGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(gesHandle:)];
        [self addGestureRecognizer:_longPressGes];
    }
}


- (void)setEnableMove:(BOOL)enableMove{
    _enableMove = enableMove;
    if (enableMove) {
        if (![self.gestureRecognizers containsObject:_longPressGes]) {
            [self addGestureRecognizer:_longPressGes];
        }
    }
    else{
        if ([self.gestureRecognizers containsObject:_longPressGes]) {
            [self removeGestureRecognizer:_longPressGes];
        }
    }
}

#pragma mark - LongPressGestureRecognizer

- (void)gesHandle:(UILongPressGestureRecognizer*)longPressGes{
    static NSIndexPath* sourceIndexpath = nil;
    switch (longPressGes.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath* indexPath = [self indexPathForItemAtPoint:[longPressGes locationInView:self]];
            sourceIndexpath = indexPath;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            NSIndexPath* indexPath = [self indexPathForItemAtPoint:[longPressGes locationInView:self]];
            if (indexPath && ![indexPath isEqual:sourceIndexpath]) {
                [self moveItemAtIndexPath:sourceIndexpath toIndexPath:indexPath];
                sourceIndexpath = indexPath;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            NSIndexPath* indexPath = [self indexPathForItemAtPoint:[longPressGes locationInView:self]];
            if (indexPath && ![indexPath isEqual:sourceIndexpath]) {
                [self moveItemAtIndexPath:sourceIndexpath toIndexPath:indexPath];
                sourceIndexpath = indexPath;
                [self reloadData];
            }
        }
            break;
        default:
            break;
    }
}




@end
