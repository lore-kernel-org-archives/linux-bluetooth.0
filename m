Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
Subject: Re: [Bluez-users] Re: MSI 6970 removing - kernel freeze
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200402222357.46031.pavouk@pavouk.org>
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
Date: Sun, 22 Feb 2004 23:57:46 +0100

Hello,

> > > > When I have hci0 up and I remove my USB MSI 6970 dongle, then kernel
> > > > freezes.
> >
> > Workaround is to make "hciconfig hci0 down" before removing USB dongle
> > from computer.
>
> or you don't select CONFIG_BT_HCIUSB_SCO in your kernel config.

thanks, It works now.

But i found other problem.

When I make "hciconfig hci0 up"
Interface goes up.
next "hciconfig hci0 down".
Interface goes down.
next hciconfig hci0 up"
I get this error:
Can't init device hci0. Connection timed out(110)

I must reinsert dongle or rmmod/modprobe kernel module hci_usb.

Best regards,

Pavel Ruzicka



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
