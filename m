Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MSI 6970 removing - kernel freeze
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402210038.59119.pavouk@pavouk.org>
References: <200402210038.59119.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1077320992.1433.18.camel@pegasus>
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
Date: Sat, 21 Feb 2004 00:49:53 +0100

Hi Pavel,

> When I have hci0 up and I remove my USB MSI 6970 dongle, then kernel freezes.
> 
> This is copied from the screen:
> ----------------------------------------------------------------------
> kernel panic: fatal exception in interrupt
> In interrupt handler - not syncing
> EIP is at uhci_remove_pending_qhs+0x61/0xc0 [uhci_hcd]
> ----------------------------------------------------------------------

this is a known problem with UHCI USB host controllers, but not our
problem. Alan Stern has patches and fixes for it and I think at least
with 2.6.4 this problem should be gone. See the BlueZ and USB mailing
list archives for more details.

> When I start computer, hci0 is down. I run hciconfig hci0 up.
> After this I have in dmesg this:
> -----------------------------------------------------------------------
> drivers/usb/core/urb.c: usb_submit_urb: bogus endpoint 3-IN on 
> usb-0000:00:07.3-1 (bad maxpacket 0)
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb c71c1a14 err -90
> drivers/usb/core/urb.c: usb_submit_urb: bogus endpoint 3-IN on 
> usb-0000:00:07.3-1 (bad maxpacket 0)
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb c71c1a14 err -90
> -----------------------------------------------------------------------

This one is new and Todd E. Johnson looked at it, but I have no time to
investigate on this problem. The only solution I can tell you is to
disable CONFIG_BT_HCIUSB_SCO.

> I have linux Mandrake 9.2 with vanilla kernel 2.6.2.

Try 2.6.3. Maybe it is already fixed.

> Is this kernel or hardware bug?

It's a kernel problem.

> Is this problem of USB or Bluetooth kernel module?

I am quite sure that this is an USB problem.

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
