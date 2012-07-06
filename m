Return-Path: <cyrus@holtmann.org>
Subject: Re: About udev rule removal
From: Pacho Ramos <pacho@gentoo.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <CAMOw1v6hMcHqWAhHHyJAsQhjo=nrp62bYm9+TCeOehV_ktoKbw@mail.gmail.com>
References: <1341001405.2852.4.camel@belkin4>
	 <1341080127.3770.6.camel@belkin4>
	 <CAMOw1v6hMcHqWAhHHyJAsQhjo=nrp62bYm9+TCeOehV_ktoKbw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-O51x/tReKosXwTF55gwp"
Date: Fri, 06 Jul 2012 20:36:59 +0200
Message-ID: <1341599820.4531.0.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-O51x/tReKosXwTF55gwp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 03-07-2012 a las 10:21 -0300, Lucas De Marchi escribi=C3=B3:
> On Sat, Jun 30, 2012 at 3:15 PM, Pacho Ramos <pacho@gentoo.org> wrote:
> > El vie, 29-06-2012 a las 22:23 +0200, Pacho Ramos escribi=C3=B3:
> >> I would like to know what distributions not relying on systemd are
> >> supposed to get bluetoothd autostarted now that udev rule was dropped:
> >> http://git.kernel.org/?p=3Dbluetooth/bluez.git;a=3Dcommit;h=3D2ea98a6a=
043710ad4958355b62c682b4767f292e
> >>
> >> Looks like we go back from udev rule to manually starting bluetoothd a=
ll
> >> the time, even if bluetooth device is not connected? Why are we going
> >> back to old behavior?
> >>
> >> Thanks for the info
> >
> > Should we revert that change downstream if we are not going to rely on
> > systemd and until udev is changed to break that setup (forcing us to go
> > to old "always running" behavior)?
>=20
> Udev rules are not supposed to spawn daemons. It never was. And now if
> you do that udev will kill your daemon after a certain timeout. You'd
> need to a) maintain that rule by yourself and b) patch udev to not do
> that.
>=20
>=20
> Lucas De Marchi
>=20

Will go with the old way of starting it with an init.d script then.
Thanks for the info.

--=-O51x/tReKosXwTF55gwp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAk/3MEsACgkQCaWpQKGI+9QlGwCeO/6uk35VNnX63Ri8tqsgdPsz
IjoAn08wtHQA2RsTYvss+YsFg2FSc1Tk
=Me4O
-----END PGP SIGNATURE-----

--=-O51x/tReKosXwTF55gwp--

