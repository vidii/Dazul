//
//  ViewController.h
//  Dazul
//
//  Created by eduardo on 6/22/13.
//  Copyright (c) 2013 LosPibes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSMutableData*      receivedData;
    NSURLConnection*    connection;
    
    NSMutableArray* elementsArray;
    NSMutableArray* listadoNacs;
    
    NSMutableString* currentString;
    
}

@property (strong, nonatomic) IBOutlet UILabel *valorVenta;
@property (strong, nonatomic) IBOutlet UILabel *valorCompra;

@property (strong, nonatomic) IBOutlet UIButton *actualizar;

@end
