Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Palm Hotsync over Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: leonerd@leonerd.org.uk, hacker@gnu-designs.com, fpillet@mac.com
In-Reply-To: <1127412332.24352.14.camel@wyatt.hadess.net>
References: <1127412332.24352.14.camel@wyatt.hadess.net>
Content-Type: text/plain
Message-Id: <1127413417.12287.19.camel@blade>
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
Date: Thu, 22 Sep 2005 20:23:37 +0200

Hi Bastien,

> David, Florent, Paul, I've copied you on this mail as the
> pilot-sync-devel list seems to be down ATM. Bluez-devel people, I know a
> few have been interested in Hotsync'ing over Bluetooth for Palm devices.
> 
> This patch should apply to the current CVS HEAD of pilot-link.
> It adds configure checks for BlueZ (with the default being to turn on
> the Bluetooth support), and use the "bt:" port.
> 
> How-to use it:
> 1) Make sure your Palm and computer are paired
> 2) Select your computer as the Hotsync (Bluetooth->Setup
> devices->Hotsync, ignore the instructions on screen, and go through the
> wizard)
> 3) launch your favourite Palm conduit with the "bt:" port, such as:
> pilot-xfer -p bt: -l
> 4) Enjoy
> 
> There are a few kludges though:
> - Multiple HOTSYNC SDP records could get created, you can remove them by
> hand using sdptool.

look at the pand daemon and see how they handle the SDP records. There
is no need to make them persistent. If the application dies, the records
are automatically removed by sdpd.

> - We need to wait for the rfcomm device to be created, and then handled
> by the hotplug scripts before we can use it. Marcel probably knows how
> to do this better than I do.

Don't create a TTY device. You can use the RFCOMM socket directly.

> You can use bt:<Palm bdaddr> to only allow a specific Palm to connect to
> your conduit.
> 
> Comments welcome. Palm hackers, is "bluetooth:" being used, and if not,
> could we hijack it, and is the current code mergeable?

Someone has to send me a Palm device with Bluetooth, so I can do more
testing.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
