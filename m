Return-Path: <cyrus@holtmann.org>
Message-ID: <4A0DE7F0.3090803@dell.com>
Date: Fri, 15 May 2009 17:08:48 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 3/3] Launch hid2hci from udev rules dynamically.
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7BF99BB61C34493584AB22A2"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7BF99BB61C34493584AB22A2
Content-Type: multipart/mixed;
 boundary="------------050108050504080003040205"

This is a multi-part message in MIME format.
--------------050108050504080003040205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

 Rather than launching hid2hci upon every boot even when the user
 doesn't have hardware that needs it installed, launch it from
 a set of udev rules that matches the hardware by attributes.

---
 scripts/Makefile.am       |    9 ++++++++-
 scripts/bluetooth.default |    3 ---
 scripts/bluetooth.init    |    7 -------
 scripts/hid2hci.rules     |   38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 11 deletions(-)
 create mode 100644 scripts/hid2hci.rules

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------050108050504080003040205
Content-Type: text/x-patch;
 name="0003-Launch-hid2hci-from-udev-rules-dynamically.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0003-Launch-hid2hci-from-udev-rules-dynamically.patch"

=46rom cde70b37b15cc2c41e97e3e307607a980809a5cf Mon Sep 17 00:00:00 2001
From: Mario Limonciello <Mario_Limonciello@Dell.com>
Date: Fri, 15 May 2009 17:02:56 -0500
Subject: [PATCH] Launch hid2hci from udev rules dynamically.
 Rather than launching hid2hci upon every boot even when the user
 doesn't have hardware that needs it installed, launch it from
 a set of udev rules that matches the hardware by attributes.

---
 scripts/Makefile.am       |    9 ++++++++-
 scripts/bluetooth.default |    3 ---
 scripts/bluetooth.init    |    7 -------
 scripts/hid2hci.rules     |   38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 11 deletions(-)
 create mode 100644 scripts/hid2hci.rules

diff --git a/scripts/Makefile.am b/scripts/Makefile.am
index 6a8eec7..2dc754a 100644
--- a/scripts/Makefile.am
+++ b/scripts/Makefile.am
@@ -9,7 +9,14 @@ udevdir =3D $(libexecdir)/udev
 udev_SCRIPTS =3D bluetooth_serial
 endif
=20
-EXTRA_DIST =3D bluetooth.rules bluetooth_serial bluetooth.init bluetooth=
=2Edefault
+if HID2HCI
+hid2hcidir =3D $(sysconfdir)/udev
+
+hid2hci_DATA =3D hid2hci.rules
+
+endif
+
+EXTRA_DIST =3D bluetooth.rules bluetooth_serial bluetooth.init bluetooth=
=2Edefault hid2hci.rules
=20
 MAINTAINERCLEANFILES =3D Makefile.in
=20
diff --git a/scripts/bluetooth.default b/scripts/bluetooth.default
index b0c4493..cdf37fa 100644
--- a/scripts/bluetooth.default
+++ b/scripts/bluetooth.default
@@ -1,4 +1 @@
 # Bluetooth configuraton file
-
-# Run hid2hci (allowed values are "true" and "false")
-HID2HCI_ENABLE=3Dtrue
diff --git a/scripts/bluetooth.init b/scripts/bluetooth.init
index ee12408..3ea8a89 100644
--- a/scripts/bluetooth.init
+++ b/scripts/bluetooth.init
@@ -10,13 +10,10 @@ NAME=3Dbluetooth
 DESC=3D"Bluetooth subsystem"
=20
 DAEMON_NAME=3Dbluetoothd
-HID2HCI_NAME=3Dhid2hci
=20
 DAEMON_EXEC=3D"`which $DAEMON_NAME || true`"
-HID2HCI_EXEC=3D"`which $HID2HCI_NAME || true`"
=20
 DAEMON_ENABLE=3Dtrue
-HID2HCI_ENABLE=3Dfalse
=20
 [ -e /etc/default/bluetooth ] && . /etc/default/bluetooth
=20
@@ -27,10 +24,6 @@ case "$1" in
 		$DAEMON_EXEC
 		echo -n " $DAEMON_NAME"
 	fi
-	if $HID2HCI_ENABLE && [ -x "$HID2HCI_EXEC" ] ; then
-		$HID2HCI_EXEC --tohci > /dev/null 2>&1 || true
-		echo -n " $HID2HCI_NAME"
-	fi
 	echo "."
 	;;
   stop)
diff --git a/scripts/hid2hci.rules b/scripts/hid2hci.rules
new file mode 100644
index 0000000..37bbe4b
--- /dev/null
+++ b/scripts/hid2hci.rules
@@ -0,0 +1,38 @@
+#UDEV Rules to match on Bluetooth USB dongles that need to be switched t=
o HCI mode upon
+#being plugged into the PC's USB bus.
+
+##Variety of Dell Bluetooth adapters
+# it looks like a bit of an odd rule, because it is matching
+# on a mouse device that is self powered, but that is where
+# a HID report needs to be sent to switch modes.
+#Known supported devices:
+# 413c:8154
+# 413c:8158
+# 413c:8162
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"413c", ENV{ID_CLASS}=3D=3D"mouse=
", ATTRS{bmAttributes}=3D=3D"e0", KERNEL=3D=3D"mouse*", RUN+=3D"/usr/sbin=
/hid2hci --method dell -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+
+##Logitech adapters
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c703"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c704"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c705"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70a"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70b"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70c"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70e"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c713"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c714"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c71b"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c71c"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
+
+##CSR adapters
+#These rules are for csr adapters to default them to hci mode
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0a12", ENV{ID_MODEL}=3D=3D"1000"=
 RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MOD=
EL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0458", ENV{ID_MODEL}=3D=3D"1000"=
 RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MOD=
EL} --mode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"1000"=
 RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MOD=
EL} --mode hci"
+
+#These rules are for csr adapters to default them to hid mode
+#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0a12", ENV{ID_MODEL}=3D=3D"0001=
" RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MO=
DEL} --mode hid"
+#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0458", ENV{ID_MODEL}=3D=3D"003f=
" RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MO=
DEL} --mode hid"
+#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"8203=
" RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MO=
DEL} --mode hid"
+#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"8204=
" RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MO=
DEL} --mode hid"
+#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"8207=
" RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MO=
DEL} --mode hid"
--=20
1.6.0.4


--------------050108050504080003040205--

--------------enig7BF99BB61C34493584AB22A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoN5/AACgkQ2CrZjkA73YsQEwCeNvQ5ejBEwRQ7iQZIxHCzp+Uz
w74Ani2p3miLWgYl7AvnDVl0dKM4W/iE
=2pLz
-----END PGP SIGNATURE-----

--------------enig7BF99BB61C34493584AB22A2--
