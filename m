Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2test
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de465760412122003779e7efa@mail.gmail.com>
References: <2de465760412122003779e7efa@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1102925900.8750.98.camel@pegasus>
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
Date: Mon, 13 Dec 2004 09:18:20 +0100

Hi Manjunath,

> i am conduting a l2test between 2 devices, say A and B, using fixed
> packet types (i.e) i am setting  the packet type to say DM1 on both
> sides. Now when A sends data, does it send during all the 6 slots or
> does it send in alternate slots as the receiver is just listening(not
> sending)?? I want to know in which slots the packets are transmitted??
>  I am conducting the same tests for other packet types too.

and actually I advise you not to try anything like this, because you
can't measure things this way. The HCI is in between and there are no
rules that maps any of the ACL traffic on HCI to the ACL traffic on the
baseband. Get yourself a protocol analyzer and use its routines for
measurement of the traffic.

> In l2test, is the method of calculating the throughput correct??? It
> is calculating the  time as
> time=time at which last byte is received - time at which first byte is
> received.

I never checked it and as the name suggest it is a test utility.

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
