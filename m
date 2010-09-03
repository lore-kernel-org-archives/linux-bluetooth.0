Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Sep 2010 20:01:02 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, cbe-oss-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] hid/hid-sony: Apply sixaxis quirks only to sixaxis
Message-Id: <20100903200102.9ad0abc1.ospite@studenti.unina.it>
In-Reply-To: <alpine.LNX.2.00.1009020941120.26813@pobox.suse.cz>
References: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it>
	<1272917756-31098-2-git-send-email-ospite@studenti.unina.it>
	<1283357615.2361.20.camel@localhost.localdomain>
	<20100901192055.2f23c8c7.ospite@studenti.unina.it>
	<alpine.LNX.2.00.1009020941120.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__3_Sep_2010_20_01_02_+0200_BvOWCOVdTdF6pveE"
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Fri__3_Sep_2010_20_01_02_+0200_BvOWCOVdTdF6pveE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Sep 2010 09:41:29 +0200 (CEST)
Jiri Kosina <jkosina@suse.cz> wrote:

> On Wed, 1 Sep 2010, Antonio Ospite wrote:
>=20
> > > > Be more explicit and avoid calling sony_set_operational_usb() when =
we
> > > > have USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE.
> > > >=20
> > > > While at it, rename the sony_set_operational routines to
> > > > sixaxis_set_operational as they are sixaxis specific.
> > > >=20
> > > > This is also in preparation for the sysfs interface to set and get =
bdaddr
> > > > over usb and for some other Sixaxis report fixup.
> > > >=20

I have just realized that the commit message mentions the now obsolete
sysfs interface, maybe Jiri can remove the last paragraph from it? Not
a big deal anyway.

> > > > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> > >=20
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > >
> >=20
> > Thanks Bastien for bringing this up again, I was going to repost
> > this patch sometime this month.
> >=20
> > Added Jiri to CC as I forgot to do that back then.
>=20
> Thanks, I have missed that one on linux-input@.
>=20
> Applied now.
>=20

Thanks Jiri.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__3_Sep_2010_20_01_02_+0200_BvOWCOVdTdF6pveE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyBN94ACgkQ5xr2akVTsAEcEwCfeArO866Z5HfZVmG0CzzFTbfQ
szUAoKLRIi6reXEFFqUagT0D/Pg6bxY4
=rIBd
-----END PGP SIGNATURE-----

--Signature=_Fri__3_Sep_2010_20_01_02_+0200_BvOWCOVdTdF6pveE--
