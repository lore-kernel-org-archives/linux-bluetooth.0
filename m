Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: USB Bluetooth works manually, but won't
	hotplug with the SAME script
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050221185035.98722.qmail@web53003.mail.yahoo.com>
References: <20050221185035.98722.qmail@web53003.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1109026929.7626.21.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 22 Feb 2005 00:02:09 +0100

Hi Alfredo,

> I've tried the script... unfortunately, again, it
> works manually, but doesn't work with hotplug :( ... I
> had to remove the "modprobe bluetooth", because it
> didn't find the module, but AFAIK, the functionality
> is implemented in hci_usb... I might be wrong on this
> :(

don't start any daemons from hotplug. You can run them without having
any device plugged in.

> What the last 2 lines do, is what other people are
> suggesting to do with an rfcomm-kernel patch :)...
> basically, the second to last line:
> sdptool add --channel=3 SP
> adds the Serial Port service to sdpd, and the last
> line, fires up a pppd connection everytime a
> connection request comes from channel 3, establishing
> a connection to the palm :)

This specific stuff is only needed for WinCE connection and actually
someone should test the --mrouter option from dund and report or fix any
problems.

> Is there a chance that the problem is caused by the
> environment the kernel uses to execute the script is
> more restricted than when I do it manually? If so, how
> do I determine the difference? :S

Don't call it from hotplug. There is no need for it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
