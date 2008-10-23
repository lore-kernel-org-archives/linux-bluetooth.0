Return-Path: <cyrus@holtmann.org>
Message-ID: <4900DBD0.3040108@dell.com>
Date: Thu, 23 Oct 2008 15:17:20 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] first udev rules for running hid2hci 
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7D7AC00EB0B9F54B8DF7AC01"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7D7AC00EB0B9F54B8DF7AC01
Content-Type: multipart/mixed;
 boundary="------------030303070907040101070009"

This is a multi-part message in MIME format.
--------------030303070907040101070009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi:

Attached is a patch that adds another set of udev rules that will run
hid2hci, at least for the Dell BT adapters.  Other adapters can get
added in too, but I think some more attributes will be needed for them.=20
I'm doing this as a separate set of udev rules than the PCMCIA rules so
that these can be installed by default whereas the PCMCIA ones are
normally placed in a different binary package for distros.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------030303070907040101070009
Content-Type: text/x-patch;
 name="hid2hci_udev.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="hid2hci_udev.patch"

diff -Nur -x '*.orig' -x '*~' bluez-4.12/scripts/bluetooth.rules bluez-4.=
12.new/scripts/bluetooth.rules
--- bluez-4.12/scripts/bluetooth.rules	2008-10-07 13:28:29.000000000 -050=
0
+++ bluez-4.12.new/scripts/bluetooth.rules	1969-12-31 18:00:00.000000000 =
-0600
@@ -1,35 +0,0 @@
-# Brain Boxes BL-620 Bluetooth Adapter
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Brain Box=
es", SYSFS{prod_id2}=3D=3D"Bluetooth PC Card", ENV{HCIOPTS}=3D"bboxes", R=
UN+=3D"bluetooth_serial"
-
-# Xircom CreditCard Bluetooth Adapter
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Xircom", =
SYSFS{prod_id3}=3D=3D"CBT", ENV{HCIOPTS}=3D"xircom", RUN+=3D"bluetooth_se=
rial"
-
-# Xircom RealPort2 Bluetooth Adapter
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Xircom", =
SYSFS{prod_id3}=3D=3D"CBT", ENV{HCIOPTS}=3D"xircom", RUN+=3D"bluetooth_se=
rial"
-
-# IBM Bluetooth PC Card II
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"IBM", SYS=
FS{prod_id2}=3D=3D"Bluetooth PC Card II", ENV{HCIOPTS}=3D"tdk", RUN+=3D"b=
luetooth_serial"
-
-# TDK Bluetooth PC Card
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"TDK", SYS=
FS{prod_id2}=3D=3D"Bluetooth PC Card II", ENV{HCIOPTS}=3D"tdk", RUN+=3D"b=
luetooth_serial"
-
-# AmbiCom BT2000C Bluetooth PC/CF Card
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"AmbiCom B=
T2000C", SYSFS{prod_id2}=3D=3D"Bluetooth PC/CF Card", ENV{HCIOPTS}=3D"bt2=
000c", RUN+=3D"bluetooth_serial"
-
-# COM One Platinium Bluetooth PC Card
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"COM1 SA",=
 SYSFS{prod_id2}=3D=3D"MC310 CARD", ENV{HCIOPTS}=3D"comone", RUN+=3D"blue=
tooth_serial"
-
-# Sphinx PICO Card
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"SPHINX", =
SYSFS{prod_id2}=3D=3D"BT-CARD", ENV{HCIOPTS}=3D"picocard", RUN+=3D"blueto=
oth_serial"
-
-# H-Soft blue+Card
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"H-Soft", =
SYSFS{prod_id2}=3D=3D"Blue+CARD", ENV{HCIOPTS}=3D"$sysfs{manf_id},$sysfs{=
card_id}", RUN+=3D"bluetooth_serial"
-
-# Compaq iPAQ Bluetooth Sleeve, Belkin F8T020, any other muppet who used=
 an OXCF950 and didn't bother to program it appropriately.
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"CF CARD",=
 SYSFS{prod_id2}=3D=3D"GENERIC", ENV{HCIOPTS}=3D"$sysfs{manf_id},$sysfs{c=
ard_id}", RUN+=3D"bluetooth_serial"
-
-# Zoom Bluetooth Card and Sitecom CN-504 Card
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"PCMCIA", =
SYSFS{prod_id2}=3D=3D"Bluetooth Card", ENV{HCIOPTS}=3D"zoom", RUN+=3D"blu=
etooth_serial"
-
-# CC&C BT0100M
-SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Bluetooth=
 BT0100M", ENV{HCIOPTS}=3D"bcsp 115200", RUN+=3D"bluetooth_serial"
