Return-Path: <maxk@qualcomm.com>
Subject: Re: BCM2033 firmware loader
From: Max Krasnyansky <maxk@qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074197813.2629.52.camel@pegasus>
References: <1074193649.2629.23.camel@pegasus>
	 <1074196213.2559.255.camel@localhost>  <1074197813.2629.52.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074287664.2559.422.camel@localhost>
Mime-Version: 1.0
Date: Fri, 16 Jan 2004 13:14:24 -0800
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-01-15 at 12:16, Marcel Holtmann wrote:
> Hi Max,
> 
> > What's wrong with BlueFW ? Why did you implement BCM FW loader in the
> > kernel ?
> > I looked in the archive and the only thing I could find was that you
> > don't want to keep it without an explanation why.
> 
> actually I never got bluefw working stable with 2.6. The usbfs interface
> causes troubles which I can't explain. Maybe the problems are caused by
> my hardware, but I don't know. I also want to avoid using bulk transfer
> over ISOC endpoint to make OHCI happy and it seems that inside the
> kernel there exists no more problems for the OHCI chips. 
You mean Bulk over Interrupt. BlueFW doesn't send Bulk over Isoc.

> So after I made
> my experiences with the request_firmware() interface and the bfusb
> driver I decided to give it a try and the bcm203x driver was born.

I see. I have no problem with implementation in fact it's very clean and
nice. My only concern is that if it can be done from user space it
should be done in user-space thing :). I mean nobody is going to unload
this bcm203x module after fw download is complete. Yeah it's small but
it's still a waste. I'd rather fix usbfs if it's broken. Greg and
Johannes will happily accept patches ;-). 

Max
