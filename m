Return-Path: <cyrus@holtmann.org>
Message-ID: <4900A67C.2050803@dell.com>
Date: Thu, 23 Oct 2008 11:29:48 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Run hid2hci after resuming from suspend
References: <48FF92EB.3050007@dell.com> <1224737041.9386.160.camel@californication>
In-Reply-To: <1224737041.9386.160.camel@californication>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3C429FA0D924F1855DDE9830"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C429FA0D924F1855DDE9830
Content-Type: multipart/mixed;
 boundary="------------090303070306010808040607"

This is a multi-part message in MIME format.
--------------090303070306010808040607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Marcel:

Marcel Holtmann wrote:
> Hi Mario,
>
> we should not install multiple scripts. Lets only install one "bluez"
> file for pm-utils. So no need for a hid2hci specific script.
>
> Regards
>
> Marcel
>  =20
Attached is an updated patch that will install this as "48bluez" for
pm-utils.  Of course the only thing in it right now is hid2hci, but
should that need to change, it's easy to add more.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------090303070306010808040607
Content-Type: text/x-patch;
 name="hid2hci_pm-utils.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="hid2hci_pm-utils.patch"

diff -Nur -x '*.orig' -x '*~' bluez-4.12/scripts/bluetooth.pm-utils bluez=
-4.12.new/scripts/bluetooth.pm-utils
--- bluez-4.12/scripts/bluetooth.pm-utils	1969-12-31 18:00:00.000000000 -=
0600
+++ bluez-4.12.new/scripts/bluetooth.pm-utils	2008-10-23 09:24:48.0000000=
00 -0500
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
+++ bluez-4.12.new/scripts/Makefile.am	2008-10-23 09:37:16.000000000 -050=
0
@@ -9,7 +9,7 @@
 udev_SCRIPTS =3D bluetooth_serial
 endif
=20
-EXTRA_DIST =3D bluetooth.rules bluetooth_serial bluetooth.init bluetooth=
=2Edefault
+EXTRA_DIST =3D bluetooth.rules bluetooth_serial bluetooth.init bluetooth=
=2Edefault bluetooth.pm-utils
=20
 MAINTAINERCLEANFILES =3D Makefile.in
=20
@@ -24,3 +24,10 @@
 	@rm -f $(DESTDIR)$(sysconfdir)/init.d/bluetooth
 	@rm -f $(DESTDIR)$(sysconfdir)/default/bluetooth
 endif
+
+install-data-pm:
+	$(mkinstalldirs) $(DESTDIR)/$(libexecdir)/pm-utils/sleep.d
+	$(INSTALL) -D -m 744 $(srcdir)/bluetooth.pm-utils $(DESTDIR)$(libexecdi=
r)/pm-utils/sleep.d/48bluez
+
+uninstall-pm:
+	@rm -f $(DESTDIR)$(libexecdir)/pm-utils/sleep.d/48bluez
diff -Nur -x '*.orig' -x '*~' bluez-4.12/scripts/Makefile.in bluez-4.12.n=
ew/scripts/Makefile.in
--- bluez-4.12/scripts/Makefile.in	2008-10-07 13:28:29.000000000 -0500
+++ bluez-4.12.new/scripts/Makefile.in	2008-10-23 09:38:54.000000000 -050=
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
+uninstall-pm:
+install-data-pm:
 clean: clean-am
=20
 clean-am: clean-generic clean-libtool mostlyclean-am
@@ -354,7 +356,7 @@
 info-am:
=20
 install-data-am: install-data-local install-rulesDATA \
-	install-udevSCRIPTS
+	install-udevSCRIPTS install-data-pm
=20
 install-dvi: install-dvi-am
=20
@@ -416,6 +418,13 @@
 @INITSCRIPTS_TRUE@uninstall-local:
 @INITSCRIPTS_TRUE@	@rm -f $(DESTDIR)$(sysconfdir)/init.d/bluetooth
 @INITSCRIPTS_TRUE@	@rm -f $(DESTDIR)$(sysconfdir)/default/bluetooth
+
+install-data-pm:
+	$(mkinstalldirs) $(DESTDIR)/$(libexecdir)/pm-utils/sleep.d
+	$(INSTALL) -D -m 744 $(srcdir)/bluetooth.pm-utils $(DESTDIR)$(libexecdi=
r)/pm-utils/sleep.d/48bluez
+
+uninstall-pm:
+	@rm -f $(DESTDIR)$(libexecdir)/pm-utils/sleep.d/48bluez
 # Tell versions [3.59,3.63) of GNU make to not export all variables.
 # Otherwise a system limit (for SysV at least) may be exceeded.
 .NOEXPORT:

--------------090303070306010808040607--

--------------enig3C429FA0D924F1855DDE9830
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkkApnwACgkQ2CrZjkA73YuVjACfVWPdfYtZ78vcvlhRzmXi85Ee
fyAAnRzckIXH9ZbZZlPP1msEtHBbmIba
=YokY
-----END PGP SIGNATURE-----

--------------enig3C429FA0D924F1855DDE9830--
