Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 10:37:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ido Yariv <ido@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib-server: Fix multiple channels detaching mix-up
Message-ID: <20120530073701.GB6539@x220>
References: <1338322808-15503-1-git-send-email-ido@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338322808-15503-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ido,

On Tue, May 29, 2012, Ido Yariv wrote:
> The identifier returned by g_attrib_register is not unique across
> different channels. Since attrib_channel_detach assumes this identifier
> to be unique, it may end up detaching the wrong channel when a device
> disconnects.
> 
> Fix this by using the channel's pointer as a unique identifier for
> detaching the channel. The identifier returned from g_attrib_register
> will still be used to find the relevant event structure.
> ---
>  src/attrib-server.c |   22 +++++++---------------
>  1 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index dd1bba4..39085de 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -72,7 +72,7 @@ struct gatt_channel {
>  	GAttrib *attrib;
>  	guint mtu;
>  	gboolean le;
> -	guint id;
> +	guint event_id;
>  	gboolean encrypted;
>  	struct gatt_server *server;
>  	guint cleanup_id;
> @@ -1077,8 +1077,8 @@ guint attrib_channel_attach(GAttrib *attrib)
>  
>  
>  	channel->attrib = g_attrib_ref(attrib);
> -	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
> -					channel_handler, channel, NULL);
> +	channel->event_id = g_attrib_register(channel->attrib, GATTRIB_ALL_REQS,
> +						channel_handler, channel, NULL);
>  
>  	channel->cleanup_id = g_io_add_watch(io, G_IO_HUP, channel_watch_cb,
>  								channel);
> @@ -1087,15 +1087,7 @@ guint attrib_channel_attach(GAttrib *attrib)
>  
>  	server->clients = g_slist_append(server->clients, channel);
>  
> -	return channel->id;
> -}
> -
> -static gint channel_id_cmp(gconstpointer data, gconstpointer user_data)
> -{
> -	const struct gatt_channel *channel = data;
> -	guint id = GPOINTER_TO_UINT(user_data);
> -
> -	return channel->id - id;
> +	return GPOINTER_TO_UINT(channel);

I don't think converting a pointer to uint is safe since some systems
can have 64-bit pointers but 32-bit uints. These macros are therefore
only safe to be used in the other direction, i.e. when starting off with
an uint and passing it to an API that expects a pointer.

Johan
