Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN-BNEP-and TCP/IP
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050208074804.15870.qmail@web26404.mail.ukl.yahoo.com>
References: <20050208074804.15870.qmail@web26404.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1107855015.7327.159.camel@pegasus>
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
Date: Tue, 08 Feb 2005 10:30:15 +0100

Hi,

> I was thinking about how PAN profile interact with the
> TCP/IP stacks in blueZ.
> PAN uses the BNEP layer to provide layer 3 IP data and
> for instance how do we detect a ping answer or a ping
> request? 

when using BNEP you get a virtual network card in your system for every
connection. So call ifconfig and you see bnep0, bnep1 and so on network
devices. They work like physical network cards and so every IP stuff in
Linux also works over Bluetooth.

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
