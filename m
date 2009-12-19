Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Dec 2009 09:46:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Nick Pelly <npelly@google.com>, linux-bluetooth@vger.kernel.org
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL
 packets  with L2CAP_LM_RELIABLE
Message-ID: <20091219074622.GA27738@jh-x301>
References: <35c90d960912161359u2b3f9b2fi875288896a7a8478@mail.gmail.com>
 <1261006596.4041.39.camel@localhost.localdomain>
 <35c90d960912161548p6cdcc1f0i7d74b31a4bc145b6@mail.gmail.com>
 <1261177540.4041.106.camel@localhost.localdomain>
 <35c90d960912181523n1067f87cw1d585a17ba57475a@mail.gmail.com>
 <1261180228.4041.111.camel@localhost.localdomain>
 <35c90d960912181612x494c5626r8cd01168e4991e7@mail.gmail.com>
 <1261182368.4041.114.camel@localhost.localdomain>
 <35c90d960912181750g6f82c3c1tf89df6aec2ae97cf@mail.gmail.com>
 <1261188322.4041.127.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1261188322.4041.127.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 18, 2009, Marcel Holtmann wrote:
> > > are you expecting to change this frequently and from different parts of
> > > the code during the lifetime of a socket. I just don't see that
> > > happening at all actually. Either you create a "flushable" socket or you
> > > don't. Fill me in on how you wanna actually use this feature.
> > 
> > My use case is just for A2DP. I turn on flushing with a timeout of say
> > 160ms just before starting streaming of A2DP data, and turn it off
> > when I finish. This is not a problem with either API proposal.
> 
> I count this as creating socket, setting flushable and then using it.
> Then closing it. And especially in A2DP case where the media socket is
> brought up and taken down a lot that is a proper usage. However I do
> expect that each socket should not change from flushable to
> non-flushable in mid term usage. While potentially possible it don't see
> its usage at all.

I hope you remember that the A2DP media transport socket is kept open
much longer periods than e.g. the SCO socket in HFP/HSP since suspending
an A2DP stream only means stopping sending data but still keeping the
media socket open. Only when the configured codec parameters aren't
suitable for the audio data would you close, reconfigure and recreate
the media socket. So is it ok to keep the flushable setting even while
the A2DP stream is suspended?

Johan
