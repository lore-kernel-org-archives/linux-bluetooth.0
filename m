Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci.c:885: storage size of `iv' isn't known
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.63.0601022121160.23868@sundust>
References: <20051231185308.E3D14130C8@sc8-sf-spam2.sourceforge.net>
	 <Pine.LNX.4.63.0512312154150.23868@sundust>
	 <1136201460.22810.10.camel@localhost>
	 <Pine.LNX.4.63.0601022121160.23868@sundust>
Content-Type: multipart/mixed; boundary="=-nKSUhkDOyv8jewJ7LtN1"
Message-Id: <1136230278.24985.4.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 02 Jan 2006 20:31:18 +0100


--=-nKSUhkDOyv8jewJ7LtN1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

> OS: Openwall GNU/*/Linux., http://www.openwall.com/Owl/
> 
> ls -l /lib/libc[.-]*
> -rwxr-xr-x    1 root     root         3.9M  20  2003 /lib/libc-2.1.3.so
> lrwxrwxrwx    1 root     root           13  23  2004 /lib/libc.so.6 -> libc-2.1.3.so
> 
> $ gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-unknown-linux/2.95.3/specs
> gcc version 2.95.3 20010315 (release)

check if the attached patch helps.

Regards

Marcel


--=-nKSUhkDOyv8jewJ7LtN1
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: src/hci.c
===================================================================
RCS file: /cvsroot/bluez/libs/src/hci.c,v
retrieving revision 1.88
diff -u -r1.88 hci.c
--- src/hci.c	21 Nov 2005 10:26:57 -0000	1.88
+++ src/hci.c	2 Jan 2006 19:30:21 -0000
@@ -36,6 +36,7 @@
 #include <string.h>
 
 #include <sys/param.h>
+#include <sys/uio.h>
 #include <sys/poll.h>
 #include <sys/types.h>
 #include <sys/ioctl.h>

--=-nKSUhkDOyv8jewJ7LtN1--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
