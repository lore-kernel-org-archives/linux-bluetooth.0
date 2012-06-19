Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Jun 2012 00:55:20 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Subject: Re: [PATCH 3/3] Bluetooth: Use GFP_KERNEL in mgmt events functions
Message-ID: <20120619035520.GG1679@joana>
References: <1339106746-22886-1-git-send-email-aguedespe@gmail.com>
 <1339106746-22886-3-git-send-email-aguedespe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
In-Reply-To: <1339106746-22886-3-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre,

* Andre Guedes <aguedespe@gmail.com> [2012-06-07 19:05:46 -0300]:

> cmd_status, cmd_complete and mgmt_event functions are executed in
> process context and they are not called inside atomic sections. Thus,
> they should use GFP_KERNEL for memory allocation instead of GFP_ATOMIC.
>=20
> Signed-off-by: Andre Guedes <aguedespe@gmail.com>
> ---
>  net/bluetooth/mgmt.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

All 3 patches have been applied to bluetooth-next. Thanks.

	Gustavo

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP3/goAAoJEPs3PUX4s20oz2YP/Rdc3Tm+KqB5yGG9B+KXfm7F
ZvU6rtEaB1AI2rNMphp3ftM1SGasLtzyQQk2cPd1eZVCo7FnlTcN7VDZNjCLwuQP
EcoBWoEUFtPwhJW3nR43W2QUQr3lxLMzVHkf+F9U4e7XtjEaZFj9Q/YSoPDKT3nf
TTOYVUvFZCvY0wfi3DMs54vPnGcBe3qSLxalpkw6YvsSAI0KaWYXV3HYO2rVtfwE
5U3CL4h/8HGYMLnH9KZfS7zZhd1QoQpyDFU37pqmqHqiTHXsIb/71fG/MHuKpMjW
WlaGVZb320jfIPSbQ32ykobX2oVMnti5ksH67CD6gnXTqum7kyHwkohtBGuu8FEP
MGGMycz6DgtBDQ5XFadnuk5nB7FHA2TYKxjng0s5KsMcM9vcUIwHTqHk1iyvn+Z4
LmGjYHY66fUZFqx9SfZ2HnM4yFwUIYH8ISvA/HqHI1CtZZEiHCTN9V9TaLBOf5zi
p6pyJyFm9gC3UUNh/QuPtLJ71lI2/MzwFOLYA+preBJQxvdrvMj7/VP9B0AQkdZG
ojy5vTBi9TNwjt8o42Oo9m+HNRDeKZyRdbfDW0GN4U+x1vCWv0Y/ulSIheQTflp7
N9EKoT81SoMm4iNqfbdBeCp04yhj3nutP4vtabTtW3CGW58GBfhN+qmkcjojkG33
VfsXGkEXehcZTQR4DnjN
=g21U
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
