Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Nov 2011 22:51:00 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Building master on Debian systems fails at linking "check".
Message-Id: <20111114225100.c75e709827f4b22fa83e0327@studenti.unina.it>
In-Reply-To: <4EC15A27.90305@codeaurora.org>
References: <20111114155620.4fc2987fad25c9ccd724f68a@studenti.unina.it>
	<4EC15A27.90305@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__14_Nov_2011_22_51_00_+0100_Zds4lKM=IjaQB6B2"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Mon__14_Nov_2011_22_51_00_+0100_Zds4lKM=IjaQB6B2
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Nov 2011 10:12:55 -0800
Brian Gix <bgix@codeaurora.org> wrote:

> Hi Antonio,
>=20
> On 11/14/2011 6:56 AM, Antonio Ospite wrote:
> > Hi,
> >
> > building the master branch (a267bc2) on Debian systems fails when
> > linking the unit tests to the "check" library with this error:
> >
[...]

> >
> > The workaround I use for now is:
> >    - run "make" and let the build system fail
> >    - show the  failing command with "make V=3D1"
> >    - change -lcheck to -lcheck_pic and rerun the command
> >    - "make" will now proceed with the build
>=20
>=20
> This same solution works for me:  After running ./bootstrap-configure, I=
=20
> change the unit_test_eir_LDADD line in the Makefile to:
>=20
> unit_test_eir_LDADD =3D lib/libbluetooth-private.la -lglib-2.0   -lcheck_=
pic
>

Eh Brian, this is surely a little prettier than what I am doing :)

> There is probably a way to make this happen automatically, but I don't=20
> know enough about the configure mechanism to know how to do this.
>

I think using a =E2=80=9Clibcheck_pic aware=E2=80=9D m4 macro is the way to=
 go, ideally
this should be provided in the check package itself, I'll try asking the
Debian maintainers if there is no interest for a solution in BlueZ.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__14_Nov_2011_22_51_00_+0100_Zds4lKM=IjaQB6B2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7BjUUACgkQ5xr2akVTsAGHtACfRA4YOzpJMhAYr5PKaVV1PddR
0NQAn33TwlUsfqzLErE8bdL+8bXhhekl
=jvLm
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Nov_2011_22_51_00_+0100_Zds4lKM=IjaQB6B2--
