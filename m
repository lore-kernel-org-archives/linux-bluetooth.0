Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 28 Apr 2017 13:44:49 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add module license for HCI UART Nokia H4+
Message-ID: <20170428114449.e74v6tet3l23xiam@earth>
References: <1493378771-22557-1-git-send-email-frederic.danis.oss@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4eu2irozqaoiix3d"
In-Reply-To: <1493378771-22557-1-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--4eu2irozqaoiix3d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 28, 2017 at 01:26:11PM +0200, Fr=E9d=E9ric Danis wrote:
> Fix the following error preventing to load Nokia H4+ module:
>   kernel: [  826.461619] hci_nokia: module license 'unspecified' taints k=
ernel.
>   kernel: [  826.461629] Disabling lock debugging due to kernel taint
>   kernel: [  826.461836] hci_nokia: Unknown symbol gpiod_get_value_cansle=
ep (err 0)
>   kernel: [  826.461876] hci_nokia: Unknown symbol devm_kmalloc (err 0)
>   kernel: [  826.461908] hci_nokia: Unknown symbol gpiod_set_value (err 0)
>   kernel: [  826.461937] hci_nokia: Unknown symbol serdev_device_set_baud=
rate (err 0)
>   kernel: [  826.461994] hci_nokia: Unknown symbol gpiod_set_value_cansle=
ep (err 0)
>   kernel: [  826.462021] hci_nokia: Unknown symbol hci_uart_tx_wakeup (er=
r 0)
>   kernel: [  826.462043] hci_nokia: Unknown symbol serdev_device_set_flow=
_control (err 0)
>   kernel: [  826.462064] hci_nokia: Unknown symbol gpiod_to_irq (err 0)
>   kernel: [  826.462085] hci_nokia: Unknown symbol serdev_device_open (er=
r 0)
>   kernel: [  826.462106] hci_nokia: Unknown symbol gpiod_get_value (err 0)
>   kernel: [  826.462150] hci_nokia: Unknown symbol clk_prepare (err 0)
>   kernel: [  826.462182] hci_nokia: Unknown symbol pm_runtime_enable (err=
 0)
>   kernel: [  826.462204] hci_nokia: Unknown symbol h4_recv_buf (err 0)
>   kernel: [  826.462246] hci_nokia: Unknown symbol serdev_device_write_fl=
ush (err 0)
>   kernel: [  826.462268] hci_nokia: Unknown symbol serdev_device_get_tioc=
m (err 0)
>   kernel: [  826.462298] hci_nokia: Unknown symbol driver_unregister (err=
 0)
>   kernel: [  826.462318] hci_nokia: Unknown symbol serdev_device_wait_unt=
il_sent (err 0)
>   kernel: [  826.462347] hci_nokia: Unknown symbol __serdev_device_driver=
_register (err 0)
>   kernel: [  826.462384] hci_nokia: Unknown symbol serdev_device_set_tioc=
m (err 0)
>   kernel: [  826.462417] hci_nokia: Unknown symbol clk_get_rate (err 0)
>   kernel: [  826.462454] hci_nokia: Unknown symbol __pm_runtime_resume (e=
rr 0)
>   kernel: [  826.462486] hci_nokia: Unknown symbol serdev_device_close (e=
rr 0)
>   kernel: [  826.462524] hci_nokia: Unknown symbol cancel_work_sync (err =
0)
>   kernel: [  826.462546] hci_nokia: Unknown symbol btbcm_set_bdaddr (err =
0)
>   kernel: [  826.462567] hci_nokia: Unknown symbol clk_disable (err 0)
>   kernel: [  826.462610] hci_nokia: Unknown symbol __pm_runtime_disable (=
err 0)
>   kernel: [  826.462632] hci_nokia: Unknown symbol hci_uart_register_devi=
ce (err 0)
>   kernel: [  826.462653] hci_nokia: Unknown symbol clk_enable (err 0)
>   kernel: [  826.462675] hci_nokia: Unknown symbol __pm_runtime_idle (err=
 0)
>   kernel: [  826.462700] hci_nokia: Unknown symbol clk_unprepare (err 0)
>
> Signed-off-by: Fr=E9d=E9ric Danis <frederic.danis.oss@gmail.com>
> ---
>  drivers/bluetooth/hci_nokia.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
> index 4038daf..c563f3c 100644
> --- a/drivers/bluetooth/hci_nokia.c
> +++ b/drivers/bluetooth/hci_nokia.c
> @@ -36,6 +36,8 @@
>  #include "hci_uart.h"
>  #include "btbcm.h"
> =20
> +#define VERSION "0.1"
> +
>  #define NOKIA_ID_BCM2048	0x04
>  #define NOKIA_ID_TI1271		0x31
> =20
> @@ -818,3 +820,8 @@ static struct serdev_device_driver nokia_bluetooth_se=
rdev_driver =3D {
>  };
> =20
>  module_serdev_device_driver(nokia_bluetooth_serdev_driver);
> +
> +MODULE_AUTHOR("Sebastian Reichel <sre@kernel.org>-");

There is a superfluous - at end of string.

> +MODULE_DESCRIPTION("Bluetooth HCI UART Nokia H4+ driver ver " VERSION);
> +MODULE_VERSION(VERSION);
> +MODULE_LICENSE("GPL");

Otherwise:

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--4eu2irozqaoiix3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkDKy4ACgkQ2O7X88g7
+pqTLA//WF5jSlgV5K2a0iAILuajaDqqah2uYsT0oxH8ZPmAmlGHCHn1E50XLpAu
YgiwW62c6xlhA7IHoLFpgip4vHliOsvRBZl9CA/v3IhY3nOPnTt0jt2/xCWkFsv1
pSV7u0qYWaZPjok7T2DHQoU/0Z80sxsrTeIwvu9rNr8oriCn4eZ7n/PCAxqV+6ml
1CwVsUbtvs4tJ3GSnULfyIRkO9Gu7TqBnp7JI5H0merbi4MyCm+NE5kNR0JGuepv
2Qpm8uKphfS125YPk8Zt7zhhL8M6kWaCsYOhR50thZE43UO6+qXNcUuEwdO8Kquj
3OWv47QSjK27NwB6fJUcskDo2YVKk/N9/fjQ8zOV2ArexKyj9udjWYJs99bscTXK
x4HxsgVn57ObQwXYECddCnUCIkWHW1FVgCIgiXdkRKS4ir5wCVggWESAPmbXRAJb
qprhs3jftJZ21tBEuJ3yzKaNIkelrcHMZoqAY13zimYxzucAFmsxZ+xqn0cNKHlZ
asvyAa5Cdo2U9rwW1SaneVbSXhC8oxiN8Vfmga0y/gWTaIT7qUKkvpo7vCkldtIv
m3z0afh/qGe3zclh4riklTv2QJ+5A3UmU4yzd7/sP8RYikVR37Vu5WygkzVtO5hY
HZcW6r3GSrGhCuGqGxK0itEwFZ2TC6z2odPt7AKw6bryPDBhvaw=
=JbiZ
-----END PGP SIGNATURE-----

--4eu2irozqaoiix3d--
