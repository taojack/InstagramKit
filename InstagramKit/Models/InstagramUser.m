//
//    Copyright (c) 2013 Shyam Bhat
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "InstagramUser.h"
#import "InstagramEngine.h"

@implementation InstagramUser

- (id)initWithInfo:(NSDictionary *)info
{
    self = [super initWithInfo:info];
    if (self && VALID_OBJECT(info)) {
        _username = [[NSString alloc] initWithString:info[kUsername]];
        _fullname = [[NSString alloc] initWithString:info[kFullName]];
        _profilePictureURL = [[NSURL alloc] initWithString:info[kProfilePictureURL]];
        if (VALID_OBJECT(info[kBio]))
            _bio = [[NSString alloc] initWithString:info[kBio]];;
        if (VALID_OBJECT(info[kWebsite]))
            _website = [[NSURL alloc] initWithString:info[kWebsite]];

        // DO NOT PERSIST
        if (VALID_OBJECT(info[kCountMedia]))
            _mediaCount = [(info[kCounts])[kCountMedia] integerValue];
        if (VALID_OBJECT(info[kCountFollows]))
            _followsCount = [(info[kCounts])[kCountFollows] integerValue];
        if (VALID_OBJECT(info[kCountFollowedBy]))
            _followedByCount = [(info[kCounts])[kCountFollowedBy] integerValue];

    }
    return self;
}

- (void)loadCounts
{
    [self loadCountsWithSuccess:nil failure:nil];
}

- (void)loadCountsWithSuccess:(void(^)(void))success failure:(void(^)(void))failure
{
    [[InstagramEngine sharedEngine] getUserDetails:self withSuccess:^(InstagramUser *userDetail) {
        _mediaCount = userDetail.mediaCount;
        _followsCount = userDetail.followsCount;
        _followedByCount = userDetail.followedByCount;
        success();
    } failure:^(NSError *error) {
        failure();
    }];
    
}

- (void)loadFeed
{
    
}
@end
