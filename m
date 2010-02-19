Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Feb 2010 14:32:58 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix double free on AVDTP Abort response
Message-ID: <20100219173257.GA12855@jh-x301>
References: <eb7933e21002190820x7b2b0ea3v3f48ce96a5d11a1e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <eb7933e21002190820x7b2b0ea3v3f48ce96a5d11a1e@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Fri, Feb 19, 2010, Daniel Örstadius wrote:
> +	if (session->req == AVDTP_ABORT) {
> +		/* Avoid freeing the Abort request here */
> +		debug("handle_unanswered_req: Abort req, returning");
> +		session->req->stream = NULL;
> +		return;
> +	}

Please try to at least do a compile check before you submit patches.
This one gives the following error:
audio/avdtp.c: In function ‘handle_unanswered_req’:
audio/avdtp.c:908: error: comparison between pointer and integer

What you probably want is session->req->signal_id == AVDTP_ABORT.

Johan
