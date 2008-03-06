Return-Path: <cyrus@holtmann.org>
Message-ID: <47D020D1.9020204@inov.pt>
Date: Thu, 06 Mar 2008 16:50:25 +0000
From: Jose Goncalves <jose.goncalves@inov.pt>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Bug in compat_ppoll
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

When I was cross-compiling Bluez for a system without the ppoll() system
call, I've found a bug on you ppoll() stub, compat_ppoll(), that causes
rfcomm to eat all CPU power when called in this way:

$ rfcomm listen 0 1 <cmd>

After the RFCOMM connection is established and the command is executed
the CPU load reaches 100%.

This patch solved my problem:

diff -Naur bluez-utils-3.27.orig/common/ppoll.h
bluez-utils-3.27/common/ppoll.h
--- bluez-utils-3.27.orig/common/ppoll.h    2007-05-20
09:28:28.000000000 +0100
+++ bluez-utils-3.27/common/ppoll.h 2008-03-06 15:56:02.000000000 +0000
@@ -7,5 +7,10 @@
 static inline int compat_ppoll(struct pollfd *fds, nfds_t nfds,
        const struct timespec *timeout, const sigset_t *sigmask)
 {
-   return poll(fds, nfds, timeout ? timeout->tv_sec * 1000 : 500);
+   if (timeout =3D=3D NULL)
+       return poll(fds, nfds, -1);
+   else if (timeout->tv_sec =3D=3D 0)
+       return poll(fds, nfds, 500);
+   else
+       return poll(fds, nfds, timeout->tv_sec * 1000);
 }

Regards,
Jos=E9 Miguel Gon=E7alves


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
