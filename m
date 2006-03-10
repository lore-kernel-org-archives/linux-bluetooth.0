Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4411710D.5000509@suse.de>
From: Stefan Scheler <sscheler@suse.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig279A4DA6874DEE93C530A711"
Subject: [Bluez-devel] snd-bt-sco.ko and ACPI suspend
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
Date: Fri, 10 Mar 2006 13:29:01 +0100

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig279A4DA6874DEE93C530A711
Content-Type: multipart/mixed;
 boundary="------------060905010902060506000100"

This is a multi-part message in MIME format.
--------------060905010902060506000100
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello,

currently snd-bt-sco.ko is breaking ACPI suspend. So can we please apply
a minor patch like the following to CVS and fix this? Thanks.

Stefan

--------------060905010902060506000100
Content-Type: text/x-patch;
 name="fix_acpi_suspend_s3.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix_acpi_suspend_s3.diff"

Signed-off-by: Stefan Scheler <sscheler@suse.de>

diff -ru btsco/kernel/btsco.c btsco/kernel/btsco.c
--- btsco/kernel/btsco.c	2006-03-10 12:45:25.000000000 +0100
+++ btsco/kernel/btsco.c	2006-03-10 12:52:15.000000000 +0100
@@ -891,6 +891,11 @@
 	up(&bt_sco->thread_sem);
=20
 	do {
+
+#ifdef CONFIG_PM
+		try_to_freeze();
+#endif
+
 		if (signal_pending(current))
 			flush_signals(current);
=20

--------------060905010902060506000100--

--------------enig279A4DA6874DEE93C530A711
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEEXEQhHfBfWZJXtERA37fAJ4+8eF8Jv4bG6OhBzzb0arFAzdrhQCcCR3T
YvEaq+I7fiHno9GLDNz3BB4=
=1TxD
-----END PGP SIGNATURE-----

--------------enig279A4DA6874DEE93C530A711--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