diff -Nur -x '*.orig' -x '*~' bluez-4.12/scripts/hid2hci.rules bluez-4.12=
=2Enew/scripts/hid2hci.rules
--- bluez-4.12/scripts/hid2hci.rules	1969-12-31 18:00:00.000000000 -0600
+++ bluez-4.12.new/scripts/hid2hci.rules	2008-10-23 15:09:14.000000000 -0=
500
@@ -0,0 +1,8 @@
+#UDEV Rules to match on Bluetooth USB dongles that need to be switched t=
o HCI mode upon
+#being plugged into the PC's USB bus.
+
+#This rule covers a variety of Dell Bluetooth adapters
+# it looks like a bit of an odd rule, because it is matching
+# on a mouse device that is self powered, but that is where
+# a HID report needs to be sent to switch modes.
+ACTION=3D=3D"add", SYSFS{idVendor}=3D=3D"413c", ATTRS{bInterfaceProtocol=
}=3D=3D"02", ATTRS{bmAttributes}=3D=3D"e0", RUN+=3D"/usr/sbin/hid2hci --t=
ohci"
diff -Nur -x '*.orig' -x '*~' bluez-4.12/scripts/Makefile.am bluez-4.12.n=
ew/scripts/Makefile.am
--- bluez-4.12/scripts/Makefile.am	2008-10-07 13:28:29.000000000 -0500
+++ bluez-4.12.new/scripts/Makefile.am	2008-10-23 15:11:15.000000000 -050=
0
@@ -2,14 +2,14 @@
 if PCMCIARULES
 rulesdir =3D $(sysconfdir)/udev
=20
-rules_DATA =3D bluetooth.rules
+rules_DATA =3D pcmcia.rules
=20
 udevdir =3D $(libexecdir)/udev
=20
 udev_SCRIPTS =3D bluetooth_serial
 endif
=20
-EXTRA_DIST =3D bluetooth.rules bluetooth_serial bluetooth.init bluetooth=
=2Edefault
+EXTRA_DIST =3D pcmcia.rules bluetooth_serial bluetooth.init bluetooth.de=
fault hid2hci.rules
=20
 MAINTAINERCLEANFILES =3D Makefile.in
=20
@@ -24,3 +24,9 @@
 	@rm -f $(DESTDIR)$(sysconfdir)/init.d/bluetooth
 	@rm -f $(DESTDIR)$(sysconfdir)/default/bluetooth
 endif
+
+install-data-pm:
+	$(INSTALL) -D -m 644 $(srcdir)/hid2hci.rules $(DESTDIR)$(rulesdir)/rule=
s.d/62-bluez-hid2hci.rules
+
+uninstall-pm:
+	@rm -f $(DESTDIR)$(rulesdir)/rules.d/62-bluez-hid2hci.rules
diff -Nur -x '*.orig' -x '*~' bluez-4.12/scripts/Makefile.in bluez-4.12.n=
ew/scripts/Makefile.in
--- bluez-4.12/scripts/Makefile.in	2008-10-07 13:28:29.000000000 -0500
+++ bluez-4.12.new/scripts/Makefile.in	2008-10-23 15:13:03.000000000 -050=
0
@@ -189,10 +189,10 @@
 top_builddir =3D @top_builddir@
 top_srcdir =3D @top_srcdir@
 @PCMCIARULES_TRUE@rulesdir =3D $(sysconfdir)/udev
-@PCMCIARULES_TRUE@rules_DATA =3D bluetooth.rules
+@PCMCIARULES_TRUE@rules_DATA =3D pcmcia.rules
 @PCMCIARULES_TRUE@udevdir =3D $(libexecdir)/udev
 @PCMCIARULES_TRUE@udev_SCRIPTS =3D bluetooth_serial
-EXTRA_DIST =3D bluetooth.rules bluetooth_serial bluetooth.init bluetooth=
=2Edefault
+EXTRA_DIST =3D pcmcia.rules bluetooth_serial bluetooth.init bluetooth.de=
fault hid2hci.rules
 MAINTAINERCLEANFILES =3D Makefile.in
 all: all-am
=20
@@ -354,7 +354,7 @@
 info-am:
=20
 install-data-am: install-data-local install-rulesDATA \
-	install-udevSCRIPTS
+	install-udevSCRIPTS install-data-pm
=20
 install-dvi: install-dvi-am
=20
@@ -416,6 +416,12 @@
 @INITSCRIPTS_TRUE@uninstall-local:
 @INITSCRIPTS_TRUE@	@rm -f $(DESTDIR)$(sysconfdir)/init.d/bluetooth
 @INITSCRIPTS_TRUE@	@rm -f $(DESTDIR)$(sysconfdir)/default/bluetooth
