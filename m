Return-Path: <cyrus@holtmann.org>
Date: Sun, 25 Oct 2015 21:27:21 +0100
From: Alexander Aring <alex.aring@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	kernel@pengutronix.de,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>
Subject: Re: [RFC bluetooth-next 1/2] bluetooth: 6lowpan: avoid endless loop
Message-ID: <20151025202716.GA6435@omega>
References: <1445698256-10407-1-git-send-email-alex.aring@gmail.com>
 <1445698256-10407-2-git-send-email-alex.aring@gmail.com>
 <D10520FE-A8A8-49D9-B6BA-E6682CBCFB42@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <D10520FE-A8A8-49D9-B6BA-E6682CBCFB42@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 26, 2015 at 05:11:37AM +0900, Marcel Holtmann wrote:
> Hi Alex,
> 
> > When -EAGAIN as return value for receive handling will do a retry of
> > parsing I can trigger a endless loop when iphc decompression e.g.
> > returns an errno because some missing function "-ENOTSUPP" or something
> > else. Somebody from outside can trigger an endless loop when sending a
> > an IPHC header which triggers this behaviour.
> > 
> > NOTE: This really depends only if -EAGAIN means "try again to call the
> > receive handler with the skb". Sometimes we also drop (and kfree) the
> > skb, I think something is broken there... depends on the error branch.
> > When receiving failed simple free skb and return errno (which is not
> > -EAGAIN).
> 
> I am lost on this comment, you need to explain this more and might actually want to put a comment in the code on this.
> 

I am sorry, what I meant there is "How exactly does the '.recv' of
'l2cap_ops'" handle an -EAGAIN errno. If this means the callback will be
called again with the same parameters (What I am thinking of, when I
return -EAGAIN) then we have an endless loop which can be triggered from
the outside by sending an invalid/not supported IPHC 6LoWPAN header.
Because the function "chan_recv_cb" (which is ".recv") will call
recv_pkt (which return -EAGAIN on failure) and this function will call
ret = iphc_decompress(local_skb, dev, chan), which parse the IPHC Header
(can occur errno on invalid frames), then the complete calling chain
will return -EAGAIN at ".recv" callback of l2cap_ops". The IPHC header
comming from the "outside", everybody can manipulate this data.

Is it more clear now what I try to explained here?

First look on ".recv" callback handling in "net/bluetooth/l2cap_core.c"
a return of -EAGAIN, will not try to call the ".recv" callback with the
same parameters again.

Anyway, we should not use -EAGAIN here, or? Simple return the errno from
function which returns it.

- Alex
