Return-Path: <sebastian.reichel@collabora.co.uk>
Date: Sat, 8 Jul 2017 16:52:13 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, ohad@bencohen.org
Subject: Re: [PATCH 2/3] bluetooth: Nokia: Use new
 hci_uart_unregister_device() function.
Message-ID: <20170708145213.c2ido62qit2lctmq@earth>
References: <20170708142949.13496-1-ian@mnementh.co.uk>
 <20170708142949.13496-3-ian@mnementh.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4zxk5jtgryozu26c"
In-Reply-To: <20170708142949.13496-3-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>


--4zxk5jtgryozu26c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 08, 2017 at 03:29:48PM +0100, Ian Molton wrote:
> Simplify _remove() path for hci_nokia.c
>=20
> Signed-off-by: Ian Molton <ian@mnementh.co.uk>
> ---
>  drivers/bluetooth/hci_nokia.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
> index 6dbb1f6ff6bd..1a465dd2970e 100644
> --- a/drivers/bluetooth/hci_nokia.c
> +++ b/drivers/bluetooth/hci_nokia.c
> @@ -770,11 +770,7 @@ static void nokia_bluetooth_serdev_remove(struct ser=
dev_device *serdev)
>  	struct hci_uart *hu =3D &btdev->hu;
>  	struct hci_dev *hdev =3D hu->hdev;
> =20
> -
> -	hci_unregister_dev(hdev);
> -	hci_free_dev(hdev);
> -
> -	cancel_work_sync(&hu->write_work);
> +	hci_uart_unregister_device(hdev);
> =20
>  	hu->proto->close(hu);
>  }

I think "hu->proto->close(hu)" should also be moved into the
helper function. Also I suggest to use hci_uart instead of hci_dev
as parameter for hci_uart_unregister_device, which matches the
related hci_uart_register_device.

-- Sebastian

--4zxk5jtgryozu26c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllg8ZYACgkQ2O7X88g7
+poosQ//V1+vLRrW/B2HhCcUQ47MM+ptH7Yul6qamkbzv82BYSU6oOGaEdyWylOb
P1i0fiokonEadWrxFpC2DsgR6mHiEQuiAt70igoPScXyH8VqlBmhSwyL7W9l+5jt
ZfZ6iaHnALvtQBgsl5uijXI2T3+TmDM2eXubzYhYzByq5MF8RYmQnR+vgDOnVgbp
KcftVZOyIx/nJGkF1rq3VUyw3neNKHtAhUXF9+C0Q7ew/zG1KTl9hV1Nj493lbtp
BKNIH1UQ7479lKryFNMeM8sehfHT1RnZp8iH5OmfLJeh/olT1FlU1m9fIS2qau5L
46gpYIjPXqgZm71SXm9FtZdP6tzwqP7TiDZKCCW9nH6S5Y6JmpVMUFN9vPkIDWsP
+MQIqX9Y67TR7uqbPyUC5jkpuo9qVfEnq58HNUA5AGwJH98XkrBk8DydIx2abRaS
UqIpwowhR3zxZ9VpiiQhwJlOu2bnbIAiJm6wrItxRXphF1gsfoi/pEZMn8GN5rX2
J11VvH2OUG7Rg4aRIEL0fnoj5EeXHw/jCpA4ju1nhPzNOw9wzUZG6SjHeN2jVQ1H
QjowCaiHJZ4uFdcGCkS+LA4EqPhIBeOqcO5D3VUQC8gydfW810M/eMWVelGWY1Ru
qIBy+qv9vHOV5rPPidImecWpDgK7rydqWCz5nKeG7qOosBGjZnE=
=iShm
-----END PGP SIGNATURE-----

--4zxk5jtgryozu26c--
