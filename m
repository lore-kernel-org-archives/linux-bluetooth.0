Return-Path: <Maksim.Yevmenkin@cw.com>
Message-ID: <3E493B1A.B3B1C3E3@cw.com>
Date: Tue, 11 Feb 2003 10:04:10 -0800
From: Maksim Yevmenkin <Maksim.Yevmenkin@cw.com>
MIME-Version: 1.0
To: Alexandros Karypidis <karypid@inf.uth.gr>
CC: Max Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] How do I obtain a free PSM  automatically?
References: <1044653775.32672.14.camel@pegasus.local>
	<5.1.0.14.2.20030210123957.0417f4c0@mail1.qualcomm.com>
	<200302111822.44704.karypid@inf.uth.gr>
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Alexandros Karypidis wrote:
> 
> On Monday 10 February 2003 22:49, Max Krasnyansky wrote:
> 
> > [...]
> > Currently psm zero means that socket doesn't have PSM assigned to it.
> > bind(psm==0) means that application doesn't need PSM it's simply wants to
> > bind it's socket to some BD address. Which is exactly what L2CAP clients
> > need. So you proposing a change that will brake current bind() interface.
> > Well I guess it won't really break it but it will allocated PSM for all
> > client apps which doesn't make any sense.
> 
> Ok, from another e-mail you sent in this thread I realize that I should not
> consider the PSM as the equivalent of a port number. CIDs are closer to that
> notion. Sorry, I've only started using Bluetooth for a week now and since IP
> is all I've ever known, I'm trying (perhaps too much) to find analogies.
> 
> > Why do you think we need dynamic PSM allocation ? l2cap already allocates
> > CIDs dynamically. I don't see why people would want the same thing for
> > PSMs.
> 
> Well, assume that I need to run several server processes on a BT device. When
> each process launches, it needs to bind to a BDADDR:PSM entry point and
> accept() connections. Currently, I need to pre-assign this PSM value for each
> server process, as I have no other option. I would like to have a fixed
> BDADDR:PSM value for only one "special" server and have the others bind() to
> a BDADDR:I_DONT_CARE_PSM pair. Then, clients could inquire and obtain the
> PSMs of the other servers from the "special" server at the well-known entry
> point. It would be very much like a custom "service contact-address
> discovery" method.
> 
> Basically, my problem is that when you have a device where you can
> install/remove services created from various manufacturers, there must exist
> a global agreement about PSM allocations. For example, suppose I install 2
> services which are manufactured from entities A and B. Now, A decides that it
> will receive connections on PSM 15000 and B chooses 16004. No problem. If by
> pure bad luck they had chosen the same PSM, I would be unable to run both
> concurrently. Ideally, each would obtain an arbitrary PSM when it was
> launched and publish its contact address via some other mechanism.

life sucks, isn't it? :) http://www.iana.org/ is in control of "well
known"
IP ports, but nothing prevents you from running HTTP server on port 23
and telnet on port 80. i presume http://www.bluetooth.org/ or something
like this will assign PSM to different manufacturers. but again there is
no way you can control decisions made by the particular manufacturer.
everybody should play nice :)

i agree you have control over the IP ports (most of the time). but
nobody
will run public web server on any port other then 80 (or 443). you can
not
run two *different* web servers bound to the same IP and port (IP
aliases
and virtual servers do not count :)

if you have more then one BT device, you can bound each service to
particular
device on the same PSM.

thanks,
max
