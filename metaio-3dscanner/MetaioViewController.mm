//
//  MetaioViewController.m
//  metaio-3dscanner
//
//  Created by Matsui Nobuyuki on 13/02/10.
//  Copyright (c) 2013年 TIS Inc. All rights reserved.
//

#import "MetaioViewController.h"
#import "EAGLView.h"

@interface MetaioViewController ()

@end

@implementation MetaioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *trackingConfigFile = [self findAssetFromName:@"TrackingData_Marker" ofType:@"xml"];
    bool trackingConfigResult = m_metaioSDK->setTrackingConfiguration([trackingConfigFile UTF8String]);
    if (!trackingConfigResult) {
        [NSException raise:@"tracking config error" format:@"can't load tracking config"];
    }
    
    NSString *modelFile = [self findAssetFromName:@"0_Remesh" ofType:@"obj"];
    metaio::IGeometry *model = m_metaioSDK->createGeometry([modelFile UTF8String]);
    if (!model) {
        [NSException raise:@"model create error" format:@"can't create model"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBAction
- (IBAction)onClickCloseBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark private
- (NSString *)findAssetFromName:(NSString *)name ofType:(NSString *)ofType
{
    NSString *fileName = [[NSBundle mainBundle] pathForResource:name
                                                         ofType:ofType
                                                    inDirectory:@"Assets"];
    if (!fileName) {
        [NSException raise:@"find asset error" format:@"can't find %@.%@", name, ofType];
    }
    return fileName;
}


@end
