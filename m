Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] l2cap and multiple connections
From: Marcel Holtmann <marcel@holtmann.org>
To: Vladimeros Vladimerou <vladimer@legend.me.uiuc.edu>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0405141244120.5838-100000@elegy.mie.uiuc.edu>
References: <Pine.LNX.4.44.0405141244120.5838-100000@elegy.mie.uiuc.edu>
Content-Type: text/plain
Message-Id: <1084557367.25099.211.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 14 May 2004 19:56:07 +0200

Hi Vlad,

> > you should step down to a book for socket programming. Which actually
> > means bind() once and accept() often ;)
> 
>   I know this is how it's normally done, but since
> I was using HCI before, and connections had to be initiated by the
> "master", I thought the method I mentioned was the way to use.
> 
>   So, from what your saying, I should listen() and accept() at the 
> bluetooth "master"? Is there an implicit role-change command
> happening somewhere, cause if I accept at the "master", otherwise,
> that would mean that the connection is initiated by the "slave", which
> is not as the bluetooth spec, right? How does it work?

the master is the device that creates the connection. That is what the
Bluetooth specification says. This means that an access point for
example is not a master per se, but it can tell a client to become
slave. Look at the L2CAP socket options for the master link policy.

> "eSCO"? Never heard about that. Thanks, I'll look into that.

It is part of the Bluetooth 1.2 specification.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
