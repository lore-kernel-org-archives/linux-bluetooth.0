Return-Path: <fengguang.wu@intel.com>
Date: Sun, 16 Jul 2017 08:20:50 +0800
From: kbuild test robot <lkp@intel.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: kbuild-all@01.org, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Tunin <hanipouspilot@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Add support of all Foxconn (105b) Broadcom devices
Message-ID: <201707160824.jsgHdvYF%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
In-Reply-To: <1499340593-12739-1-git-send-email-hanipouspilot@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--LZvS9be/3tNcYl/X
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
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   include/linux/usb.h:1062:14: warning: excess elements in scalar initializer
     .idVendor = (vend), \
                 ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1062:14: note: (near initialization for 'btusb_table[21].driver_info')
     .idVendor = (vend), \
                 ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:2: error: field name not in record or union initializer
     .bInterfaceClass = (cl), \
     ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:2: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceClass = (cl), \
     ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:21: warning: excess elements in scalar initializer
     .bInterfaceClass = (cl), \
                        ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1063:21: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceClass = (cl), \
                        ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:2: error: field name not in record or union initializer
     .bInterfaceSubClass = (sc), \
     ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:2: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceSubClass = (sc), \
     ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:24: warning: excess elements in scalar initializer
     .bInterfaceSubClass = (sc), \
                           ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1064:24: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceSubClass = (sc), \
                           ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:2: error: field name not in record or union initializer
     .bInterfaceProtocol = (pr)
     ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:2: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceProtocol = (pr)
     ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:24: warning: excess elements in scalar initializer
     .bInterfaceProtocol = (pr)
                           ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/usb.h:1065:24: note: (near initialization for 'btusb_table[21].driver_info')
     .bInterfaceProtocol = (pr)
                           ^
   drivers//bluetooth/btusb.c:141:4: note: in expansion of macro 'USB_VENDOR_AND_INTERFACE_INFO'
     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//bluetooth/btusb.c:142:4: error: field name not in record or union initializer
       .driver_info = BTUSB_BCM_PATCHRAM },
       ^
   drivers//bluetooth/btusb.c:142:4: note: (near initialization for 'btusb_table[21].driver_info')
   drivers//bluetooth/btusb.c:58:28: warning: excess elements in scalar initializer
    #define BTUSB_BCM_PATCHRAM 0x400
                               ^
   drivers//bluetooth/btusb.c:142:19: note: in expansion of macro 'BTUSB_BCM_PATCHRAM'
       .driver_info = BTUSB_BCM_PATCHRAM },
                      ^~~~~~~~~~~~~~~~~~
   drivers//bluetooth/btusb.c:58:28: note: (near initialization for 'btusb_table[21].driver_info')
    #define BTUSB_BCM_PATCHRAM 0x400
                               ^
   drivers//bluetooth/btusb.c:142:19: note: in expansion of macro 'BTUSB_BCM_PATCHRAM'
       .driver_info = BTUSB_BCM_PATCHRAM },
                      ^~~~~~~~~~~~~~~~~~
