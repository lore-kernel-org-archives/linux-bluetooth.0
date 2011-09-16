Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Gustavo Padovan <padovan@profusion.mobi>,
	Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: RE: [PATCH v2] btusb.c: add support for 2011 mac mini
Date: Fri, 16 Sep 2011 08:58:21 +0000
Message-ID: <654DF80AD31A344E93DBCC6280BD6DEF2224F3D9@NL0230MBX08N1.DIR.slb.com>
References: <1316102688.1973.5.camel@paragon.slim>
 <20110915162821.GA4690@joana>
In-Reply-To: <20110915162821.GA4690@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gustavo Padovan
> Sent: Thursday, 15 September, 2011 20:28
> To: Jurgen Kramer
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v2] btusb.c: add support for 2011 mac mini
> 
> Hi Jurgen,
> 
> * Jurgen Kramer <gtmkramer@xs4all.nl> [2011-09-15 18:04:44 +0200]:
> 
> > Hopefully this patch is now correct.
> > Patch against current kernel git to add ID for MacMini5,1 to btusb.c
> >
> > Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
> > --- linux/drivers/bluetooth/btusb.c	2011-09-14 17:31:09.411475756 +0200
> > +++ linux.new/drivers/bluetooth/btusb.c	2011-09-14
> 17:33:37.727484053
> > +0200
> > @@ -75,6 +75,9 @@ static struct usb_device_id btusb_table[
> >  	/* Apple MacBookPro8,2 */
> >  	{ USB_DEVICE(0x05ac, 0x821a) },
> >
> > +	/* Apple MacMini5,1 */
> > +	{ USB_DEVICE(0x05ac, 0x8281) },
> > +
> >  	/* AVM BlueFRITZ! USB v2.0 */
> >  	{ USB_DEVICE(0x057c, 0x3800) },
> 
Hmm, mine says the id is:

DMI: Apple Inc. Macmini5,3/Mac-7BA5B2794B2CDB12, BIOS MM51.88Z.0075.B00.1106271442 06/27/2011

..rather than " MacMini5,1"

