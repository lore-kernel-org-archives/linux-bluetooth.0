Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 May 2014 10:15:48 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Adam Lee <adam8157@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Bluetooth: ath3k: no need to set same pipe multiple times
Message-ID: <20140527131548.GB2034@joana>
References: <1401169747-11033-1-git-send-email-adam8157@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
In-Reply-To: <1401169747-11033-1-git-send-email-adam8157@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Adam,

2014-05-27 Adam Lee <adam8157@gmail.com>:

> Invoking usb_sndbulkpipe() on same pipe for same purpose only once is
> enough.
>=20
> Signed-off-by: Adam Lee <adam8157@gmail.com>
> ---
>  drivers/bluetooth/ath3k.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThJAEAAoJEPs3PUX4s20opBMP/jyTuSva1+zZDmFQmO1r4vOD
0AvefzKAKlI8dD+njkUhCglDnrjluqcUewKRaXyIEyuxmiqSPQtVT1BOQXUNIeeB
SHM29nlgNMNR+Gw3eO7P1TDsUPLrDIGIjrBDO8kqj8kSHWZhZ18N2iL+KVzGWPSd
I6PUSAVvOoMl2MaR9i0q87jsgvjTNpxN/AyBvWT/YKVAxpyq2L2oQAMmQBm9MKbi
0uLpdSiYOqCuJ0DFnN7WnoDfLd5f4RiBT2dPe4F9WCcBeVZJMdnSukuLPNfiAJLr
O/sk2e/YaN7x6BEZTAZf0dk5NMEaD2pMfyRIeATyBCXXSV/exUAQChnLGjgjlN50
OMpTqRPPgDA2Ub2K0yjho3B81UGiH2+h5w+zNKRjaPuoPA1xvGnAlE3ge5rP8p0p
7CoF38km5ot/ocZNNaqMe37cE6E/UQQRutggbOf1AotUyQu5y4WPfm9WC09dW9mX
Wnizz2n+3ssq2IaTzRQqGslZD5Pnl9V7qA0wPdCE1FFfGa75Oy5lYkQFji3ttbw5
FxHTaTScOie8sCSJ/HvZ2FWfE8lEBT870oX/54LS1keTVlo2qKSmOtfU2k7SC16O
e12igMuRKrzwS4qd4T0V27xhT/oWTuezfHQmA2AV7LCQeIRYCrt2NaN4iE8/DCP7
2vnqXgTp/lvg9oGhAzsx
=aQa8
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
