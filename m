Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] error on connect
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <425FFF54.6000701@gmx.ch>
References: <425FFF54.6000701@gmx.ch>
Content-Type: text/plain
Message-Id: <1113607202.16433.42.camel@pegasus>
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
Date: Sat, 16 Apr 2005 01:20:02 +0200

Hi Marco,

> When I connect from a pc to another (both running bluez, own programs), I 
> get sometimes this error:
> hci_acldata_packet: hci0 ACL packet for unknown connection handle 6
> 
> I can't reproduce it. sometimes it happen, sometimes not.
> If the error occures, the connection breaks down else it works fine...
> 
> What means this error?

it actually means what it says. You receive a data packet for a closed
connection. What manufacturer is it? Is is not CSR.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
