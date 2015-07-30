Return-Path: <cyrus@holtmann.org>
Message-ID: <1438258362.3969.194.camel@collabora.co.uk>
Subject: Re: [PATCH] Bluetooth: btusb: Recognize Realtek shared
 wifi/bluetooth devices
From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Drake
	 <drake@endlessm.com>, Larry Finger <Larry.Finger@lwfinger.net>
Date: Thu, 30 Jul 2015 14:12:42 +0200
In-Reply-To: <734FAB01-9120-43F7-A003-FD7822DFA2F8@holtmann.org>
References: <1437144905-3482-1-git-send-email-sjoerd.simons@collabora.co.uk>
	 <734FAB01-9120-43F7-A003-FD7822DFA2F8@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2015-07-30 at 13:45 +0200, Marcel Holtmann wrote:
> Hi Sjoerd,
>=20
> > Recognize Realtek devices which share wifi and bluetooth such as=20
> > the
> > rtl8723AU by vendor and interface.
> >=20
> > T:  Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D  3 Spd=3D480=
  MxCh=3D 0
> > D:  Ver=3D 2.00 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1
> > P:  Vendor=3D0bda ProdID=3D0724 Rev=3D 2.00
> > S:  Manufacturer=3DRealtek
> > S:  Product=3D802.11n WLAN Adapter
> > S:  SerialNumber=3D00e04c000001
> > C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> > A:  FirstIf#=3D 0 IfCount=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> > I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
> > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > I:* If#=3D 2 Alt=3D 0 #EPs=3D 4 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff=20
> > Driver=3Drtl8723au
> > E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D06(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D87(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D500us
> >=20
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > ---
> > drivers/bluetooth/btusb.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 93339a4..3324c91 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -149,6 +149,10 @@ static const struct usb_device_id=20
> > btusb_table[] =3D {
> > 	{ USB_DEVICE(0x8087, 0x0a5a),
> > 	  .driver_info =3D BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
> >=20
> > +	/* Realtek devices sharing Bluetooth and Wifi*/
> > +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
> > +	  .driver_info =3D BTUSB_REALTEK },
> > +
>=20
> is this still needed after I applied the generic USB_INTERFACE_INFO=20
> patch?

Noe as Daniel Drake mentioned in his submission, this patch is obsolete
now that the USB_INTERFACE_INFO change has landed.


--=20
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
