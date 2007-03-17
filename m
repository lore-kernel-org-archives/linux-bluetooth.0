Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: "Vladimir Vasilev" <vladimir_v@asenovgrad.net>
MIME-Version: 1.0
Date: Sat, 17 Mar 2007 19:04:33 +0200
Message-ID: <op.tpce1vcu80yvcu@zaska>
Subject: [Bluez-users] help compilling bluez-utils 3.9
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net



Hi folks

I have some problems compilling bluez-utils 3.9 (latest official)
The configure script does not get me an error, so my next step is "make"\
Here is the error:


make[2]: Entering directory `/home/vladimir/programs/bluez-utils-3.9/hcid'
make  all-am
make[3]: Entering directory `/home/vladimir/programs/bluez-utils-3.9/hcid'
/bin/sh ../libtool --tag=CC --mode=link gcc -I/usr/include/dbus-1.0  
-I/usr/lib/dbus-1.0/include   -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2    
-o hcid  main.o libhciserver.a ../sdpd/libsdpserver.a  
../common/libhelper.a ../eglib/libeglib.la -L/lib -ldbus-1   -lbluetooth    
-lexpat
gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I../eglib -Wall  
-O2 -D_FORTIFY_SOURCE=2 -o hcid main.o  libhciserver.a  
../sdpd/libsdpserver.a ../common/libhelper.a ../eglib/.libs/libeglib.a  
-L/lib -ldbus-1 -lbluetooth /usr/lib/libexpat.so
libhciserver.a(dbus-common.o): In function `unregister_sdp_record':
dbus-common.c:(.text+0x90): undefined reference to  
`sdp_device_record_unregister_binary'
libhciserver.a(dbus-common.o): In function `register_sdp_binary':
dbus-common.c:(.text+0x106): undefined reference to  
`sdp_device_record_register_binary'
collect2: ld returned 1 exit status
make[3]: *** [hcid] Error 1
make[3]: Leaving directory `/home/vladimir/programs/bluez-utils-3.9/hcid'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/vladimir/programs/bluez-utils-3.9/hcid'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/vladimir/programs/bluez-utils-3.9'
make: *** [all] Error 2

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
