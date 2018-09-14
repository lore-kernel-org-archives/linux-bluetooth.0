Return-Path: <pavel@ucw.cz>
Date: Fri, 14 Sep 2018 18:42:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: bluez from git: does not compile, bluetoothd crashes
Message-ID: <20180914164258.GA8745@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
List-ID: <linux-bluetooth.vger.kernel.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have version e4cf43fc62b4e4dbabc72d4e44e095d7a9087992.

It did not compile, so I did this:

gcc --version
gcc (Debian 4.9.2-10+deb8u1) 4.9.2

diff --git a/monitor/display.h b/monitor/display.h
index 12d13f8..ca85dcc 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -70,6 +70,7 @@ struct bitfield_data {
 	const char *str;
 };
=20
+#ifdef WANT_BITFIELD
 inline uint64_t print_bitfield(int indent, uint64_t val,
 				const struct bitfield_data *table)
 {
@@ -85,6 +86,7 @@ inline uint64_t print_bitfield(int indent, uint64_t val,
=20
 	return mask;
 }
+#endif
=20
 int num_columns(void);
=20
diff --git a/monitor/packet.c b/monitor/packet.c
index aca0761..21fc1dc 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
=20
+#define WANT_BITFIELD
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>

Possibly not nicest fix but it got me version that compiled.

I was trying to play with btle, but bluetoothd crashed. That can't be
good.

pavel@amd:~/denx/bt/bluez$ sudo src/bluetoothd
*** Error in `src/bluetoothd': free(): invalid size: 0x08162908 ***

Syslog says:

pavel@amd:~/denx/bt/bluez$ sudo tail /var/log/syslog
Sep 14 18:38:59 amd dbus[2801]: [system] Activating via systemd:
service name=3D'org.bluez' unit=3D'dbus-org.bluez.service'
Sep 14 18:38:59 amd systemd[1]: Starting Bluetooth service...
Sep 14 18:38:59 amd bluetoothd[8731]: Bluetooth daemon 5.23
Sep 14 18:38:59 amd dbus[2801]: [system] Successfully activated
service 'org.bluez'
Sep 14 18:38:59 amd systemd[1]: Started Bluetooth service.
Sep 14 18:38:59 amd bluetoothd[8731]: Starting SDP server
Sep 14 18:39:00 amd bluetoothd[8731]: Bluetooth management interface
1.14 initialized
Sep 14 18:39:00 amd bluetoothd[8731]: Sap driver initialization
failed.
Sep 14 18:39:00 amd bluetoothd[8731]: sap-server: Operation not
permitted (1)
Sep 14 18:39:01 amd dbus[2801]: [system] Failed to activate service
'org.freedesktop.hostname1': timed out

Any ideas?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlub5RIACgkQMOfwapXb+vItSQCdFP/Txjb8hL0BH35M1SKHkD1D
x6gAn36dFlJn40fQk4okPyWPcjJ5n3hB
=ifaJ
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
