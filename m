Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201926335.15090.32.camel@violet>
References: <1201926335.15090.32.camel@violet>
Content-Type: multipart/mixed; boundary="=-f8dIymtslDiHSAjHHEQw"
Date: Sat, 02 Feb 2008 13:03:47 +0000
Message-Id: <1201957427.2389.354.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [BlueZ-Announce] Release of bluez-libs-3.25
	and	bluez-utils-3.25
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


--=-f8dIymtslDiHSAjHHEQw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2008-02-02 at 05:25 +0100, Marcel Holtmann wrote:
> Hi Folks,
> 
> this is an update release of the new stable versions of the Bluetooth
> library and the utilities. This release updates the audio service with
> experimental MPEG12/MP3 support. It also updates the GStreamer plugins
> to make use of it.

I got a build problem with the 3.25 release of bluez-libs:
sdp.c: In function 'sdp_data_alloc_with_length':
sdp.c:450: error: 'USHRT_MAX' undeclared (first use in this function)
sdp.c:450: error: (Each undeclared identifier is reported only once
sdp.c:450: error: for each function it appears in.)
sdp.c: In function 'sdp_append_to_buf':
sdp.c:2393: error: 'UCHAR_MAX' undeclared (first use in this function)
make[2]: *** [sdp.lo] Error 1

The attached patch fixes it for me, although I don't see the problem on
my older system (Fedora 8 vs. Rawhide).

--=-f8dIymtslDiHSAjHHEQw
Content-Disposition: attachment; filename=bluez-missing-limits-include.patch
Content-Type: text/x-patch; name=bluez-missing-limits-include.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: sdp.c
===================================================================
RCS file: /cvsroot/bluez/libs/src/sdp.c,v
retrieving revision 1.79
diff -u -p -r1.79 src/sdp.c
--- src/sdp.c	2 Feb 2008 03:11:11 -0000	1.79
+++ src/sdp.c	2 Feb 2008 12:02:02 -0000
@@ -35,6 +35,7 @@
 #include <stdlib.h>
 #include <malloc.h>
 #include <syslog.h>
+#include <limits.h>
 #include <sys/un.h>
 #include <sys/socket.h>
 #include <sys/time.h>

--=-f8dIymtslDiHSAjHHEQw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-f8dIymtslDiHSAjHHEQw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-f8dIymtslDiHSAjHHEQw--
