Return-Path: <cyrus@holtmann.org>
Subject: Re: DiscoverableTimeout not working as expected
From: Ross Burton <ross@linux.intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c101002260124w2a526e5bh4622af9658e179c0@mail.gmail.com>
References: <1267100354.22889.16.camel@flashheart.burtonini.com>
	 <2d5a2c101002260124w2a526e5bh4622af9658e179c0@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-TgZwbDp79Nq/Qt/Rp6jU"
Date: Fri, 26 Feb 2010 10:29:29 +0000
Message-ID: <1267180169.32051.20.camel@flashheart.burtonini.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-TgZwbDp79Nq/Qt/Rp6jU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-02-26 at 11:24 +0200, Luiz Augusto von Dentz wrote:
> I got a different behavior (using git tree and testtest-adapter):
>=20
> signal sender=3D:1.65 -> dest=3D(null destination) serial=3D151
> path=3D/org/bluez/3359/hci0; interface=3Dorg.bluez.Adapter;
> member=3DPropertyChanged
>    string "DiscoverableTimeout"
>    variant       uint32 10
> signal sender=3D:1.65 -> dest=3D(null destination) serial=3D160
> path=3D/org/bluez/3359/hci0; interface=3Dorg.bluez.Adapter;
> member=3DPropertyChanged
>    string "Discoverable"
>    variant       boolean true
> signal sender=3D:1.65 -> dest=3D(null destination) serial=3D161
> path=3D/org/bluez/3359/hci0; interface=3Dorg.bluez.Adapter;
> member=3DPropertyChanged
>    string "Class"
>    variant       uint32 6430988
> signal sender=3D:1.65 -> dest=3D(null destination) serial=3D162
> path=3D/org/bluez/3359/hci0; interface=3Dorg.bluez.Adapter;
> member=3DPropertyChanged
>    string "Discoverable"
>    variant       boolean false
> signal sender=3D:1.65 -> dest=3D(null destination) serial=3D163
> path=3D/org/bluez/3359/hci0; interface=3Dorg.bluez.Adapter;
> member=3DPropertyChanged
>    string "Class"
>    variant       uint32 6422796

Interesting.  Using test-adaptor and bluez 4.60 (debian sid), I don't
see that behaviour.  I also can't see anything relevant in the git
log. :(

Ross
--=20
Intel Open Source Technology Centre
http://oss.intel.com/

--=-TgZwbDp79Nq/Qt/Rp6jU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQBLh6KHLQnkR9C0M98RApCvAKCnNSuCgQTqmHoQC+b6+z292mYNIgCZAaw0
ca6QOlHks6XkSOQmRUOeKvE=
=vXrX
-----END PGP SIGNATURE-----

--=-TgZwbDp79Nq/Qt/Rp6jU--
