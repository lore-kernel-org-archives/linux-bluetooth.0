Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: a2@adamis.de
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Once again: Socket CF card and Kernel 2.6
Message-ID: <20050228220209.GA8151@adamis.de>
References: <20050226031901.GL11723@adamis.de> <1109578431.17256.9.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1109578431.17256.9.camel@pegasus>
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
Date: Mon, 28 Feb 2005 23:02:09 +0100

Hi Marcel,

On 28.02.05 09:13:51, Marcel Holtmann wrote:
> > I'm trying to install a Socket Bluetooth Compactflash Card (Revision H)
> > in my Thinkpad X21. I tested it with the 2.4.29 kernel (from Debian
> > unstable) and it works, but I would like to use 2.6 and there it doesn't
> > work.
> > 
> > With 2.6, the serial_cs module gets loaded as I insert the card and
> > dmesg shows the following:
> > 
> > -----
> > ttyS1: detected caps 00000700 should be 00000100
> > ttyS1 at I/O 0x2f8 (irq = 11) is a 16C950/954
> > -----
> > 
> > Then I run modprobe hci_uart and this is what dmesg says:
> > 
> > -----
> > Bluetooth: HCI UART driver ver 2.1
> > Bluetooth: HCI BCSP protocol initialized
> > -----
> > (I didn't include CONFIG_BT_HCIUART_H4 in my kernel this time)
> > 
> > No problem so far, but then:  hciattach ttyS1 socket
> > and it says "BCSP initialization timed out" and hcitool dev doesn't show
> > any devices.
> 
> what kind of 2.6 kernel is this? Give 2.6.11-rc5 a chance. Do you see
> anything special with dmesg?

Before I have tried 2.6.9-1-686 (Debian unstable) and 2.6.10 (from
www.kernel.org). Now I patched the 2.6.10 up to 2.6.11-rc5, but it seems
to behave the same - same messages in dmesg as before, still timeout
when running hciattach (nothing in dmesg after this command)...
Also the same with the -mh4 patch (against a clean 2.6.10).

I checked what the working 2.4.29 shows in dmesg, maybe this helps
somewhat:

Inserting the card:
-----
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff
0xd8000-0xfffff
ttyS01 at port 0x02f8 (irq = 11) is a 16C950/954
-----

modprobe hci_uart:
-----
BlueZ HCI UART driver ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
-----

hciattach ttyS1 socket:
-----
bcsp_recv: Out-of-order packet arrived, got 1 expected 0
-----
(but the bluetooth device works despite this error)

One idea: is there an (easy) way to log what's going on on the ttyS1
device (I mean the communication between the hci_uart driver and the cf
card)? This way one could compare the logs of kernel 2.4 and 2.6 and
maybe see what's wrong...

Another question: What about the btuart_cs.ko module, what's the
difference to the hci_uart module?

Thanks in advance

Mathias

-- 
http://www.adamis.de/adam/
Es gibt mehr Leute, die kapitulieren, als solche, die scheitern.
 - Henry Ford


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
