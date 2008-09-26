Return-Path: <cyrus@holtmann.org>
Message-ID: <48DD699C.9090307@dell.com>
Date: Fri, 26 Sep 2008 18:00:44 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluetoothd crashing on 4.7
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig07B736E580915657DC4E4A9C"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07B736E580915657DC4E4A9C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi:

I recently packaged bluez 4.7 for possible inclusion in Ubuntu intrepid
[1].  Upon doing some basic testing with it, I've run into a situation
where when I try to pair with a keyboard, bluetoothd crashes.  If I run
it under valgrind, bluetoothd survives the crash, and the keyboard works
[2].  If I run it with gdb, it comes down, and I get a trace at
least[3].  If I run it without a debugger, keyboard doesn't properly work=
=2E

[1] https://bugs.edge.launchpad.net/~superm1/+archive
[2] http://paste.ubuntu.com/51091/
[3] http://paste.ubuntu.com/51090/

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig07B736E580915657DC4E4A9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFI3Wmc2CrZjkA73YsRAuIDAJ9KV7DM9wHx8t4+QJ+uA/1E0myklwCdH0hm
HKnFvG/klL/EYcdh/qKyQ00=
=CHkA
-----END PGP SIGNATURE-----

--------------enig07B736E580915657DC4E4A9C--
