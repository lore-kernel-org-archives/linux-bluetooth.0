Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH 2/2] Bluetooth:  FTP and OPP over L2CAP
From: Marcel Holtmann <marcel@holtmann.org>
To: tim.howes@accenture.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 15 Jun 2011 07:21:24 -0700
In-Reply-To: <1AFE20D16950C745A2A83986B72E87480132148C3622@EMEXM3131.dir.svc.accenture.com>
References: <1308110046-5704-1-git-send-email-nami.li@atheros.com>
	 <1308136632.2518.11.camel@aeonflux>
	 <1AFE20D16950C745A2A83986B72E87480132148C3622@EMEXM3131.dir.svc.accenture.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308147687.2196.3.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

> > +enum obex_transport_format{
> > +      OBEX_MT_STREAM ,
> > +      OBEX_MT_SEQPACKET
> > +};
> > +
> > And more important, I have no idea why are you doing this anyway. Even
> > with L2CAP this should run over SOCK_STREAM.
> 
> Is that really so?  I expect exposing L2CAP ERTM as a stream could break protocols above that expect datagram-boundary preservation (eg RTP).  Or can break protocols that mandate that only one higher-layer packet exists in each L2CAP SDU.  For these the socket needs to be packet based.
> 
> So, my surprise is that ERTM is exposed as SOCK_STREAM.  So I do have an idea why the patch mentions sequenced packet...

you can do both for ERTM actually. You can create SOCK_SEQPACKET and
have it negotiate ERTM. However you can not run SOCK_STREAM on a Basic
Mode connection.

But the real benefit for higher layer protocols is if you become a
SOCK_STREAM. Because you are MTU free now. Using SOCK_SEQPACKET with
ERTM or Basic Mode is not really much of a difference.

Especially with OBEX that has its own MTU anyway in the first place has
always been run on SOCK_STREAM so far, what is the different that you
expect by running it of SOCK_SEQPACKET with ERTM?

Regards

Marcel


