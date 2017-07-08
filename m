Return-Path: <sebastian.reichel@collabora.co.uk>
Date: Sat, 8 Jul 2017 12:49:32 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: PATCH: Nokia HCI driver minor issues
Message-ID: <20170708104932.ig3ncqhznjodhqdc@earth>
References: <c9907efa-aff0-fa9e-7cdf-868e02203d95@mnementh.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7o2wjzzlneuqqtbz"
In-Reply-To: <c9907efa-aff0-fa9e-7cdf-868e02203d95@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>


--7o2wjzzlneuqqtbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 07, 2017 at 11:03:28PM +0100, Ian Molton wrote:
> I've collected a couple of patches together over the last week, they
> might be of use.
>=20
> I'm not entirely certain the 2nd one is the *correct* fix, as I could
> only test my (very similar) driver I've based off this one, but it WFM.
>=20
> --Ian

Please always send using get-send-email(1) mail style.

> -------------------------------------------------------------------
> From 3e5182a84717acd5eadd645294a008bcf27201a0 Mon Sep 17 00:00:00 2001
> From: Ian Molton <ian@mnementh.co.uk>
> Date: Tue, 4 Jul 2017 15:01:46 +0100
> Subject: [PATCH 1/3] Bluetooth: Nokia HCIUART driver should depend on H4
>=20
> 	The Nokia H4+ driver causes a build error if BT_HCIUART_H4
> is not configured. Make it depend on this symbol.
>=20
>=20
> Signed-off-by: Ian Molton <ian@mnementh.co.uk>

You are on an old branch. Current mainline selects BT_HCIUART_H4.

> ---
>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 737d93ef27c5..adcd093b7bb3 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -96,6 +96,7 @@ config BT_HCIUART_NOKIA
>  	tristate "UART Nokia H4+ protocol support"
>  	depends on BT_HCIUART
>  	depends on BT_HCIUART_SERDEV
> +	depends on BT_HCIUART_H4
>  	depends on PM
>  	help
>  	  Nokia H4+ is serial protocol for communication between Bluetooth
> --=20
> 2.11.0
>=20
> From d3f45ffce99e85e73a7777c6cc39e61ee6971094 Mon Sep 17 00:00:00 2001
> From: Ian Molton <ian@mnementh.co.uk>
> Date: Fri, 7 Jul 2017 22:55:18 +0100
> Subject: [PATCH 2/3] bluetooth: Nokia: prevent crash on module removal.
>=20
> 	Unsure if this is correct, but the same code in my brcm serdev
> 	driver crashes if not done in this sequence.

I think the commit message should be:

Only cancel any ongoing work after making sure, that no new work can
be scheduled. This fixes a race condition in the remove handler.

Missing SoB.=20

Otherwise:
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

> ---
>  drivers/bluetooth/hci_nokia.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
> index a7d687d8d456..728dab3c03f6 100644
> --- a/drivers/bluetooth/hci_nokia.c
> +++ b/drivers/bluetooth/hci_nokia.c
> @@ -770,10 +770,12 @@ static void nokia_bluetooth_serdev_remove(struct
> serdev_device *serdev)
>  	struct hci_uart *hu =3D &btdev->hu;
>  	struct hci_dev *hdev =3D hu->hdev;
>=20
> -	cancel_work_sync(&hu->write_work);
>=20
>  	hci_unregister_dev(hdev);
>  	hci_free_dev(hdev);
> +
> +	cancel_work_sync(&hu->write_work);
> +
>  	hu->proto->close(hu);
>=20
>  	pm_runtime_disable(&btdev->serdev->dev);
> --=20
> 2.11.0
>=20
> From 806ac777fae2e800e79a2e04e84e3fb998b61ff3 Mon Sep 17 00:00:00 2001
> From: Ian Molton <ian@mnementh.co.uk>
> Date: Fri, 7 Jul 2017 22:57:49 +0100
> Subject: [PATCH 3/3] bluetooth: Nokia: remove duplicate call to
>  pm_runtime_disable()
>=20
> 	pm_runtime_disable() is called in the _close() handler.
>=20
> Since we call the _close() handler on remove, there is no need to
> call pm_runtime_disable() a second time.
>=20
>=20
> Signed-off-by: Ian Molton <ian@mnementh.co.uk>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

> ---
>  drivers/bluetooth/hci_nokia.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
> index 728dab3c03f6..3aac150eac97 100644
> --- a/drivers/bluetooth/hci_nokia.c
> +++ b/drivers/bluetooth/hci_nokia.c
> @@ -777,8 +777,6 @@ static void nokia_bluetooth_serdev_remove(struct
> serdev_device *serdev)
>  	cancel_work_sync(&hu->write_work);
>=20
>  	hu->proto->close(hu);
> -
> -	pm_runtime_disable(&btdev->serdev->dev);
>  }
>=20
>  static int nokia_bluetooth_runtime_suspend(struct device *dev)
> --=20
> 2.11.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--7o2wjzzlneuqqtbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllguLkACgkQ2O7X88g7
+pqoBQ/6AvROtS1qtb/TGAPOiVU/ijnf+C4m8kLJ4Kz9Ucf2b9RwoQlRKEPeaJp5
FguWprzLKyTS3BgQqF8xEAKDtEeLdBGE8HBSL4D5CSMvha59HhM14bazooOAYCxl
cT0xJU7lpPp4pL7dKboSo0zBivEoRHkwrXb5OovuvuKg0uQSy2osOIB7kOBfFMCy
iXw4+esPOoMfimkxN9gEMmJT549ucHEbe70YGyFqG/pdjnm4wJWLxC35/R/3qfUQ
rAbROmWAV+hS3Uj+k+LIALg7pehPM7zhjYoDLxaJBh33wvbQp87clurg0JfnNSMn
Y7RhwwCIHJ/0um8jiJQkmzFJn1fYDXZtiqtWREJWPejaRurPh8F3TJYdycZlD3Fs
czsgVWrxwx5mtmqYS2hlmLO8ZK5mEZhvAZcK44ANXmGJx6WytxWO/DRdEdQQaB11
ZuMqxCq7FdL7XBFjcrArEPcfM7wRWrS0IMCfZEc1tqn4oinBFtA11UyGjl2EYbOm
pDzy3pWlk3yeT+/0ubzDRs7GCpj50MSG/u5DNUdVpzYOZbsKyCiVGrQVNxjKPCZd
5Btg7zmZVJKqgY76y/2ZXfGx+6IauXhqfZ5lHkzQmnM3WC7tLXHIUx+YJZOLBT0X
6kRliE5qVXUKKGe9wKySresNNqlOmJY0wwEroXzzD/r/2Kay/S8=
=1uEJ
-----END PGP SIGNATURE-----

--7o2wjzzlneuqqtbz--
