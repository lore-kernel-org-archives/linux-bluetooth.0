Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Apr 2012 14:28:24 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ v2 1/3] manager: add a
 btd_manager_get_default_adapter_address_str() call
Message-Id: <20120420142824.d911492d073ba9fc887f04a7@studenti.unina.it>
In-Reply-To: <1334746924.8818.115.camel@novo.hadess.net>
References: <1334741891-11869-1-git-send-email-ospite@studenti.unina.it>
	<1334741891-11869-2-git-send-email-ospite@studenti.unina.it>
	<1334746924.8818.115.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__20_Apr_2012_14_28_24_+0200_raQnClGQ4lpKS5La"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Fri__20_Apr_2012_14_28_24_+0200_raQnClGQ4lpKS5La
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Apr 2012 12:02:04 +0100
Bastien Nocera <hadess@hadess.net> wrote:

> On Wed, 2012-04-18 at 11:38 +0200, Antonio Ospite wrote:
> > Add a new btd_* call to get the default adapter address as a string,
> > meant to be used by _external_ plugins, this is to avoid to make public
> > these symbols:
> >=20
> >   manager_get_default_adapter
> >   adapter_get_address
> >   bt_malloc
>=20
> It's already public.
>=20
> >   ba2str
>=20
> Already public.
>

I think I am messing up the terminology again here, the interface is
public but the symbol is not exported as _global_ in src/bluetooth.ver
so external plugins can't use it.

> > ---
> > Alternatively a version without the _str prefix can be used which
> > returns a bdaddr_t, but I have to make ba2str a global symbol so I can
> > make the conversion to string in the plugin itself.
> >=20
> > Let me know how do you like that.
>=20
> ba2str() is in libbluetooth.
> $ grep ba2str /usr/include/bluetooth/bluetooth.h=20
> int ba2str(const bdaddr_t *ba, char *str);
>=20
> So it's already public.
>

What I meant is: if you like a version which returns a bdaddr_t rather
than a char* I have to add ba2str to src/bluetooth.ver

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__20_Apr_2012_14_28_24_+0200_raQnClGQ4lpKS5La
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+RVmgACgkQ5xr2akVTsAEwcwCgmeG+IxO8eAbSHRTBcEQj46VA
1ocAoIvJtrGwzdBvUX3MdnuTvU+uZm36
=eLby
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Apr_2012_14_28_24_+0200_raQnClGQ4lpKS5La--
