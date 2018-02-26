Return-Path: <eric@anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>, Loic Poulain
 <loic.poulain@gmail.com>, =?utf-8?B?RnLDqWTDqXJpYw==?= Danis
 <frederic.danis.oss@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Lukas Wunner <lukas@wunner.de>, Phil Elwell <phil@raspberrypi.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 4/4] ARM: bcm2385_defconfig: Enable BT support for BCM43438
In-Reply-To: <1519567855-26105-5-git-send-email-stefan.wahren@i2se.com>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com> <1519567855-26105-5-git-send-email-stefan.wahren@i2se.com>
Date: Mon, 26 Feb 2018 15:31:48 -0800
Message-ID: <87o9kbjpjv.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The Raspberry Pi Zero W has an onboard BT chip (BCM43438). So enable the
> necessary HCI UART driver (requires serial device bus).
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied patches 2-4 to bcm2835-dt-next and bcm2835-defconfig-next.
Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqUmOQACgkQtdYpNtH8
nugtQRAAmiPGH0pBTkoT6m5JIyciCezgb1YEKC9KmYo+V8Vw5d43JadadIxRKrIJ
zMZTz9EkePEUGXnLCXcPBLsIKPMLIgYj5aZH6K3BEdLzA7s8fqYLtQb3hF6Jkzwd
HA7A6DnLUXimN3kBuRgb5vME8rPDhSYZsvDUDAFAdxIcol04vlvmbNHEdgrBnZWG
0o9Q1GUrl/RF8Z4ySdQSpi3/FA42+D8G+/ScnShKQIvamoA/VMK9ZDYbkyK3jx38
EXqGplTiznuiSCD1dq8mZWOC9hR9hDEFPZrxdQVdZgtA+11gXGp51fl4VyR6wDmw
GR5uHMtYmJ3LP22gND1FqC6r2qNJLLqt4kyQjQ4JDgDnsyXFPunaRsh3//k3WqL9
LEx10YXewSf+J6VKyAjC5B8RxtkNlt87MZpKJHzc+cVtc+atwZYJMnNrS/j60Qsk
jJN00uKNJPQmKRnmgsLoQC2KaWNwR39ndnBgpYF5oHf1U0aGyQZ5wcQ7nFX1wNNY
MiXLahYfOzeTr0UHb+BbnQBKNmOPSJ6L/P8ujh57+M/6sinZWuO0tzqOPmvzP8KU
GLBdxI2NpXPejAx3jvXcovyzUvCofgVCtuWirODHRzRqdIRhTlqK//I3YN4mLHH5
F2zIzz1vDA0sGrviYXjNYxgQbkb8RpJi9eWsnXpJknPC/H5zspo=
=K0n+
-----END PGP SIGNATURE-----
--=-=-=--
