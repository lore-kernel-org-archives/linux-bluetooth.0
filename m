Return-Path: <cyrus@holtmann.org>
Subject: Re: About udev rule removal
From: Pacho Ramos <pacho@gentoo.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1341001405.2852.4.camel@belkin4>
References: <1341001405.2852.4.camel@belkin4>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-qv4yhV/MCUH4Ma/K8pAR"
Date: Sat, 30 Jun 2012 20:15:27 +0200
Message-ID: <1341080127.3770.6.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-qv4yhV/MCUH4Ma/K8pAR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 29-06-2012 a las 22:23 +0200, Pacho Ramos escribi=C3=B3:
> I would like to know what distributions not relying on systemd are
> supposed to get bluetoothd autostarted now that udev rule was dropped:
> http://git.kernel.org/?p=3Dbluetooth/bluez.git;a=3Dcommit;h=3D2ea98a6a043=
710ad4958355b62c682b4767f292e
>=20
> Looks like we go back from udev rule to manually starting bluetoothd all
> the time, even if bluetooth device is not connected? Why are we going
> back to old behavior?
>=20
> Thanks for the info

Should we revert that change downstream if we are not going to rely on
systemd and until udev is changed to break that setup (forcing us to go
to old "always running" behavior)?

--=-qv4yhV/MCUH4Ma/K8pAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEABECAAYFAk/vQj8ACgkQCaWpQKGI+9QF1gCfcoq/q3PtGyoyLoZUhLhfjd2o
H3IAn3I+2JEgxTvAu3PNERUhfUkFtVfD
=FnKB
-----END PGP SIGNATURE-----

--=-qv4yhV/MCUH4Ma/K8pAR--

