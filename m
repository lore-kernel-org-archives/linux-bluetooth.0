Return-Path: <sre@kernel.org>
Date: Thu, 11 May 2017 20:14:16 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Gross <andy.gross@linaro.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Loic Poulain <loic.poulain@intel.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_nokia: select CONFIG_BT_HCIUART_H4
Message-ID: <20170511181416.e3esc3rhuemw6p5q@earth>
References: <20170511121135.3505055-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aqmz47hokb2ko3ij"
In-Reply-To: <20170511121135.3505055-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>


--aqmz47hokb2ko3ij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Thu, May 11, 2017 at 02:11:26PM +0200, Arnd Bergmann wrote:
> Like the other H4 variants, this only builds when the base
> H4 support is enabled, otherwise we get a build error:
>=20
> drivers/bluetooth/hci_nokia.c:624:33: error: array type has incomplete el=
ement type 'struct h4_recv_pkt'
>=20
> Fixes: 7bb318680e86 ("Bluetooth: add nokia driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This has already been sent by Tobias Regnery some days ago:

http://www.spinics.net/lists/linux-bluetooth/msg70433.html

-- Sebastian

>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 40994d96d151..b2cf0ae6b62d 100644
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
> 2.9.0
>=20

--aqmz47hokb2ko3ij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkUqfgACgkQ2O7X88g7
+ppYqg/9EyF8ElvlqiB4WQxCKdRqZX8zZqK8YzyQCir4yvhG8mbldglC9ILvK4eI
xgALa9PqddFJ2g7H6Hl08FnjeiEAPQZVo+/ERo7hmtxKvcmf5JllLDsY17WUdMeb
2pYD5r/pGRbR2/88b90SD6zJsknmmcEh4uj9NQOEh0hefoCoJIHQw35K9eoBVey0
ewEbzxBK8lBDqrsSSIJ6T3fZO9OH/Ys5XStLRaor7dCvNOn9kd25l9Ypc74oBDs3
PIQ83yLP39TWgoLbDqzL1bcwE6asSQ5gfXv7TMmsDEFBOzX4ax5VEQnhirm7JPKe
Ci/F856z0wzd87zmqd3tY3M+9zNIohZNPN9GO4KRwJ3QQuGzAAG/F1P2f6sSjSt/
k/5tCj+edx0xrljoEdFXUwlMwJqPtYvSnc3t/CBpoNUocxwbDYsOaOuRf3gXIDtD
6zorzjZoOb3xLtC/u00QFuNMeuyYmW59J3Quv+wPV99izwggL0ZqCYUPE8NVHe09
3ulHgzGyX45bNoI77nhpXv2+Iy3mBSwFmOUDtx7H2nNlXAQR1QjxuFfSQN8xHdjv
7P93mo/X/hPjPusu3qhd9JTQt4OrfWHRoP2SOxqluG2+wdMpVjSfy7ihYnLAQnWf
G4JIhU+3YYMyb67BS5IsPM6+unpJS78I85YLoAoy1gotUs6yJgs=
=PzyK
-----END PGP SIGNATURE-----

--aqmz47hokb2ko3ij--
