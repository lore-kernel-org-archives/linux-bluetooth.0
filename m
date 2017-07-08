Return-Path: <sebastian.reichel@collabora.co.uk>
Date: Sat, 8 Jul 2017 21:32:23 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, ohad@bencohen.org
Subject: Re: [PATCH 3/3] bluetooth: hci_ll: Use new
 hci_uart_unregister_device() function.
Message-ID: <20170708193223.gamjvhnhywddzrr3@earth>
References: <20170708163743.24394-1-ian@mnementh.co.uk>
 <20170708163743.24394-4-ian@mnementh.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pmvkgael4xuyahea"
In-Reply-To: <20170708163743.24394-4-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>


--pmvkgael4xuyahea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 08, 2017 at 05:37:43PM +0100, Ian Molton wrote:
> Convert hci_ll to use hci_uart_unregister_device().
>=20
> This simplifies the _remove() handler as well as fixes a
> potential race condition on unload.
>=20
> Signed-off-by: Ian Molton <ian@mnementh.co.uk>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabor.co.uk>

-- Sebastian

> ---
>  drivers/bluetooth/hci_ll.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index c982943f0747..1b898445a0b8 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -742,14 +742,8 @@ static int hci_ti_probe(struct serdev_device *serdev)
>  static void hci_ti_remove(struct serdev_device *serdev)
>  {
>  	struct ll_device *lldev =3D serdev_device_get_drvdata(serdev);
> -	struct hci_uart *hu =3D &lldev->hu;
> -	struct hci_dev *hdev =3D hu->hdev;
> =20
> -	cancel_work_sync(&hu->write_work);
> -
> -	hci_unregister_dev(hdev);
> -	hci_free_dev(hdev);
> -	hu->proto->close(hu);
> +	hci_uart_unregister_device(&lldev->hu);
>  }
> =20
>  static const struct of_device_id hci_ti_of_match[] =3D {
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--pmvkgael4xuyahea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllhM0cACgkQ2O7X88g7
+prAfxAAnPIttx8RVOW2NcMmgyA62Lr3KGjaHwCT2VFCvKvNUlDcYNKLuUV+zTji
/Cvc8aPcD6NVWUWVlHIlKA0unfIvDQd0pzq21QREoGP3POaaOJCUhL8guqSXE2HW
ik4Oilph9aiQVNaxpMv9Ip0OoD3DGOguMCNtYuup2tZ+wqU1tda7lQ4W8T231OO/
HYCpkUbg8anrqsRWVwIEBlC67mUZYpMcyPVmcuMzKOG5D4juNcz5dRj15+2Kfmej
fJty2ucoGyETrUPvmF7ttzEuzbnDFZLzmYpJNMI8f3edYVj170RpcRrE8a7TEn80
2ormh6EGtzqPfzMWvBZFNpmsEzxOHVmjs400dtX4EnIBFPfCTgIH3pNdvH1iFRWJ
386mBUHkFeDDiTViwopZpv3W3mH6hBNhlVGLIynmTd3c0afj1fTlxne1/0TFfK+b
Sb2MEeRjUWyfnWjdiYgHlhwpeBtmeir7Oxj0t+Px2X7ehRwmUGHglEJwc/H+cwtn
hgqaMDXgthIlMdKtHC3LDIwNxiU3wIvHRgMuFNOuRMrgezPivWyhAOiD6bdtCEEb
MuJWe3PwSKOXl6LetFQglKwF2O5S16HuvJ3drNEetUFY9o2TxSjr4qqSVekgW7Ze
uQ1F9JBWilRKKUQgcZ/NQzBitnZSfWPbKtj8/dLNcNpIdURpbBg=
=YF6i
-----END PGP SIGNATURE-----

--pmvkgael4xuyahea--
