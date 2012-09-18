Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetoothd: Refusing input device connect: Operation already
 in progress (114)
From: Pacho Ramos <pacho@gentoo.org>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1347704153.24322.11.camel@belkin4>
References: <1347704153.24322.11.camel@belkin4>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-QUe2lmCBSJ110ZtQyfkD"
Date: Tue, 18 Sep 2012 21:01:41 +0200
Message-ID: <1347994901.27524.21.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-QUe2lmCBSJ110ZtQyfkD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 15-09-2012 a las 12:15 +0200, Pacho Ramos escribi=C3=B3:
> Hello
>=20
> Downstream we got the following report:
> https://bugs.gentoo.org/show_bug.cgi?id=3D431624
>=20
> After adding mouse (via Blueman's "Add device" dialog) it works fine
> until sleeping or powering off. After that it fails reconnecting.
> In /var/log/messages appears strings like these:
>=20
> Aug 16 15:40:31 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
> Aug 16 15:45:13 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
> Aug 16 15:45:16 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
> Aug 16 15:45:17 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
> Aug 16 15:45:19 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
> Aug 16 15:47:46 user bluetoothd[3222]: Refusing input device connect:
> Operation already in progress (114)
>=20
> Searching, I found this thread that pointed to the culprit, but I
> haven't found what finally occurred with it, if patch was reverted or a
> different fix was pulled in:
> http://www.spinics.net/lists/linux-bluetooth/msg26442.html
>=20
> Thanks

No idea? :/


--=-QUe2lmCBSJ110ZtQyfkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlBYxRUACgkQCaWpQKGI+9RzZACfZldC6dk+dqQKwDnHx0/vnsHy
Z5IAnj1ojy357jbzJyZ17rVPknmlhf5g
=WHNu
-----END PGP SIGNATURE-----

--=-QUe2lmCBSJ110ZtQyfkD--

