Return-Path: <sre@kernel.org>
Date: Thu, 11 May 2017 20:12:11 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Gross <andy.gross@linaro.org>,
	Loic Poulain <loic.poulain@intel.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluetooth: hci_ll: add proper SERDEV dependency
Message-ID: <20170511181053.rter2luofu5elzh6@earth>
References: <20170511114223.2744939-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hvjmnaiadm52vihi"
In-Reply-To: <20170511114223.2744939-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>


--hvjmnaiadm52vihi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 11, 2017 at 01:41:54PM +0200, Arnd Bergmann wrote:
> When SERDEV is a loadable module, and the HCI code is built-in, we
> get a link error:
>=20
> drivers/bluetooth/built-in.o: In function `ll_close':
> hci_ll.c:(.text+0x278d): undefined reference to `serdev_device_close'
> drivers/bluetooth/built-in.o: In function `hci_ti_probe':
> hci_ll.c:(.text+0x283c): undefined reference to `hci_uart_register_device'
> drivers/bluetooth/built-in.o: In function `ll_setup':
> hci_ll.c:(.text+0x289e): undefined reference to `serdev_device_set_flow_c=
ontrol'
> hci_ll.c:(.text+0x2b9c): undefined reference to `serdev_device_set_baudra=
te'
> drivers/bluetooth/built-in.o: In function `ll_open':
> hci_ll.c:(.text+0x2c77): undefined reference to `serdev_device_open'
> drivers/bluetooth/built-in.o: In function `ll_init':
> (.init.text+0x10d): undefined reference to `__serdev_device_driver_regist=
er'
>=20
> We already have CONFIG_BT_HCIUART_SERDEV as a Kconfig symbol that is
> set when the serdev code is reachable by a driver. Unlike the nokia
> driver, this one can also be built when serdev is completely disabled,
> so we add a dependency on serdev either being usable or disabled here.
>=20
> Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver =
support")
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

> ---
>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index a63130ef2b98..b2cf0ae6b62d 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -133,6 +133,7 @@ config BT_HCIUART_ATH3K
>  config BT_HCIUART_LL
>  	bool "HCILL protocol support"
>  	depends on BT_HCIUART
> +	depends on BT_HCIUART_SERDEV || SERIAL_DEV_BUS=3Dn
>  	help
>  	  HCILL (HCI Low Level) is a serial protocol for communication
>  	  between Bluetooth device and host. This protocol is required for
> --=20
> 2.9.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--hvjmnaiadm52vihi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkUqXsACgkQ2O7X88g7
+ppYrhAApSwoHeivfbpD5rqWaITAHOQb04Ps9tQ+plRSInZPR7Z5LLGlFcP8Y8Er
NsTzxUKIqkK30nm9cuwegaV7sVyYJdXzOzJLygTaTevUJZb+f/BU0rE6D2R298ZI
bw1LDRkaD6zmYEe6GWt6i2m/pRpVOe++n1xyK5KQFC8GFr5k0RrOaGIhxhQHUcUk
I9gPFZvjJRfZFuizSnscHeVeRIumwqsqMCk7+E88niRn0GSb3eURfIjwza+zbz57
XaZdYHZnSB5NGxUMb4lanUXfJtTjVtmdpuA/IP9B+FfqF9CXn60wMYe1udS1hWdl
CAQmSyjyFQvzdh4BB5a96h2sNehPfeXzslfaD1QQ90F/2KYZKxTVyoWRRFf9Y/x4
nRxe1CKvDf2mHCKlgRdZdxUendRMXlt58H7gWizW5ET7BLmvnJd/I/tfP/BujKhf
SdcXaJBq7xEnkPMRP25gO/vpdfq9sbOuTqJYR8cu6bOZhvhj3x9gnriBQHSVpTW/
jJmfdf+OrsJwITzy86LDfJewAZLoVrowSpTCvlyrto+rR4NgjzPX1skjniC/JjGg
jpZEhu2zgyBSwoa66T6liaD2MLAqt70p2LdPGC5dxJ+L4HNjYQ/1VTWzickLQFwU
dOCCrqI8FuqrZ00gT56B4mw+oTlTHiJ2ggMsHAdSFXrVhz2ninY=
=MDTr
-----END PGP SIGNATURE-----

--hvjmnaiadm52vihi--
