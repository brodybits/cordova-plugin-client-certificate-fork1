#import "OpenCertFile.h"

@implementation OpenCertFile : CDVPlugin

- (void)pluginInitialize
{
    NSLog(@"*****************************************************");
    NSLog(@"*****************************************************");
    NSLog(@"*****************************************************");
    NSLog(@"*****************************************************");
    NSLog(@"*****************************************************");
    NSLog(@"*****************************************************");
    NSLog(@"******************   OpenCertFile pluginInitialize");
    NSLog(@"OpenCertFile pluginInitialize");

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOpenURL1:) name:CDVPluginHandleOpenURLNotification object:nil];
}

- (void)selectCert:(CDVInvokedUrlCommand *)invokedCommand
{
     printf("HERE selectCert: %s", [[invokedCommand description] UTF8String]);
     NSLog(@"HERE selectCert: %@", [invokedCommand description]);
}

- (void)handleOpenURL1:(NSNotification*)notification
{
    // override to handle urls sent to your app
    // register your url schemes in your App-Info.plist

    NSLog(@"OpenCertFile RECEIVED NOTIFICATION in handleOpenURL callback");

    NSURL* url = [notification object];

    printf("HERE Notification: %s", [[notification description] UTF8String]);
    NSLog(@"HERE Notification: %@", [notification description]);
    [self readDirectoryContent: @"/"];

    if ([url isKindOfClass:[NSURL class]]) {
        /* Do your thing! */
    }
}

-(NSMutableArray *)readDirectoryContent:(NSString *)sourcePath
{
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath error:NULL];
    NSMutableArray *certFiles = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        printf("HERE File: %s", [filename UTF8String]);
        if ([extension isEqualToString:@"myp12"]) {
            [certFiles addObject:[sourcePath stringByAppendingPathComponent:filename]];
        }
    }];
    return certFiles;
}

@end
