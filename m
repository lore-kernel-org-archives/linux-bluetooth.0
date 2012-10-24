Return-Path: <cyrus@holtmann.org>
Message-ID: <1351091899.1785.69.camel@aeonflux>
Subject: Re: [RFC 1/2] Bluetooth: Add driver extension for vendor specific
 init
From: Marcel Holtmann <marcel@holtmann.org>
To: "Ho, Albert O" <albert.o.ho@intel.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	"Hedberg, Johan" <johan.hedberg@intel.com>,
	"tedd.hj.an@gmail.com" <tedd.hj.an@gmail.com>,
	"An, Tedd" <tedd.an@intel.com>
Date: Wed, 24 Oct 2012 08:18:19 -0700
In-Reply-To: <95EBF2BD638BE24EB7C4104AF2911E3945F4C895@ORSMSX101.amr.corp.intel.com>
References: <39660287.XHkFNqYcyS@tedd-ubuntu>
	 <1349346013.27233.28.camel@aeonflux>
	 <95EBF2BD638BE24EB7C4104AF2911E3945F4C895@ORSMSX101.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Albert,

> > This patch provides an extension of btusb to support device vendor can 
> > implement their own module to execute the vendor specific device 
> > initialization before the stack sends generic BT device 
> > initialization.
> > 
> > Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> > ---
> >  drivers/bluetooth/btusb.c        |  191 +++++++++++++++++++++++++-------------
> >  drivers/bluetooth/btusb.h        |   53 +++++++++++
> >  include/net/bluetooth/hci_core.h |   10 ++
> >  net/bluetooth/hci_core.c         |   15 ++-
> >  4 files changed, 204 insertions(+), 65 deletions(-)  create mode 
> > 100644 drivers/bluetooth/btusb.h
> > 
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c 
> > index f637c25..afa1558 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -26,6 +26,7 @@
> >  
> >  #include <net/bluetooth/bluetooth.h>
> >  #include <net/bluetooth/hci_core.h>
> > +#include "btusb.h"
> >  
> >  #define VERSION "0.6"
> >  
> > @@ -39,14 +40,59 @@ static bool reset = 1;
> >  
> >  static struct usb_driver btusb_driver;
> >  
> > -#define BTUSB_IGNORE		0x01
> > -#define BTUSB_DIGIANSWER	0x02
> > -#define BTUSB_CSR		0x04
> > -#define BTUSB_SNIFFER		0x08
> > -#define BTUSB_BCM92035		0x10
> > -#define BTUSB_BROKEN_ISOC	0x20
> > -#define BTUSB_WRONG_SCO_MTU	0x40
> > -#define BTUSB_ATH3012		0x80
> > +/*
> > + * Create btusb_driver_info struct for each driver_info flags used by
> > + * blacklist since vendor's btusb driver will return btusb_driver_info struct.
> > + */
> > +
> > +/*
> > + * if the device is set to this, this menas that the device is 
> > +generic and
> > + * doesn't require any vendor specific handling  */ static const 
> > +struct btusb_driver_info generic = {
> > +	.description	= "BTUSB Generic",
> > +	.flags		= BTUSB_GENERIC,
> > +};
> > +
> > +static const struct btusb_driver_info ignore = {
> > +	.description	= "BTUSB Ignore",
> > +	.flags		= BTUSB_IGNORE,
> > +};
> 
> >> I like the effort, but I think you went a little bit too far here. For these simple ones, we can easily keep our simple blacklist. It keeps the code more readable than this part. But I do appreciate the attempt in unifying this.
> 
> 
> > +
> > +static const struct btusb_driver_info digianswer = {
> > +	.description	= "BTUSB DIGIANSWER",
> > +	.flags		= BTUSB_DIGIANSWER,
> > +};
> > +
> > +static const struct btusb_driver_info csr = {
> > +	.description	= "BTUSB CSR",
> > +	.flags		= BTUSB_CSR,
> > +};
> > +
> > +static const struct btusb_driver_info sniffer = {
> > +	.description	= "BTUSB Sniffer",
> > +	.flags		= BTUSB_SNIFFER,
> > +};
> > +
> > +static const struct btusb_driver_info bcm92035 = {
> > +	.description	= "BTUSB BCM92035",
> > +	.flags		= BTUSB_BCM92035,
> > +};
> > +
> > +static const struct btusb_driver_info broken_isoc = {
> > +	.description	= "BTUSB Broken ISOC",
> > +	.flags		= BTUSB_BROKEN_ISOC,
> > +};
> > +
> > +static const struct btusb_driver_info wrong_sco_mtu = {
> > +	.description	= "BTUSB Wrong SCO MTU",
> > +	.flags		= BTUSB_WRONG_SCO_MTU,
> > +};
> > +
> > +static const struct btusb_driver_info ath3012 = {
> > +	.description	= "BTUSB Ath3012",
> > +	.flags		= BTUSB_ATH3012,
> > +};
> >  
> >  static struct usb_device_id btusb_table[] = {
> >  	/* Generic Bluetooth USB device */
> > @@ -105,90 +151,89 @@ static struct usb_device_id btusb_table[] = {
> >  
> >  	{ }	/* Terminating entry */
> >  };
> > -
> >  MODULE_DEVICE_TABLE(usb, btusb_table);
> >  
> >  static struct usb_device_id blacklist_table[] = {
> >  	/* CSR BlueCore devices */
> > -	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },
> > +	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = (unsigned long) &csr },
> 
> >> Keep the blacklist_table as it is. The important table to modify is btusb_table and use a common driver_info that will be shared between drivers.
> 
> >> That would also make it simple to just add BTUSB_IGNORE or a new BTUSB_VENDOR flag to call out the drivers that have a separate driver with a vendor init function, but would match >> the Bluetooth general USB descriptors.
> 
> I looked at usbnet minidriver as you suggested.  If we do a similar scheme such that btusb_probe() invokes the mini_driver's bind()/unbind() then btusb's usage of driver_info will need to change from storing flags (ex: BTUSB_IGNORE) and change to store "static const struct" where it holds a struct containing the mini-driver's bind/unbind functions (just like usbnet minidriver).   Are you good with this change?  I also want to mention that in the patch containing the BT USB mini driver template, it already has its own module_usb_driver() section with its VID/PID listed.

you know what. Just send around what you have right now after the
cleanup and then I can take another look at it.

Regards

Marcel


