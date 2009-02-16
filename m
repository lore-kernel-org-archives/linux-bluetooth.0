Return-Path: <cyrus@holtmann.org>
Message-ID: <49999BDA.8010001@dell.com>
Date: Mon, 16 Feb 2009 11:01:14 -0600
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Show BlueZ gnome utilities in XFCE
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE7BAE9E598AB4EB11B7E2CF3"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE7BAE9E598AB4EB11B7E2CF3
Content-Type: multipart/mixed;
 boundary="------------070805070908020608010001"

This is a multi-part message in MIME format.
--------------070805070908020608010001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi:

This patch is forwarded from an Ubuntu bug tracker and Gnome bug
tracker.  The original patch is by Joel Ebel from Google.  It enables
the gnome tools to show up in XFCE.

Thanks,
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------070805070908020608010001
Content-Type: text/x-patch;
 name="08_XFCE.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="08_XFCE.patch"

diff -Nur -x '*.orig' -x '*~' bluez-gnome-1.8/analyzer/bluetooth-analyzer=
=2Edesktop.in bluez-gnome-1.8.new/analyzer/bluetooth-analyzer.desktop.in
--- bluez-gnome-1.8/analyzer/bluetooth-analyzer.desktop.in	2009-02-04 14:=
04:41.000000000 -0800
+++ bluez-gnome-1.8.new/analyzer/bluetooth-analyzer.desktop.in	2009-02-04=
 14:02:24.000000000 -0800
@@ -8,5 +8,5 @@
 MimeType=3Dapplication/x-hcidump;application/x-btsnoop;application/x-pkt=
log;
 Type=3DApplication
 Categories=3DSystem;Monitor;
-OnlyShowIn=3DGNOME;
+OnlyShowIn=3DGNOME;XFCE;
 NoDisplay=3Dtrue
diff -Nur -x '*.orig' -x '*~' bluez-gnome-1.8/applet/bluetooth-applet.des=
ktop.in bluez-gnome-1.8.new/applet/bluetooth-applet.desktop.in
--- bluez-gnome-1.8/applet/bluetooth-applet.desktop.in	2008-08-29 08:32:5=
3.000000000 -0700
+++ bluez-gnome-1.8.new/applet/bluetooth-applet.desktop.in	2009-02-04 13:=
55:31.000000000 -0800
@@ -7,4 +7,4 @@
 Terminal=3Dfalse
 Type=3DApplication
 Categories=3D
-OnlyShowIn=3DGNOME;
+OnlyShowIn=3DGNOME;XFCE;
diff -Nur -x '*.orig' -x '*~' bluez-gnome-1.8/properties/bluetooth-proper=
ties.desktop.in bluez-gnome-1.8.new/properties/bluetooth-properties.deskt=
op.in
--- bluez-gnome-1.8/properties/bluetooth-properties.desktop.in	2008-09-13=
 10:34:11.000000000 -0700
+++ bluez-gnome-1.8.new/properties/bluetooth-properties.desktop.in	2009-0=
2-04 14:02:56.000000000 -0800
@@ -7,4 +7,4 @@
 Terminal=3Dfalse
 Type=3DApplication
 Categories=3DGTK;GNOME;Settings;HardwareSettings;
-OnlyShowIn=3DGNOME;
+OnlyShowIn=3DGNOME;XFCE;

--------------070805070908020608010001--

--------------enigE7BAE9E598AB4EB11B7E2CF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkmZm9oACgkQ2CrZjkA73YurygCePzsv+I2FzXgL4o4VOnivfDNy
pO8AoIEsLbvEY2bWeufB6Akqx9oExK7z
=QV9C
-----END PGP SIGNATURE-----

--------------enigE7BAE9E598AB4EB11B7E2CF3--
