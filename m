Return-Path: <cyrus@holtmann.org>
Subject: bluez installs alsa related stuff under /etc/alsa instead of
 /usr/share/alsa
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-59R7oPVK5gbRwCsbBTGT"
Date: Thu, 04 Mar 2010 09:37:39 +0100
Message-Id: <1267691859.10782.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-59R7oPVK5gbRwCsbBTGT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello

bluez installs stuff into /etc/alsa and it seems wrong since default
location for alsa stuff seems to be /usr/share/alsa instead. You can
also see that this is been workarounded in ubuntu, gentoo (and probably
debian also).

Any reason why using /etc/alsa instead?

Thanks a lot

--=-59R7oPVK5gbRwCsbBTGT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
 digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuPcVMACgkQCaWpQKGI+9SBLgCeN4P4cLb6GntyIhjEzPjW0WE/
JlAAnjJQsOspkYxn44w+PiWG+s2KQQ9Q
=IEWy
-----END PGP SIGNATURE-----

--=-59R7oPVK5gbRwCsbBTGT--

