Return-Path: <cyrus@holtmann.org>
Message-ID: <1357089591.19248.90.camel@aeonflux>
Subject: Re: [PATCH 2/2] AVCTP: Replace calls to g_queue_free_full function
From: Marcel Holtmann <marcel@holtmann.org>
To: Giovanni Gherdovich <g.gherdovich@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 01 Jan 2013 17:19:51 -0800
In-Reply-To: <1357039308-8913-1-git-send-email-g.gherdovich@gmail.com>
References: <1357039308-8913-1-git-send-email-g.gherdovich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Giovanni,

> The function g_queue_free_full is available only from GLib 2.32.
> If BlueZ has to build against GLib 2.28, as stated in the configure.ac,
> this patch replaces the calls to g_queue_free_full in the AVTCP module
> with its body, taken from the sources of GLib 2.32.
> ---
>  profiles/audio/avctp.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 013c587..745ced8 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -395,7 +395,8 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
>  		g_source_remove(chan->process_id);
>  
>  	g_free(chan->buffer);
> -	g_queue_free_full(chan->queue, pending_destroy);
> +	g_queue_foreach(chan->queue, (GFunc)pending_destroy, NULL);On Tue, 2013-01-01 at 12:21 +0100, Giovanni Gherdovich wrote:

Same here. Provide a proper pending_destroy. The other places can just
call it with NULL as second parameter.

> +	g_queue_free(chan->queue);
>  	g_slist_free_full(chan->processed, pending_destroy);
>  	g_slist_free_full(chan->handlers, g_free);
>  	g_free(chan);

Regards

Marcel


