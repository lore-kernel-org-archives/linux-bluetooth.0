Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030722125704.097cd218@unixmail.qualcomm.com>
Date: Tue, 22 Jul 2003 13:05:28 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: Version 3 libs/utils
Cc: Stephen Crane <steve.crane@rococosoft.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1058870455.24408.66.camel@pegasus>
References: <5.1.0.14.2.20030721173324.096d96b0@unixmail.qualcomm.com>
	<5.1.0.14.2.20030717163326.07385478@unixmail.qualcomm.com>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<5.1.0.14.2.20030717163326.07385478@unixmail.qualcomm.com>
	<5.1.0.14.2.20030721173324.096d96b0@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 03:40 AM 7/22/2003, Marcel Holtmann wrote:
>Hi Max,
>
>> >The SDP server is needed in most cases (see my other post). Why do not
>> >make it smart and integrate it. We need to keep track of different
>> >Bluetooth adapters attached to one host, so if we have one daemon, the
>> >SDP server can profite from a general approach.
>> >
>> >This idea is not completly designed, but it makes sense to me, because
>> >in the long term, we can't live without SDP.
>> I'd keep it separate. But I don't have very strong feeling about this one :).
>
>let's see how it goes. If we have more details on how the new Bluetooth
>master server will look like, we may can make a better decission.
Sounds good.

>> >> Also I don't see a need for user space inquiry cache. I guess you mean name database or
>> >> something.
>> >
>> >I meant inquiry cache in a little bit wider range. It should store
>> >device specific information, but also the inquiry results. I think it is
>> >a good idea, that the library also have access to the inquiry results,
>> >because name resolves can be much faster if you fill in the paramters
>> >from an inquiry (even if the clock drifts).
>> Yeah, I call it device database :).
>
>Should we keep the kernel inquiry interface? The kernel inside inquiry
>cache is a nice thing and works in the background like a charm :)
You mean HCI_INQUIRY ioctl, right ? I'm not sure about that one.
We'll certainly keep inquiry cache. Cache doesn't really depend on ioctl.

>What about the idea to integrate the inquiry into the library or into
>the Bluetooth master daemon.
I don't see a need for forwarding inquiry results from a daemon. It can be 
done in a simple way in the kernel, just like I explained in prev emails
(ie kernel parsing hci_inquiry command).

>> At least you're not saying - lets combine 'ifconfig', 'route', 'ip', 'iptables', 'netstat',
>> into a single tool :).
>
>You always hit me with this point, but what about "netstat -r" and
>"netstat -i". Some things can be done with two different tools, but from
>the kernel side they are all the same.
Sure. Sometimes it makes sense. hcitool dev shows device list for example. 

Max
