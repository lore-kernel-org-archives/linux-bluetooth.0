Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1099788984.4543.5.camel@localhost>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>  <1099721547.5132.70.camel@localhost>
	 <1099744491.6919.39.camel@pegasus>  <1099771915.4563.9.camel@localhost>
	 <1099776680.6919.104.camel@pegasus>  <1099788984.4543.5.camel@localhost>
Content-Type: text/plain
Message-Id: <1099795084.6896.3.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 07 Nov 2004 03:38:04 +0100

Hi Matthew,

> > and what does /proc/bluetooth/l2cap show you?
> > 
> 
> root@sharon:/usr/src/bluetooth/bluez-utils-2.10#
> # cat /proc/bluetooth/l2cap
> A7:FF:10:93:0D:00 49:0B:3B:95:0A:00 1 4864 0x0041 0x0041 48 672 0x1
> A7:FF:10:93:0D:00 49:0B:3B:95:0A:00 1 4352 0x0040 0x0040 48 672 0x1
> A7:FF:10:93:0D:00 61:DF:16:61:07:00 1 4864 0x0041 0x004d 48 48 0x1
> A7:FF:10:93:0D:00 61:DF:16:61:07:00 1 4352 0x0040 0x004c 48 48 0x1
> 00:00:00:00:00:00 00:00:00:00:00:00 4 4864 0x0000 0x0000 48 48 0x1
> 00:00:00:00:00:00 00:00:00:00:00:00 4 4352 0x0000 0x0000 48 48 0x1
> 00:00:00:00:00:00 00:00:00:00:00:00 4 256 0x0000 0x0000 672 0 0x0
> 00:00:00:00:00:00 00:00:00:00:00:00 4 768 0x0000 0x0000 1024 0 0x0
> 
> The above bluetooth addresses are all in reverse byte order!!!
> 
> Apple Keyboard is 00:0A:95:3B:0B:49
> Logitech Mx900 Mouse is 00:07:61:16:DF:61
> computer hci0 is 00:0D:93:10:FF:A7

the address order is ok, but the column for the PSM has a big endian
bug. This needs to be fixed.

However you are connected to the mouse and the keyboard. This is
actually working fine.

> > You can enable the DEBUG in the hidp driver or add some printk calls be
> > yourself to see where the ioctl fails.
> > 
> I will give this a go latter on this afternoon.

Try to find the reason why and where the ioctl fails.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
