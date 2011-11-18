Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Bluetooth: btusb: Add Qualcomm Atheros AR3006 in
 blacklist_table
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 18 Nov 2011 06:17:58 +0100
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3D67@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3A49@nasanexd02b.na.qualcomm.com>
	 <1321450153.15441.548.camel@aeonflux>
	 <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3C48@nasanexd02b.na.qualcomm.com>
	 <1321545089.15441.572.camel@aeonflux>
	 <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3D67@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321593478.15441.578.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> > > > > Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> > > > > ---
> > > > >  drivers/bluetooth/btusb.c |    5 ++++-
> > > > >  1 files changed, 4 insertions(+), 1 deletions(-)
> > > > >
> > > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > > > index 39dd65c..94124ad 100644
> > > > > --- a/drivers/bluetooth/btusb.c
> > > > > +++ b/drivers/bluetooth/btusb.c
> > > > > @@ -55,6 +55,7 @@ static struct usb_driver btusb_driver;
> > > > >  #define BTUSB_BROKEN_ISOC	0x20
> > > > >  #define BTUSB_WRONG_SCO_MTU	0x40
> > > > >  #define BTUSB_ATH3012		0x80
> > > > > +#define BTUSB_ATH3006		0x0100
> > > > >
> > > > >  static struct usb_device_id btusb_table[] = {
> > > > >  	/* Bluetooth USB interface */
> > > > > @@ -125,6 +126,7 @@ static struct usb_device_id blacklist_table[]
> > > > > = {
> > > > >
> > > > >  	/* Atheros 3012 with sflash firmware */
> > > > >  	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> > > > > +	{ USB_DEVICE(0x0cf3, 0x3006), .driver_info = BTUSB_ATH3006 },
> > > > >
> > > > >  	/* Atheros AR5BBU12 with sflash firmware */
> > > > >  	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE }, @@
> > > > > -937,7 +939,8 @@ static int btusb_probe(struct usb_interface *intf,
> > > > >  	if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
> > > > >  		return -ENODEV;
> > > > >
> > > > > -	if (id->driver_info & BTUSB_ATH3012) {
> > > > > +	if ((id->driver_info & BTUSB_ATH3012) ||
> > > > > +				(id->driver_info & BTUSB_ATH3006)) {
> > > > >  		struct usb_device *udev = interface_to_usbdev(intf);
> > > > >
> > > > >  		/* Old firmware would otherwise let ath3k driver load
> > > >
> > > >         if (id->driver_info & BTUSB_ATH3012) {
> > > >                 struct usb_device *udev = interface_to_usbdev(intf);
> > > >
> > > >                 /* Old firmware would otherwise let ath3k driver load
> > > >                  * patch and sysconfig files */
> > > >                 if (le16_to_cpu(udev->descriptor.bcdDevice) <=
> > 0x0001)
> > > >                         return -ENODEV;
> > > >         }
> > > >
> > > > are you sure this is true for the 3006 as well? Otherwise just using
> > > > the BTUSB_IGNORE quirk to blacklist a device would be enough.
> > > >
> > > I send this patch just for a 3012 chip, with PID 3006. Because we need to
> > separate it with another 3012 chip(PID 3004).
> > > So we use BTUSB_ATH3012 for PID 3004 and BTUSB_ATH3006 for PID 3006.
> > >
> > > And I am sure that we need use this quirk, not BTUSB_IGNORE. Because we
> > need to check whether chip has been patched or not through bcdDevice value.
> > 
> > so you are telling me that you guys managed to screw up another set of
> > hardware with the same mess as the previous one.
> > 
> > Are you 100% sure you need the bcdDevice check for this generation of
> > hardware? Care to explain to me how that is suppose to work.
> Yes, before download patch, the bcdDevice <= 0x0001 in btusb.c, then ath3k driver have the opportunity to download the patch and reset the bluetooth hardware.
> When the hardware are enumerated the second time, the bcdDevice will larger than 0x0001. For this reason, I am 100% sure that we need do bcdDevice check.
> 
> > And why you are introducing a new quirk if the handling is exactly the same.
> In btusb.c, yes, the handling is the same as BTUSB_ATH3012. So maybe we can use the same quirk BTUSB_ATH3012.
> But in ath3k.c, the handling for BTUSB_ATH3006 is different from BTUSB_ATH3012, so I want to introduce a new quirk BTUSB_ATH3006. 

the ath3k.c driver has nothing to do with the btusb.c driver. So please
rename the quirk to BTUSB_ATH3K in btusb.c and use it for both.

Regards

Marcel


