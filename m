Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464750FD.3080409@gentoo.org>
Date: Sun, 13 May 2007 20:55:09 +0300
From: =?UTF-8?B?UGV0dGVyaSBSw6R0eQ==?= <betelgeuse@gentoo.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4646071D.6020303@gentoo.org>
In-Reply-To: <4646071D.6020303@gentoo.org>
Subject: Re: [Bluez-devel] a2dpd getting into an endless loop when it fails
 to get a socket and not dying on CTRL+c
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1846891529=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1846891529==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig45B16845411D0872648C10F9"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig45B16845411D0872648C10F9
Content-Type: multipart/mixed; boundary="------------000804010104060006050903"

This is a multi-part message in MIME format.
--------------000804010104060006050903
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Petteri R=C3=A4ty kirjoitti:
>=20
> Basically it seems to go into an endless loop when it can't get the
> socket and I must then kill it with kill -9 <pid>.
>=20

Attached is a patch that fixes this.

Regards,
Petteri

--------------000804010104060006050903
Content-Type: text/x-patch;
 name="a2dpd-sigint.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="a2dpd-sigint.patch"

Index: a2dpd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/plugz/alsa-plugins/a2dpd/a2dpd.c,v
retrieving revision 1.31
diff -u -r1.31 a2dpd.c
--- a2dpd.c	10 May 2007 10:06:11 -0000	1.31
+++ a2dpd.c	13 May 2007 17:54:09 -0000
@@ -1780,7 +1780,7 @@
 	a2dp_init();
=20
 	// Run main loop
-	while(main_loop(addr)<0) {
+	while(main_loop(addr)<0 && !bSigINTReceived) {
 		sleep(1);
 	}
=20

--------------000804010104060006050903--

--------------enig45B16845411D0872648C10F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGR1D9cxLzpIGCsLQRAqxGAJ9b9lKo5YrVHCD/gkOIuR7xc/VIdACfd3AT
a1gpnqJsK0Smkib43R38IIA=
=LmoM
-----END PGP SIGNATURE-----

--------------enig45B16845411D0872648C10F9--


--===============1846891529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1846891529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1846891529==--
