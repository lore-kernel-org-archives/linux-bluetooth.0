Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Feb 2015 14:21:55 -0500
From: Josh Boyer <jwboyer@redhat.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: alex.ploumistos@gmail.com, marcel@holtmann.org, gustavo@padovan.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexander Ploumistos <alexpl@fedoraproject.org>
Subject: Re: [PATCH v2] Bluetooth: ath3k: Add support for 04f2:aff1 (Atheros
 AR5B195 combo Mini PCIe card)
Message-ID: <20150213192154.GA16771@hansolo.redhat.com>
References: <CAM86y2vc-EUswU+D6EeEAeKQWDVuDVGOvpLTgKjB-R4VzxyshA@mail.gmail.com>
 <1423854311-7909-1-git-send-email-alexpl@fedoraproject.org>
 <54DE4E93.1090402@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54DE4E93.1090402@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Feb 13, 2015 at 10:20:51PM +0300, Dmitry Tunin wrote:
> 
> > From: alxpl <alex.ploumistos@gmail.com>
> > 
> > Add 04f2:aff1 to ath3k.c supported devices list and btusb.c blacklist, so that the device can load the ath3k firmware and re-enumerate itself as an AR3011 device.
> > 
> > 
> > T:  Bus=05 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> > D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=04f2 ProdID=aff1 Rev= 0.01
> > C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> > I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > 
> > 
> > Signed-off-by: Alexander Ploumistos <alexpl@fedoraproject.org>
> 
> I think it makes sense to add
> 
> Cc: stable@vger.kernel.org
> 
> If you do, it will be merged into stable kernel versions.

I agree, but this is something the upstream maintainer can also add at
their discretion.

josh

> 
> 
> > ---
> >  drivers/bluetooth/ath3k.c | 1 +
> >  drivers/bluetooth/btusb.c | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> > index de4c849..288547a 100644
> > --- a/drivers/bluetooth/ath3k.c
> > +++ b/drivers/bluetooth/ath3k.c
> > @@ -65,6 +65,7 @@ static const struct usb_device_id ath3k_table[] = {
> >  	/* Atheros AR3011 with sflash firmware*/
> >  	{ USB_DEVICE(0x0489, 0xE027) },
> >  	{ USB_DEVICE(0x0489, 0xE03D) },
> > +	{ USB_DEVICE(0x04F2, 0xAFF1) },
> >  	{ USB_DEVICE(0x0930, 0x0215) },
> >  	{ USB_DEVICE(0x0CF3, 0x3002) },
> >  	{ USB_DEVICE(0x0CF3, 0xE019) },
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index b876888..2f9c9d8c 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -159,6 +159,7 @@ static const struct usb_device_id blacklist_table[] = {
> >  	/* Atheros 3011 with sflash firmware */
> >  	{ USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
> >  	{ USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
> > +	{ USB_DEVICE(0x04f2, 0xaff1), .driver_info = BTUSB_IGNORE },
> >  	{ USB_DEVICE(0x0930, 0x0215), .driver_info = BTUSB_IGNORE },
> >  	{ USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
> >  	{ USB_DEVICE(0x0cf3, 0xe019), .driver_info = BTUSB_IGNORE },
> > 
