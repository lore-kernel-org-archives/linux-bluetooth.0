Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Extremely slow printing?
From: Marcel Holtmann <marcel@holtmann.org>
To: Jon Valvatne <jon@valvatne.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1087431069.6361.26.camel@localhost.localdomain>
References: <1087431069.6361.26.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1087432013.4309.43.camel@pegasus>
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
Date: Thu, 17 Jun 2004 02:26:53 +0200

Hi Jon,

> I got my bluetooth CF card today, stuck it in my laptop, and I have to
> say I'm very impressed with the status of BlueZ; all my bluetooth
> devices are working fine with minimal effort.
> 
> I'm noticing just one annoyance: I've got a Canon i80 printer with the
> bluetooth module, and printing over bluetooth turns out to be *much*
> slower than printing over USB: A 250K postscript file takes 40 seconds
> to print over USB, but 3 minutes to print over bluetooth.
> 
> I'm not very familiar with the internals of printers and printer
> drivers, so I'm not sure how surprising this is. The raw speed advantage
> that USB has shouldn't be an issue here, since bluetooth's bandwidth
> should still be enough to transfer the data in a couple of seconds. Is
> latency the issue? Or is it inefficiencies in the bluetooth backend for
> CUPS?

maybe the Bluetooth device or chip in the printer is too slow. Do it use
SPP or HCRP?

> I suppose I'll try using Canon's own drivers under Windows, which might
> tell me whether or not this is an inherent problem with printing over
> the bluetooth medium. But I thought I'd ask here as well.

Please check this first, because BlueZ tries to send with the maximum
speed. This must be a hardware issue.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
