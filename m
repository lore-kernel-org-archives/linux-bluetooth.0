Return-Path: <cyrus@holtmann.org>
From: "Gregory M. Turner" <gmt@be-evil.net>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] bluetooth/l2cap: silence framedrop kmsg noise
Date: Mon, 23 Feb 2015 16:31:54 -0800
Message-ID: <10888960.rEuGP2Y2Ro@moneypit>
In-Reply-To: <99FAFB7A-43DF-47DF-B6B1-D62311227073@holtmann.org>
References: <1832240.mNuY6LIF5L@moneypit> <1619328.sIzMdT7lV0@moneypit> <99FAFB7A-43DF-47DF-B6B1-D62311227073@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 23 February 2015 13:18:39 Marcel Holtmann wrote:
> So I am fine adding a patch that rate limits it.

While I'm at it, I'd might as well go whole-hog and implement 
BT_*_RATELIMITED, no?  Since, obviously, 50 lines of elegant 90% untested code 
is way better than two lines of ugly 100% tested code* :)

To that end, I notice bt_{err,info} are exports in lib.c, while the rest are 
macros.  I'm trying to determine how tragic and/or useful it would be if those 
symbols proliferated into bt_{err,info}{,_ratelimited}.

"git blame" suggests they are object-file-size optimizations and therefore, 
there is probably no good reason not to just make them macros -- since there 
will only be the single consumer.

Any objections out there?

-
* Just kidding, sort of -- I'd at least make sure they work, by means of some 
ugly offline experiment.

-gmt
