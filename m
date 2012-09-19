Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Sep 2012 22:06:03 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Jaroslav Resler <resler@cs.cas.cz>,
	kernel-janitors@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	"Cho, Yu-Chen" <acho@suse.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth:master 22/22] drivers/bluetooth/btusb.c:97:2: error:
 expected '}' before '{' token
Message-ID: <20120919010603.GF24689@joana>
References: <20120919000657.GA9208@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
In-Reply-To: <20120919000657.GA9208@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fengguang,

* Fengguang Wu <fengguang.wu@intel.com> [2012-09-19 08:06:57 +0800]:

> Hi Jaroslav,
>=20
> FYI, kernel build failed on
>=20
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth=
-next.git master
> head:   493969cf4728668412ecd428a60b39914d9831e3
> commit: 493969cf4728668412ecd428a60b39914d9831e3 [22/22] Bluetooth: Add s=
upport for BCM20702A0 [04ca, 2003]
> config: x86_64-allmodconfig
>=20
> All related error/warning messages:
>=20
> drivers/bluetooth/btusb.c:97:2: error: expected '}' before '{' token
>=20
> vim +97 drivers/bluetooth/btusb.c
>     92		/* Canyon CN-BTU1 with HID interfaces */
>     93		{ USB_DEVICE(0x0c10, 0x0000) },
>     94=09
>     95		/* Broadcom BCM20702A0 */
>     96		{ USB_DEVICE(0x04ca, 0x2003) }
>   > 97		{ USB_DEVICE(0x0489, 0xe042) },
>     98		{ USB_DEVICE(0x0a5c, 0x21e3) },
>     99		{ USB_DEVICE(0x0a5c, 0x21e6) },
>    100		{ USB_DEVICE(0x0a5c, 0x21e8) },
>    101		{ USB_DEVICE(0x0a5c, 0x21f3) },
>    102		{ USB_DEVICE(0x413c, 0x8197) },

I fixed this upstream already. Thanks for reporting.

	Gustavo

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQWRp7AAoJEPs3PUX4s20oTfwP/RT9AjsJtreETsluIoi8lMi1
jSa45LWkDw9uk8lhyRxuS3Bqqqsr5oQZFHATHNn4qHAVO/UNTGF1c+RWAJwWmuRk
f6tOM9Kl0JA4qqS8hembaJmDrglPVUWXHi0X8kQU0zt06N15lyXxrJ2T+gDlIzuJ
4Gja4lX3RZKE1ZEQKQVS8yzJmMh83mmkEq8srBYgZB5E52HE84jITd54qx62i4Mb
8cDOWqU9m2eC9noK3DbfEdBvs3QSgVLZU0jZkE8uW9XsDy1yFGN0vTqiVTWoP1nl
Ir8WqcZj+5tyY7/2Q3DbINliyzUm48yjHNETvxt8TvWUEnft65cY6IhAJB1vQZIh
24zJ9e5ojKCh8fePEXH/jrNR4x3Q8n573uPyrtnunURtz4Mhn3EeG2bvUGuFnKIU
KD6dBf7f09BN6TCgXm3QaTjBJpsq5TiXziuqZgBrubPzkH54S9VVkFOeskLef8Bm
tPwJSBMqJhqHCH3lb2CY2LVIBDBqU74V3t2DCpij5Wm4NPl/t47/YQ1GDgtOE1OE
bDgClSz8X4goxtWIJdIo1ib29iqDF2VGnZqGlZAdz5HzjUXPhjJ2RTda12zvOag0
lzg3hLYWSjDNffDjGeC/yKsdAoOs/fLCPG3dFINxPz6flcILfywI1al6z1Gad1PL
PEgLvAKeJNPz17+pKSf4
=A2jb
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
