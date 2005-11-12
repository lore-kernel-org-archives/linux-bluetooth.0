Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm simultaneous connection
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <45bf5ff80511121135o5ee92e8bn9cdf5317f25d6e6d@mail.gmail.com>
References: <45bf5ff80511120733m222f37b0u580167f357e3b282@mail.gmail.com>
	 <1131811109.29461.24.camel@blade>
	 <45bf5ff80511121135o5ee92e8bn9cdf5317f25d6e6d@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1131828732.29461.29.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 12 Nov 2005 21:52:12 +0100

Hi Artur,

> t01:/# /usr/local/sbin/hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.27
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:13:FD:BB:22:3F ptype 0xcc18 rswitch 0x01 clkoffset 0x0000 
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:14:60:01:23:45 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000 
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x0c ncmd 1
>     Error: Command Disallowed

you try to create both piconets at the same time. This can't work,
because the Bluetooth chip can only page one. You must wait at least
until one piconet is established.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
