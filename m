Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
References: <200402210038.59119.pavouk@pavouk.org>
In-Reply-To: <200402210038.59119.pavouk@pavouk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402221306.46964.pavouk@pavouk.org>
Subject: [Bluez-users] Re: MSI 6970 removing - kernel freeze
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
Date: Sun, 22 Feb 2004 13:06:46 +0100

Hello,

today I was testing this with new kernel 2.6.3 and problem is
identical like in kernel 2.6.2.

Best regards,

Pavel Ruzicka
 
> When I have hci0 up and I remove my USB MSI 6970 dongle, then kernel
> freezes.
>
> This is copied from the screen:
> ----------------------------------------------------------------------
> kernel panic: fatal exception in interrupt
> In interrupt handler - not syncing
> EIP is at uhci_remove_pending_qhs+0x61/0xc0 [uhci_hcd]
> ----------------------------------------------------------------------
>
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



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
