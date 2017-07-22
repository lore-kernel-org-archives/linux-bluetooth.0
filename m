Return-Path: <sre@kernel.org>
Date: Sat, 22 Jul 2017 21:03:23 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_nokia: select BT_BCM for
 btbcm_set_bdaddr()
Message-ID: <20170722190323.mt5mrnioql7z2uj2@earth>
References: <20170722095747.101069-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhbnegvsou255quw"
In-Reply-To: <20170722095747.101069-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--xhbnegvsou255quw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 22, 2017 at 11:57:47AM +0200, Marcel Holtmann wrote:
> The Nokia devices require the setup of its Public Bluetooth Device
> Address and for that it is required to depend on vendor specific
> commands. For Broadcom based Nokia devices, that is part of btbcm
> module and can be selected via BT_BCM config option.
>=20
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 35952a94875e..3a6ead603e49 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -98,6 +98,7 @@ config BT_HCIUART_NOKIA
>  	depends on BT_HCIUART_SERDEV
>  	depends on PM
>  	select BT_HCIUART_H4
> +	select BT_BCM
>  	help
>  	  Nokia H4+ is serial protocol for communication between Bluetooth
>  	  device and host. This protocol is required for Bluetooth devices
> --=20
> 2.13.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--xhbnegvsou255quw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllzoXcACgkQ2O7X88g7
+pqRWA/+O8fl5AUTRdYhREJqJYoKjYj44k0KeWxoMU62+fhfLe/JuYvcqbn+DUU+
GMB3T8GLmMW0H12UHlgpBHS8dpqfDBCRbJcIxwGN1Xm7CBgI+qpfwNqDF2G0YKkN
7gq8bDg7HDfNzPARMe0WFy3njgOzUYjm2HcqQm/GTfJ1wiYH62brVaSouwZaknoJ
a4cqdLHUCENDhAxeePw6wd4Mbv2I+wYRBPT7xGFRghiRIfPKZSDSwpEMaBXpIa51
aD0TAblTcTpUeDin/CctRmkSQ/t72mxnWahvCSqeSOP0YzC91s/eqEvRaIH62PZJ
XOTv01A5fmCO8mUexx3Y6qTtK/oPxudHxpwedFQ+cao7Rr8wuZSqvCIb+RgLwRLr
iRqloFvzWl/LozxVq4DxmoIPFe8SONnyxkQCKnUYQI+HBLNtmS2vlmrqgzWsUh6c
FyMjoEPTXzJkUpofq/4mTDPwCDGjOHUxP8gLk1HvLuVQO27KxXJjGoemUu3UI0jY
jME9esIh5MxxYtca7K6shYbL77qO/ZZpfYt+KZ8lhxAp5lm3jEClkzP0/hvUZg9i
2ITwezjBxmiukSY85W3j5OOzHGLBBGRvTtCoAfv+4XsT4pVHZyI90An9T9gZAMYo
RiQeu3RoBIM1Z/7ROCg70jAg20t93VLKPkFqwk331SBljuZ2dBM=
=m/Cn
-----END PGP SIGNATURE-----

--xhbnegvsou255quw--
