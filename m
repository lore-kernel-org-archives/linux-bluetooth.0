Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F598FC.4040803@ipb.pt>
Date: Wed, 30 Aug 2006 14:56:12 +0100
From: Rui Pedro Lopes <rlopes@ipb.pt>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F55552.4050502@ipb.pt> <44F55B85.6010800@palmsource.com>
In-Reply-To: <44F55B85.6010800@palmsource.com>
Subject: Re: [Bluez-devel] Some tests with the userland ALSA plugin for
 A2DP: problem with changing tracks
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Fr=E9d=E9ric DALLEAU wrote:
> Hi, There exists another alsa driver for a2dp. It's based upon the
> previous but uses a daemon instead of being standalone. It really
> miss documentation, but you can have a look at :
> http://sourceforge.net/mailarchive/forum.php?thread_id=3D20199009&forum_i=
d=3D1881
>  You'll need the latest cvs.
>
> If your headset support AVRCP (next/prev buttons) you may also use
> it, see somewhere in this thread :
> http://sourceforge.net/mailarchive/forum.php?thread_id=3D29326874&forum_i=
d=3D1881
>
>
> Let us know if it works! Fr=E9d=E9ric
>
It did!
I had to change the Makefile a bit though...
Here goes the diff:
=3D=3D=3D snip =3D=3D=3D
- --- alsa-plugins/Makefile.am    2006-07-26 10:56:20.000000000 +0100
+++ /home/rlopes/tash/btsco/alsa-plugins/Makefile.am    2006-08-30
14:39:00.000000000 +0100
@@ -5,7 +5,7 @@

 if ALSAPLUGIN

- -LIBS =3D
+#LIBS =3D

 alsadir =3D $(libdir)/alsa-lib

@@ -25,6 +25,7 @@

 bin_PROGRAMS =3D a2dpd
 a2dpd_SOURCES =3D a2dpd.c a2dplib.c a2dp_timer.c a2dp_ipc.c
+a2dpd_CFLAGS =3D $(AM_CFLAGS)
 a2dpd_LDADD =3D @BLUEZ_LIBS@ -lsbc -lpthread -lrt

 AM_CFLAGS =3D @ALSA_CFLAGS@ @BLUEZ_CFLAGS@ -pthread
=3D=3D=3D snip =3D=3D=3D

Cheers,

/rp
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9Zj8AhGrHSs5PNIRAi8bAJ9DQCZ+xZ89LyDUGAtgV72XV9zDgACfS4pO
NKzVAgM5zsbWcTN3oLYN3x4=3D
=3DSHLH
-----END PGP SIGNATURE-----


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
