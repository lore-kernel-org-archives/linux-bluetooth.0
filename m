Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Sep 2011 21:08:12 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix batostr(): return the bdaddr in the right
 order
Message-Id: <20110914210812.2f33e1ad702e5727b5256bd0@studenti.unina.it>
In-Reply-To: <1316022826.1937.44.camel@aeonflux>
References: <1316015179-6474-1-git-send-email-ospite@studenti.unina.it>
	<1316022826.1937.44.camel@aeonflux>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__14_Sep_2011_21_08_12_+0200_WS4zlAXptA6HTtyd"
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Wed__14_Sep_2011_21_08_12_+0200_WS4zlAXptA6HTtyd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Sep 2011 19:53:45 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Antonio,
>=20
> > lib/bluetooth.c::batostr() is returning the bdaddr reversed, fix this
> > and put more arguments on the same line to look more like ba2str().
>=20
> this would be breaking existing API. So NAK.
>=20

OK, but it is still weird that batostr() and ba2str() work differently.
batostr() has no in-tree user AFAICS, just FYI.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__14_Sep_2011_21_08_12_+0200_WS4zlAXptA6HTtyd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5w+5wACgkQ5xr2akVTsAEYGgCeL7i5H/vTnmLSE/UPkSTdQF+p
nzAAnij+7vp58MC/aFisjCzj0UrSgkz6
=RZk8
-----END PGP SIGNATURE-----

--Signature=_Wed__14_Sep_2011_21_08_12_+0200_WS4zlAXptA6HTtyd--
