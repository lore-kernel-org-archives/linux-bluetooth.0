Return-Path: <fengguang.wu@intel.com>
Date: Sun, 16 Jul 2017 09:11:28 +0800
From: kbuild test robot <lkp@intel.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: kbuild-all@01.org, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Tunin <hanipouspilot@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Add support of all Foxconn (105b) Broadcom devices
Message-ID: <201707160921.hZWQ6bLL%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <1499340593-12739-1-git-send-email-hanipouspilot@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Dmitry,

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on v4.13-rc1]
[cannot apply to next-20170714]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Tunin/Add-support-of-all-Foxconn-105b-Broadcom-devices/20170708-021656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: powerpc-ps3_defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1062:2: error: field name not in record or union initializer
     .idVendor = (vend), \
     ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1062:2: note: (near initialization for 'btusb_table[21].bInterfaceNumber')
     .idVendor = (vend), \
     ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1062:14: warning: excess elements in scalar initializer
     .idVendor = (vend), \
                 ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1062:14: note: (near initialization for 'btusb_table[21].bInterfaceNumber')
     .idVendor = (vend), \
                 ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:2: error: field name not in record or union initializer
     .bInterfaceClass = (cl), \
     ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:2: note: (near initialization for 'btusb_table[21].bInterfaceNumber')
     .bInterfaceClass = (cl), \
     ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:21: warning: excess elements in scalar initializer
     .bInterfaceClass = (cl), \
                        ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:21: note: (near initialization for 'btusb_table[21].bInterfaceNumber')
     .bInterfaceClass = (cl), \
                        ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:2: error: field name not in record or union initializer
     .bInterfaceSubClass = (sc), \
     ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:2: note: (near initialization for 'btusb_table[21].bInterfaceNumber')
     .bInterfaceSubClass = (sc), \
     ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:24: warning: excess elements in scalar initializer
     .bInterfaceSubClass = (sc), \
                           ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:24: note: (near initialization for 'btusb_table[21].bInterfaceNumber')
     .bInterfaceSubClass = (sc), \
                           ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:2: error: field name not in record or union initializer
     .bInterfaceProtocol = (pr)
     ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:2: note: (near initialization for 'btusb_table[21].bInterfaceNumber')
     .bInterfaceProtocol = (pr)
     ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:24: warning: excess elements in scalar initializer
     .bInterfaceProtocol = (pr)
                           ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:24: note: (near initialization for 'btusb_table[21].bInterfaceNumber')
     .bInterfaceProtocol = (pr)
                           ^
   drivers/bluetooth/btusb.c:137:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btusb.c:138:4: error: field name not in record or union initializer
       .driver_info = BTUSB_BCM_PATCHRAM },
       ^
   drivers/bluetooth/btusb.c:138:4: note: (near initialization for 'btusb_table[21].bInterfaceNumber')
   drivers/bluetooth/btusb.c:58:28: warning: excess elements in scalar initializer
    #define BTUSB_BCM_PATCHRAM 0x400
                               ^
   drivers/bluetooth/btusb.c:138:19: note: in expansion of macro 'BTUSB_BCM_PATCHRAM'
       .driver_info = BTUSB_BCM_PATCHRAM },
                      ^~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c:58:28: note: (near initialization for 'btusb_table[21].bInterfaceNumber')
    #define BTUSB_BCM_PATCHRAM 0x400
                               ^
   drivers/bluetooth/btusb.c:138:19: note: in expansion of macro 'BTUSB_BCM_PATCHRAM'
       .driver_info = BTUSB_BCM_PATCHRAM },
                      ^~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c:141:2: warning: braces around scalar initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
     ^
   drivers/bluetooth/btusb.c:141:2: note: (near initialization for 'btusb_table[21].driver_info')
   In file included from drivers/bluetooth/btusb.c:25:0:
   include/linux/usb.h:1060:2: error: field name not in record or union initializer
     .match_flags = USB_DEVICE_ID_MATCH_INT_INFO \
     ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1060:2: note: (near initialization for 'btusb_table[21].driver_info')
     .match_flags = USB_DEVICE_ID_MATCH_INT_INFO \
     ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1062:2: error: field name not in record or union initializer
     .idVendor = (vend), \
     ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1062:2: note: (near initialization for 'btusb_table[21].driver_info')
     .idVendor = (vend), \
     ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1062:14: warning: excess elements in scalar initializer
     .idVendor = (vend), \
                 ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1062:14: note: (near initialization for 'btusb_table[21].driver_info')
     .idVendor = (vend), \
                 ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:2: error: field name not in record or union initializer
     .bInterfaceClass = (cl), \
     ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:2: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceClass = (cl), \
     ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:21: warning: excess elements in scalar initializer
     .bInterfaceClass = (cl), \
                        ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:21: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceClass = (cl), \
                        ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:2: error: field name not in record or union initializer
     .bInterfaceSubClass = (sc), \
     ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:2: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceSubClass = (sc), \
     ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:24: warning: excess elements in scalar initializer
     .bInterfaceSubClass = (sc), \
                           ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:24: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceSubClass = (sc), \
                           ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:2: error: field name not in record or union initializer
     .bInterfaceProtocol = (pr)
     ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:2: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceProtocol = (pr)
     ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:24: warning: excess elements in scalar initializer
     .bInterfaceProtocol = (pr)
                           ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:24: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceProtocol = (pr)
                           ^
   drivers/bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c:142:4: error: field name not in record or union initializer
       .driver_info = BTUSB_BCM_PATCHRAM },
       ^
   drivers/bluetooth/btusb.c:142:4: note: (near initialization for 'btusb_table[21].driver_info')
   drivers/bluetooth/btusb.c:58:28: warning: excess elements in scalar initializer
    #define BTUSB_BCM_PATCHRAM 0x400
                               ^
   drivers/bluetooth/btusb.c:142:19: note: in expansion of macro 'BTUSB_BCM_PATCHRAM'
       .driver_info = BTUSB_BCM_PATCHRAM },
                      ^~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c:58:28: note: (near initialization for 'btusb_table[21].driver_info')
    #define BTUSB_BCM_PATCHRAM 0x400
                               ^
   drivers/bluetooth/btusb.c:142:19: note: in expansion of macro 'BTUSB_BCM_PATCHRAM'
       .driver_info = BTUSB_BCM_PATCHRAM },
                      ^~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c:145:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x04ca, 0xff, 0x01, 0x01),
     ^
   drivers/bluetooth/btusb.c:145:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:145:2: warning: excess elements in struct initializer
   drivers/bluetooth/btusb.c:145:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:149:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01),
     ^
   drivers/bluetooth/btusb.c:149:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:149:2: warning: excess elements in struct initializer
   drivers/bluetooth/btusb.c:149:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:153:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x0b05, 0xff, 0x01, 0x01),
     ^
   drivers/bluetooth/btusb.c:153:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:153:2: warning: excess elements in struct initializer
   drivers/bluetooth/btusb.c:153:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:157:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x050d, 0xff, 0x01, 0x01),
     ^
   drivers/bluetooth/btusb.c:157:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:157:2: warning: excess elements in struct initializer
   drivers/bluetooth/btusb.c:157:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:161:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01),
     ^
   drivers/bluetooth/btusb.c:161:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:161:2: warning: excess elements in struct initializer
   drivers/bluetooth/btusb.c:161:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:165:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x413c, 0xff, 0x01, 0x01),
     ^
   drivers/bluetooth/btusb.c:165:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:165:2: warning: excess elements in struct initializer
   drivers/bluetooth/btusb.c:165:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:169:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x0930, 0xff, 0x01, 0x01),
     ^
   drivers/bluetooth/btusb.c:169:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:169:2: warning: excess elements in struct initializer
   drivers/bluetooth/btusb.c:169:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:173:2: error: extra brace group at end of initializer
     { USB_DEVICE(0x8087, 0x0a5a),
     ^
   drivers/bluetooth/btusb.c:173:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:173:2: warning: excess elements in struct initializer
   drivers/bluetooth/btusb.c:173:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:176:2: error: extra brace group at end of initializer
     { } /* Terminating entry */
     ^
   drivers/bluetooth/btusb.c:176:2: note: (near initialization for 'btusb_table[21]')
   drivers/bluetooth/btusb.c:176:2: warning: excess elements in struct initializer
   drivers/bluetooth/btusb.c:176:2: note: (near initialization for 'btusb_table[21]')
>> drivers/bluetooth/btusb.c:177:2: error: expected '}' before ';' token
    };
     ^
   drivers/bluetooth/btusb.c:46:26: warning: 'btusb_driver' defined but not used [-Wunused-variable]
    static struct usb_driver btusb_driver;
                             ^~~~~~~~~~~~
   drivers/bluetooth/btusb.c:44:13: warning: 'reset' defined but not used [-Wunused-variable]
    static bool reset = true;
                ^~~~~
   drivers/bluetooth/btusb.c:42:13: warning: 'force_scofix' defined but not used [-Wunused-variable]
    static bool force_scofix;
                ^~~~~~~~~~~~
   drivers/bluetooth/btusb.c:41:13: warning: 'disable_scofix' defined but not used [-Wunused-variable]
    static bool disable_scofix;
                ^~~~~~~~~~~~~~

