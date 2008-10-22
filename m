Return-Path: <cyrus@holtmann.org>
Message-ID: <48FF92EB.3050007@dell.com>
Date: Wed, 22 Oct 2008 15:54:03 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Run hid2hci after resuming from suspend
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig47D48D3800F1E59AD69B5344"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig47D48D3800F1E59AD69B5344
Content-Type: multipart/mixed;
 boundary="------------060105040702010807000508"

This is a multi-part message in MIME format.
--------------060105040702010807000508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

This patch adds support for the hid2hci command to be ran upon resuming
from suspend.  At least the USB adapters I've been operating with that
need to switch modes need to do so upon resume.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------060105040702010807000508
Content-Type: text/x-patch;
 name="hid2hci_pm-utils.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="hid2hci_pm-utils.patch"

diff -Nur -x '*.orig' -x '*~' bluez-4.12/scripts/hid2hci.pm-utils bluez-4=
=2E12.new/scripts/hid2hci.pm-utils
--- bluez-4.12/scripts/hid2hci.pm-utils	1969-12-31 18:00:00.000000000 -06=
00
+++ bluez-4.12.new/scripts/hid2hci.pm-utils	2008-10-22 15:37:00.000000000=
 -0500
@@ -0,0 +1,24 @@
+#!/bin/sh
+# Switch all devices that were in a HID mode to HCI mode
+# after a resume
+
+. "${PM_FUNCTIONS}"
+
+[ -f /etc/default/bluetooth ] || exit $NA
+
+. /etc/default/bluetooth
+
+hid2hci()
+{
+	if [ "$HID2HCI_ENABLED" =3D "1" ] && [ -x /usr/sbin/hid2hci ]; then
+		/usr/sbin/hid2hci --tohci
+        fi
+}
+
+case "$1" in
+	thaw|resume)
+		hid2hci
+		;;
+	*) exit $NA
+		;;
+esac
diff -Nur -x '*.orig' -x '*~' bluez-4.12/scripts/Makefile.am bluez-4.12.n=
ew/scripts/Makefile.am
--- bluez-4.12/scripts/Makefile.am	2008-10-07 13:28:29.000000000 -0500
+++ bluez-4.12.new/scripts/Makefile.am	2008-10-22 15:37:00.000000000 -050=
0
@@ -9,7 +9,7 @@
 udev_SCRIPTS =3D bluetooth_serial
 endif
=20
-EXTRA_DIST =3D bluetooth.rules bluetooth_serial bluetooth.init bluetooth=
=2Edefault
+EXTRA_DIST =3D bluetooth.rules bluetooth_serial bluetooth.init bluetooth=
=2Edefault hid2hci.pm-utils
=20
 MAINTAINERCLEANFILES =3D Makefile.in
=20
@@ -24,3 +24,12 @@
 	@rm -f $(DESTDIR)$(sysconfdir)/init.d/bluetooth
 	@rm -f $(DESTDIR)$(sysconfdir)/default/bluetooth
 endif
+
+if HID2HCI
+install-data-local:
+	$(mkinstalldirs) $(DESTDIR)/$(libexecdir)/pm-utils/sleep.d
+	$(INSTALL) -D -m 744 $(srcdir)/hid2hci.pm-utils $(DESTDIR)$(libexecdir)=
/pm-utils/sleep.d/48hid2hci
+
+uninstall-local:
+	@rm -f $(DESTDIR)$(libexecdir)/pm-utils/sleep.d/48hid2hci
+endif
diff -Nur -x '*.orig' -x '*~' bluez-4.12/scripts/Makefile.in bluez-4.12.n=
ew/scripts/Makefile.in
--- bluez-4.12/scripts/Makefile.in	2008-10-07 13:28:29.000000000 -0500
+++ bluez-4.12.new/scripts/Makefile.in	2008-10-22 15:37:20.000000000 -050=
0
@@ -192,7 +192,7 @@
 @PCMCIARULES_TRUE@rules_DATA =3D bluetooth.rules
 @PCMCIARULES_TRUE@udevdir =3D $(libexecdir)/udev
 @PCMCIARULES_TRUE@udev_SCRIPTS =3D bluetooth_serial
-EXTRA_DIST =3D bluetooth.rules bluetooth_serial bluetooth.init bluetooth=
=2Edefault
+EXTRA_DIST =3D bluetooth.rules bluetooth_serial bluetooth.init bluetooth=
=2Edefault hid2hci.pm-utils
 MAINTAINERCLEANFILES =3D Makefile.in
 all: all-am
=20
@@ -335,6 +335,8 @@
 	-test -z "$(MAINTAINERCLEANFILES)" || rm -f $(MAINTAINERCLEANFILES)
 @INITSCRIPTS_FALSE@uninstall-local:
 @INITSCRIPTS_FALSE@install-data-local:
+@HID2HCI_FALSE@uninstall-local:
+@HID2HCI_FALSE@install-data-local:
 clean: clean-am
=20
 clean-am: clean-generic clean-libtool mostlyclean-am
@@ -416,6 +418,13 @@
 @INITSCRIPTS_TRUE@uninstall-local:
 @INITSCRIPTS_TRUE@	@rm -f $(DESTDIR)$(sysconfdir)/init.d/bluetooth
 @INITSCRIPTS_TRUE@	@rm -f $(DESTDIR)$(sysconfdir)/default/bluetooth
+
+@HID2HCI_TRUE@install-data-local:
+@HID2HCI_TRUE@	$(mkinstalldirs) $(DESTDIR)/$(libexecdir)/pm-utils/sleep.=
d
+@HID2HCI_TRUE@	$(INSTALL) -D -m 744 $(srcdir)/hid2hci.pm-utils $(DESTDIR=
)$(libexecdir)/pm-utils/sleep.d/48hid2hci
+
+@HID2HCI_TRUE@uninstall-local:
+@HID2HCI_TRUE@	@rm -f $(DESTDIR)$(libexecdir)/pm-utils/sleep.d/48hid2hci=

 # Tell versions [3.59,3.63) of GNU make to not export all variables.
 # Otherwise a system limit (for SysV at least) may be exceeded.
 .NOEXPORT:

--------------060105040702010807000508--

--------------enig47D48D3800F1E59AD69B5344
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj/kusACgkQ2CrZjkA73YvVlQCfe1dquYYGOqefo4QSzxVYpZ93
jncAoJKS4My6Mw7kHQaBZMubX5kF4MS3
=6bzD
-----END PGP SIGNATURE-----

--------------enig47D48D3800F1E59AD69B5344--
