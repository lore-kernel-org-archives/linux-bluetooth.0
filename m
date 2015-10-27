Return-Path: <cyrus@holtmann.org>
Message-ID: <1445937705.2902.9.camel@linux.intel.com>
Subject: Re: [RFC bluetooth-next 1/2] bluetooth: 6lowpan: avoid endless loop
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth
	 <linux-bluetooth@vger.kernel.org>, kernel@pengutronix.de,
	johan.hedberg@gmail.com
Date: Tue, 27 Oct 2015 11:21:45 +0200
In-Reply-To: <20151025202716.GA6435@omega>
References: <1445698256-10407-1-git-send-email-alex.aring@gmail.com>
	 <1445698256-10407-2-git-send-email-alex.aring@gmail.com>
	 <D10520FE-A8A8-49D9-B6BA-E6682CBCFB42@holtmann.org>
	 <20151025202716.GA6435@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On su, 2015-10-25 at 21:27 +0100, Alexander Aring wrote:
> Hi Marcel,
> 
> On Mon, Oct 26, 2015 at 05:11:37AM +0900, Marcel Holtmann wrote:
> > Hi Alex,
> > 
> > > When -EAGAIN as return value for receive handling will do a retry of
> > > parsing I can trigger a endless loop when iphc decompression e.g.
> > > returns an errno because some missing function "-ENOTSUPP" or something
> > > else. Somebody from outside can trigger an endless loop when sending a
> > > an IPHC header which triggers this behaviour.
> > > 
> > > NOTE: This really depends only if -EAGAIN means "try again to call the
> > > receive handler with the skb". Sometimes we also drop (and kfree) the
> > > skb, I think something is broken there... depends on the error branch.
> > > When receiving failed simple free skb and return errno (which is not
> > > -EAGAIN).
> > 
> > I am lost on this comment, you need to explain this more and might actually want to put a comment in the code on this.
> > 
> 
> I am sorry, what I meant there is "How exactly does the '.recv' of
> 'l2cap_ops'" handle an -EAGAIN errno. If this means the callback will be
> called again with the same parameters (What I am thinking of, when I
> return -EAGAIN) then we have an endless loop which can be triggered from
> the outside by sending an invalid/not supported IPHC 6LoWPAN header.
> Because the function "chan_recv_cb" (which is ".recv") will call
> recv_pkt (which return -EAGAIN on failure) and this function will call
> ret = iphc_decompress(local_skb, dev, chan), which parse the IPHC Header
> (can occur errno on invalid frames), then the complete calling chain
> will return -EAGAIN at ".recv" callback of l2cap_ops". The IPHC header
> comming from the "outside", everybody can manipulate this data.
> 
> Is it more clear now what I try to explained here?
> 
> First look on ".recv" callback handling in "net/bluetooth/l2cap_core.c"
> a return of -EAGAIN, will not try to call the ".recv" callback with the
> same parameters again.

I was trying to follow how the chan->ops->recv() is called in
l2cap_core.c and the code seems to ignore the actual error value. I
might have missed the actual place thou.

Johan/Marcel, you know what the code should return in channel receive
callback. Does it matter what is the error value returned by
chan->ops->recv()?

> 
> Anyway, we should not use -EAGAIN here, or? Simple return the errno from
> function which returns it.
> 
> - Alex


Cheers,
Jukka