vim +138 drivers/bluetooth/btusb.c

5e23b923da Marcel Holtmann                2007-10-20   69  
54265202f1 Marcel Holtmann                2013-10-11   70  static const struct usb_device_id btusb_table[] = {
5e23b923da Marcel Holtmann                2007-10-20   71  	/* Generic Bluetooth USB device */
5e23b923da Marcel Holtmann                2007-10-20   72  	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
5e23b923da Marcel Holtmann                2007-10-20   73  
893ba5440a Marcel Holtmann                2015-01-28   74  	/* Generic Bluetooth AMP device */
893ba5440a Marcel Holtmann                2015-01-28   75  	{ USB_DEVICE_INFO(0xe0, 0x01, 0x04), .driver_info = BTUSB_AMP },
893ba5440a Marcel Holtmann                2015-01-28   76  
d63b282645 Daniel Drake                   2015-07-17   77  	/* Generic Bluetooth USB interface */
d63b282645 Daniel Drake                   2015-07-17   78  	{ USB_INTERFACE_INFO(0xe0, 0x01, 0x01) },
d63b282645 Daniel Drake                   2015-07-17   79  
1fa6535faf Henrik Rydberg                 2012-08-25   80  	/* Apple-specific (Broadcom) devices */
17b2772b8f Marcel Holtmann                2015-03-22   81  	{ USB_VENDOR_AND_INTERFACE_INFO(0x05ac, 0xff, 0x01, 0x01),
22f8e9dbf6 Marcel Holtmann                2015-10-20   82  	  .driver_info = BTUSB_BCM_APPLE | BTUSB_IFNUM_2 },
1fa6535faf Henrik Rydberg                 2012-08-25   83  
178c059e76 Cho, Yu-Chen                   2013-06-04   84  	/* MediaTek MT76x0E */
178c059e76 Cho, Yu-Chen                   2013-06-04   85  	{ USB_DEVICE(0x0e8d, 0x763f) },
178c059e76 Cho, Yu-Chen                   2013-06-04   86  
c510eae377 Oliver Neukum                  2011-09-21   87  	/* Broadcom SoftSailing reporting vendor specific */
2e8b506310 Don Zickus                     2012-03-28   88  	{ USB_DEVICE(0x0a5c, 0x21e1) },
c510eae377 Oliver Neukum                  2011-09-21   89  
3cd01976e7 Nobuhiro Iwamatsu              2010-08-20   90  	/* Apple MacBookPro 7,1 */
3cd01976e7 Nobuhiro Iwamatsu              2010-08-20   91  	{ USB_DEVICE(0x05ac, 0x8213) },
3cd01976e7 Nobuhiro Iwamatsu              2010-08-20   92  
0a79f67445 Cyril Lacoux                   2010-07-14   93  	/* Apple iMac11,1 */
0a79f67445 Cyril Lacoux                   2010-07-14   94  	{ USB_DEVICE(0x05ac, 0x8215) },
0a79f67445 Cyril Lacoux                   2010-07-14   95  
9c047157a2 Nobuhiro Iwamatsu              2010-08-20   96  	/* Apple MacBookPro6,2 */
9c047157a2 Nobuhiro Iwamatsu              2010-08-20   97  	{ USB_DEVICE(0x05ac, 0x8218) },
9c047157a2 Nobuhiro Iwamatsu              2010-08-20   98  
3e3ede7dda Edgar (gimli  Hucek            2010-11-04   99) 	/* Apple MacBookAir3,1, MacBookAir3,2 */
3e3ede7dda Edgar (gimli  Hucek            2010-11-04  100) 	{ USB_DEVICE(0x05ac, 0x821b) },
3e3ede7dda Edgar (gimli  Hucek            2010-11-04  101) 
a63b723d02 Pieter-Augustijn Van Malleghem 2011-09-07  102  	/* Apple MacBookAir4,1 */
a63b723d02 Pieter-Augustijn Van Malleghem 2011-09-07  103  	{ USB_DEVICE(0x05ac, 0x821f) },
a63b723d02 Pieter-Augustijn Van Malleghem 2011-09-07  104  
88d377b6c3 Marc-Antoine Perennou          2011-03-24  105  	/* Apple MacBookPro8,2 */
88d377b6c3 Marc-Antoine Perennou          2011-03-24  106  	{ USB_DEVICE(0x05ac, 0x821a) },
88d377b6c3 Marc-Antoine Perennou          2011-03-24  107  
f78b68261e Jurgen Kramer                  2011-09-04  108  	/* Apple MacMini5,1 */
f78b68261e Jurgen Kramer                  2011-09-04  109  	{ USB_DEVICE(0x05ac, 0x8281) },
f78b68261e Jurgen Kramer                  2011-09-04  110  
cfeb414537 Marcel Holtmann                2008-08-07  111  	/* AVM BlueFRITZ! USB v2.0 */
4fcef8ed75 Marcel Holtmann                2015-01-01  112  	{ USB_DEVICE(0x057c, 0x3800), .driver_info = BTUSB_SWAVE },
cfeb414537 Marcel Holtmann                2008-08-07  113  
cfeb414537 Marcel Holtmann                2008-08-07  114  	/* Bluetooth Ultraport Module from IBM */
cfeb414537 Marcel Holtmann                2008-08-07  115  	{ USB_DEVICE(0x04bf, 0x030a) },
cfeb414537 Marcel Holtmann                2008-08-07  116  
cfeb414537 Marcel Holtmann                2008-08-07  117  	/* ALPS Modules with non-standard id */
cfeb414537 Marcel Holtmann                2008-08-07  118  	{ USB_DEVICE(0x044e, 0x3001) },
cfeb414537 Marcel Holtmann                2008-08-07  119  	{ USB_DEVICE(0x044e, 0x3002) },
cfeb414537 Marcel Holtmann                2008-08-07  120  
cfeb414537 Marcel Holtmann                2008-08-07  121  	/* Ericsson with non-standard id */
cfeb414537 Marcel Holtmann                2008-08-07  122  	{ USB_DEVICE(0x0bdb, 0x1002) },
cfeb414537 Marcel Holtmann                2008-08-07  123  
cfeb414537 Marcel Holtmann                2008-08-07  124  	/* Canyon CN-BTU1 with HID interfaces */
7a9d402053 Marcel Holtmann                2008-11-30  125  	{ USB_DEVICE(0x0c10, 0x0000) },
cfeb414537 Marcel Holtmann                2008-08-07  126  
d13431ca3e Wen-chien Jesse Sung           2011-11-08  127  	/* Broadcom BCM20702A0 */
d13431ca3e Wen-chien Jesse Sung           2011-11-08  128  	{ USB_DEVICE(0x413c, 0x8197) },
d13431ca3e Wen-chien Jesse Sung           2011-11-08  129  
d049f4e513 Marcel Holtmann                2015-01-26  130  	/* Broadcom BCM20702B0 (Dynex/Insignia) */
d049f4e513 Marcel Holtmann                2015-01-26  131  	{ USB_DEVICE(0x19ff, 0x0239), .driver_info = BTUSB_BCM_PATCHRAM },
d049f4e513 Marcel Holtmann                2015-01-26  132  
2faf71ce90 Santtu Rekilä                  2015-10-05  133  	/* Broadcom BCM43142A0 (Foxconn/Lenovo) */
6b3a9e1458 Dmitry Tunin                   2017-07-06  134  	{ USB_VENDOR_AND_INTERFACE_INFO(0x105b, 0xff, 0x01, 0x01),
2faf71ce90 Santtu Rekilä                  2015-10-05  135  
a57bac4346 Christoph Haag                 2017-02-10  136  	/* Broadcom BCM920703 (HTC Vive) */
a57bac4346 Christoph Haag                 2017-02-10 @137  	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
a57bac4346 Christoph Haag                 2017-02-10 @138  	  .driver_info = BTUSB_BCM_PATCHRAM },
a57bac4346 Christoph Haag                 2017-02-10  139  
985140369b Steven Harms                   2012-04-13  140  	/* Foxconn - Hon Hai */
6029ddc233 Heinrich Siebmanns             2014-12-03  141  	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
6029ddc233 Heinrich Siebmanns             2014-12-03  142  	  .driver_info = BTUSB_BCM_PATCHRAM },
985140369b Steven Harms                   2012-04-13  143  
8f0c304c69 Matej Dubovy                   2015-02-02  144  	/* Lite-On Technology - Broadcom based */
8f0c304c69 Matej Dubovy                   2015-02-02  145  	{ USB_VENDOR_AND_INTERFACE_INFO(0x04ca, 0xff, 0x01, 0x01),
8f0c304c69 Matej Dubovy                   2015-02-02  146  	  .driver_info = BTUSB_BCM_PATCHRAM },
8f0c304c69 Matej Dubovy                   2015-02-02  147  
92c385f46b Gustavo Padovan                2012-08-06  148  	/* Broadcom devices with vendor specific id */
10d4c6736e Petri Gynther                  2014-05-08  149  	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01),
10d4c6736e Petri Gynther                  2014-05-08  150  	  .driver_info = BTUSB_BCM_PATCHRAM },
92c385f46b Gustavo Padovan                2012-08-06  151  
c2aef6e8cb Marcel Holtmann                2014-07-21  152  	/* ASUSTek Computer - Broadcom based */
9a5abdaaf9 Rick Dunn                      2015-01-17  153  	{ USB_VENDOR_AND_INTERFACE_INFO(0x0b05, 0xff, 0x01, 0x01),
9a5abdaaf9 Rick Dunn                      2015-01-17  154  	  .driver_info = BTUSB_BCM_PATCHRAM },
c2aef6e8cb Marcel Holtmann                2014-07-21  155  
5bcecf3253 Ken O'Brien                    2013-09-21  156  	/* Belkin F8065bf - Broadcom based */
6331c686e6 Marcel Holtmann                2015-03-27  157  	{ USB_VENDOR_AND_INTERFACE_INFO(0x050d, 0xff, 0x01, 0x01),
6331c686e6 Marcel Holtmann                2015-03-27  158  	  .driver_info = BTUSB_BCM_PATCHRAM },
5bcecf3253 Ken O'Brien                    2013-09-21  159  
9113bfd82d Jurgen Kramer                  2014-02-15  160  	/* IMC Networks - Broadcom based */
6331c686e6 Marcel Holtmann                2015-03-27  161  	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01),
6331c686e6 Marcel Holtmann                2015-03-27  162  	  .driver_info = BTUSB_BCM_PATCHRAM },
9113bfd82d Jurgen Kramer                  2014-02-15  163  
fdfddc6017 Wen-chien Jesse Sung           2017-01-10  164  	/* Dell Computer - Broadcom based  */
fdfddc6017 Wen-chien Jesse Sung           2017-01-10  165  	{ USB_VENDOR_AND_INTERFACE_INFO(0x413c, 0xff, 0x01, 0x01),
fdfddc6017 Wen-chien Jesse Sung           2017-01-10  166  	  .driver_info = BTUSB_BCM_PATCHRAM },
fdfddc6017 Wen-chien Jesse Sung           2017-01-10  167  
1623d0bf84 Dmitry Tunin                   2015-12-05  168  	/* Toshiba Corp - Broadcom based */
1623d0bf84 Dmitry Tunin                   2015-12-05  169  	{ USB_VENDOR_AND_INTERFACE_INFO(0x0930, 0xff, 0x01, 0x01),
1623d0bf84 Dmitry Tunin                   2015-12-05  170  	  .driver_info = BTUSB_BCM_PATCHRAM },
1623d0bf84 Dmitry Tunin                   2015-12-05  171  
40df783d1e Marcel Holtmann                2014-07-06  172  	/* Intel Bluetooth USB Bootloader (RAM module) */
d92f2df056 Marcel Holtmann                2014-07-06 @173  	{ USB_DEVICE(0x8087, 0x0a5a),
d92f2df056 Marcel Holtmann                2014-07-06  174  	  .driver_info = BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
40df783d1e Marcel Holtmann                2014-07-06  175  
5e23b923da Marcel Holtmann                2007-10-20  176  	{ }	/* Terminating entry */
5e23b923da Marcel Holtmann                2007-10-20 @177  };
5e23b923da Marcel Holtmann                2007-10-20  178  

:::::: The code at line 138 was first introduced by commit
:::::: a57bac43468e005064d6560183b313b269403f0a Bluetooth: btusb: add support for 0bb4:0306

:::::: TO: Christoph Haag <haagch@frickel.club>
:::::: CC: Marcel Holtmann <marcel@holtmann.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--OgqxwSJOaUobr8KG
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
g+MP/G9QOUqK6+UAAA==

--OgqxwSJOaUobr8KG--
