Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Jul 2011 01:36:59 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Gottfried Haider <gottfried.haider@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, hadess@hadess.net, marcel@holtmann.org
Subject: Re: PS3 Sixaxis status (input/sixaxis.c)
Message-Id: <20110710013659.0aeb5fea9e9c1f482cdaa301@studenti.unina.it>
In-Reply-To: <CAPoCmYKYc9K=cCAMQ2_y1QDCa=cL8QxtVcp7_g_Kkp6oHYEeFA@mail.gmail.com>
References: <CAPoCmYLDnpi-=zdfPiTUad_AuYRcOtasapFSp-uSF_E8oy4Cew@mail.gmail.com>
	<CAPoCmYKYc9K=cCAMQ2_y1QDCa=cL8QxtVcp7_g_Kkp6oHYEeFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__10_Jul_2011_01_36_59_+0200_46vz+KOYfbkfs8ii"
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Sun__10_Jul_2011_01_36_59_+0200_46vz+KOYfbkfs8ii
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Jul 2011 18:40:58 +0200
Gottfried Haider <gottfried.haider@gmail.com> wrote:

> > I had high expectations when I found sixaxis.c in the bluez git tree -
> > but even after getting it to compile against the bluez version (4.91)
> > that comes with my xubuntu version, it still does not seem to work
>=20
> Forgot to add: I am running a recent kernel version (3.0.0-rc5).

input/sixaxis.c is going away, apply this patch to bluez for now,
it adds a new plugin which runs with bluez and does all the
paring/association work in background:
https://patchwork.kernel.org/patch/861522/

I plan to send an updated version soon-ish.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Sun__10_Jul_2011_01_36_59_+0200_46vz+KOYfbkfs8ii
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4Y5hsACgkQ5xr2akVTsAGORACcDf3IqasX7q4w69f5lPJs4n9y
7SgAn3WAGZkgmEvLNYVexBDyodpXx8/n
=FwtU
-----END PGP SIGNATURE-----

--Signature=_Sun__10_Jul_2011_01_36_59_+0200_46vz+KOYfbkfs8ii--
