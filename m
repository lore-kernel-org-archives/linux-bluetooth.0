Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 May 2012 12:08:45 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Michael =?iso-8859-1?Q?Gr=FCtzner?= <mgruetzn@gmx.de>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] bluetooth: Add support for Foxconn/Hon Hai AR5BBU22
 0489:E03C
Message-ID: <20120502150844.GB16030@joana>
References: <1769868.QZY8sEHkp9@dagobah>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1769868.QZY8sEHkp9@dagobah>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael.

* Michael Gr=FCtzner <mgruetzn@gmx.de> [2012-05-01 01:43:17 +0200]:

> From: Michael Gruetzner <mgruetzn@gmx.de>
>=20
> Add Foxconn/Hon Hai AR5BBU22 Bluetooth Module( 0x489:0xE03C) to=20
> the blacklist of btusb module and add it to the ath3k module to properly =
load=20
> the firmware in Kernel 3.3.4
> The device is integrated in  e.g. some  Acer Aspire 7750G.
> =20
> Output from /sys/kernel/debug/usb/devices:
>=20
> T:  Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D05 Cnt=3D02 Dev#=3D  6 Spd=3D12   =
MxCh=3D 0
> D:  Ver=3D 2.00 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D0489 ProdID=3De03c Rev=3D 0.02
> S:  Manufacturer=3DAtheros Communications
> S:  Product=3DBluetooth USB Host Controller
> S:  SerialNumber=3DAlaska Day 2006
> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>=20
> Signed-off-by: Michael Gruetzner <mgruetzn@gmx.de>
> ---
> diff -uprN -X linux-3.3.4-vanilla/Documentation/dontdiff linux-3.3.4-vani=
lla/drivers/bluetooth/ath3k.c linux-3.3.4/drivers/bluetooth/ath3k.c
> --- linux-3.3.4-vanilla/drivers/bluetooth/ath3k.c	2012-04-27 19:17:35.000=
000000 +0200
> +++ linux-3.3.4/drivers/bluetooth/ath3k.c	2012-04-30 01:29:47.081838667 +=
0200
> @@ -79,6 +79,9 @@ static struct usb_device_id ath3k_table[
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xE02C) },
> =20
> +	/* Atheros AR5BBU22 with sflash firmware */
> +	{ USB_DEVICE(0x0489, 0xE03C) },
> +
>  	{ }	/* Terminating entry */
>  };
> =20
> @@ -95,6 +98,9 @@ static struct usb_device_id ath3k_blist_
>  	{ USB_DEVICE(0x13d3, 0x3375), .driver_info =3D BTUSB_ATH3012 },
>  	{ USB_DEVICE(0x04ca, 0x3005), .driver_info =3D BTUSB_ATH3012 },
> =20
> +	/* Atheros AR5BBU22 with sflash firmware */
> +	{ USB_DEVICE(0x0489, 0xE03C), .driver_info =3D BTUSB_ATH3012 },
> +
>  	{ }	/* Terminating entry */
>  };
> =20
> diff -uprN -X linux-3.3.4-vanilla/Documentation/dontdiff linux-3.3.4-vani=
lla/drivers/bluetooth/btusb.c linux-3.3.4/drivers/bluetooth/btusb.c
> --- linux-3.3.4-vanilla/drivers/bluetooth/btusb.c	2012-04-27 19:17:35.000=
000000 +0200
> +++ linux-3.3.4/drivers/bluetooth/btusb.c	2012-04-30 01:31:49.302182281 +=
0200
> @@ -135,6 +135,9 @@ static struct usb_device_id blacklist_ta
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xe02c), .driver_info =3D BTUSB_IGNORE },
> =20
> +	/* Atheros AR5BBU22 with sflash firmware */
> +	{ USB_DEVICE(0x0489, 0xe03c), .driver_info =3D BTUSB_ATH3012 },
> +
>  	/* Broadcom BCM2035 */
>  	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info =3D BTUSB_WRONG_SCO_MTU },
>  	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info =3D BTUSB_WRONG_SCO_MTU },

This patch doesn't apply upstream, please rebase it on top of
bluetooth-next.

	Gustavo
