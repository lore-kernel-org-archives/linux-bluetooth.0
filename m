Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Sep 2011 13:02:00 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix batostr(): return the bdaddr in the right
 order
Message-Id: <20110919130200.93d5e77df3bae3f35949c34c@studenti.unina.it>
In-Reply-To: <20110914210812.2f33e1ad702e5727b5256bd0@studenti.unina.it>
References: <1316015179-6474-1-git-send-email-ospite@studenti.unina.it>
	<1316022826.1937.44.camel@aeonflux>
	<20110914210812.2f33e1ad702e5727b5256bd0@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__19_Sep_2011_13_02_00_+0200_WSrgm17PU8+gzivC"
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Mon__19_Sep_2011_13_02_00_+0200_WSrgm17PU8+gzivC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Sep 2011 21:08:12 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> On Wed, 14 Sep 2011 19:53:45 +0200
> Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> > Hi Antonio,
> >=20
> > > lib/bluetooth.c::batostr() is returning the bdaddr reversed, fix this
> > > and put more arguments on the same line to look more like ba2str().
> >=20
> > this would be breaking existing API. So NAK.
> >=20
>=20
> OK, but it is still weird that batostr() and ba2str() work differently.
> batostr() has no in-tree user AFAICS, just FYI.
>=20

Would a batostr_bis() which behaves more like ba2str() wrt. bdaddr
ordering be accepted, or do I just duplicate the code in my function?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__19_Sep_2011_13_02_00_+0200_WSrgm17PU8+gzivC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk53ISgACgkQ5xr2akVTsAGpUwCfcQx1a+NmA2k1Il/TMkvB2LYE
Gk8AoKwoqSwgYBz8z/bDGEFpP+eYfiZi
=fBgy
-----END PGP SIGNATURE-----

--Signature=_Mon__19_Sep_2011_13_02_00_+0200_WSrgm17PU8+gzivC--
