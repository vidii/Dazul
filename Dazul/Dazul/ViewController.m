//
//  ViewController.m
//  Dazul
//
//  Created by eduardo on 6/22/13.
//  Copyright (c) 2013 LosPibes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end



@implementation ViewController

@synthesize valorVenta;
@synthesize valorCompra;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    valorVenta.text = @"Cargando...";
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.eldolarblue.net/getDolarBlue.php?as=xml"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
	if (request)
	{
		[request setURL:url];
		connection = [[NSURLConnection alloc] initWithRequest:request delegate:self ];
	}
    
    //[self actualizar];
    

    
    
}

- (IBAction)actualizar:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://www.eldolarblue.net/getDolarBlue.php?as=xml"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
	if (request)
	{
		[request setURL:url];
		connection = [[NSURLConnection alloc] initWithRequest:request delegate:self ];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection*)connection
didReceiveResponse:(NSURLResponse*)response;
{
    receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection*)connection
    didReceiveData:(NSData*)data;
{
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    NSString* s = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
	NSLog(@"Received data %@", s);
    
    NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithData:receivedData];
    [xmlParser setDelegate:self];
    [xmlParser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    elementsArray = [[NSMutableArray alloc] init];
}

//store all found characters between elements in currentString mutable string
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(!currentString)
    {
        currentString = [[NSMutableString alloc] init];
    }
    [currentString appendString:string];
}

//When end of XML tag is found this method gets notified
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"buy"])
    {
        [elementsArray addObject:currentString];
        currentString = nil ;
        
        return;
    }
    if([elementName isEqualToString:@"sell"])
    {
        [elementsArray addObject:currentString];
        currentString = nil ;
        
        return;
    }
    
    currentString =nil;
}


//Parsing has ended
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"Los elementos del array son: %@", elementsArray);
    
    valorCompra.text = elementsArray[0];
    
    valorVenta.text = elementsArray[1];

    
}

@end
