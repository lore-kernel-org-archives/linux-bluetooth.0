Return-Path: <sre@kernel.org>
Date: Thu, 20 Apr 2017 02:15:34 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Kalle Valo <kvalo@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blutooth: try to improve CONFIG_SERIAL_DEV_BUS dependency
Message-ID: <20170420001534.ecnkaqlk652thya7@earth>
References: <20170419175051.4177480-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ibkhrv5gec764lu"
In-Reply-To: <20170419175051.4177480-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>


--4ibkhrv5gec764lu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 19, 2017 at 07:50:18PM +0200, Arnd Bergmann wrote:
> With CONFIG_SERIAL_DEV_BUS=3Dm, the hci_serdev.o file does not actually
> get built into hci_uart.o as the Makefile doesn't pick it up, leading
> to a link error with anything referring to it:
>=20
> ERROR: "hci_uart_register_device" [drivers/bluetooth/hci_nokia.ko] undefi=
ned!
> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
>=20
> Changing this in the Makefile would cause another problem when
> hci_uart itself is built-in and cannot reference symbols from the
> serdev module.
>=20
> This tries to address both problems by introducing a new hidden
> Kconfig symbol that controls both the compilation of hci_serdev.o
> and whether the Nokia driver can be selected. This seems to address
> the problem for me, though there might be a better way to do it.
>=20
> Fixes: 7bb318680e86 ("Bluetooth: add nokia driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/bluetooth/Kconfig  | 8 +++++++-
>  drivers/bluetooth/Makefile | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 8aafbed9e160..737d93ef27c5 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -76,6 +76,12 @@ config BT_HCIUART
>  	  Say Y here to compile support for Bluetooth UART devices into the
>  	  kernel or say M to compile it as module (hci_uart).
> =20
> +config BT_HCIUART_SERDEV
> +	bool
> +	depends on SERIAL_DEV_BUS && BT_HCIUART
> +	depends on SERIAL_DEV_BUS=3Dy || SERIAL_DEV_BUS=3DBT_HCIUART
> +	default y
> +
>  config BT_HCIUART_H4
>  	bool "UART (H4) protocol support"
>  	depends on BT_HCIUART
> @@ -89,7 +95,7 @@ config BT_HCIUART_H4
>  config BT_HCIUART_NOKIA
>  	tristate "UART Nokia H4+ protocol support"
>  	depends on BT_HCIUART

I guess BT_HCIUART dependency is no longer needed
when we have BT_HCIUART_SERDEV dependency?

Otherwise:

Reviewed-by: Sebastian Reichel <sre@kernel.org>

> -	depends on SERIAL_DEV_BUS
> +	depends on BT_HCIUART_SERDEV
>  	depends on PM
>  	help
>  	  Nokia H4+ is serial protocol for communication between Bluetooth
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index a7f237320f4b..e693ca6eeed9 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -31,7 +31,7 @@ btmrvl-y			:=3D btmrvl_main.o
>  btmrvl-$(CONFIG_DEBUG_FS)	+=3D btmrvl_debugfs.o
> =20
>  hci_uart-y				:=3D hci_ldisc.o
> -hci_uart-$(CONFIG_SERIAL_DEV_BUS)	+=3D hci_serdev.o
> +hci_uart-$(CONFIG_BT_HCIUART_SERDEV)	+=3D hci_serdev.o
>  hci_uart-$(CONFIG_BT_HCIUART_H4)	+=3D hci_h4.o
>  hci_uart-$(CONFIG_BT_HCIUART_BCSP)	+=3D hci_bcsp.o
>  hci_uart-$(CONFIG_BT_HCIUART_LL)	+=3D hci_ll.o
> --=20
> 2.9.0
>=20

--4ibkhrv5gec764lu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlj3/aQACgkQ2O7X88g7
+pqNhBAAkAb5Vyf+nhn+1kduVZ1HPprK3UxOuX8S7BUKsrTxUfuUV5vkNNTa37Us
cYnD3X3sgitYVtc/vfWZ0nzcvMfqoE/CV5B0CvMVxwYyBR1QfASb+9+4uVuG3UVz
dPZc90+L2N8I0KWOgR9wdORt9Vk5G7xr4CjlpI/6wOQSxiD8+yTiD6L44ACqMEut
cczhc9HE2RhT5rCxBSYKBkuyXU7kI3eUvy/jneq4y7JW1biTA+BimoGS2yjc+MIx
17Y5Q5eNxzPxllktdeYH0G9sEKOX0+3RJ1caKSKVrhc4JxKeRm3L+qaTGFip9U1B
UGlQLthRWrv+0oFBAX1XR6uZIScQWreSWuMFmB5X7xppdMfDb5Dbe0V1VhndT/eP
V6XeJHUgSBR/tQ/42MN/sI0hOdzjeb1ronvJyTdhOOYY2iYb3AaiQlJUhJDb5twk
mI3mqt7djlDDfew8iwsgar9rnlTiuJviG1ZselBiPRMbdYsUOuYrtYlD6tHeGBvM
IqClLaKqEeOh8GfnmxvAzXymvMiodLiXeX/H1owtnXXLpymGfdKWmmaxmnI/D4A6
+bCrKlYAQhylA/ro4A9O/P++nQ/L1A9f+t2KSK/KM+wspT/rdifvUuBIi31oV1DW
GByGJqG+urz0UxlIvO2uJubKQZ/27lAb4ChRCnFlkzFO6nccW00=
=f3U8
-----END PGP SIGNATURE-----

--4ibkhrv5gec764lu--
