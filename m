Return-Path: <cyrus@holtmann.org>
Message-ID: <1437459289.10315.78.camel@collabora.co.uk>
Subject: Re: [PATCH] Bluetooth: btusb: match generic class code in interface
 descriptor
From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
To: Daniel Drake <drake@endlessm.com>, marcel@holtmann.org,
 gustavo@padovan.org,  johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, larry.finger@lwfinger.net,
	xry111@outlook.com, linux-usb@vger.kernel.org
Date: Tue, 21 Jul 2015 08:14:49 +0200
In-Reply-To: <1437153145-5387-1-git-send-email-drake@endlessm.com>
References: <1437153145-5387-1-git-send-email-drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2015-07-17 at 11:12 -0600, Daniel Drake wrote:
> btusb currently has a generic match on USB device descriptors:
>         { USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
>=20
> However, http://www.usb.org/developers/defined_class states:
>=20
>   Base Class E0h (Wireless Controller)
>   This base class is defined for devices that are Wireless=20
> controllers.
>   Values not shown in the table below are reserved. These class codes=20
> are
>   to be used in Interface Descriptors, with the exception of the=20
> Bluetooth
>   class code which can also be used in a Device Descriptor.
>=20
> Add a match on the interface descriptors accordingly.

> This fixes compatibility with the RTL8723AU device shown below.
> This device conforms to the USB Interface Association Descriptor
> specification, which requires the device to have class ef/02/01.
> The extra IAD descriptor then specifies that interfaces 0 and 1
> belong to the same function/driver, which is true. Provided that
> the Bluetooth device class spec accepts use of the IAD, I imagine=20
> that
> technically, all btusb devices should be configured like this.

Great, i didn't know whether was allowed hence using the more
conservative _VENDOR_AND_INTERFACE in my patch, but this solution is de
finately nicer.

Tested with a RTL8723AU device on a Radxa Rock Pro board

Reviewed-By: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Tested-By: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

> T:  Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D  3 Spd=3D480  =
MxCh=3D 0
> D:  Ver=3D 2.00 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D0bda ProdID=3D0724 Rev=3D 2.00
> S:  Manufacturer=3DRealtek
> S:  Product=3D802.11n WLAN Adapter
> S:  SerialNumber=3D00e04c000001
> C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> A:  FirstIf#=3D 0 IfCount=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 4 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff=20
> Driver=3Drtl8723au
> E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D06(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D87(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D500us
>=20
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> This replaces/obsoletes:
>   [PATCH] Bluetooth: btusb: Recognize Realtek shared wifi/bluetooth=20
> devices
>   [PATCH] Bluetooth: btusb: Add Realtek devices into module device=20
> table
>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 93339a4..9874aac 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -64,6 +64,7 @@ static struct usb_driver btusb_driver;
>  static const struct usb_device_id btusb_table[] =3D {
>  	/* Generic Bluetooth USB device */
>  	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
> +	{ USB_INTERFACE_INFO(0xe0, 0x01, 0x01) },
> =20
>  	/* Generic Bluetooth AMP device */
>  	{ USB_DEVICE_INFO(0xe0, 0x01, 0x04), .driver_info =3D=20
> BTUSB_AMP },

--=20
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
