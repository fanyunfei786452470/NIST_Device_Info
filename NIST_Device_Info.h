//
//  NIST_Device_Info.h
//  WhiteBoxSDKText(白盒SDK)
//
//  Created by 范云飞 on 2017/10/31.
//  Copyright © 2017年 范云飞. All rights reserved.
//

/**
 获取设备信息
 */
#import <Foundation/Foundation.h>

@interface NIST_Device_Info : NSObject

#pragma mark -
/**
 单例
 
 @return NIST_WB_SDK
 */
+ (NIST_Device_Info *)shareInstance;

#pragma mark - 
/**
 获取系统平台

 @return NSString
 */
+ (NSString *)get_System_Platform;

#pragma mark -
/**
 获取设备型号

 @return NSString
 */
+ (NSString *)get_Device_Model;

#pragma mark -
/**
 获取固件版本

 @return NSString
 */
+ (NSString *)get_Firmware_Version;

#pragma mark -
/**
 获取设备序列号

 @return NSString
 */
+ (NSString *)get_Device_SerialNumber;

#pragma mark -
/**
 获取CPU型号

 @return NSString
 */
+ (NSString *)get_CPU_Model;

#pragma mark -
/**
 获取GPU型号(目前获取不到)

 @return NSString
 */
+ (NSString *)get_GPU_Model;

#pragma mark -
/**
 获取Mac地址

 @return NSString
 */
+ (NSString *)get_MAC_Address;

#pragma mark -
/**
 获取分辨率

 @return NSString
 */
+ (NSString *)get_Resolution;

#pragma mark -
/**
 获取基带版本（不支持）

 @return NSString
 */
+ (NSString *)get_Baseband_Version;

#pragma mark -
/**
 获取SIM卡序列号（不支持）

 @return NSString
 */
+ (NSString *)get_SIM_Card_SerialNumber;

#pragma mark -
/**
 获取手机号（不支持）

 @return NSString
 */
+ (NSString *)get_telephoneNumber;

#pragma mark -
/**
 获取设备IP

 @return NSString
 */
+ (NSString *)get_IP_Address;

#pragma mark -
/**
 获取UUID

 @return NSString
 */
+ (NSString *)get_UUID;

@end
