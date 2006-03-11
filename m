Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4412B8DB.1080508@suse.de>
From: Stefan Scheler <sscheler@suse.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco.ko and ACPI suspend
References: <4411710D.5000509@suse.de> <441223BD.8000903@xmission.com>
In-Reply-To: <441223BD.8000903@xmission.com>
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enigFAC240402BB2AB4CD049B746"
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
Date: Sat, 11 Mar 2006 12:47:39 +0100

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFAC240402BB2AB4CD049B746
Content-Type: multipart/mixed;
 boundary="------------060008020904000005040104"

This is a multi-part message in MIME format.
--------------060008020904000005040104
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

> Can you give me a safer patch that will work with 2.6.12 for example?

Well, yes. I also removed the unnecessary CONFIG_PM-define.
try_to_freeze() is also available with power management disabled as I
found out. The following patch has been tested with 2.6.11.4 and I
didn't notice any ill effects.

Stefan


--------------060008020904000005040104
Content-Type: text/x-patch;
 name="fix_suspend_v2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix_suspend_v2.diff"

diff -ru btsco.orig/kernel/btsco.c btsco/kernel/btsco.c
--- btsco.orig/kernel/btsco.c	2006-03-11 11:52:08.000000000 +0100
+++ btsco/kernel/btsco.c	2006-03-11 11:52:57.000000000 +0100
@@ -892,8 +892,11 @@
=20
 	do {
=20
-#ifdef CONFIG_PM
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,12))
 		try_to_freeze();
+#else
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
 #endif
=20
 		if (signal_pending(current))

--------------060008020904000005040104--

--------------enigFAC240402BB2AB4CD049B746
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEErjfhHfBfWZJXtERA/m9AJ9ZVir0QNIrCTS7WWLPt9pjSP1UGwCePbkZ
Yka9EX29IK+eK+vfPC9sH1k=
=eYOT
-----END PGP SIGNATURE-----

--------------enigFAC240402BB2AB4CD049B746--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
