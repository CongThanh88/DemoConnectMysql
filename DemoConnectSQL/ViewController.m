//
//  ViewController.m
//  DemoConnectSQL
//
//  Created by Cong Thanh on 1/28/15.
//  Copyright (c) 2015 com.htam86. All rights reserved.
//

#import "ViewController.h"
#import "MySql.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MySql* mySql= [[MySql alloc] initWithHost:@"http://127.0.0.1"
                                         port:3306
                                         user:@"root"
                                     password:@""];
    [mySql selectDatabase:@"DemoConnectIOS"];
    [mySql performQuery:@"SELECT * FROM user;" continueWithBlock:^(MySqlResults* results){
        NSLog(@"Received %d results", [results.rows count]);
        for(NSString* field in [results fields]) {
            fprintf(stderr, "%s, ", [(NSString*)[field valueForKey:@"name"] cStringUsingEncoding:NSASCIIStringEncoding]);
        }
        fprintf(stderr, "\n---------------\n");
        for( NSDictionary* row in [results rows]) {
            for(NSString* field in [results fields]) {
                fprintf(stderr, "%s, ", [(NSString*) [row valueForKey: [field valueForKey:@"name"] ] cStringUsingEncoding:NSASCIIStringEncoding]);
            }
            fprintf(stderr, "\n");
        }
    }];
//    [mySql performQuery:@"UPDATE user SET Host='xxxx' WHERE user='SpongeBobSquarePants'" continueWithBlock:^(MySqlResults* results){
//        if( [results affectedRows] > 0 ) {
//            NSLog(@"Affected %@ rows", [results affectedRows]);
//        }
//    }];
//    
//    [mySql performQuery:@"INSERT INTO user (user,host) VALUES ('bob','localhost')" continueWithBlock:^(MySqlResults* results){
//        if( [results affectedRows] > 0 ) {
//            NSLog(@"Affected %@ rows (Insert id: %@)", [results affectedRows], [results insertId]);
//        }
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
