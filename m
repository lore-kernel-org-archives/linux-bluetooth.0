Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] textfile.c find_key
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <CBBBD909D2D6D211B4700090273F9E6E04C49B68@polaris.hhn.com>
References: <CBBBD909D2D6D211B4700090273F9E6E04C49B68@polaris.hhn.com>
Content-Type: multipart/mixed; boundary="=-61KGt/Tdy/lVG17z//9T"
Message-Id: <1131494589.5544.22.camel@blade>
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
Date: Wed, 09 Nov 2005 01:03:09 +0100


--=-61KGt/Tdy/lVG17z//9T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Robert,

> It might possibly be.  I'm using an Arm processor with the kernel
> version 2.6.10 for use with Busybox.  It's probably a safe bet that
> not many people are using an Arm  processor so it could be something
> about that.  I'll look around.

okay lets check for (map == NULL). The attached patch would do it the
right way.

Regards

Marcel


--=-61KGt/Tdy/lVG17z//9T
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: textfile.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/textfile.c,v
retrieving revision 1.9
diff -u -r1.9 textfile.c
--- textfile.c	29 Oct 2005 22:36:31 -0000	1.9
+++ textfile.c	9 Nov 2005 00:01:34 -0000
@@ -149,7 +149,7 @@
 	}
 
 	map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_LOCKED, fd, 0);
-	if (map == MAP_FAILED) {
+	if (!map || map == MAP_FAILED) {
 		err = errno;
 		goto unlock;
 	}
@@ -243,7 +243,7 @@
 	size = st.st_size;
 
 	map = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
-	if (map == MAP_FAILED) {
+	if (!map || map == MAP_FAILED) {
 		err = errno;
 		goto unlock;
 	}

--=-61KGt/Tdy/lVG17z//9T--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
