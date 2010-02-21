Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix double free on AVDTP Abort response
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel =?ISO-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <eb7933e21002210454r4b3805e1pec3f4f58440191bf@mail.gmail.com>
References: <eb7933e21002190820x7b2b0ea3v3f48ce96a5d11a1e@mail.gmail.com>
	 <20100219173257.GA12855@jh-x301>
	 <eb7933e21002210454r4b3805e1pec3f4f58440191bf@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 21 Feb 2010 14:04:09 +0100
Message-ID: <1266757449.18491.17.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> > Please try to at least do a compile check before you submit patches.
> > This one gives the following error:
> > audio/avdtp.c: In function ‘handle_unanswered_req’:
> > audio/avdtp.c:908: error: comparison between pointer and integer
> >
> > What you probably want is session->req->signal_id == AVDTP_ABORT.
> >
> 
> Sorry. The attached patch compiles without warnings on "./configure && make".
> (new dependency to a capabilities lib prevents ./bootstrap-configure atm)

you can use ./bootstrap-configure --disable-capng.

Regards

Marcel


