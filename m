Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Ludovic Drolez <ldrolez@debian.org>
Date: Tue, 13 Feb 2007 18:44:42 +0000 (UTC)
Message-ID: <loom.20070213T193254-288@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] Small bugfix for dund
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi !

Sometimes, dund fails with the following error:
 dund[15658]: RFCOMM TTY creation failed. No such file or directory(2)

That's because, udev does not have the time to create the device.
I've found in dund's code that dund waits, at most, 30*100us for the device to
become readable. I think that the author made a typo here, and that 30*100ms is
much more appropriate (see the patch below).

Cheers,

   Ludovic.

========= patch
--- bluez-utils-3.7.orig/dund/dun.c
+++ bluez-utils-3.7/dund/dun.c
@@ -213,7 +213,7 @@
                if (stat(tty, &st) < 0) {
                        snprintf(tty, size, "/dev/rfcomm%d", id);
                        if (try--) {
-                               usleep(100);
+                               usleep(100000);
                                continue;
                        }
 
======== end patch


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
