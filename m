Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1099942733.5806.7.camel@localhost>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>  <1099721547.5132.70.camel@localhost>
	 <1099744491.6919.39.camel@pegasus>  <1099771915.4563.9.camel@localhost>
	 <1099776680.6919.104.camel@pegasus>  <1099788984.4543.5.camel@localhost>
	 <1099795084.6896.3.camel@pegasus>  <1099942733.5806.7.camel@localhost>
Content-Type: text/plain
Message-Id: <1099943605.29330.21.camel@pegasus>
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
Date: Mon, 08 Nov 2004 20:53:25 +0100

Hi Matthew,

> Just got debug going.  Going to put printks into hidp_get_connlist to
> see what is happening.
> 
> Your comment on the big endian bug in the L2CAP you noticed below, and
> some of the debug I have seen with the other BT problems make it look
> like I am having endianess issues. 
> 
> I am going to print the kernel code tonight and read it through as it is
> obvious I have to understand the stack if I am get things fixed - you
> don't have access to an Apple machine to test things on.  In the past I
> was a commercial router programmer, doing OSPF and IPX development.
> 
> Any good places to find protocol specs?  I especially need
> specifications on the endianess of the incoming BT data so I can audit
> and check the debug for that sort of thing.

everything is in the Bluetooth core and HID profile specification.

It must not be an endian problem, because other people with Apple
machines are using HID. May you wanna try another compiler.

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
