Return-Path: <karypid@inf.uth.gr>
From: Alexandros Karypidis <karypid@inf.uth.gr>
To: Max Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
Date: Tue, 11 Feb 2003 18:22:44 +0200
Cc: bluez-devel@lists.sourceforge.net
References: <1044653775.32672.14.camel@pegasus.local>
	<5.1.0.14.2.20030210123957.0417f4c0@mail1.qualcomm.com>
In-Reply-To: <5.1.0.14.2.20030210123957.0417f4c0@mail1.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200302111822.44704.karypid@inf.uth.gr>
List-ID: <bluez-devel.lists.sourceforge.net>

On Monday 10 February 2003 22:49, Max Krasnyansky wrote:

> [...]
> Currently psm zero means that socket doesn't have PSM assigned to it.
> bind(psm==0) means that application doesn't need PSM it's simply wants to
> bind it's socket to some BD address. Which is exactly what L2CAP clients
> need. So you proposing a change that will brake current bind() interface.
> Well I guess it won't really break it but it will allocated PSM for all
> client apps which doesn't make any sense.

Ok, from another e-mail you sent in this thread I realize that I should not 
consider the PSM as the equivalent of a port number. CIDs are closer to that 
notion. Sorry, I've only started using Bluetooth for a week now and since IP 
is all I've ever known, I'm trying (perhaps too much) to find analogies.

> Why do you think we need dynamic PSM allocation ? l2cap already allocates
> CIDs dynamically. I don't see why people would want the same thing for
> PSMs.

Well, assume that I need to run several server processes on a BT device. When 
each process launches, it needs to bind to a BDADDR:PSM entry point and 
accept() connections. Currently, I need to pre-assign this PSM value for each 
server process, as I have no other option. I would like to have a fixed 
BDADDR:PSM value for only one "special" server and have the others bind() to 
a BDADDR:I_DONT_CARE_PSM pair. Then, clients could inquire and obtain the 
PSMs of the other servers from the "special" server at the well-known entry 
point. It would be very much like a custom "service contact-address 
discovery" method.

Basically, my problem is that when you have a device where you can 
install/remove services created from various manufacturers, there must exist 
a global agreement about PSM allocations. For example, suppose I install 2 
services which are manufactured from entities A and B. Now, A decides that it 
will receive connections on PSM 15000 and B chooses 16004. No problem. If by 
pure bad luck they had chosen the same PSM, I would be unable to run both 
concurrently. Ideally, each would obtain an arbitrary PSM when it was 
launched and publish its contact address via some other mechanism.

Sorry for the long e-mail. I hope I've explained clearly what "bothers" me. :)
