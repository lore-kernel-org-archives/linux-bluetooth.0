Return-Path: <sebastian.reichel@collabora.co.uk>
Date: Sat, 8 Jul 2017 21:31:54 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, ohad@bencohen.org
Subject: Re: [PATCH 2/3] bluetooth: Nokia: Use new
 hci_uart_unregister_device() function.
Message-ID: <20170708193154.f2owsq3yaxrr47od@earth>
References: <20170708163743.24394-1-ian@mnementh.co.uk>
 <20170708163743.24394-3-ian@mnementh.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jllmrb3alxnod5tr"
In-Reply-To: <20170708163743.24394-3-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>


--jllmrb3alxnod5tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 08, 2017 at 05:37:42PM +0100, Ian Molton wrote:
> Simplify _remove() path for hci_nokia.c
>=20
> Signed-off-by: Ian Molton <ian@mnementh.co.uk>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/bluetooth/hci_nokia.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>=20
> diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
> index 6dbb1f6ff6bd..3539fd03f47e 100644
> --- a/drivers/bluetooth/hci_nokia.c
> +++ b/drivers/bluetooth/hci_nokia.c
> @@ -767,16 +767,8 @@ static int nokia_bluetooth_serdev_probe(struct serde=
v_device *serdev)
>  static void nokia_bluetooth_serdev_remove(struct serdev_device *serdev)
>  {
>  	struct nokia_bt_dev *btdev =3D serdev_device_get_drvdata(serdev);
> -	struct hci_uart *hu =3D &btdev->hu;
> -	struct hci_dev *hdev =3D hu->hdev;
> =20
> -
> -	hci_unregister_dev(hdev);
> -	hci_free_dev(hdev);
> -
> -	cancel_work_sync(&hu->write_work);
> -
> -	hu->proto->close(hu);
> +	hci_uart_unregister_device(&btdev->hu);
>  }
> =20
>  static int nokia_bluetooth_runtime_suspend(struct device *dev)
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--jllmrb3alxnod5tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllhMyoACgkQ2O7X88g7
+pratRAAoNjHNiphGD+7O71BsTTkn0Tp9ujnIw6fHK9Dz9HmcQ6y4C0xZyujQXYB
k1jv8sm7nxj5PFUyEnZ9urUi7benebkATFaBBZjY5DNMiLJ3MWpDTYWMRXFXY1S5
E1jGqMuwsuasoYfmweT5tjFREJ18lmrl820ffcaPH4QC9lKx4i7P37cOJSVYBqxo
PmKs58Y0VvjDwdeUe256SWn0B0OLlpxGGfbWhidzoG7AMcRRxxqaPAk9cEGsc6RT
6N3wuPcWN9pT6DV1cXoxfROQ1aRA4P5w/zEWB85NAP2hnLVbkuLsdc8yN/L174VB
ep2mFROtAqK/rTIaffZY0501uz1vTTyRYC7zrSo2XbozALaXdpRBQ1PJPe7SZIOj
bWOexLOeW7f8lj5Xb9h1XixJA5UcjhdbIWeJmbff6IjyxzvwI12s0/gQSIGrTDaX
qQTrIwoj008lE2NxwucqpkwmD1SyDkjdIjTSDjCreemHaHacYcZN4+dIDXz4s6L2
Fujm4MXlqFyuw0tzgd2K2qlpkvxcqnswMfNmMNHCishYDbrHueMSZH8UDrI4R41I
c30reWLBGn8953A4A7m1sOe02t407RSTL4DOQtHpYuzEdsI4MDN2LgojhzMXXJoJ
z6AOi+72aBu5/XCosd7ngD7Ax375lgAKG8K1YIojx+Lzuj9DWlY=
=VPZA
-----END PGP SIGNATURE-----

--jllmrb3alxnod5tr--
