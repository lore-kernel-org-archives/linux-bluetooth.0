Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 May 2012 23:40:58 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Ido Yariv <ido@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] gattrib: Fix a request/response command deadlock
Message-ID: <20120529024058.GA2382@echo>
References: <20120529011624.GA31806@WorkStation.localnet>
 <1338254446-32725-1-git-send-email-ido@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338254446-32725-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ido,

On 04:20 Tue 29 May, Ido Yariv wrote:
> New requests and responses are never sent if a request was sent and the
> response for it hasn't been received yet. As a result, if both end
> points send requests at the same time, a deadlock could occur. This
> could happen, for instance, if the client sends a read request and the
> server sends an indication before responding to the read request.
> 
> Fix this by introducing an additional queue for responses. Responses may
> be sent while there's still a pending request/indication.
> ---
>  attrib/gattrib.c |  107 ++++++++++++++++++++++++++++++++++++++++++------------
>  1 files changed, 83 insertions(+), 24 deletions(-)
> 
> diff --git a/attrib/gattrib.c b/attrib/gattrib.c
> index 769be36..71c94d8 100644
> --- a/attrib/gattrib.c
> +++ b/attrib/gattrib.c

[snip]

> @@ -504,12 +554,21 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
>  
>  	if (head) {
>  		/* ... and put it back in the queue */
> -		g_queue_push_head(attrib->queue, head);
> +		g_queue_push_head(queue, head);
>  	}
>  
>  	return TRUE;
>  }
>  
> +gboolean g_attrib_cancel_all(GAttrib *attrib)
> +{
> +	if (attrib == NULL)
> +		return FALSE;
> +
> +	return cancel_all_per_queue(attrib->requests) &&
> +		cancel_all_per_queue(attrib->responses);

Sorry, but I just noticed something, even if it's very unlikely that it would
happen in practice: if attrib->requests is NULL, it wouldn't cancel the
responses.

> +}
> +
>  gboolean g_attrib_set_debug(GAttrib *attrib,
>  		GAttribDebugFunc func, gpointer user_data)
>  {
> -- 
> 1.7.7.6
> 

Cheers,
-- 
Vinicius
