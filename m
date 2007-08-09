Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 9 Aug 2007 12:44:17 -0700 (PDT)
From: hong zhang <henryzhang62@yahoo.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <mailman.178591.1186595427.21973.bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <769157.98123.qm@web58010.mail.re3.yahoo.com>
Subject: [Bluez-devel] build error for bluez-utils-3.11 on embedded arm
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

List,

I am building bluez-utils-3.11. bluez-libs-3.11 is
perfect for configure and make.

No problem for "configure --houst=arm-linux
CC=montavista-gcc --prefix=maypath_for_bluez-utils" on
bluez-utils-3.11. But make error occurs, it looks
local /usr/lib/libdbus-1.so instead libdbud-1.so in
montavista library. any clue?

[root@localhost hcid]# make
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
../eglib/libeglib.la -ldbus-1  
-L/root/Desktop/bluez/bluez-libs-3.11/lib -lbluetooth 
 -lexpat
arm_v6_vfp_le-gcc
-I/root/Desktop/bluez/bluez-libs-3.11/include
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
-DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2
-D_FORTIFY_SOURCE=2 -o .libs/hcid main.o 
libhciserver.a ../sdpd/libsdpserver.a
../common/libhelper.a ../eglib/.libs/libeglib.a
/usr/lib/libdbus-1.so -lnsl
-L/root/Desktop/bluez/bluez-libs-3.11/lib
/root/Desktop/bluez/bluez-libs-3.11/lib/libbluetooth.so
/usr/lib/libexpat.so  -Wl,--rpath
-Wl,/root/Desktop/bluez/bluez-libs-3.11/lib
/usr/lib/libdbus-1.so: could not read symbols: File in
wrong format
collect2: ld returned 1 exit status
make[1]: *** [hcid] Error 1
make[1]: Leaving directory
`/root/Desktop/bluez/bluez-utils-3.11/hcid'
make: *** [all] Error 2


---henry


       
____________________________________________________________________________________
Need a vacation? Get great deals
to amazing places on Yahoo! Travel.
http://travel.yahoo.com/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
