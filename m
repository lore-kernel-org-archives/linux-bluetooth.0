Return-Path: <cyrus@holtmann.org>
Message-ID: <4A7C7585.7000409@dell.com>
Date: Fri, 07 Aug 2009 13:42:13 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Revert "Add API definition for device nodes"
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig36336FE2AEBA513F28ECB055"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig36336FE2AEBA513F28ECB055
Content-Type: multipart/mixed;
 boundary="------------010407060309080609040800"

This is a multi-part message in MIME format.
--------------010407060309080609040800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This reverts commit 438c23eb400088fbdc830f7287af175559ce9a18.
There is no code in the tree to support these APIs, so they shouldn't
be in the documentation.
---
 doc/device-api.txt |   34 ----------------------------------
 doc/node-api.txt   |   28 ----------------------------
 2 files changed, 0 insertions(+), 62 deletions(-)
 delete mode 100644 doc/node-api.txt

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------010407060309080609040800
Content-Type: text/x-patch;
 name="0001-Revert-Add-API-definition-for-device-nodes.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0001-Revert-Add-API-definition-for-device-nodes.patch"

=46rom 0f2b300557498eb5c23ccf3406901cfcc389a285 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <Mario_Limonciello@Dell.com>
Date: Fri, 7 Aug 2009 13:40:27 -0500
Subject: [PATCH] Revert "Add API definition for device nodes"

This reverts commit 438c23eb400088fbdc830f7287af175559ce9a18.
There is no code in the tree to support these APIs, so they shouldn't
be in the documentation.
---
 doc/device-api.txt |   34 ----------------------------------
 doc/node-api.txt   |   28 ----------------------------
 2 files changed, 0 insertions(+), 62 deletions(-)
 delete mode 100644 doc/node-api.txt

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 698f9ce..957f0d1 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -71,32 +71,6 @@ Methods		dict GetProperties()
=20
 			Possible errors: org.bluez.Error.NotConnected
=20
-		array{object} ListNodes()
-
-			Returns list of device node object paths.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.Failed
-					 org.bluez.Error.OutOfMemory
-
-		object CreateNode(string uuid)
-
-			Creates a persistent device node binding with a
-			remote device. The actual support for the specified
-			UUID depends if the device driver has support for
-			persistent binding. At the moment only RFCOMM TTY
-			nodes are supported.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotSupported
-
-		void RemoveNode(object node)
-
-			Removes a persistent device node binding.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
-
 Signals		PropertyChanged(string name, variant value)
=20
 			This signal indicates a changed value of the given
@@ -108,14 +82,6 @@ Signals		PropertyChanged(string name, variant value)
 			disconnection to a remote device has been requested.
 			The actual disconnection will happen 2 seconds later.
=20
-		NodeCreated(object node)
-
-			Parameter is object path of created device node.
-
-		NodeRemoved(object node)
-
-			Parameter is object path of removed device node.
-
 Properties	string Address [readonly]
=20
 			The Bluetooth device address of the remote device.
diff --git a/doc/node-api.txt b/doc/node-api.txt
deleted file mode 100644
index 7a33dab..0000000
--- a/doc/node-api.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-BlueZ D-Bus Node API description
-********************************
-
-Copyright (C) 2004-2008  Marcel Holtmann <marcel@holtmann.org>
-
-
-Node hierarchy
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Service		org.bluez
-Interface	org.bluez.Node
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/{nod=
e0,...}
-
-Methods		dict GetProperties()
-
-			Returns all properties for the device node. See the
-			properties section for available properties.
-
-			Possible Errors: org.bluez.Error.DoesNotExist
-					 org.bluez.Error.InvalidArguments
-
-Properties	string Name [readonly]
-
-			The name of the node. For example "rfcomm0".
-
-		object Device [readonly]
-
-			The object path of the device this node belongs to.
--=20
1.6.0.4


--------------010407060309080609040800--

--------------enig36336FE2AEBA513F28ECB055
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkp8dYUACgkQ2CrZjkA73Ytb7wCfRGHkQDCP/gxBBC7afN3zoF9t
Ne8An1E48FKuzFvQh+2Z4Pw1iDSpjPRt
=ijJx
-----END PGP SIGNATURE-----

--------------enig36336FE2AEBA513F28ECB055--