+
+install-data-pm:
+	$(INSTALL) -D -m 644 $(srcdir)/hid2hci.rules $(DESTDIR)$(rulesdir)/rule=
s.d/62-bluez-hid2hci.rules
+
+uninstall-local:
+	@rm -f $(DESTDIR)$(rulesdir)/rules.d/62-bluez-hid2hci.rules
 # Tell versions [3.59,3.63) of GNU make to not export all variables.
 # Otherwise a system limit (for SysV at least) may be exceeded.
 .NOEXPORT:
diff -Nur -x '*.orig' -x '*~' bluez-4.12/scripts/pcmcia.rules bluez-4.12.=
new/scripts/pcmcia.rules
--- bluez-4.12/scripts/pcmcia.rules	1969-12-31 18:00:00.000000000 -0600
+++ bluez-4.12.new/scripts/pcmcia.rules	2008-10-23 15:09:14.000000000 -05=
00
@@ -0,0 +1,35 @@
+# Brain Boxes BL-620 Bluetooth Adapter
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Brain Box=
es", SYSFS{prod_id2}=3D=3D"Bluetooth PC Card", ENV{HCIOPTS}=3D"bboxes", R=
UN+=3D"bluetooth_serial"
+
+# Xircom CreditCard Bluetooth Adapter
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Xircom", =
SYSFS{prod_id3}=3D=3D"CBT", ENV{HCIOPTS}=3D"xircom", RUN+=3D"bluetooth_se=
rial"
+
+# Xircom RealPort2 Bluetooth Adapter
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Xircom", =
SYSFS{prod_id3}=3D=3D"CBT", ENV{HCIOPTS}=3D"xircom", RUN+=3D"bluetooth_se=
rial"
+
+# IBM Bluetooth PC Card II
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"IBM", SYS=
FS{prod_id2}=3D=3D"Bluetooth PC Card II", ENV{HCIOPTS}=3D"tdk", RUN+=3D"b=
luetooth_serial"
+
+# TDK Bluetooth PC Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"TDK", SYS=
FS{prod_id2}=3D=3D"Bluetooth PC Card II", ENV{HCIOPTS}=3D"tdk", RUN+=3D"b=
luetooth_serial"
+
+# AmbiCom BT2000C Bluetooth PC/CF Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"AmbiCom B=
T2000C", SYSFS{prod_id2}=3D=3D"Bluetooth PC/CF Card", ENV{HCIOPTS}=3D"bt2=
000c", RUN+=3D"bluetooth_serial"
+
+# COM One Platinium Bluetooth PC Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"COM1 SA",=
 SYSFS{prod_id2}=3D=3D"MC310 CARD", ENV{HCIOPTS}=3D"comone", RUN+=3D"blue=
tooth_serial"
+
+# Sphinx PICO Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"SPHINX", =
SYSFS{prod_id2}=3D=3D"BT-CARD", ENV{HCIOPTS}=3D"picocard", RUN+=3D"blueto=
oth_serial"
+
+# H-Soft blue+Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"H-Soft", =
SYSFS{prod_id2}=3D=3D"Blue+CARD", ENV{HCIOPTS}=3D"$sysfs{manf_id},$sysfs{=
card_id}", RUN+=3D"bluetooth_serial"
+
+# Compaq iPAQ Bluetooth Sleeve, Belkin F8T020, any other muppet who used=
 an OXCF950 and didn't bother to program it appropriately.
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"CF CARD",=
 SYSFS{prod_id2}=3D=3D"GENERIC", ENV{HCIOPTS}=3D"$sysfs{manf_id},$sysfs{c=
ard_id}", RUN+=3D"bluetooth_serial"
+
+# Zoom Bluetooth Card and Sitecom CN-504 Card
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"PCMCIA", =
SYSFS{prod_id2}=3D=3D"Bluetooth Card", ENV{HCIOPTS}=3D"zoom", RUN+=3D"blu=
etooth_serial"
+
+# CC&C BT0100M
+SUBSYSTEM=3D=3D"tty", BUS=3D=3D"pcmcia", SYSFS{prod_id1}=3D=3D"Bluetooth=
 BT0100M", ENV{HCIOPTS}=3D"bcsp 115200", RUN+=3D"bluetooth_serial"

--------------030303070907040101070009--

--------------enig7D7AC00EB0B9F54B8DF7AC01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkkA29EACgkQ2CrZjkA73YsP7wCeJgaEi3r/MfXNUMceaOMbDbNH
OqMAmwVBeBjZxMyRA545YHbHuAQHTuv0
=Ejnd
-----END PGP SIGNATURE-----

--------------enig7D7AC00EB0B9F54B8DF7AC01--
