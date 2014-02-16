Return-Path: <cyrus@holtmann.org>
Message-ID: <1392538778.3368.1.camel@orwell.fritz.box>
Subject: Re: [PATCH v3] btusb.c - Add IMC Networks (Broadcom based)
From: Jurgen Kramer <gtmkramer@xs4all.nl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	 <linux-bluetooth@vger.kernel.org>
Date: Sun, 16 Feb 2014 09:19:38 +0100
In-Reply-To: <5A7ECA4A-ADC4-4587-8DC1-20784328A5F0@holtmann.org>
References: <1392462069-3093-1-git-send-email-gtmkramer@xs4all.nl>
	 <5A7ECA4A-ADC4-4587-8DC1-20784328A5F0@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, 2014-02-15 at 11:54 -0800, Marcel Holtmann wrote:
> Hi Jurgen,
> 
> the subject should start with Bluetooth: for patches.
> 
> > Add support for IMC Networks (Broadcom based) to btusb.c.
> > 
> > v3: Switch to using USB_VENDOR_AND_INTERFACE_INFO.
> 
> This belong after --- in git patches.

OK, will do next time.
> 
> > 
> > Below the output of /sys/kernel/debug/usb/devices for this device:
> > 
> > T:  Bus=01 Lev=02 Prnt=02 Port=04 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
> > D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=13d3 ProdID=3404 Rev= 1.12
> > S:  Manufacturer=Broadcom Corp
> > S:  Product=BCM20702A0
> > S:  SerialNumber=240A649F8246
> > C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
> > I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> > E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> > E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> > I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> > 
> > Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
> > ---
> > drivers/bluetooth/btusb.c | 3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 3980fd1..a372df8 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -116,6 +116,9 @@ static const struct usb_device_id btusb_table[] = {
> > 	/* Belkin F8065bf - Broadcom based */
> > 	{ USB_VENDOR_AND_INTERFACE_INFO(0x050d, 0xff, 0x01, 0x01) },
> > 
> > +	/* IMC Networks - Broadcom based */
> > +	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01 },
> > +
> 
>   CC      drivers/bluetooth/btusb.o
> drivers/bluetooth/btusb.c:1716:0: error: unterminated argument list invoking macro "USB_VENDOR_AND_INTERFACE_INFO"
>  MODULE_LICENSE("GPL");
>  ^
> drivers/bluetooth/btusb.c:120:4: error: ‘USB_VENDOR_AND_INTERFACE_INFO’ undeclared here (not in a function)
>   { USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01 },
>     ^
> drivers/bluetooth/btusb.c:120:2: error: expected ‘}’ at end of input
>   { USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01 },
>   ^
> 
> > 	{ }	/* Terminating entry */
> > };
> 
> I fixed this all up for you now and applied the patch to bluetooth-next tree.
> 
> However next time, at least compile test the patch before sending it. Otherwise you are wasting everyones time.

Sorry about that. Thanks for fixing.

Regards,
Jurgen
