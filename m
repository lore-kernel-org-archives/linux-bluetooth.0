Return-Path: <Maksim.Yevmenkin@cw.com>
Message-ID: <3E4956A6.3CC2A841@cw.com>
Date: Tue, 11 Feb 2003 12:01:42 -0800
From: Maksim Yevmenkin <Maksim.Yevmenkin@cw.com>
MIME-Version: 1.0
To: Max Krasnyansky <maxk@qualcomm.com>
CC: Alexandros Karypidis <karypid@inf.uth.gr>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] How do I obtain a free PSM  automatically?
References: <1044653775.32672.14.camel@pegasus.local>
	<5.1.0.14.2.20030210123957.0417f4c0@mail1.qualcomm.com>
	<200302111822.44704.karypid@inf.uth.gr>
	<5.1.0.14.2.20030211103102.0438d370@mail1.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Max Krasnyansky wrote:
> 
> At 10:04 AM 2/11/2003 -0800, Maksim Yevmenkin wrote:
> >> Basically, my problem is that when you have a device where you can
> >> install/remove services created from various manufacturers, there must exist
> >> a global agreement about PSM allocations. For example, suppose I install 2
> >> services which are manufactured from entities A and B. Now, A decides that it
> >> will receive connections on PSM 15000 and B chooses 16004. No problem. If by
> >> pure bad luck they had chosen the same PSM, I would be unable to run both
> >> concurrently. Ideally, each would obtain an arbitrary PSM when it was
> >> launched and publish its contact address via some other mechanism.
> >
> >life sucks, isn't it? :) http://www.iana.org/ is in control of "well known"
> >IP ports, but nothing prevents you from running HTTP server on port 23
> >and telnet on port 80. i presume http://www.bluetooth.org/ or something
> >like this will assign PSM to different manufacturers. but again there is
> >no way you can control decisions made by the particular manufacturer.
> >everybody should play nice :)
> >
> >i agree you have control over the IP ports (most of the time). but nobody
> >will run public web server on any port other then 80 (or 443). you can not
> >run two *different* web servers bound to the same IP and port (IP aliases
> >and virtual servers do not count :)
> 
> You can really tell if person has "ALL IP" mentality :).
> I'm that kind of person myself.

i was trying to explain it in "IP terms" since orignal post
was about comparing IP and Bluetooth :)  i'm trying to keep
my mind open :)
 
> btw Originally PSM was supposed to be assigned by Bluetooth SIG. ie. Just like
> well known IP port. And then some "clever" people came up with the idea of dynamic
> PSMs (probably the same people decided that PSM field needs 'an extension
> bit' and made half of the PSMs space invalid). Unfortunately those "clever"
> people didn't realize that [:[dynamic CID] is stupid.

well there is nothing *really* wrong with extenstion. i think
it is just a safeguard. however i think this is way to optimistic.
i just can't imagine that Bluetooth can ever use up all 65536
or even 32768) PSMs. IP has lived with 65536 ports since the
day one. i missed "dynamic PSM" stuff. was it somewhere is spec?

> When you add [dynamic DLCI] op top for RFCOMM sessions it becomes ridiculous :).
> And I'm not even sure what to call it when you add [dynamic OBEX channel] ;-)

whoa! i missed them too :) what exactly dynamic DLCI and 
dynamic OBEX channel mean? does it mean that user select
channel (DLCI) and give to server app? or does it mean
that server app itself somehow figures out available DCLI
and get it? 

and what the hell is dynamic OBEX channel? OBEX works
over RFCOMM so it needs RFCOMM channel (DLCI), right?

> Anyhow, we may have to provide dynamic PSM and DLCI service just because it may
> become a common thing on other platforms and stacks.

examples please :) what platforms/stacks do support these
features? how they use it? 

thanks,
max
