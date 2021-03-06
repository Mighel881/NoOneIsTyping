#import <UserNotifications/UserNotifications.h>

@interface BBBulletinRequest
@property (nonatomic,copy) NSString *publisherBulletinID;
@end

@interface BBServer
-(void)_publishBulletinRequest:(id)arg1 forSectionID:(id)arg2 forDestinations:(unsigned long long)arg3 alwaysToLockScreen:(BOOL)arg4;
-(void)_publishBulletinRequest:(id)arg1 forSectionID:(id)arg2 forDestinations:(unsigned long long)arg3;
@end

%hook BBServer

//gotta still hook the old one to maintain ios <12 compatiblity
-(void)_publishBulletinRequest:(id)arg1 forSectionID:(id)arg2 forDestinations:(unsigned long long)arg3 alwaysToLockScreen:(BOOL)arg4 {
	BBBulletinRequest *request = ((BBBulletinRequest *)arg1);
	NSString *publisherBulletinID = [request.publisherBulletinID lowercaseString];
	NSString *appId = (NSString *)arg2;

	if (!([appId isEqualToString:@"com.toyopagroup.picaboo"] && ([publisherBulletinID hasPrefix:@"typing"] || [publisherBulletinID hasPrefix:@"mischief_typing"]))) {
	 	%orig;
	} 
}

- (void)_publishBulletinRequest:(id)arg1 forSectionID:(id)arg2 forDestinations:(unsigned long long)arg3 {
	BBBulletinRequest *request = ((BBBulletinRequest *)arg1);
	NSString *publisherBulletinID = [request.publisherBulletinID lowercaseString];
	NSString *appId = (NSString *)arg2;
	HBLogDebug(@"HODOR - got notif - %@", publisherBulletinID);

	if (!([appId isEqualToString:@"com.toyopagroup.picaboo"] && ([publisherBulletinID hasPrefix:@"typing"] || [publisherBulletinID hasPrefix:@"mischief_typing"]))) {
	 	%orig;
	}
}

%end