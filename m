Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Sep 2009 10:02:04 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] AVDTP start/stop handling during disconnection
Message-ID: <20090901070204.GA27211@jh-x301>
References: <eb7933e20908270824w2dc3ae2x8257d20d307ce6fd@mail.gmail.com> <2d5a2c100908271008v67bb1b86xa5ad5ef6e95ba49a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2d5a2c100908271008v67bb1b86xa5ad5ef6e95ba49a@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel & Luiz,

On Thu, Aug 27, 2009, Luiz Augusto von Dentz wrote:
> On Thu, Aug 27, 2009 at 12:24 PM, Daniel
> Örstadius<daniel.orstadius@gmail.com> wrote:
> > A suggested patch for rejecting AVDTP CLOSE and START requests when a
> > CLOSE request has been initiated. The check is done by testing the
> > close_int flag in the avdtp_stream struct. The flag is reset when
> > receiving a timeout or rejection from the remote.
> >
> > Changes in unix.c were made to call avdtp_unref() in case an AVDTP
> > session was marked by avdtp_ref(), but no SEP was found. This could
> > happen if START is called on a session being disconnected.
> >
> > We found that these changes help to improve behavior both in case the
> > audio streaming application tries to start the stream during a
> > disconnection procedure, and if avdtp_close() is called twice.
> 
> It probably works better if you place it on avdtp struct so it works
> even if we don't have a stream configured,

But a stream can't be in OPEN state if it hasn't been configured (i.e. we
have a stream struct for it). So this part of the patch looks good to me.

> I also prefer closing instead of close_int.

That would have a different meaning though. To me closing means we're
closing but doesn't say anything about who initiated the close. close_int
otoh tells us that we initiated the close. Also, since this variable
already exists and is needed I think reusing it is fine.

So Daniel, could you split out the first part of your patch and resend it?
Thanks.

Johan
