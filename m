Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Working Socket CF Rev G/H w/ 2.6.x kernel?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0412070840490.5533@gaia3.cc.gatech.edu>
References: <Pine.GSO.4.58.0412070840490.5533@gaia3.cc.gatech.edu>
Content-Type: text/plain
Message-Id: <1102428093.8447.44.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 07 Dec 2004 15:01:33 +0100

Hi Jay,

> I have a Socket Compact Flash 2.5 (Revision H) card [new one with CSR chip].
> 
> My system recognizes it as a serial port with the serial_cs module, but
> "hciattach ttyS4 socket" doesn't initialize it properly (BCSP
> initialization failed). {I have also tried the HCI_UART module, but it
> doesn't work.} The rest of my bluetooth/pcmcia system works fine with a
> Zoom PCMCIA card.

the Socket card should work the same as the Zoom card, because I also
used the Zoom card with serial_cs + hci_uart.

> I am running kernel 2.6.7 and have heard that I may need to upgrade my
> kernel to get some serial patches to get it working.
> 
> My question before I do:
> -Is there anything else I should check first?

What does dump_cis say?

> -Is 2.6.9 late enough or should I go for 2.6.10-rc3 (or some other patch
> level)?

Go with the 2.6.10-rc3.

> -Anybody have a Rev G or H card working with any 2.6.x kernel?

No that I know of and I don't have one of these at home for testing.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
