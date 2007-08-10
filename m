Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 10 Aug 2007 10:44:03 -0700 (PDT)
From: hong zhang <henryzhang62@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <mailman.195893.1186749978.21973.bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <257505.31786.qm@web58013.mail.re3.yahoo.com>
Subject: [Bluez-users] build error on hcid
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

List,

When I compiled hcid for bluez-utils-3.11 and complain
missing functions. And I could not find where they are
defined. Is any link I missed?

make  all-am
make[1]: Entering directory
`/root/Desktop/bluez/bluez-utils-3.11/hcid'
/bin/sh ../libtool --tag=CC --mode=link
arm_v6_vfp_le-gcc
-I/root/Desktop/bluez/bluez-libs-3.11/include  
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
-DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2
-D_FORTIFY_SOURCE=2   -o hcid  main.o libhciserver.a
../sdpd/libsdpserver.a ../common/libhelper.a
../eglib/libeglib.la
/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/target/usr/lib/libdbus-1.so
-L/root/Desktop/bluez/bluez-libs-3.11/lib -lbluetooth
-L/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/target/usr/lib
arm_v6_vfp_le-gcc
-I/root/Desktop/bluez/bluez-libs-3.11/include
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
-DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2
-D_FORTIFY_SOURCE=2 -o .libs/hcid main.o
/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/target/usr/lib/libdbus-1.so
 libhciserver.a ../sdpd/libsdpserver.a
../common/libhelper.a ../eglib/.libs/libeglib.a
-L/root/Desktop/bluez/bluez-libs-3.11/lib
/root/Desktop/bluez/bluez-libs-3.11/lib/libbluetooth.so
-L/opt/montavista/mobilinux/devkit/arm/v6_vfp_le/target/usr/lib
 -Wl,--rpath
-Wl,/root/Desktop/bluez/bluez-libs-3.11/lib
libhciserver.a(dbus-manager.o)(.text+0x2f4): In
function `list_adapters':
dbus-manager.c: undefined reference to
`dbus_message_iter_init_append'
libhciserver.a(dbus-manager.o)(.text+0x308):dbus-manager.c:
undefined reference to
`dbus_message_iter_open_container'
libhciserver.a(dbus-manager.o)(.text+0x36c):dbus-manager.c:
undefined reference to
`dbus_message_iter_append_basic'
libhciserver.a(dbus-manager.o)(.text+0x384):dbus-manager.c:
undefined reference to
`dbus_message_iter_close_container'
libhciserver.a(dbus-manager.o)(.text+0x548): In
function `list_services':
dbus-manager.c: undefined reference to
`dbus_message_iter_init_append'
libhciserver.a(dbus-manager.o)(.text+0x55c):dbus-manager.c:
undefined reference to
`dbus_message_iter_open_container'
......
......
......
../common/libhelper.a(sdp-expat.o)(.text+0x5c8):sdp-expat.c:
undefined reference to `XML_GetCurrentLineNumber'
../common/libhelper.a(sdp-expat.o)(.text+0x5d4):sdp-expat.c:
undefined reference to `XML_GetErrorCode'
../common/libhelper.a(sdp-expat.o)(.text+0x5d8):sdp-expat.c:
undefined reference to `XML_ErrorString'
../common/libhelper.a(sdp-expat.o)(.text+0x62c):sdp-expat.c:
undefined reference to `XML_Parse'
collect2: ld returned 1 exit status
make[1]: *** [hcid] Error 1
make[1]: Leaving directory
`/root/Desktop/bluez/bluez-utils-3.11/hcid'
make: *** [all] Error 2

----henry


       
____________________________________________________________________________________Ready for the edge of your seat? 
Check out tonight's top picks on Yahoo! TV. 
http://tv.yahoo.com/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
