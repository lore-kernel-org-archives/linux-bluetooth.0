Return-Path: <pavel@ucw.cz>
Date: Wed, 5 Oct 2016 21:11:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Joe Perches <joe@perches.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, trivial@kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluetooth.h: __ variants of u8 and friends are not
 neccessary inside kernel
Message-ID: <20161005191103.GA25972@amd>
References: <20161003085640.GA8130@amd>
 <368810F9-519C-44B5-85D4-1815273438BF@holtmann.org>
 <1475689996.6105.11.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <1475689996.6105.11.camel@perches.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2016-10-05 10:53:16, Joe Perches wrote:
> On Wed, 2016-10-05 at 13:14 +0200, Marcel Holtmann wrote:
> > Hi Pavel,
> >=20
> > > bluetooth.h is not part of user API, so __ variants are not neccessary
> > > here.
> > >=20
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > >=20
> > > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetoot=
h/bluetooth.h
> []
> > > struct bt_skb_cb {
> > > -	__u8 pkt_type;
> > > -	__u8 force_active;
> > > -	__u16 expect;
> > > -	__u8 incoming:1;
> > > +	u8 pkt_type;
> > > +	u8 force_active;
> > > +	u16 expect;
> > > +	u8 incoming:1;
> > > 	union {
> > > 		struct l2cap_ctrl l2cap;
> > > 		struct hci_ctrl hci;
>=20
> trivia:
>=20
> It's generally faster to use bool instead of u8 foo:1;

Ok, but I'm not changing that in this patch.

(And actually, bool will take a lot more memory, right?)
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlf1UEcACgkQMOfwapXb+vLL7QCfQIEcwKn89iZuB2xPud/61CFI
Yx8AoLIifb6F89oprpCglUbjQT7fiQXw
=QID+
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
