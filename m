Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jun 2012 14:00:41 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Ido Yariv <ido@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gattrib: Fix a premature response timer removal
Message-ID: <20120606170041.GB11387@samus>
References: <1338980175-14980-1-git-send-email-ido@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338980175-14980-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ido,

On 13:56 Wed 06 Jun, Ido Yariv wrote:
> A timer is set when a response is expected. The timer is removed when
> data is received, regardless of whether or not the data is a response.
> As a result, the timer may be cleared even though a response was not
> received and there would be no way to detect a command timeout.
> 
> Fix this by clearing the timer only after verifying a response was
> received.

The patch looks good.

Just a little background on how things are done this way. This was
written thinking that when a indication (a request) is received the
timer should be reset, even if there is already a pending response.

So with this patch we trust that BlueZ will send responses in time, and
we only handle timeouts from the remote. Which is a good assumption for
me. At least it is more consistent.

Here's my Ack.

> ---
>  attrib/gattrib.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/attrib/gattrib.c b/attrib/gattrib.c
> index 29c3585..a1e29a1 100644
> --- a/attrib/gattrib.c
> +++ b/attrib/gattrib.c
> @@ -361,11 +361,6 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
>  	if (attrib->stale)
>  		return FALSE;
>  
> -	if (attrib->timeout_watch > 0) {
> -		g_source_remove(attrib->timeout_watch);
> -		attrib->timeout_watch = 0;
> -	}
> -
>  	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
>  		attrib->read_watch = 0;
>  		return FALSE;
> @@ -393,6 +388,11 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
>  	if (is_response(buf[0]) == FALSE)
>  		return TRUE;
>  
> +	if (attrib->timeout_watch > 0) {
> +		g_source_remove(attrib->timeout_watch);
> +		attrib->timeout_watch = 0;
> +	}
> +
>  	cmd = g_queue_pop_head(attrib->requests);
>  	if (cmd == NULL) {
>  		/* Keep the watch if we have events to report */
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
