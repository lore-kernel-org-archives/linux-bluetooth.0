Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez-libs & bluez-utils updated!
From: Marcel Holtmann <marcel@holtmann.org>
To: Robert Foster <rfoster@mountainvisions.com.au>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084105014.13776.15.camel@rover.mountainvisions.com.au>
References: <1084105014.13776.15.camel@rover.mountainvisions.com.au>
Content-Type: text/plain
Message-Id: <1084107637.9269.67.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 09 May 2004 15:00:37 +0200

Hi Robert,

> So, I noticed a new set of bluez-libs and bluez-utils (2.7) on the bluez
> website...
> 
> Incorporating HID, no less:)
> 
> Is there anything we need to know about here, regarding differences to
> bthid from the utils2 in cvs?

so what do you need to now? The incorporated HID support is very
different from what you've used now. It depends on a new kernel module
called hidp, which handles the complete Human Interface Device Protocol.
This module is not public at moment, because I am doing my last work on
it so I can include it into patch-2.6.6-mh1. The final inclusion into
the kernel will take longer, because for that the current HID parser
must be rewritten to serve the USB and Bluetooth needs.

However this is the first time I am happy with the BlueZ HID support and
from my private tests it is working very great. I already played with
seven HID devices connected to the same host at the same time. A full
piconet of mice and keyboards and it is still working with a minimum of
latency.

Oh and btw the name of the program is hidd ;)

> Great work! thanks!  So, I guess you are now working on release 2.8:)

You are welcome. Right now 2.8 is not in my focus, but it will come ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
