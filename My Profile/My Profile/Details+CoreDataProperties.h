//
//  Details+CoreDataProperties.h
//  My Profile
//
//  Created by SaTHYa on 08/01/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Details.h"

NS_ASSUME_NONNULL_BEGIN

@interface Details (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *professional;

@end

NS_ASSUME_NONNULL_END
