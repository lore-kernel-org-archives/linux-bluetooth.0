Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Setting up an hotplug connection with USB dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412232343.45609.rdorsch@web.de>
References: <200411282132.37941.rdorsch@web.de>
	 <200412192323.20579.rdorsch@web.de> <1103495289.29892.85.camel@pegasus>
	 <200412232343.45609.rdorsch@web.de>
Content-Type: text/plain
Message-Id: <1103889889.20258.82.camel@pegasus>
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
Date: Fri, 24 Dec 2004 13:04:49 +0100

Hi Rainer,

> I used the Debian standard stuff (at least, as far as I am aware of it):
> 
> rd@topsi:~$ grep bnep0 /etc/network/interfaces
> iface bnep0 inet dhcp

add a line with "auto bnep0" and it will bring up your interface when it
is available.

> rd@topsi:~$ cat /etc/bluetooth/pan/dev-up
> #!/bin/sh
> echo running dev-up
> ifup bnep0

Don't do it this way. Bad stuff.

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
