Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <10d5a90c0da.squonimo@virgilio.it>
Date: Tue, 29 Aug 2006 16:33:58 +0100 (GMT+01:00)
From: Alex B <squonimo@virgilio.it>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Subject: [Bluez-devel] Problems with bluez-utils 3.4
Reply-To: Alex B <squonimo@virgilio.it>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

hi all,
I'm trying to croos compile the bluez utils 3.4 for arm-linux 
(XScale PXA270).
I read many tutorial and howto, but i've always the 
same problem with dbus-glib.1 when I write make Install:
-----------------------------------
/usr/local/arm-linux/lib/gcc-
lib/arm-linux/3.3.2/../../../../arm-linux/bin/ld:
skipping incompatible 
/opt/gnome/lib/libdbus-glib-1.so when searching
for -ldbus-glib-1
/usr/local/arm-linux/lib/gcc-lib/arm-linux/3.3.2/../../../../arm-
linux/bin/ld:
cannot find -ldbus-glib-1
collect2: ld returned 1 exit 
status 
-----------------------------------

in /opt/gnome/lib libdbus-
glib-1.so it's a simlink to /usr/lib/libdbus-glib-1.so

Can someone 
help me???

tnx 
Alex B

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
