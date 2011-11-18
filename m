Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Nov 2011 10:37:50 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Brian Gix <bgix@codeaurora.org>, linux-bluetooth@vger.kernel.org
Subject: Re: Building master on Debian systems fails at linking "check".
Message-Id: <20111118103750.5170f828b72afcb32ea737a2@studenti.unina.it>
In-Reply-To: <1321325981.15441.481.camel@aeonflux>
References: <20111114155620.4fc2987fad25c9ccd724f68a@studenti.unina.it>
	<4EC15A27.90305@codeaurora.org>
	<20111114225100.c75e709827f4b22fa83e0327@studenti.unina.it>
	<1321323919.15441.475.camel@aeonflux>
	<4EC1CEEB.2000702@codeaurora.org>
	<1321325610.15441.479.camel@aeonflux>
	<4EC1D53D.4030500@codeaurora.org>
	<1321325981.15441.481.camel@aeonflux>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__18_Nov_2011_10_37_50_+0100_lrsD+CksNIGG_Mjf"
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Fri__18_Nov_2011_10_37_50_+0100_lrsD+CksNIGG_Mjf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Nov 2011 11:59:38 +0900
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Brian,
>=20
> > >> I believe it is more likely an X86-64 issue.  And support for libche=
ck
> > >> is checked (and is there), but for some reason fails in this instanc=
e.
> > >
> > > So what does "pkg-config --libs check" actually tells you?
> >=20
> >=20
> > $ pkg-config --libs check
> > -lcheck
>=20
> there you have your problem. It should return -lcheck_pic if that is
> required for building with a dynamic library. File a bug with Debian for
> this.
>=20

Indeed, I suggested this workaround here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D605207

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__18_Nov_2011_10_37_50_+0100_lrsD+CksNIGG_Mjf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7GJ24ACgkQ5xr2akVTsAGIfQCgsXDI16EuT69FVIoSdkxGgPkk
SPYAnRTZPa5Qe6AtZ3zVJXdnQsQZSC6v
=Qji9
-----END PGP SIGNATURE-----

--Signature=_Fri__18_Nov_2011_10_37_50_+0100_lrsD+CksNIGG_Mjf--
