Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Running L2CAP & HCI layers without OS
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050222092538.81728.qmail@web53205.mail.yahoo.com>
References: <20050222092538.81728.qmail@web53205.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1109066407.8506.11.camel@pegasus>
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
Date: Tue, 22 Feb 2005 11:00:07 +0100

Hi Filipa,

> It seams that my question about the l2cap and hci
> layers implemented in User Space is not so stupid
> after all! ;)

you should spent some time to think about hardware abstraction and the
right interface to L2CAP, RFCOMM etc. and then this looks stupid again.
Actually the OpenBT Bluetooth stack had exactly these two problems.

> Could anyone give me directions on how to run these
> layers without OS? One solution, I think, would be to
> change the l2cap and the hci files in order on not to
> have any OS call (that was actually what I as doing,
> which is quite a heavy work!). But it seams that there
> is an easy way (thanks Marcel, for pointing that
> out!).

There is no easy way and actually I don't see any need for it. Feel free
to start another Bluetooth stack, but this mailing list is about the
BlueZ and Linux and not any other operating system.

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
