Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <56CE5C6D2B8C7844B3FD6D5DDA55523D3E8FFE6371@EMEXM3125.dir.svc.accenture.com>
References: <56CE5C6D2B8C7844B3FD6D5DDA55523D3E8FFE6371@EMEXM3125.dir.svc.accenture.com>
Date: Wed, 15 Jun 2011 14:21:56 +0100
Message-ID: <BANLkTinfF-+_peRhJ8wGZBpV=u3V3Bt+xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: FTP and OPP over L2CAP
From: =?ISO-8859-1?Q?Piotr_Zg=F3recki?= <pzgorecki@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Tim, Marcel,

> > +enum obex_transport_format{
> > +      OBEX_MT_STREAM ,
> > +      OBEX_MT_SEQPACKET
> > +};
> > +
> > And more important, I have no idea why are you doing this anyway. Even
> > with L2CAP this should run over SOCK_STREAM.
>
> Is that really so?  I expect exposing L2CAP ERTM as a stream could break protocols above that expect datagram-boundary preservation (eg RTP).  Or can break protocols that mandate that only one higher-layer packet exists in each L2CAP SDU.  For these the socket needs to be packet based.
>
> So, my surprise is that ERTM is exposed as SOCK_STREAM.  So I do have an idea why the patch mentions sequenced packet...

>From the Core Specification, Vol. 3, Part A, Pt. 7.3 Encapsulation of SDUs:
"It is assumed that SDU boundaries shall be preserved between peer
upper layer entities."

SDU is by definition an abstraction exposed to the upper layer. This
assumption permeates all of Bluetooth and breaking it can have dire
consequences for profiles assuming their messages map 1:1 to SDUs.
That's obviously assuming that using SOCK_STREAM breaks this
assumption :)

Cheers,
Piotr
