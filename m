Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Selection of PtP connection type
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402230026.24596.pavouk@pavouk.org>
References: <200402230026.24596.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1077521034.2832.52.camel@pegasus>
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
Date: Mon, 23 Feb 2004 08:23:54 +0100

Hi Pavel,

> I want to connect my Desktop Mandrake linux with my Sharp Zaurus.
> On desktop side I want automatic solution. Only insert USB dongle.
> 
> On Zaurus side I have network connector with PPP connection support,
> (it's works with my Nokia 6310i phone), and with PAN support.
> I want only click "connect" on Zaurus side.
> 
> I read many FAQ, but many of them are outdated or not complete.
> I know, there are ppp over rfcomm, ppp over bnep, bridge over bnep, or 
> anything else? I'am a little confused about it.

there is no PPP over BNEP, because BNEP itself is an ethernet emulation.

> What is the preferred way of connecting two devices today?

The preferred way is to use the PAN profile (BNEP).

> ----------------------------------------------------------------------
> Other problem is with automatic configuring. For autoloading
> of kernel modules I have in kernel 2.6.3 autoloader, and in /etc/modprobe.conf
> I have this:
> # bluetooth stuff
> alias net-pf-31 bluez
> alias bt-proto-0 l2cap
> alias bt-proto-2 sco
> alias bt-proto-3 rfcomm
> alias bt-proto-4 bnep
> alias tty-ldisc-11 hci_usb
> 
> This works for me, but Is it the right way?

No.

	alias net-pf-31 bluetooth	(for 2.4 this is bluez)
	alias bt-proto-0 l2cap
	alias bt-proto-2 sco
	alias bt-proto-3 rfcomm
	alias bt-proto-4 bnep
	alias bt-proto-5 cmtp
	alias tty-ldisc-15 hci_uart

> Where can I place configuration for automatic configuring and removing 
> interface?

Start hcid. And you can make use of bluetooth.agent.

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
