Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP retransmission, flow control
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1107940961.9489.32.camel@mammoth.research.nokia.com>
References: <1107934854.9489.4.camel@mammoth.research.nokia.com>
	 <1107938887.13863.4.camel@pegasus>
	 <1107940961.9489.32.camel@mammoth.research.nokia.com>
Content-Type: text/plain
Message-Id: <1107944306.13863.15.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 09 Feb 2005 11:18:26 +0100

Hi Imre,

> > Feel free to start. I am happy to get L2CAP 1.2 support included. The
> 
> Ok, we'll have already some basic stuff to support the new config
> options, I'll start then to implement the rest. L2CAP QoS could also be
> done at some point, for the moment I don't plan to add support to
> anything but 'best effort'.

don't worry too much about QoS at the moment.

> > L2CAP options now contain a mode value and this is exactly for this
> > purpose. Let the rest of the RFC config values be the defaults from the
> > specification by now. Another way to activate RFC would be to use the
> > SOCK_STREAM socket type.
> > 
> 
> Yes, I agree. Is it ok then to do the following?
> 
> For SOCK_STREAM try to negotiate RFC, if peer doesn't accept use basic
> mode.

If SOCK_STREAM is requested and RFC negotiation fails, then also the
connection must fail. For SOCK_STREAM you need flow control.

> For SOCK_DGRAM, SOCK_RAW try to negotiate FC, if  peer doesn't accept
> use basic mode.

For SOCK_DGRAM and SOCK_RAW we don't do anything. The SOCK_DGRAM is for
connection-less channels and SOCK_RAW gives access to the signal channel
itself.

If you use SOCK_SEQPACKET (current type) and mode > 0 then negotiate RFC
and if success then use it, otherwise fail.

> Other issues I was thinking about:
> 
> The 1.2 spec says it's possible for L2CAP to send incorrect packets
> (with missing fragments) to upper layers with indication of the
> incorrect parts of the given packet. The only possiblity I found so far,
> is to signal that L2CAP reliability can't be guaranteed any more and
> drop the packet.
> Is there a way or is there a case at all where we should support
> applications that need such incorrect packets?

I think it is bad idea to support this and we don't really need it. This
interaction between different layers is useless from my point.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
