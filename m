Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification testing.
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001a01c4d7d9$4c61a800$1a01010a@baked>
References: <001a01c4d7d9$4c61a800$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1101929562.15615.23.camel@pegasus>
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
Date: Wed, 01 Dec 2004 20:32:41 +0100

Hi Daryl,

> I got word back on one of the unmentioned bugs and it appears to be a bug in
> the tester. So now there is only one outstanding item. I don't see why this
> is a failure:
> 
> CFD/BV-01:
> Tester sends an l2cap config request in two pieces (using continuation flag)
> to the IUT. The tester expects to see one of two alternatives:
> 
> 1. The IUT includes in the response to each request the requested options.
> 2. The IUT first sends an empty response and in its second response it sends
> all the requested options.
> 
> We currently just send two empty responses. I think an empty response would
> be acceptable if all the requested options were in one request, so I don't
> see why this fails.

do you have a hcidump or another trace for me?

> > to be honest, I am already aware of this problem. I ran into it when I
> > first started to look at the support for L2CAP retransmission and flow
> > control. Our current way of handling the configuration must be changed
> > to deal better with L2CAP 1.2 devices and their features. It 
> > is not that
> > easy to change and my time was too limited for it. However I 
> > am open for
> > any ideas and I am sorry to say that, but your patch looks 
> > like a dirty
> > hack.
> 
> Ah yes, the expected response. ;)  But you are right, it is a bit of a hack.
> As far as I can see it's either going to be a hack or a rewrite of that
> config request handling code. Do you have a better solution?

Not at the moment and maybe not so fast. This needs a little bit more
work.

> Is QoS one of the things you're thinking of?

Actually no. However this might come for free.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
