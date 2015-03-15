//
//  MGGPulsingBlueDot.m
//  MGGStaticMapView
//
//  Created by Mason Glidden on 3/14/15.
//  Copyright (c) 2015 mgg. All rights reserved.
//

#import "MGGPulsingBlueDot.h"

#import <SimpleAL/SimpleAL.h>

static const CGFloat kOuterDotDimension = 22.0;

static const CGFloat kInnerBlueDotRelativeMinSize = 0.58;
static const CGFloat kInnerBlueDotRelativeMaxSize = 0.72;
static const CGFloat kInnerBlueDotScaleFactor = kInnerBlueDotRelativeMaxSize / kInnerBlueDotRelativeMinSize;

static const CGFloat kOuterBlueDotInitialDimension = kOuterDotDimension;
static const CGFloat kOuterBlueDotScaleFactor = 5.5;

@interface MGGPulsingBlueDot ()
@property (strong, nonatomic) UIView *outerBlueDot;
@property (strong, nonatomic) UIView *middleWhiteDot;
@property (strong, nonatomic) UIView *innerBlueDot;
@end

@implementation MGGPulsingBlueDot

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.clipsToBounds = NO;
    
    _outerBlueDot = [[UIView alloc] init];
    _outerBlueDot.backgroundColor = [[self class] _smallColor];
    _outerBlueDot.alpha = 0.5;
    _outerBlueDot.layer.cornerRadius = kOuterBlueDotInitialDimension / 2.0;
    _outerBlueDot.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_outerBlueDot];
    
    _middleWhiteDot = [[UIView alloc] init];
    _middleWhiteDot.backgroundColor = [UIColor whiteColor];
    _middleWhiteDot.layer.cornerRadius = kOuterDotDimension / 2.0;
    _middleWhiteDot.layer.shadowColor = [UIColor blackColor].CGColor;
    _middleWhiteDot.layer.shadowRadius = 10.0;
    _middleWhiteDot.layer.shadowOpacity = 0.2;
    _middleWhiteDot.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_middleWhiteDot];
    
    _innerBlueDot = [[UIView alloc] init];
    _innerBlueDot.backgroundColor = [[self class] _smallColor];
    _innerBlueDot.translatesAutoresizingMaskIntoConstraints = NO;
    _innerBlueDot.layer.cornerRadius = kOuterDotDimension * kInnerBlueDotRelativeMinSize / 2.0;
    [self addSubview:_innerBlueDot];
    
    [self _installConstraints];
    [self _startAnimation];
  }
  return self;
}

- (void)_installConstraints {
  [self addConstraints:@[
                         [self.innerBlueDot.al_width equalToValue:kOuterDotDimension*kInnerBlueDotRelativeMinSize],
                         [self.innerBlueDot.al_height equalToViewProperty:self.innerBlueDot.al_width],
                         [self.innerBlueDot.al_centerX equalToViewProperty:self.al_centerX],
                         [self.innerBlueDot.al_centerY equalToViewProperty:self.al_centerY],
                         
                         [self.middleWhiteDot.al_width equalToValue:kOuterDotDimension],
                         [self.middleWhiteDot.al_height equalToViewProperty:self.middleWhiteDot.al_width],
                         [self.middleWhiteDot.al_centerX equalToViewProperty:self.al_centerX],
                         [self.middleWhiteDot.al_centerY equalToViewProperty:self.al_centerY],
                         
                         [self.outerBlueDot.al_width equalToValue:kOuterBlueDotInitialDimension],
                         [self.outerBlueDot.al_height equalToViewProperty:self.outerBlueDot.al_width],
                         [self.outerBlueDot.al_centerX equalToViewProperty:self.al_centerX],
                         [self.outerBlueDot.al_centerY equalToViewProperty:self.al_centerY],
                         ]];
}

- (void)_startAnimation {
  [UIView animateKeyframesWithDuration:1.5 delay:0.0 options:UIViewKeyframeAnimationOptionRepeat|UIViewKeyframeAnimationOptionAutoreverse animations:^{
    [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.925 animations:^{
      self.innerBlueDot.layer.transform = CATransform3DScale(CATransform3DIdentity, kInnerBlueDotScaleFactor, kInnerBlueDotScaleFactor, 1.0);
      self.innerBlueDot.backgroundColor = [[self class] _largeColor];
    }];
  } completion:nil];
  
  [UIView animateKeyframesWithDuration:3 delay:0 options:UIViewKeyframeAnimationOptionRepeat|UIViewKeyframeAnimationOptionCalculationModePaced animations:^{
    [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.6 animations:^{
      self.outerBlueDot.layer.transform = CATransform3DScale(CATransform3DIdentity, kOuterBlueDotScaleFactor, kOuterBlueDotScaleFactor, 1.0);
      self.outerBlueDot.alpha = 0.0;
    }];
  } completion:nil];
}

+ (UIColor *)_smallColor {
  return [UIColor colorWithRed:51.0/255.0 green:148.0/255.0 blue:255.0/255.0 alpha:1.0];
}

+ (UIColor *)_largeColor {
  return [UIColor colorWithRed:6.0/255.0 green:124.0/255.0 blue:255.0/255.0 alpha:1.0];
}

@end