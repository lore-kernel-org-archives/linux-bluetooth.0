Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH v2] btusb.c: add support for 2011 mac mini
From: Jurgen Kramer <gtmkramer@xs4all.nl>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Gustavo Padovan <padovan@profusion.mobi>
Date: Sat, 17 Sep 2011 15:50:55 +0200
In-Reply-To: <654DF80AD31A344E93DBCC6280BD6DEF2224FAE7@NL0230MBX08N1.DIR.slb.com>
References: <1316102688.1973.5.camel@paragon.slim>
	 <20110915162821.GA4690@joana>
	 <654DF80AD31A344E93DBCC6280BD6DEF2224F3D9@NL0230MBX08N1.DIR.slb.com>
	 <1316164099.1976.4.camel@paragon.slim>
	 <654DF80AD31A344E93DBCC6280BD6DEF2224FAE7@NL0230MBX08N1.DIR.slb.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316267470.6744.2.camel@paragon.slim>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2011-09-17 at 12:58 +0000, John Frankish wrote:
> > > > -----Original Message-----
> > > > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > > > owner@vger.kernel.org] On Behalf Of Gustavo Padovan
> > > > Sent: Thursday, 15 September, 2011 20:28
> > > > To: Jurgen Kramer
> > > > Cc: linux-bluetooth@vger.kernel.org
> > > > Subject: Re: [PATCH v2] btusb.c: add support for 2011 mac mini
> > > >
> > > > Hi Jurgen,
> > > >
> > > > * Jurgen Kramer <gtmkramer@xs4all.nl> [2011-09-15 18:04:44 +0200]:
> > > >
> > > > > Hopefully this patch is now correct.
> > > > > Patch against current kernel git to add ID for MacMini5,1 to
> > > > > btusb.c
> > > > >
> > > > > Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
> > > > > --- linux/drivers/bluetooth/btusb.c	2011-09-14
> > 17:31:09.411475756 +0200
> > > > > +++ linux.new/drivers/bluetooth/btusb.c	2011-09-14
> > > > 17:33:37.727484053
> > > > > +0200
> > > > > @@ -75,6 +75,9 @@ static struct usb_device_id btusb_table[
> > > > >  	/* Apple MacBookPro8,2 */
> > > > >  	{ USB_DEVICE(0x05ac, 0x821a) },
> > > > >
> > > > > +	/* Apple MacMini5,1 */
> > > > > +	{ USB_DEVICE(0x05ac, 0x8281) },
> > > > > +
> > > > >  	/* AVM BlueFRITZ! USB v2.0 */
> > > > >  	{ USB_DEVICE(0x057c, 0x3800) },
> > > >
> > > Hmm, mine says the id is:
> > >
> > > DMI: Apple Inc. Macmini5,3/Mac-7BA5B2794B2CDB12, BIOS
> > > MM51.88Z.0075.B00.1106271442 06/27/2011
> > >
> > > ..rather than " MacMini5,1"
> > >
> > Yes, there are multiple models all which all have a different model name,
> > 5,1/5,2/5,3 etc.
> > I have the base mini (intel GPU), you probably have the server version.
> > The patch should work regardless as it is not depended on DMI info.
> > 
> Just to let you know the patch works on the latest mac mini server:
> 
> DMI: Apple Inc. Macmini5,3/Mac-7BA5B2794B2CDB12, BIOS MM51.88Z.0075.B00.1106271442 06/27/2011
> 
> Bus 001 Device 003: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub (part of BCM2046 Bluetooth)
> 
> ..I'm not totally sure why id:0x4500 should work when the patch is for id:0x8281, but anyway :)
> 
> 
Thanks for testing.
The BCM2046 is a hub with multiple devices, one of which is the
bluetooth device. You can check with lsusb -t



