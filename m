Return-Path: <rfoster@mountainvisions.com.au>
Subject: Re: [Bluez-devel] bluez-libs & bluez-utils updated!
From: Robert Foster <rfoster@mountainvisions.com.au>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084107637.9269.67.camel@pegasus>
References: <1084105014.13776.15.camel@rover.mountainvisions.com.au>
	 <1084107637.9269.67.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084108335.3326.1.camel@rover.mountainvisions.com.au>
Mime-Version: 1.0
Date: Sun, 09 May 2004 23:12:15 +1000
List-ID: <bluez-devel.lists.sourceforge.net>

Thanks for the reply, Marcel.
So, are we actually able to play with hidd yet?  Or do we need to wait
for the hidp module?  In other words, should I just stick with the bthid
in utils2?

Thanks,
Rob.
On Sun, 2004-05-09 at 23:00, Marcel Holtmann wrote:
> Hi Robert,
> 
> > So, I noticed a new set of bluez-libs and bluez-utils (2.7) on the bluez
> > website...
> > 
> > Incorporating HID, no less:)
> > 
> > Is there anything we need to know about here, regarding differences to
> > bthid from the utils2 in cvs?
> 
> so what do you need to now? The incorporated HID support is very
> different from what you've used now. It depends on a new kernel module
> called hidp, which handles the complete Human Interface Device Protocol.
> This module is not public at moment, because I am doing my last work on
> it so I can include it into patch-2.6.6-mh1. The final inclusion into
> the kernel will take longer, because for that the current HID parser
> must be rewritten to serve the USB and Bluetooth needs.
> 
> However this is the first time I am happy with the BlueZ HID support and
> from my private tests it is working very great. I already played with
> seven HID devices connected to the same host at the same time. A full
> piconet of mice and keyboards and it is still working with a minimum of
> latency.
> 
> Oh and btw the name of the program is hidd ;)
> 
> > Great work! thanks!  So, I guess you are now working on release 2.8:)
> 
> You are welcome. Right now 2.8 is not in my focus, but it will come ;)
> 
> Regards
> 
> Marcel
> 
> 
