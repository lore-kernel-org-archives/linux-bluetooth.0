Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP dropping packets on BlueZ based receiver
From: Marcel Holtmann <marcel@holtmann.org>
To: Till Harbaum <harbaum@beecon.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200408031416.46803.harbaum@beecon.de>
References: <200408021859.44496.harbaum@beecon.de>
	 <200408031223.11789.harbaum@beecon.de> <1091532252.4259.38.camel@pegasus>
	 <200408031416.46803.harbaum@beecon.de>
Content-Type: text/plain
Message-Id: <1091538562.4259.77.camel@pegasus>
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
Date: Tue, 03 Aug 2004 15:09:22 +0200

Hi Till,

> > this. We only have to take care of that we don't get more packets than
> > our receive buffers can take. So the RFCOMM flow control should be
> But this means, that rfcomm has to know about the socket buffers and will have 
> to make sure, that it won't give more credits than socket buffers are 
> available.

the point is that we don't really thought about it when we were writing
our RFCOMM layer. It worked out, but I never checked the granted credits
against the receive buffer. Sounds like a work for a diploma thesis ;)

> In fact i always wondered what the purpose of rfcomm giving credits on packets 
> not on bytes is. But with such an implementation this even makes sense 
> (although i still think, that these per-packet-credits are an as bad idea as 
> keeping the header checksum behind the rfcomm payload is ...).

The checksum stuff is historical and you will only get the sense behind
it if you read the full ETSI specification that RFCOMM is based on. In
case of Bluetooth it makes no sense and costs only performance. They
left so much out that it would have been better if they designed a new
protocol for serial port emulation.

> > enought to assure this. In general this is a big design mistake in the
> > Bluetooth protocol stack itself and only L2CAP with retransmission and
> > flow control can fix it.
> Yes, you are right.
> 
> Wouldn't it be a good idea to use acl flow control at least as long as there's 
> only one acl client? This would at least increase the reliability for single 
> connection scenarios which are probably the most common case.
> 
> This has the disadvantage, that the system behaves differently with single 
> connections and with multiple connections. For multiple acl connections it's 
> exactly as unrealiable as it is today, but it gives a little advantage to 
> single acl connections.

It won't work out in any case. If you have one ACL link and two L2CAP
channels (for HIDP, HCRP or AVDTP this is normal) then one of them can
suspend the other one, because they share the same ACL link and thus
they share the same flow control. This can't work.

The first time I realized why people asking for host to host controller
flow control (BlueZ don't supports it btw) I screamed out loud. Then I
tried to convince them that it is always a bad idea, but they still
wanted it and these people are still thinking that it is a good idea. In
the long run all of them must accept that it is not possible to use the
flow control of a lower layer for its own purpose. Implementation
details must reside inside the layer. This is one of the basics of the
OSI model.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
