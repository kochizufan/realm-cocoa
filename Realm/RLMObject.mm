////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import "RLMObject_Private.h"
#import "RLMSchema_Private.h"
#import "RLMProperty_Private.h"
#import "RLMObjectSchema_Private.hpp"
#import "RLMObjectStore.hpp"
#import "RLMQueryUtil.hpp"
#import "RLMUtil.hpp"
#import "RLMSwiftSupport.h"

#import <objc/runtime.h>


// We declare things in RLMObject which are actually implemented in RLMObjectBase
// for documentation's sake, which leads to -Wunimplemented-method warnings.
// Other alternatives to this would be to disable -Wunimplemented-method for this
// file (but then we could miss legitimately missing things), or declaring the
// inherited things in a category (but they currently aren't nicely grouped for
// that).
@implementation RLMObject

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithObject:(id)object {
    return [super initWithObject:object];
}

+ (instancetype)createInDefaultRealmWithObject:(id)object {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return (RLMObject *)RLMCreateObjectInRealmWithValue([RLMRealm defaultRealm], [self className], object, RLMCreationOptionsAllowCopy);
}

+ (instancetype)createInRealm:(RLMRealm *)realm withObject:(id)value {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return (RLMObject *)RLMCreateObjectInRealmWithValue(realm, [self className], value, RLMCreationOptionsAllowCopy);
}

+ (instancetype)createOrUpdateInDefaultRealmWithObject:(id)object {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    // verify primary key
    RLMObjectSchema *schema = [self sharedSchema];
    if (!schema.primaryKeyProperty) {
        NSString *reason = [NSString stringWithFormat:@"'%@' does not have a primary key and can not be updated", schema.className];
        @throw [NSException exceptionWithName:@"RLMExecption" reason:reason userInfo:nil];
    }

    return (RLMObject *)RLMCreateObjectInRealmWithValue([RLMRealm defaultRealm], [self className], object, RLMCreationOptionsUpdateOrCreate | RLMCreationOptionsAllowCopy);
}

+ (instancetype)createOrUpdateInRealm:(RLMRealm *)realm withObject:(id)value {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return (RLMObject *)RLMCreateObjectInRealmWithValue(realm, [self className], value, RLMCreationOptionsUpdateOrCreate | RLMCreationOptionsAllowCopy);
}

- (id)objectForKeyedSubscript:(NSString *)key {
    return [super objectForKeyedSubscript:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key {
    [super setObject:obj forKeyedSubscript:key];
}

+ (RLMResults *)allObjects {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return RLMGetObjects(RLMRealm.defaultRealm, self.className, nil);
}

+ (RLMResults *)allObjects:(NSString *)className {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return RLMGetObjects(RLMRealm.defaultRealm, className, nil);
}

+ (RLMResults *)allObjectsInRealm:(RLMRealm *)realm {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return RLMGetObjects(realm, self.className, nil);
}

+ (RLMResults *)objectsWhere:(NSString *)predicateFormat, ... {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    va_list args;
    RLM_VARARG(predicateFormat, args);
    return [self objectsWhere:predicateFormat args:args];
}

+ (RLMResults *)objectsWhere:(NSString *)predicateFormat args:(va_list)args {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [self objectsWithPredicate:[NSPredicate predicateWithFormat:predicateFormat arguments:args]];
}

+ (RLMResults *)objectsInRealm:(RLMRealm *)realm where:(NSString *)predicateFormat, ... {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    va_list args;
    RLM_VARARG(predicateFormat, args);
    return [self objectsInRealm:realm where:predicateFormat args:args];
}

+ (RLMResults *)objectsInRealm:(RLMRealm *)realm where:(NSString *)predicateFormat args:(va_list)args {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [self objectsInRealm:realm withPredicate:[NSPredicate predicateWithFormat:predicateFormat arguments:args]];
}

+ (RLMResults *)objectsWithPredicate:(NSPredicate *)predicate {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return RLMGetObjects(RLMRealm.defaultRealm, self.className, predicate);
}

+ (RLMResults *)objectsInRealm:(RLMRealm *)realm withPredicate:(NSPredicate *)predicate {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return RLMGetObjects(realm, self.className, predicate);
}

+ (instancetype)objectForPrimaryKey:(id)primaryKey {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return RLMGetObject(RLMRealm.defaultRealm, self.className, primaryKey);
}

+ (instancetype)objectInRealm:(RLMRealm *)realm forPrimaryKey:(id)primaryKey {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return RLMGetObject(realm, self.className, primaryKey);
}

- (NSArray *)linkingObjectsOfClass:(NSString *)className forProperty:(NSString *)property {
    return [super linkingObjectsOfClass:className forProperty:property];
}

- (BOOL)isEqualToObject:(RLMObject *)object {
    return [super isEqualToObject:object];
}

+ (NSString *)className {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [super className];
}

+ (RLMPropertyAttributes)attributesForProperty:(NSString *)propertyName {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [super attributesForProperty:propertyName];
}

+ (NSDictionary *)defaultPropertyValues {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [super defaultPropertyValues];
}

+ (NSString *)primaryKey {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [super primaryKey];
}

+ (NSArray *)ignoredProperties {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [super ignoredProperties];
}

@end
