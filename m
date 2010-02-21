Return-Path: <cyrus@holtmann.org>
Date: Sun, 21 Feb 2010 10:46:55 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix double free on AVDTP Abort response
Message-ID: <20100221134631.GA25639@jh-x301>
References: <eb7933e21002190820x7b2b0ea3v3f48ce96a5d11a1e@mail.gmail.com>
 <20100219173257.GA12855@jh-x301>
 <eb7933e21002210454r4b3805e1pec3f4f58440191bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <eb7933e21002210454r4b3805e1pec3f4f58440191bf@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Sun, Feb 21, 2010, Daniel Örstadius wrote:
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

You can avoid that with "./bootstrap-configure --disable-capng"

> The pending request might be freed twice when receiving an Abort
> response, in handle_unanswered_req and session_cb. Avoid freeing
> it in handle_unanswered_req.
> ---
>  audio/avdtp.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)

Thanks, the patch is now upstream.

Johan
