Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Multiple Headsets
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41E267C4.5030906@dark-reality.de>
References: <41E25ECD.2000505@fcse.co.uk> <41E267C4.5030906@dark-reality.de>
Content-Type: text/plain
Message-Id: <1105362147.8652.10.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 10 Jan 2005 14:02:27 +0100

Hi Lars,

> first, it would be a good idea to update to the latest available sources
> (that is, 2.6.10 kernel and mh10 patchset).
> 
> I think we do support multiple sco connections now, but you must either
> use 8-bit-audio (by hacking the btsco stuff) or hack the kernel.
> 
> The problem in short: the hci_usb driver that handles the bt dongles
> needs to know how many data has to be send. So if using two 16bit
> channels, it needs to switch to the 32bit-mode, not the 16bit mode that
> is used by default.
> 
> This switching is not handled automatically by now (or, not handled in
> any way to be precise), and while we are talking about it a lot, I think
> nobody fixed this by now (this includes me).

starting with 2.6.10 the hci_usb got a module parameter "isoc". This
controls the alternate setting when plugging in a dongle. The default
value is 2 (or 0 if it is blacklisted device). Check the Bluetooth
specification what value you have to choose for 2 x 16-bit SCO channels.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
