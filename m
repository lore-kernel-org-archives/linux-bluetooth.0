Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: MSI 6970 removing - kernel freeze
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402222357.46031.pavouk@pavouk.org>
References: <200402222357.46031.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1077491054.2832.39.camel@pegasus>
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
Date: Mon, 23 Feb 2004 00:04:14 +0100

Hi Pavel,

> But i found other problem.
> 
> When I make "hciconfig hci0 up"
> Interface goes up.
> next "hciconfig hci0 down".
> Interface goes down.
> next hciconfig hci0 up"
> I get this error:
> Can't init device hci0. Connection timed out(110)
> 
> I must reinsert dongle or rmmod/modprobe kernel module hci_usb.

this problem only occurs on UHCI USB host contollers. The USB guys have
a bunch of fixes and I hope this gets fixed some time.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
