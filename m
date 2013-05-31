Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 May 2013 21:02:46 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] Bluetooth: check for (harmless) underflow
Message-ID: <20130531000246.GC14083@joana>
References: <20130530080510.GD8148@debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
In-Reply-To: <20130530080510.GD8148@debian>
List-ID: <linux-bluetooth.vger.kernel.org>


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

* Dan Carpenter <dan.carpenter@oracle.com> [2013-05-30 11:05:10 +0300]:

> "len" can be negative here.  It's harmless but pretty subtle and
> scary looking so lets add a check for it.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index a1b7a02..438f39e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4069,6 +4069,9 @@ static inline int l2cap_config_rsp(struct l2cap_con=
n *conn,
>  	BT_DBG("scid 0x%4.4x flags 0x%2.2x result 0x%2.2x len %d", scid, flags,
>  	       result, len);
> =20
> +	if (len < 0)
> +		return -EINVAL;
> +
>  	chan =3D l2cap_get_chan_by_scid(conn, scid);
>  	if (!chan)
>  		return 0;

We already pushed to bluetooth.git a more comprehensive patch to fix this
issue and others over the code. Thanks anyway for sending this.

	Gustavo

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJRp+imAAoJEPs3PUX4s20og0YQAIic5kSVIW92Pr5Lxy9131EZ
UKSxd+gDhTD99VpRg4oDsteB/816BKr29A1XJtAXAHrfG3AKUHGm+YGGOimgWSkf
m3OP+/L9Dw5QRw7VqSZt+85+SKE1QaC8PaJe9lgIlefwTFYqZ+faBsaSVhkVs2uc
51KyExZIbzFtmcrdP4acST+4FV0Zl5Q+HAX+I/HLhIGkJiK63ArEfjbt978Xu5Xx
WD4tcorzdvd79fgdZsDMrg4av/Px2XhJdCXtBFihTUSGh/jITaBNl5JbvRIp0DMe
a3qeo3sv/KRXn0/RKdX3z/g/UYEVu+XGjqUj2eZlrlkM4zkmyg8B+z8LETPhawE9
ugH0WckGv637racL16taLRiN1O9dFAI95sd6PasR4BFbSgO1HRT3JZPmhjWcoE+v
oxA7m1Kvau9q9jNWo9HEu+OWW/YsC0KQ1XSRklvS/GBypZLTQPNnMAQrhNV6QmsZ
0Qp3Xvc6tUeeus4HIGTzjmYFg7js+6A9ORE6fSKgMkQTp/n7c29TvxpW8DiVEDLH
Qg9B9rJYZiqHAJsaVCpC0/9QKvSnfnrXycrQu0kPeP75eaq7+XYm4X7vjb5VtbGC
9q3Ats1ItAx0KLUZyEZxacvlcj7GzkUl7Zdi6FPCyBuFEWxGe3BbmUUsCr41Wvqk
5+xOPuCl7319BP/JE/u9
=AqQw
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
