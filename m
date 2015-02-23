Return-Path: <cyrus@holtmann.org>
From: "Gregory M. Turner" <gmt@be-evil.net>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] bluetooth/l2cap: silence framedrop kmsg noise
Date: Mon, 23 Feb 2015 14:49:10 -0800
Message-ID: <1865806.xiolTP0vU5@moneypit>
In-Reply-To: <99FAFB7A-43DF-47DF-B6B1-D62311227073@holtmann.org>
References: <1832240.mNuY6LIF5L@moneypit> <1619328.sIzMdT7lV0@moneypit> <99FAFB7A-43DF-47DF-B6B1-D62311227073@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 23 February 2015 13:18:39 Marcel Holtmann wrote:
> Hi Greg,
[snip]
> the problem is that the controller tells us that this is continuation
> fragment with zero length. Meaning that there has to be a start packet in
> the first place. That one seems to never happen or it gets out of sync at
> some point.
>
> If you say that whenever you use the controller, you see this behavior, then
> it sounds like a problem with the controller. So maybe investing in a 10
> USD dongle from China would help.

undoubtedly.

[snip]
> If this is on purpose, then I can not figure out why it would be. It makes
> no sense to me and since Bluetooth is a rather old technology these days,
> this would have come up more often.

My suspicion is that the dongle (which is almost as old as bluetooth 2.1+EDR, 
which IIRC it supports) mostly works but misbehaves.  If it was more widely 
deployed, and if these things didn't cost $10

> We should rate limit the error message, but we should not suppress it
> completely. So I am fine adding a patch that rate limits it.
> 
> Sniffing the air traffic and USB HCI traffic comes with a 40k EUR price
> point.

Holy crap-hole, are you serious?  I'm a bit surprised.  I was hoping I could 
just cross-compile bluez and be off to the races.  Oh well, at least this means 
I have little cause to worry that the neighbors are spying on my phone calls 
:)

I guess this must be because it's much harder for a sniffer to figure out the 
channel hop timings negotiated between two devices than to negotiate the that 
timing directly with another device that's playing nice with you?

> So I would go for a new dongle and throw this in a trashcan ;)

I probably should have done this ages ago anyhow.  I'll send a rate-limiting 
patch.

-gmt
