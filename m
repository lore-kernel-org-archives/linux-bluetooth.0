Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mathias Adam <a2@adamis.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050226031901.GL11723@adamis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Once again: Socket CF card and Kernel 2.6
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
Date: Sat, 26 Feb 2005 04:19:03 +0100

Hello,

I'm trying to install a Socket Bluetooth Compactflash Card (Revision H)
in my Thinkpad X21. I tested it with the 2.4.29 kernel (from Debian
unstable) and it works, but I would like to use 2.6 and there it doesn't
work.

With 2.6, the serial_cs module gets loaded as I insert the card and
dmesg shows the following:

-----
ttyS1: detected caps 00000700 should be 00000100
ttyS1 at I/O 0x2f8 (irq = 11) is a 16C950/954
-----

Then I run modprobe hci_uart and this is what dmesg says:

-----
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI BCSP protocol initialized
-----
(I didn't include CONFIG_BT_HCIUART_H4 in my kernel this time)

No problem so far, but then:  hciattach ttyS1 socket
and it says "BCSP initialization timed out" and hcitool dev doesn't show
any devices.

I already searched this list's archives and found that some cards (the
Socket and some Xircom?) seem to have those problems with 2.6 while some
others (Zoom?) don't. Does anybody know yet how to solve this problem?
If there is no other solution: as my card works well with kernel 2.4, I
wonder if it is possible to use the old hci_uart module from 2.4 in 2.6?

Thanks for advice

Mathias


-- 
Perfection is achieved not when you have nothing more to add,
but when you have nothing left to take away.
 - Antoine de Saint-Exupery


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
