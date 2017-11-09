//
//  NIST_Device_Info.m
//  WhiteBoxSDKText(白盒SDK)
//
//  Created by 范云飞 on 2017/10/31.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import "NIST_Device_Info.h"
#import <UIKit/UIKit.h>

/* 获取设备序列号(唯一标识)需要导入的头文件 */
#import "NIST_UUID.h"

/* 获取SIM信息需要导入的头文件 */
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

/* 获取设备型号需要导入的头文件 */
#include <sys/types.h>
#include <sys/sysctl.h>

/* 获取CUP型号需要导入的头文件 */
#include <mach/mach_host.h>

/* 获取MAC地址需要导入的头文件 */
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

/* 获取IP地址需要导入的头文件 */
#include <ifaddrs.h>
#include <sys/socket.h>
#include <arpa/inet.h>


@implementation NIST_Device_Info

#pragma mark - 单例
static NIST_Device_Info * nist_device_info = nil;
+ (NIST_Device_Info *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nist_device_info = [[NIST_Device_Info alloc]init];
    });
    return nist_device_info;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!nist_device_info)
    {
        nist_device_info = [super allocWithZone:zone];
    }
    return nist_device_info;
}

- (id)copy
{
    return self;
}

- (id)mutableCopy
{
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [[NSUserDefaults standardUserDefaults] valueForKey:@"SBFormattedPhoneNumber"];
}

#pragma mark - 获取系统平台
+ (NSString *)get_System_Platform
{
    return [[UIDevice currentDevice] systemName];
}

#pragma mark - 获取设备型号
+ (NSString *)get_Device_Model
{
    int        mib[2];
    size_t     len;
    char       *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    return platform;
}

#pragma mark - 获取固件版本
+ (NSString *)get_Firmware_Version
{
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark - 获取设备序列号
+ (NSString *)get_Device_SerialNumber
{
    return [NIST_UUID uuidForDevice];/* 目前苹果禁用获取设备序列号，目前采用NIST_UUID 实现UDID的功能 */
}

#pragma mark - 获取CPU型号
+ (NSString *)get_CPU_Model
{
    host_basic_info_data_t hostInfo;
    mach_msg_type_number_t infoCount;
    
    infoCount = HOST_BASIC_INFO_COUNT;
    host_info(mach_host_self(), HOST_BASIC_INFO, (host_info_t)&hostInfo, &infoCount);
    switch (hostInfo.cpu_type) {
        case CPU_TYPE_ARM:
            return [NSString stringWithFormat:@"%d",CPU_TYPE_ARM];
            break;
            
        case CPU_TYPE_ARM64:
            return [NSString stringWithFormat:@"%d",CPU_TYPE_ARM64];
            break;
            
        case CPU_TYPE_X86:
            return [NSString stringWithFormat:@"%d",CPU_TYPE_X86];
            break;
            
        case CPU_TYPE_X86_64:
            return [NSString stringWithFormat:@"%d",CPU_TYPE_X86_64];
            break;
            
        default:
            break;
    }
    return nil;
}

#pragma mark - 获取GPU型号（目前获取不到）
+ (NSString *)get_GPU_Model
{
    return @"undefine";
}

#pragma mark - 获取Mac地址
+ (NSString *)get_MAC_Address
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

#pragma mark - 获取分辨率
+ (NSString *)get_Resolution
{
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    return [NSString stringWithFormat:@"%.0fx%.0f",scale_screen * height, scale_screen * width];
}

#pragma mark - 获取基带版本（目前不支持）
+ (NSString *)get_Baseband_Version
{
    return @"undefine";
}

#pragma mark - 获取SIM卡序列号（目前不支持,暂时返回国家编号代替）
+ (NSString *)get_SIM_Card_SerialNumber
{
    CTTelephonyNetworkInfo * networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier * carrier = networkInfo.subscriberCellularProvider;
//    NSString * SIM_Card_SerialNumber = [NSString stringWithFormat:@"供应商名称：%@\n所在国家编号：%@\n供应商网络编号：%@\n移动电话服务商的IOS国家编码：%@\n是否允许VoIP通话：%@",carrier.carrierName,carrier.mobileCountryCode,carrier.mobileNetworkCode,carrier.isoCountryCode,carrier.allowsVOIP ? @ "YES" : @ "NO"];
//    return SIM_Card_SerialNumber;
    return carrier.mobileCountryCode;
}

#pragma mark - 获取手机号（目前不支持）
+ (NSString *)get_telephoneNumber
{
    return @"00000000000";
}

#pragma mark - 获取设备IP
+ (NSString *)get_IP_Address
{
    NSString * address = @"error";
    struct ifaddrs * interfaces = NULL;
    struct ifaddrs * temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

#pragma mark - 获取UUID
+ (NSString *)get_UUID
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

@end
