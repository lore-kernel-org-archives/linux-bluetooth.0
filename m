Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BT3C ceased working in kernel 2.6.6
From: David Woodhouse <dwmw2@infradead.org>
To: Antti =?ISO-8859-1?Q?M=E4kel=E4?= <zarhan@cs.tut.fi>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <Pine.GSO.4.58.0405111227090.9721@viherkiuru.cs.tut.fi>
References: <Pine.GSO.4.58.0405111227090.9721@viherkiuru.cs.tut.fi>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1084371696.4426.160.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 May 2004 15:21:36 +0100

On Tue, 2004-05-11 at 12:30 +0300, Antti Mäkelä wrote:
>   The firmware is placed in /usr/lib/hotplug/firmware as it should be,

That's not a bad idea....

Index: bluefw.h
===================================================================
RCS file: /cvsroot/bluez/bluefw/bluefw.h,v
retrieving revision 1.1
diff -u -p -r1.1 bluefw.h
--- bluefw.h	14 Jul 2002 22:45:09 -0000	1.1
+++ bluefw.h	12 May 2004 13:52:28 -0000
@@ -24,7 +24,7 @@
  * $Id: bluefw.h,v 1.1 2002/07/14 22:45:09 maxk Exp $
  */
 
-#define FWDIR  "/etc/bluetooth/firmware"
+#define FWDIR  "/usr/lib/hotplug/firmware"
 
 typedef union {
 	unsigned long iobase;
Index: firmware/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/bluefw/firmware/Makefile.am,v
retrieving revision 1.2
diff -u -p -r1.2 Makefile.am
--- firmware/Makefile.am	24 May 2002 00:19:18 -0000	1.2
+++ firmware/Makefile.am	12 May 2004 13:52:28 -0000
@@ -2,7 +2,7 @@
 #  $Id: Makefile.am,v 1.2 2002/05/24 00:19:18 maxk Exp $
 #
 
-fwdir   = /etc/bluetooth/firmware
+fwdir   = /usr/lib/hotplug/firmware
 
 fw_DATA = BCM2033-FW.bin BCM2033-MD.hex BCM-LEGAL.txt
 


-- 
dwmw2



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
