Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] creation of Bnep0
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050302142837.62593.qmail@web26610.mail.ukl.yahoo.com>
References: <20050302142837.62593.qmail@web26610.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1109775195.8284.19.camel@pegasus>
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
Date: Wed, 02 Mar 2005 15:53:15 +0100

Hi Benny,

> I see how you create bnep0 with the netdev.c using
> linux/netdevice.c
> 
> Is it the only way for linking bnep with TCP/IP layers?

I do not fully understand this question, but in general it is also
possible to use TUN/TAP and a daemon dealing with BNEP in userspace. It
was discussed a long time ago and you will find the details in the
mailing list archive.

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
