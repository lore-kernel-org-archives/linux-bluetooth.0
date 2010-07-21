Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Jul 2010 13:19:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Manuel Naranjo <manuel@aircable.net>
Cc: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH][RFC] Fix SDP resolving segfault
Message-ID: <20100721101934.GA12188@jh-x301>
References: <4C46324D.5070800@aircable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C46324D.5070800@aircable.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Manuel,

On Tue, Jul 20, 2010, Manuel Naranjo wrote:
> I think this patch fixes the weird segfault I had been experiencing
> for the last few months.

Thanks for the patch proposal. It seems like you're trying to to fix the
issue by doing all sorts of minor tweaks here and there, i.e. it seems
like there isn't a full understanding of the real root cause.

> -	if (ctxt->cb)
> +	if (ctxt->cb && ctxt->user_data)
>  		ctxt->cb(recs, err, ctxt->user_data);

This part isn't right. It should be perfectly fine for a discovery
requester to pass NULL as user_data and still expect its callback to get
called.

> -		if (ctxt->cb)
> +		if (ctxt->cb && ctxt->user_data)
>  			ctxt->cb(NULL, err, ctxt->user_data);

Same here.

> @@ -254,6 +256,8 @@ static gboolean connect_watch(GIOChannel *chan, GIOCondition cond, gpointer user
>  	int sk, err = 0;
>  
>  	sk = g_io_channel_unix_get_fd(chan);
> +	if (ctxt->io_id)
> +	    g_source_remove(ctxt->io_id);

connect_watch returns FALSE in all cases which will remove the GSource.
So the change you're doing seems redundant.

> -	if (ctxt->cb)
> +	if (ctxt->cb && ctxt->user_data)
>  		ctxt->cb(NULL, -err, ctxt->user_data);

Same issue with NULL user_data being valid.

> @@ -391,11 +395,13 @@ int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst)
>  		return -ENODATA;
>  
>  	ctxt = match->data;
> -	if (!ctxt->session)
> -		return -ENOTCONN;
>  
>  	if (ctxt->io_id)
>  		g_source_remove(ctxt->io_id);
> +	ctxt->io_id = 0;
> +
> +	if (!ctxt->session)
> +		return -ENOTCONN;
>  
>  	if (ctxt->session)
>  		sdp_close(ctxt->session);

I don't really understand the need for these changes, but admitedly the
function does have issues since it first checks for !ctxt->session and
then later for ctxt->session even though at that point it's already
guaranteed that ctxt->session is not NULL.

Johan
