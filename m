Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connection times out after a while
From: Marcel Holtmann <marcel@holtmann.org>
To: Jan Schermer <zviratko@n.cz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1082288518.30797.13.camel@localhost>
References: <1082288518.30797.13.camel@localhost>
Content-Type: text/plain
Message-Id: <1082325723.4403.30.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 19 Apr 2004 00:02:04 +0200

Hi Jan,

> I can pair the devices fine, RFCOMM opens connection and I can issue AT
> commands to my mobile phone via minicom. However at some point (few
> seconds from the opening of connection) the communication just hangs and
> I have to reconnect the device and reload hci_usb driver for another
> connection to be initiated (otherwise, all connections time out (I see
> the bt communication icon on my phone though).
> 
> I am using Billionton USB dongle and SonyEricsson T610, I also tried
> with XDA2 but the same problem occurs.

what shows "hciconfig -a"?

> If I use the dongle and phone under VMWARE, everything works fine - so
> it must be something in the driver or my setup, but I have used it in
> the past and I'm almost sure that my setup is fine.

Is this Windows or Linux in your VMware session?

> I have tried kernels 2.6.5, 2.6.5-love[1-3], 2.6.5-gentoo-r1 without
> success. I even patched the third bluetooth patch in the kernel with no
> effect.
> 
> Any way I can debug this? Has anyone had the same problems like me?

We need a binary (use -w as root) hcidump of the connection.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
