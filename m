Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] tx submit failed urb c4c6b014 type 3 err -19
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0503011838200.24750-100000@blomma.comm2000.it>
References: <Pine.LNX.4.21.0503011838200.24750-100000@blomma.comm2000.it>
Content-Type: text/plain
Message-Id: <1109702721.17256.178.camel@pegasus>
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
Date: Tue, 01 Mar 2005 19:45:21 +0100

Hi Max,

> > build your own 2.6.11-rc5 kernel and use netconsole to get the full
> > oops.
> 
> Thanks. I've been running my program under 2.6.11-rc5 now. I got three
> 'oops' in a few hours of continuos running. They look different each time,
> yet they only occurred right after some errors like the one mentioned in
> the subject line, and those errors only occurred right before an oops. I
> put the logs here: http://cassandra.comm2000.it/~maxim/pub/bluez-oops/.

this is weird. The first one is related to sysfs and actually these
should all be fixed by now. The others are also not quite clear.

How many dongles are you using at the same time? I saw hci2 and hci1 in
the logs. What does "hciconfig -a" say about them?

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
