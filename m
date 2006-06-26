Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6297d67c0606260453ud6da167ic88d8ddee45ca072@mail.gmail.com>
References: <6297d67c0606260404kc22d718u4561df45147624e@mail.gmail.com>
	<449FC543.2090507@andric.com>
	<6297d67c0606260453ud6da167ic88d8ddee45ca072@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-dHHVMzTXYXeztv7xZn2k"
Date: Mon, 26 Jun 2006 14:02:03 +0200
Message-Id: <1151323323.7694.7.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez-utils do not cross compile
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-dHHVMzTXYXeztv7xZn2k
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Mayank,

> It works after I give the options --with-bluez=PATH
> But now when I say make, I get the following error:
>  
> arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common
> -I/usr/local/include -Wall -O2 -D_FORTIFY_SOURCE=2 -c `test -f
> 'hciattach.c' || echo './'`hciattach.c
> hciattach.c: In function `main':
> hciattach.c:1006: `PATH_MAX' undeclared (first use in this function) 
> hciattach.c:1006: (Each undeclared identifier is reported only once
> hciattach.c:1006: for each function it appears in.)
> hciattach.c:1006: warning: unused variable `dev'
> make[2]: *** [hciattach.o] Error 1

check if the attached patch helps.

Regards

Marcel


--=-dHHVMzTXYXeztv7xZn2k
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: tools/hciattach.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hciattach.c,v
retrieving revision 1.38
diff -u -r1.38 hciattach.c
--- tools/hciattach.c	29 Apr 2006 18:21:14 -0000	1.38
+++ tools/hciattach.c	26 Jun 2006 12:00:51 -0000
@@ -39,6 +39,7 @@
 #include <time.h>
 #include <sys/time.h>
 #include <sys/poll.h>
+#include <sys/param.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 

--=-dHHVMzTXYXeztv7xZn2k
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-dHHVMzTXYXeztv7xZn2k
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-dHHVMzTXYXeztv7xZn2k--
