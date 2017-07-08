Return-Path: <sebastian.reichel@collabora.co.uk>
Date: Sat, 8 Jul 2017 21:31:00 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, ohad@bencohen.org
Subject: Re: [PATCH 1/3] bluetooth: Introduce hci_uart_unregister_device()
Message-ID: <20170708193100.wdmgwvu5gw3u6bg2@earth>
References: <20170708163743.24394-1-ian@mnementh.co.uk>
 <20170708163743.24394-2-ian@mnementh.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bvgz2gvtat6z2jr2"
In-Reply-To: <20170708163743.24394-2-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>


--bvgz2gvtat6z2jr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 08, 2017 at 05:37:41PM +0100, Ian Molton wrote:
> Several drivers have the same (and incorrect) code in their
> _remove() handler.
>=20
> Coalesce this into a shared function.
>=20
> Signed-off-by: Ian Molton <ian@mnementh.co.uk>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/bluetooth/hci_serdev.c | 12 ++++++++++++
>  drivers/bluetooth/hci_uart.h   |  1 +
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serde=
v.c
> index aea930101dd2..abc70b5e5647 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -354,3 +354,15 @@ int hci_uart_register_device(struct hci_uart *hu,
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(hci_uart_register_device);
> +
> +void hci_uart_unregister_device(struct hci_uart *hu) {
> +	struct hci_dev *hdev =3D hu->hdev;
> +
> +	hci_unregister_dev(hdev);
> +	hci_free_dev(hdev);
> +
> +	cancel_work_sync(&hu->write_work);
> +
> +	hu->proto->close(hu);
> +}
> +EXPORT_SYMBOL_GPL(hci_uart_unregister_device);
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index c6e9e1cf63f8..d9cd95d81149 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -112,6 +112,7 @@ struct hci_uart {
>  int hci_uart_register_proto(const struct hci_uart_proto *p);
>  int hci_uart_unregister_proto(const struct hci_uart_proto *p);
>  int hci_uart_register_device(struct hci_uart *hu, const struct hci_uart_=
proto *p);
> +void hci_uart_unregister_device(struct hci_uart *hu);
> =20
>  int hci_uart_tx_wakeup(struct hci_uart *hu);
>  int hci_uart_init_ready(struct hci_uart *hu);
> --=20
> 2.11.0

--bvgz2gvtat6z2jr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllhMu4ACgkQ2O7X88g7
+pppQQ/6AgHGPAG5DO9+MoC5a/cVbXbAixQmgvLWyYAtmABN76UMNsINFXR83xd4
C7b538R251rkdl16h0yRVPkgGuPAXjG0c+5sF6WJjzxXzLSpxU2Z5bgAmX2k21ZB
IjDVVBmsDGwpN9k045t+X3ZftfqXJqddjY9AgHrTzEVkp/ThYc7Mw033/xSotNvY
xLbsLPuQIyn2+MwSIkVD627zWSm1LPpF95h3y8xh2N870xrAq0eAqm5cqwtuGqHL
Z6sWS+nM/OUWRD4RHc2XxsNkKYIjYIBHMBI6J0VfavrOoXBpfsAy7ju3ZE5BcXlf
+pYsjMHX6pdQRxfd6Gl3TDC49m8MIBo+wm2WMQCH6Z1dU0wwhKASRRue2AUFf1LI
Me43fSKA+sKEcWg2A5K5Ts2PzhssBbLHlcwfeu6YS8+OH3CiEgPYSA67SqE2mfoo
4qG98aWl4gPeXNwaOGkxUA+IimKFC+ilHIUwbjNDpgZc7p8pjGAG5IJ9Uj7uxjLA
/xjyW3nkWfqpXk7xyJQngmGDp2etDKIGnDfofdqT538P3Sf8KSmZmXxoEjS9mMgX
zEs1ZmunCoFWfaxJV83a3AKxxSrtRHP/AcVrBWlGvWNNwYW71yHnWqXKQGMEiRk+
vN2y8m6MykspO0lS7pM8Dis0o0qWl0ya8+KtiZs9crcgJkqYzY8=
=q9I/
-----END PGP SIGNATURE-----

--bvgz2gvtat6z2jr2--
