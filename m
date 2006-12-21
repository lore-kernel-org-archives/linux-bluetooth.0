Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 22 Dec 2006 00:15:20 +0500
From: Andrey Rahmatullin <wrar-alt@mail.ru>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20061221191520.GC18112@wrars-comp.wrarsdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] bluez-gnome link fix
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0606007335=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0606007335==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline


--zaRBsRFn0XYhEU69
Content-Type: multipart/mixed; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

There is a small patch which fixes linking of bluetooth-sendto with
--as-needed linker option (libs should be in command line only after
sources and static libs that use them).

--=20
WBR, wRAR (ALT Linux Team)

--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="bluez-gnome-0.6-alt-link-fixes.patch"
Content-Transfer-Encoding: quoted-printable

--- bluez-gnome/sendto/Makefile.am.orig	2006-10-22 23:41:40 +0600
+++ bluez-gnome/sendto/Makefile.am	2006-10-31 21:56:02 +0500
@@ -3,7 +3,7 @@
=20
 bluetooth_sendto_SOURCES =3D main.c
=20
-bluetooth_sendto_LDADD =3D @GTK_LIBS@ @DBUS_LIBS@ $(top_builddir)/common/l=
ibcommon.a
+bluetooth_sendto_LDADD =3D @GTK_LIBS@ $(top_builddir)/common/libcommon.a @=
DBUS_LIBS@
=20
 AM_CFLAGS =3D @DBUS_CFLAGS@ @GTK_CFLAGS@
=20

--kvUQC+jR9YzypDnK--

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFit1IB4Vf7hFmt5URApAeAJ997NQAKQfcc2lFscQtCwxJNiKc2gCg3LqX
hvuwJk27OrlhvZjte2upF7A=
=W31w
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--


--===============0606007335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0606007335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0606007335==--
