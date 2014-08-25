Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] android/health: Cache MDL file desciptor
Date: Mon, 25 Aug 2014 11:56:48 +0200
Message-ID: <1520077.kvNWHOJ9O5@uw000953>
In-Reply-To: <1408698607-23815-3-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1408698607-23815-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1408698607-23815-3-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 22 of August 2014 12:10:07 Ravi kumar Veeramally wrote:
> PTS expects to close all data channels before sending delete confirmation
> to peer. But file descriptor passed over IPC to hal needs to be closed.
> Due to timing issue IPC notification is triggering after sending
> confirmation. So cache fd and shutdown on channel free will solve the issue.
> ---
>  android/health.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/android/health.c b/android/health.c
> index f49110a..29c1d15 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -102,6 +102,7 @@ struct health_channel {
>  	struct mcap_mdl *mdl;
>  	bool mdl_conn;
>  	uint16_t mdl_id; /* MDL ID */
> +	int fd;
>  
>  	uint16_t id; /* channel id */
>  };
> @@ -168,6 +169,9 @@ static void free_health_channel(void *data)
>  	if (!channel)
>  		return;
>  
> +	if (channel->fd >= 0)
> +		shutdown(channel->fd, SHUT_RDWR);

Shouldn't channel->fd be closed here as well? (I think in what we have in
git now we also miss closing after sending fd over IPC, but that would not
matter if we cache fd with this patch.)

Also I think fd should be closed for echo scenario ie by setting
close_on_unref flag in glib io?

Thoughts?

> +
>  	unref_mdl(channel);
>  	free(channel);
>  }
> @@ -1234,6 +1238,7 @@ static void mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
>  	}
>  
>  	info("health: MDL connected");
> +	channel->fd = fd;
>  	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_CONNECTED, fd);
>  
>  	return;
> @@ -1357,6 +1362,7 @@ static struct health_channel *create_channel(struct health_app *app,
>  	channel->type = mdep->channel_type;
>  	channel->id = channel_id++;
>  	channel->dev = dev;
> +	channel->fd = -1;
>  
>  	if (!queue_push_tail(dev->channels, channel)) {
>  		free_health_channel(channel);
> @@ -1547,6 +1553,7 @@ static void connect_mdl_cb(struct mcap_mdl *mdl, GError *gerr, gpointer data)
>  		if (channel->type != CHANNEL_TYPE_RELIABLE)
>  			goto fail;
>  
> +	channel->fd = fd;
>  	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_CONNECTED, fd);
>  
>  	return;
> 

-- 
Best regards, 
Szymon Janc
