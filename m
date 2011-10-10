Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 22:08:22 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Daniele Forsi <dforsi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC PATCH BlueZ RESEND 1/3] Add a
 btd_manager_get_default_adapter_str() call
Message-Id: <20111010220822.154276932b59aa2e1a606795@studenti.unina.it>
In-Reply-To: <CAN_we7PX3DRxHrwa_A23nFD=FfwW-gQ2p39aFT7S6fGoD_rdXQ@mail.gmail.com>
References: <1316454126-32614-1-git-send-email-ospite@studenti.unina.it>
	<1318261853-22448-1-git-send-email-ospite@studenti.unina.it>
	<CAN_we7PX3DRxHrwa_A23nFD=FfwW-gQ2p39aFT7S6fGoD_rdXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__10_Oct_2011_22_08_22_+0200_Oejke7O_Gd6tTlM_"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Mon__10_Oct_2011_22_08_22_+0200_Oejke7O_Gd6tTlM_
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Oct 2011 19:16:26 +0200
Daniele Forsi <dforsi@gmail.com> wrote:

> 2011/10/10 Antonio Ospite:
>=20
> > +char *btd_manager_get_default_adapter_str(void)
>=20
> > + =A0 =A0 =A0 char *str =3D bt_malloc(18);
> > +
> > + =A0 =A0 =A0 adapter =3D manager_get_default_adapter();
> > + =A0 =A0 =A0 if (adapter =3D=3D NULL) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>=20
> you are leaking str if you return here
> --=20
> Daniele Forsi

Thanks Daniele, I'll move the allocation down, just before using str.

Not that it is an excuse, but those patches are more to test the water
than meant for inclusion as they are :)

For the record, I originally intended to use batostr() here,
unfortunately it returns the bdaddr reversed and fixing it would break
the API.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__10_Oct_2011_22_08_22_+0200_Oejke7O_Gd6tTlM_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6TULYACgkQ5xr2akVTsAHKXwCgggzOdkTIqEwhjafuw/IM8U0E
dhkAnRE5GLdesR/ugdrECkHiTcPQm39o
=/Bfg
-----END PGP SIGNATURE-----

--Signature=_Mon__10_Oct_2011_22_08_22_+0200_Oejke7O_Gd6tTlM_--
