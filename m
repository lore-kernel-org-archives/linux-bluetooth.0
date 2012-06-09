Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Jun 2012 19:30:52 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] ATH3K: Support AR3011 in Acer Iconia Tab W500
Message-ID: <20120609223052.GC1458@joana>
References: <1339158771-11818-1-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
In-Reply-To: <1339158771-11818-1-git-send-email-marex@denx.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

* Marek Vasut <marex@denx.de> [2012-06-08 14:32:50 +0200]:

> Acer used this chip connected via USB:
>=20
> Bus 005 Device 005: ID 0cf3:3005 Atheros Communications, Inc. AR3011 Blue=
tooth
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass          224 Wireless
>   bDeviceSubClass         1 Radio Frequency
>   bDeviceProtocol         1 Bluetooth
>   bMaxPacketSize0        64
>   idVendor           0x0cf3 Atheros Communications, Inc.
>   idProduct          0x3005 AR3011 Bluetooth
>   bcdDevice            0.01
>   iManufacturer           0
>   iProduct                0
>   iSerial                 0
>   bNumConfigurations      1
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> To: linux-bluetooth@vger.kernel.org
> ---
>  drivers/bluetooth/ath3k.c |    1 +
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 2 insertions(+)

Patch has been applied to bluetooth.git. It should be in 3.5, thanks.

	Gustavo

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP086bAAoJEPs3PUX4s20oGd0P/3uqMqRMjco2dklW0R5+XX15
u/JI9JbKxLvN0aZeoU/I0KBK2w3qlhsMHAmfDC4FYDlcED3f0NDctAdsXOXqSXAy
6zPkeBriIn4kCitAQTRuQKZeJpk59iwUgWgkk2TqSoFXCTatxRVlLQhB381jpi1B
XZYYnrWMWnBm1vzO3agIMEaz04m5tGu835yZtWubIktxHhw5z6zS+66p14+aoSkX
XssmUd6URQPX1ucmt2tSRKd0Gcaow2PkM7Q2/Ofhp+AbN1D0WoISB6sqlhOLTLGC
3cZNzIr0cruveMS4J9AJJIduAIi5dlbppm+EI9v1NBoKWzduc3nDBrIw0mtmgjb2
m9psJIrt/H12G+2f/fORg8r5Bz6S35nnXaQ7zwe2ocU9Ko2fgLkkcMxbw5os/x4g
tRwqjSfEwr5kiO2HfnbJhu7dB4QEHGuEUlu4swWlLLYLteC5rkFEDwk6ODmBM5IJ
/6TDSi4UrO0nElWltoOgAG21bxtTsDBvYPWs9TX5P5bnns+w7MphcP3E4fdSQVRi
KhO3J1NuGw70adZB56rwYRg9J3UjGjwntzPT3njEcyCLXaWdjDbRRkdG8ulfnFn6
Yj2TzX5fNXznMttwuoDSEjf1ePCvBGz9lu1ueqBQyiKtD/buojUX8WfAHLUAlCm7
BkvH/bQjFYsl/ZV0CwBq
=B/Eq
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
