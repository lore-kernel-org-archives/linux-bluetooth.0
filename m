Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030211100822.043916e0@mail1.qualcomm.com>
Date: Tue, 11 Feb 2003 10:23:55 -0800
To: Alexandros Karypidis <karypid@inf.uth.gr>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <200302111822.44704.karypid@inf.uth.gr>
References: <5.1.0.14.2.20030210123957.0417f4c0@mail1.qualcomm.com>
	<1044653775.32672.14.camel@pegasus.local>
	<5.1.0.14.2.20030210123957.0417f4c0@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 06:22 PM 2/11/2003 +0200, Alexandros Karypidis wrote:
>On Monday 10 February 2003 22:49, Max Krasnyansky wrote:
>
>> [...]
>> Currently psm zero means that socket doesn't have PSM assigned to it.
>> bind(psm==0) means that application doesn't need PSM it's simply wants to
>> bind it's socket to some BD address. Which is exactly what L2CAP clients
>> need. So you proposing a change that will brake current bind() interface.
>> Well I guess it won't really break it but it will allocated PSM for all
>> client apps which doesn't make any sense.
>
>Ok, from another e-mail you sent in this thread I realize that I should not 
>consider the PSM as the equivalent of a port number. CIDs are closer to that 
>notion. Sorry, I've only started using Bluetooth for a week now and since IP 
>is all I've ever known, I'm trying (perhaps too much) to find analogies.
That's perfectly ok. No need to apologize. 

>> Why do you think we need dynamic PSM allocation ? l2cap already allocates
>> CIDs dynamically. I don't see why people would want the same thing for
>> PSMs.
>
>Well, assume that I need to run several server processes on a BT device. When 
>each process launches, it needs to bind to a BDADDR:PSM entry point and 
>accept() connections. Currently, I need to pre-assign this PSM value for each 
>server process, as I have no other option. 
>I would like to have a fixed 
>BDADDR:PSM value for only one "special" server and have the others bind() to 
>a BDADDR:I_DONT_CARE_PSM pair. Then, clients could inquire and obtain the 
>PSMs of the other servers from the "special" server at the well-known entry 
>point. It would be very much like a custom "service contact-address 
>discovery" method.
Same problem (I don't really consider it a problem btw) exists in IP. Client has to 
know server's port number. What if the PSM you picked for discovery service is used
by some other service ?
btw That discovery method is called SDP in Bluetooth. You don't have to invent you own.

>Basically, my problem is that when you have a device where you can 
>install/remove services created from various manufacturers, there must exist 
>a global agreement about PSM allocations. For example, suppose I install 2 
>services which are manufactured from entities A and B. Now, A decides that it 
>will receive connections on PSM 15000 and B chooses 16004. No problem. If by 
>pure bad luck they had chosen the same PSM, I would be unable to run both 
>concurrently. 
That's exactly the reason why I don't consider it a problem in Bluetooth world.
There are very few applications exist for Bluetooth. The chances that two different 
proprietary apps pick the same PSM are very slim. Vendors can apply and 
reserve official PSM for well known apps. IP managed that pretty well.

>Ideally, each would obtain an arbitrary PSM when it was launched and publish its contact 
>address via some other mechanism.
Actually I don't think that this is ideal :). Simply because you have to do yet another 
connection to obtain PSM and Bluetooth connections already take too long (mostly baseband).
But I'm not against the idea of dynamic PSMs. We just have to decide what's the best way 
to implement them.

Max
