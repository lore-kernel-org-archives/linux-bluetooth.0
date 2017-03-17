Return-Path: <pavel@ucw.cz>
Date: Fri, 17 Mar 2017 16:25:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] Bluetooth: hci_uart: add support for word alignment
Message-ID: <20170317152538.GB8723@amd>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-4-sre@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
In-Reply-To: <20170304115833.3538-4-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This will be used by Nokia's H4+ protocol, which
> uses 2-byte aligned packets.
>=20
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

> --- a/drivers/bluetooth/hci_h4.c
> +++ b/drivers/bluetooth/hci_h4.c
> @@ -171,9 +171,20 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, st=
ruct sk_buff *skb,
>  			    const unsigned char *buffer, int count,
>  			    const struct h4_recv_pkt *pkts, int pkts_count)
>  {
> +	struct hci_uart *hu =3D hci_get_drvdata(hdev);
> +	uint8_t alignment =3D hu->alignment;

I'd do u8 here, too, for consistency with struct below (and becuase
uint8_t is somehow unusual in kernel).

> @@ -92,6 +92,9 @@ struct hci_uart {
> =20
>  	unsigned int init_speed;
>  	unsigned int oper_speed;
> +
> +	u8			alignment;
> +	u8			padding;
>  };
> =20

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljL//IACgkQMOfwapXb+vKVdgCfbmJvP9y9Up37bQKrjnr1ewkv
13oAn1M/GRkTaeFLnU+jCJUoMePOa4vA
=ZJTZ
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
