Return-Path: <sre@kernel.org>
Date: Mon, 8 May 2017 20:28:33 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Tobias Regnery <tobias.regnery@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_nokia: select BT_HCIUART_H4
Message-ID: <20170508182833.ctfvhdmu6oxy72ty@earth>
References: <20170508093911.25228-1-tobias.regnery@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fgivigjbvamfgq3o"
In-Reply-To: <20170508093911.25228-1-tobias.regnery@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--fgivigjbvamfgq3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 08, 2017 at 11:39:11AM +0200, Tobias Regnery wrote:
> We see the following build failure with CONFIG_BT_HCIUART_NOKIA=3Dy and
> CONFIG_BT_HCIUART_H4=3Dn:
>=20
> drivers/bluetooth/hci_nokia.c: In function 'nokia_recv':
> drivers/bluetooth/hci_nokia.c:644:18: error: implicit declaration of func=
tion 'h4_recv_buf' [-Werror=3Dimplicit-function-declaration]
> ...
>=20
> Fix this by selecting the BT_HCIUART_H4 symbol like all the other users
> of the protocoll.
>=20
> Fixes: 7bb318680e86 ("Bluetooth: add nokia driver")
> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>

Reviewed-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

> ---
>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index e5fd24d90b0a..35952a94875e 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -97,6 +97,7 @@ config BT_HCIUART_NOKIA
>  	depends on BT_HCIUART
>  	depends on BT_HCIUART_SERDEV
>  	depends on PM
> +	select BT_HCIUART_H4
>  	help
>  	  Nokia H4+ is serial protocol for communication between Bluetooth
>  	  device and host. This protocol is required for Bluetooth devices
> --=20
> 2.11.0
>=20

--fgivigjbvamfgq3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkQuNEACgkQ2O7X88g7
+poBpQ//Yx/Wbr4LHxyuSq4DOTKUTQYR9sZILEPQOvya6ggAY4x1ztpnUpMNyWey
Vch/5wxhqgMS4s6uL+o6rWE6UuArDBqDAx1HJAGlogayI7jsAGlt+7kpxvA4yaiH
RPdc61EPoxw+NHeAkH+H/R6Jn3A+S/4QpKxaDgurAs3ALrzwJWeEDq49kOmTfQ7x
yyLO93JRDVhjMku/s6TsUmMG7TL+MUZPBph9odFVu7IFBROffi/hqr9pc+5Coom8
S39+VuFfdSBsTPkgCOtDu/KDCQIQtFaYBZ/81lepzNpM42PLrJKeRvN61ZN9o7dc
xuzsOOZx2QzjJqUQOzStLIJJ9aglkski+XYb1kwCfGsQIn+UirZpkrVA54WmQxJH
Sz9kO/8OMycyWJ9/Z9MiQIdRbVqAMGEqdZekNoIemidTzjfWU3HNm5VE4nrGXGgO
HtTjc89U8JtuNZjiOQIDJ4PBQhdy47/DD620upeFrrRBrz1AUC9v6vngiug3zc8z
LRIVhANGrqwMGboEm7jOxL0blVKZUeLT+Az1Jo+994GrK1NrR3M7emc3vIyVTl3v
2XYrPQDAaBhw/qWyUUAXeMzrSxi22k/QnHKfePksBlnUcAbNzzYBq4SHuEoOciKT
IPZzdvIO8UQTjrOWxeKB120ygnFnnJqL8SpFJuDxVPNNVMhIVM8=
=z+bt
-----END PGP SIGNATURE-----

--fgivigjbvamfgq3o--
