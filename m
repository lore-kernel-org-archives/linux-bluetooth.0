Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1099721547.5132.70.camel@localhost>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>  <1099721547.5132.70.camel@localhost>
Content-Type: text/plain
Message-Id: <1099744491.6919.39.camel@pegasus>
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
Date: Sat, 06 Nov 2004 13:34:51 +0100

Hi Matthew,

> Finally figured out what is wrong.  There is definitely a Powerpc
> problem with the BT HIDPGETCONNLIST ioctl on the powerpc arch.
> 
> The HID ioctl HIDPGETCONNLIST is not returning any HID device entries
> from the kernel on the Powerpc architecture, even when a blue-tooth
> keyboard and mouse are working.
> 
> In Debian's boot scripts hidd --killall  is used to nicely close the
> connections so that the devices will reconnect cleanly on next boot. 
> This is not working for me as the above ioctl is not returning a list if
> addresses to be acted on.
> 
> Work around for me will be to explicitly kill each device address before
> stopping hidd, as hidd --kill <device address> works.  Does this mean
> that the devices are registering in the hidp module, but there is a
> problem in passing the list back out of the kernel?

does "hidd --show" works?

> Do you have access to a powerpc machine to test this on?  Could you give
> me any instructions on getting the hidp.ko module to produce the debug
> that would be useful?
> 
> It would be good to get this one solved, as I would like to look at
> shallower bugs which I can knock off myself. First look at the hidp code
> with this one freaked me out a bit.

I don't have access to a PowerPC machine. What Apple is this?

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
