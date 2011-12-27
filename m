Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3] Add USB ID of HP's Broadcom BCM2035 Bluetooth
From: Albert Pool <albertpool@solcon.nl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
 linux-bluetooth@vger.kernel.org
In-Reply-To: <1325008493.1965.270.camel@aeonflux>
References: <1324728064.3074.5.camel@albert-ASUSTeK-P4P800SE>
	 <20111227160323.GA8298@joana>  <1325008493.1965.270.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Dec 2011 20:02:15 +0100
Message-ID: <1325012535.2109.10.camel@albert-ASUSTeK-P4P800SE>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I think the desktop's dongle might be to blame when the old laptop fails
to pair to that. I've had more Bluetooth problems on the desktop, e.g.
being unable to remove paired devices of the dongle's previous owner.

The Bluetooth sticker on the downside of the old laptop lists:
Broadcom BCM92035NMD CE 370653-003
Universal Scientific Industrial
Contains FCC ID: QDS-BRCM1009
IC: 4324A-BRCM1009
SCT: RCPBRBC04-389
CMI ID: 2003DJ1517
CNC 16-3215
along with a lot of text in other languages.

Other BCM2035 USB ID's have BTUSB_WRONG_SCO_MTU but that option really
does not work reliably on this old laptop.

Everything's now working with Linux on this HP Compaq nc6120, except
Bluetooth.

Regards,

Albert

Op dinsdag 27-12-2011 om 09:54 uur [tijdzone -0800], schreef Marcel
Holtmann:
> Hi Gustavo,
> 
> > * Albert Pool <albertpool@solcon.nl> [2011-12-24 13:01:04 +0100]:
> > 
> > > Add USB ID of HP's Broadcom BCM2035 Bluetooth 03f0:011d
> > > 
> > > From usb-devices:
> > > T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> > > D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > > P:  Vendor=03f0 ProdID=011d Rev=00.17
> > > S:  Manufacturer=Broadcom
> > > S:  Product=HP integrated Bluetooth module
> > > C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> > > I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > > I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> > > I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> > > I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
> > > 
> > > Signed-off-by: Albert Pool <albertpool@solcon.nl> 
> > > - - - 
> > > It now pairs to my laptop (which has the other HP device 03f0:171d) but does not yet pair to my desktop with 0a12:0001 Cambridge Silicon Radio dongle.
> > > I've also tried using BTUSB_WRONG_SCO_MTU, but with that setting it often failed to enable the device.
> > > This patch is at least an improvement as it used to pair to nothing at all. Perhaps anyone knows a better solution with which it pairs to everything just like on Windows XP?
> > > 
> > > --- a/drivers/bluetooth/btusb.c 
> > > +++ b/drivers/bluetooth/btusb.c 
> > > @@ -142,7 +142,8 @@ static struct usb_device_id blacklist_ta 
> > >  	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = BTUSB_WRONG_SCO_MTU }, 
> > >  	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = BTUSB_WRONG_SCO_MTU }, 
> > >  
> > > -	/* HP laptop with Broadcom chip */ 
> > > +	/* HP laptops with Broadcom chip */ 
> > > +	{ USB_DEVICE(0x03f0, 0x011d), .driver_info = BTUSB_BCM92035 }, 
> > >  	{ USB_DEVICE(0x03f0, 0x171d), .driver_info = BTUSB_WRONG_SCO_MTU }, 
> > >  
> > >  	/* Dell laptop with Broadcom chip */ 
> > 
> > Please fix this and resend. Also add "Bluetooth: " to your commit subject.
> 
> actually I am not convinced this is the right fix. Adding random driver
> flags and hoping that it makes them works is a bad idea. The BCM92035
> was one specific behavior to switch HID proxy mode into working dongle,
> but that is ancient behavior. These days just HCI_Reset is enough for
> Broadcom dongles.
> 
> Also the fact that it still does not complete work makes me highly
> suspicious that this fix is actually wrong. And without having seen the
> hcidump's for the failing pairing, I would not bother here at all.
> 
> Regards
> 
> Marcel
> 
> 
