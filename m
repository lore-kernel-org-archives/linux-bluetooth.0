Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Sep 2013 15:53:18 +0200
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Bluetooth regression in 3.10
Message-ID: <20130904155318.21cb6f37@milhouse>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/sm/+r_pUtaQQm9SD=eOskxO"; protocol="application/pgp-signature"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Sig_/sm/+r_pUtaQQm9SD=eOskxO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johan,

I noticed the thread "3.10-rc: bluetooth disappeared on thinkpad x60 (regre=
ssion)"
on lkml, but unfortunately the resulting patch does not fix the regression
for me.
I'm running 3.10.10, so the fix from the thread is applied to my kernel.

I see similar issues when trying to bring up my Bluetooth dongle:

$ lsusb | grep Blue
Bus 004 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Don=
gle (HCI mode)

This is a Broadcom chip based device.

$ hciconfig hci0 up                                           =20
Can't init device hci0: Operation not supported (95)

hcidump hci0 -X shows:

< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
    bdaddr 00:00:00:00:00:00 all 1
> HCI Event: Command Complete (0x0e) plen 4
    Delete Stored Link Key (0x03|0x0012) ncmd 1
    status 0x11 deleted 0
    Error: Unsupported Feature or Parameter Value
device: disconnected


The following workaround fixes the problem for me:

Index: linux/net/bluetooth/hci_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/net/bluetooth/hci_core.c	2013-07-21 17:34:22.749435335 +0200
+++ linux/net/bluetooth/hci_core.c	2013-09-04 15:39:07.580170034 +0200
@@ -598,7 +598,7 @@
 	u8 p;
=20
 	/* Only send HCI_Delete_Stored_Link_Key if it is supported */
-	if (hdev->commands[6] & 0x80) {
+	if (0) {
 		struct hci_cp_delete_stored_link_key cp;
=20
 		bacpy(&cp.bdaddr, BDADDR_ANY);


This isn't a real solution, of course.
I would be happy to test alternative solutions.

--=20
Michael

--Sig_/sm/+r_pUtaQQm9SD=eOskxO
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJztRAAoJEPUyvh2QjYsOy9EQAOBlpk5o7ct3/cHngNDsZJHa
ZV6Rr4aNnN90cHApAw8wWJfGVd1XqM5Qr07z4G5cfJKOTTSusO/6+vXDYoj23yuS
6Lh8ktC3WATJw+diZ/OG0Be+cJV5hZBRn2cLfI2CanSf9DgLNUsH0O4/20jTtg9Z
u1952D0JPtbqm+ql8pAYpJjTwG+H/ktwmgAIRsQM6AP2OmxNdnJaV1oOvaHvpa5L
p//3ZYSiAw+Qdw3/1YKMSEMb/v23rGvjkhuIYj59Lvgq7hUCa5ZUZQuMlbQDurUb
FNpKxYtFrZcNUV5V61S+Hxxncjdlx5lZEIHV5REcsUXL63QwrRlplmtOGNjxmeXF
GihnhY8KiLOM8E38iOi9W9oKzswJtXxfYKxWfQ0/08OQNdgFzNnwr97Iy8nSZ2mM
mZK++Q8peGe3L+t7cG/d7DDrkeV8SfGTBb8wdoEumacx+0ipr2HjWnkkqf6hBlSI
EXxTjeEDSg0JnbuToLK0/2mmLeK/rddujPisUEcway7uBgcvlrpxyMK7/ESqRx0m
SlvL2et1n0QNLvN5J6SpNUMYYqOEzlyEHXPVqwPs7dfQ5xaZfBPyN6fY7T9h5bAu
cPe04flb96P0GyKnzXsnM5dosyD1BnvBnYGP7Sm7LUiu6ix+iDI/qEfkz9JA/A0B
C+4uet9VKbcjUy9Ot/ya
=6UKS
-----END PGP SIGNATURE-----

--Sig_/sm/+r_pUtaQQm9SD=eOskxO--
