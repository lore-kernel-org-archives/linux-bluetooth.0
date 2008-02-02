Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201958323.15090.36.camel@violet>
References: <1201926335.15090.32.camel@violet>
	<1201957427.2389.354.camel@cookie.hadess.net>
	<1201958323.15090.36.camel@violet>
Content-Type: multipart/mixed; boundary="=-PrhdpMvHNkOEdpaANjuI"
Date: Sat, 02 Feb 2008 14:19:25 +0000
Message-Id: <1201961965.2389.358.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [BlueZ-Announce] Release
	of	bluez-libs-3.25	and	bluez-utils-3.25
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-PrhdpMvHNkOEdpaANjuI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Sat, 2008-02-02 at 14:18 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > this is an update release of the new stable versions of the Bluetooth
> > > library and the utilities. This release updates the audio service with
> > > experimental MPEG12/MP3 support. It also updates the GStreamer plugins
> > > to make use of it.
> > 
> > I got a build problem with the 3.25 release of bluez-libs:
> > sdp.c: In function 'sdp_data_alloc_with_length':
> > sdp.c:450: error: 'USHRT_MAX' undeclared (first use in this function)
> > sdp.c:450: error: (Each undeclared identifier is reported only once
> > sdp.c:450: error: for each function it appears in.)
> > sdp.c: In function 'sdp_append_to_buf':
> > sdp.c:2393: error: 'UCHAR_MAX' undeclared (first use in this function)
> > make[2]: *** [sdp.lo] Error 1
> > 
> > The attached patch fixes it for me, although I don't see the problem on
> > my older system (Fedora 8 vs. Rawhide).
> 
> I hate when glibc changes its behavior. This code hasn't been touched
> for over 3 years ;)
> 
> Anyway. Patch has been applied. Thanks.

I have no idea why they changed that. Same problem with a few defines in
bluez-utils (missing UCHAR_MAX, USHRT_MAX and UINT_MAX).

Patch attached

--=-PrhdpMvHNkOEdpaANjuI
Content-Disposition: attachment;
	filename=bluez-utils-missing-limits-include.patch
Content-Type: text/x-patch; name=bluez-utils-missing-limits-include.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: common/sdp-dummy.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/sdp-dummy.c,v
retrieving revision 1.6
diff -u -p -r1.6 sdp-dummy.c
--- common/sdp-dummy.c	2 Feb 2008 03:37:21 -0000	1.6
+++ common/sdp-dummy.c	2 Feb 2008 13:09:24 -0000
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <errno.h>
+#include <limits.h>
 
 #include "logging.h"
 #include "sdp-xml.h"
Index: common/sdp-expat.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/sdp-expat.c,v
retrieving revision 1.11
diff -u -p -r1.11 sdp-expat.c
--- common/sdp-expat.c	2 Feb 2008 03:37:21 -0000	1.11
+++ common/sdp-expat.c	2 Feb 2008 13:09:24 -0000
@@ -26,6 +26,7 @@
 #endif
 
 #include <stdlib.h>
+#include <limits.h>
 
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
Index: common/sdp-glib.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/sdp-glib.c,v
retrieving revision 1.6
diff -u -p -r1.6 sdp-glib.c
--- common/sdp-glib.c	2 Feb 2008 03:37:21 -0000	1.6
+++ common/sdp-glib.c	2 Feb 2008 13:09:24 -0000
@@ -26,6 +26,7 @@
 #endif
 
 #include <stdlib.h>
+#include <limits.h>
 
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
Index: sdpd/request.c
===================================================================
RCS file: /cvsroot/bluez/utils/sdpd/request.c,v
retrieving revision 1.20
diff -u -p -r1.20 request.c
--- sdpd/request.c	2 Feb 2008 03:37:48 -0000	1.20
+++ sdpd/request.c	2 Feb 2008 13:09:24 -0000
@@ -32,6 +32,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <malloc.h>
+#include <limits.h>
 #include <sys/socket.h>
 
 #include <bluetooth/bluetooth.h>
Index: audio/pcm_bluetooth.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/pcm_bluetooth.c,v
retrieving revision 1.98
diff -u -p -r1.98 pcm_bluetooth.c
--- audio/pcm_bluetooth.c	2 Feb 2008 03:37:05 -0000	1.98
+++ audio/pcm_bluetooth.c	2 Feb 2008 13:45:15 -0000
@@ -33,6 +33,7 @@
 #include <sys/time.h>
 #include <pthread.h>
 #include <signal.h>
+#include <limits.h>
 
 #include <netinet/in.h>
 

--=-PrhdpMvHNkOEdpaANjuI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-PrhdpMvHNkOEdpaANjuI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-PrhdpMvHNkOEdpaANjuI--
