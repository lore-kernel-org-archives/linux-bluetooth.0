Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 11:51:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v3 2/6] client: fix unreported error case
Message-ID: <20120217095138.GA13492@x220>
References: <1329400834-8400-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1329400834-8400-3-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329400834-8400-3-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Feb 16, 2012, Mikel Astiz wrote:
> @@ -735,17 +735,31 @@ static void session_process_queue(struct obc_session *session)
>  	if (session->queue == NULL || g_queue_is_empty(session->queue))
>  		return;
>  
> +	obc_session_ref(session);
> +
>  	while ((p = g_queue_pop_head(session->queue))) {
>  		int err;
>  
>  		err = pending_request_auth(p);
>  		if (err == 0) {
>  			session->p = p;
> +			obc_session_unref(session);
>  			return;
>  		}

Instead of adding the unref to any place you return in the loop, it'd be
simpler to just do a break; since you've already got the necessary unref
and end of the function right after the loop.

Johan
