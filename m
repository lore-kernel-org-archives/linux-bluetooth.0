Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Sep 2011 14:25:15 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: Re: [PATCH] btusb.c: add support for 2011 mac mini
Message-ID: <20110905172515.GA2594@joana>
References: <1315152103.2441.6.camel@paragon.slim>
 <654DF80AD31A344E93DBCC6280BD6DEF22248652@NL0230MBX08N1.DIR.slb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <654DF80AD31A344E93DBCC6280BD6DEF22248652@NL0230MBX08N1.DIR.slb.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

* John Frankish <j-frankish@slb.com> [2011-09-05 17:21:34 +0000]:

> 
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > owner@vger.kernel.org] On Behalf Of Jurgen Kramer
> > Sent: Sunday, 04 September, 2011 20:02
> > To: linux-bluetooth@vger.kernel.org
> > Subject: [PATCH] btusb.c: add support for 2011 mac mini
> > 
> > Today I noticed that the usb bluetooth adapter (BCM2046B1) on my 2011 mac
> > mini was not working. I've created a patch to get it going.
> > 
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index
> > 3ef4760..8d807c5 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -75,6 +75,9 @@ static struct usb_device_id btusb_table[] = {
> >  	/* Apple MacBookPro8,2 */
> >  	{ USB_DEVICE(0x05ac, 0x821a) },
> > 
> > +	/* Apple MacMini5,1 */
> > +	{ USB_DEVICE(0x05ac, 0x8281) },
> > +
> >  	/* AVM BlueFRITZ! USB v2.0 */
> >  	{ USB_DEVICE(0x057c, 0x3800) },
> > 
> > Patch is against current kernel git.
> > 
> > Jurgen
> > 
> I tried this patch with the 3.0.3 kernel.
> 
> When I only compiled the modules in drivers/bluetooth and without Module.symvers (so no deps), I got this when I manually loaded the modules:
> 
> btusb: Unknown symbol hci_free_dev (err 0)
> btusb: Unknown symbol hci_alloc_dev (err 0)
> ...

You have to enable other bluetooth modules as well. bluetooth.ko at least.
rfcomm, bnep and hidp if you need then.

	Gustavo
