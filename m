Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030219115417.0cefad08@mail1.qualcomm.com>
Date: Wed, 19 Feb 2003 12:04:06 -0800
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
Cc: Alexandros Karypidis <karypid@inf.uth.gr>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1045609378.30001.88.camel@pegasus.local>
References: <5.1.0.14.2.20030218130327.0d1a9f48@mail1.qualcomm.com>
	<5.1.0.14.2.20030211095747.04387978@mail1.qualcomm.com>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
	<200302081740.48000.karypid@inf.uth.gr>
	<200302071951.35073.karypid@inf.uth.gr>
	<1044653775.32672.14.camel@pegasus.local>
	<200302081740.48000.karypid@inf.uth.gr>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
	<5.1.0.14.2.20030211095747.04387978@mail1.qualcomm.com>
	<5.1.0.14.2.20030218130327.0d1a9f48@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 03:00 PM 2/18/2003, Marcel Holtmann wrote:
>Hi Max,
>
>> >I think about something like a special way to bind psm 0 and all
>> >incoming connections which are not associated with a bounded psm go to
>> >this application. So you can listen on all PSM with only one call.
>> >
>> >I want use this for one of my projects, but I can also work around this
>> >problem. So my question is if this makes sense to you and how much
>> >modifications in the L2CAP core may be needed ?
>> Modifications would be simple. But that feature doesn't make sense to me.
>
>I will try to explain for what it will be good. I want to do something
>which can be described like "L2CAP Forwarding Proxy over Ethernet". So
>the only special PSM is the one for SDP, all others (mainly over 0x1000)
>would be used dynamicly and forwarded to other devices over another
>medium like ethernet. For this I only want to have two listen calls, one
>for all not bound PSM's and one for SDP.
For that you should probably hack hcidump and forward L2CAP packets.
The problem with your approach is that connection to _any_ PSM will always 
succeed even if that PSM is not active. 
i.e.
        1. accept() 
        2. try to forward 
        3. forward fails 
        4. close connection
 
That will confuse device that tries to connect to you because it will
assume that this PSM is in fact open but server closed connection
because of an error or something. 

>How much we have to change for something like this?
l2cap_get_sock_by_psm() will have to be modified slightly.
But we're not going to do that ;-).

Max