>> drivers//bluetooth/btusb.c:145:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x04ca, 0xff, 0x01, 0x01),
     ^
   drivers//bluetooth/btusb.c:145:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:145:2: warning: excess elements in struct initializer
   drivers//bluetooth/btusb.c:145:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:149:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01),
     ^
   drivers//bluetooth/btusb.c:149:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:149:2: warning: excess elements in struct initializer
   drivers//bluetooth/btusb.c:149:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:153:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x0b05, 0xff, 0x01, 0x01),
     ^
   drivers//bluetooth/btusb.c:153:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:153:2: warning: excess elements in struct initializer
   drivers//bluetooth/btusb.c:153:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:157:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x050d, 0xff, 0x01, 0x01),
     ^
   drivers//bluetooth/btusb.c:157:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:157:2: warning: excess elements in struct initializer
   drivers//bluetooth/btusb.c:157:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:161:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01),
     ^
   drivers//bluetooth/btusb.c:161:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:161:2: warning: excess elements in struct initializer
   drivers//bluetooth/btusb.c:161:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:165:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x413c, 0xff, 0x01, 0x01),
     ^
   drivers//bluetooth/btusb.c:165:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:165:2: warning: excess elements in struct initializer
   drivers//bluetooth/btusb.c:165:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:169:2: error: extra brace group at end of initializer
     { USB_VENDOR_AND_INTERFACE_INFO(0x0930, 0xff, 0x01, 0x01),
     ^
   drivers//bluetooth/btusb.c:169:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:169:2: warning: excess elements in struct initializer
   drivers//bluetooth/btusb.c:169:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:173:2: error: extra brace group at end of initializer
     { USB_DEVICE(0x8087, 0x0a5a),
     ^
   drivers//bluetooth/btusb.c:173:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:173:2: warning: excess elements in struct initializer
   drivers//bluetooth/btusb.c:173:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:176:2: error: extra brace group at end of initializer
     { } /* Terminating entry */
     ^
   drivers//bluetooth/btusb.c:176:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:176:2: warning: excess elements in struct initializer
   drivers//bluetooth/btusb.c:176:2: note: (near initialization for 'btusb_table[21]')
   drivers//bluetooth/btusb.c:177:2: error: expected '}' before ';' token
    };
     ^
   drivers//bluetooth/btusb.c:46:26: warning: 'btusb_driver' defined but not used [-Wunused-variable]
    static struct usb_driver btusb_driver;
                             ^~~~~~~~~~~~
   drivers//bluetooth/btusb.c:44:13: warning: 'reset' defined but not used [-Wunused-variable]
    static bool reset = true;
                ^~~~~
   drivers//bluetooth/btusb.c:42:13: warning: 'force_scofix' defined but not used [-Wunused-variable]
    static bool force_scofix;
                ^~~~~~~~~~~~
   drivers//bluetooth/btusb.c:41:13: warning: 'disable_scofix' defined but not used [-Wunused-variable]
    static bool disable_scofix;
                ^~~~~~~~~~~~~~

vim +145 drivers//bluetooth/btusb.c

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
a57bac4346 Christoph Haag                 2017-02-10  137  	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
a57bac4346 Christoph Haag                 2017-02-10  138  	  .driver_info = BTUSB_BCM_PATCHRAM },
a57bac4346 Christoph Haag                 2017-02-10  139  
985140369b Steven Harms                   2012-04-13  140  	/* Foxconn - Hon Hai */
6029ddc233 Heinrich Siebmanns             2014-12-03  141  	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
6029ddc233 Heinrich Siebmanns             2014-12-03 @142  	  .driver_info = BTUSB_BCM_PATCHRAM },
985140369b Steven Harms                   2012-04-13  143  
8f0c304c69 Matej Dubovy                   2015-02-02  144  	/* Lite-On Technology - Broadcom based */
8f0c304c69 Matej Dubovy                   2015-02-02 @145  	{ USB_VENDOR_AND_INTERFACE_INFO(0x04ca, 0xff, 0x01, 0x01),
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
d92f2df056 Marcel Holtmann                2014-07-06  173  	{ USB_DEVICE(0x8087, 0x0a5a),
d92f2df056 Marcel Holtmann                2014-07-06  174  	  .driver_info = BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
40df783d1e Marcel Holtmann                2014-07-06  175  
5e23b923da Marcel Holtmann                2007-10-20  176  	{ }	/* Terminating entry */
5e23b923da Marcel Holtmann                2007-10-20  177  };
5e23b923da Marcel Holtmann                2007-10-20  178  

:::::: The code at line 145 was first introduced by commit
:::::: 8f0c304c693c5a9759ed6ae50d07d4590dad5ae7 Bluetooth: btusb: Add support for Lite-On (04ca) Broadcom based, BCM43142

:::::: TO: Matej Dubovy <matej.dubovy@gmail.com>
:::::: CC: Marcel Holtmann <marcel@holtmann.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--LZvS9be/3tNcYl/X
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
1IkWksYO7f8A61xKIKgkAwA=

--LZvS9be/3tNcYl/X--
