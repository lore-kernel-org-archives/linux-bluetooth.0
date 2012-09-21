Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetoothd: Refusing input device connect: Operation already
 in progress (114)
From: Pacho Ramos <pacho@gentoo.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20120921124323.GA14885@x220>
References: <1347704153.24322.11.camel@belkin4>
	 <20120921124323.GA14885@x220>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-fTWnPO5Ix2jSrwBhoTMy"
Date: Fri, 21 Sep 2012 21:00:18 +0200
Message-ID: <1348254019.2085.2.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-fTWnPO5Ix2jSrwBhoTMy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 21-09-2012 a las 15:43 +0300, Johan Hedberg escribi=C3=B3:
> Hi,
>=20
> On Sat, Sep 15, 2012, Pacho Ramos wrote:
> > Downstream we got the following report:
> > https://bugs.gentoo.org/show_bug.cgi?id=3D431624
> >=20
> > After adding mouse (via Blueman's "Add device" dialog) it works fine
> > until sleeping or powering off. After that it fails reconnecting.
> > In /var/log/messages appears strings like these:
> >=20
> > Aug 16 15:40:31 user bluetoothd[3222]: Refusing input device connect:
> > Operation already in progress (114)
> > Aug 16 15:45:13 user bluetoothd[3222]: Refusing input device connect:
> > Operation already in progress (114)
> > Aug 16 15:45:16 user bluetoothd[3222]: Refusing input device connect:
> > Operation already in progress (114)
> > Aug 16 15:45:17 user bluetoothd[3222]: Refusing input device connect:
> > Operation already in progress (114)
> > Aug 16 15:45:19 user bluetoothd[3222]: Refusing input device connect:
> > Operation already in progress (114)
> > Aug 16 15:47:46 user bluetoothd[3222]: Refusing input device connect:
> > Operation already in progress (114)
> >=20
> > Searching, I found this thread that pointed to the culprit, but I
> > haven't found what finally occurred with it, if patch was reverted or a
> > different fix was pulled in:
> > http://www.spinics.net/lists/linux-bluetooth/msg26442.html
>=20
> This is a different issue but the cause seems to be similar. You don't
> need to patch bluetoothd though but just disable the mgmt part by
> passing -P mgmtops to bluetoothd. For whatever reason the connection
> state isn't cleaned up with mgmt (which shouldn't be dependent on mgmt
> to begin with) and the input_device_set_channel function returns
> -EALREADY when accepting a connection.
>=20
> Johan
>=20

But it sounds like a workaround as mgmt is still broken as compared with
bluetoothd previous above change was committed, no? Thanks for the
info :)

--=-fTWnPO5Ix2jSrwBhoTMy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlBcuUIACgkQCaWpQKGI+9S/JQCfVf6eo4PYrffwi/gaEdstKTp/
WJYAnRVvNo0iJoG9A5a0+vOKnrG625kr
=q++k
-----END PGP SIGNATURE-----

--=-fTWnPO5Ix2jSrwBhoTMy--

