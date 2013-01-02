Return-Path: <cyrus@holtmann.org>
Message-ID: <1357164610.19248.94.camel@aeonflux>
Subject: Re: [PATCH 2/2] AVCTP: Replace calls to g_queue_free_full function
From: Marcel Holtmann <marcel@holtmann.org>
To: Giovanni Gherdovich <g.gherdovich@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 02 Jan 2013 14:10:10 -0800
In-Reply-To: <1357162350-14253-1-git-send-email-g.gherdovich@gmail.com>
References: <1357162350-14253-1-git-send-email-g.gherdovich@gmail.com>
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
>  profiles/audio/avctp.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 013c587..7a5a096 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -383,6 +383,15 @@ static void pending_destroy(void *data)
>  	g_free(req);
>  }
>  
> +static void pending_destroy_wrapper(void *data, void *dummy)
> +{
> +	/*
> +	 * Wrapper around pending_destroy to match the signature
> +	 * required for the second argument of g_queue_foreach.
> +	 */
> +        pending_destroy(data);
> +}
> +

change pending_destroy() to this:

	static void pending_destroy(gpointer data, gpointer user_data)
	{
		...
	}

And then fix the callers to add an extra NULL.

>  static void avctp_channel_destroy(struct avctp_channel *chan)
>  {
>  	g_io_channel_shutdown(chan->io, TRUE, NULL);
> @@ -395,7 +404,8 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
>  		g_source_remove(chan->process_id);
>  
>  	g_free(chan->buffer);
> -	g_queue_free_full(chan->queue, pending_destroy);
> +	g_queue_foreach(chan->queue, pending_destroy_wrapper, NULL);
> +	g_queue_free(chan->queue);
>  	g_slist_free_full(chan->processed, pending_destroy);
>  	g_slist_free_full(chan->handlers, g_free);
>  	g_free(chan);

Regards

Marcel


