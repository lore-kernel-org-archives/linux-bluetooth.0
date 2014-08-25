Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] android/health: Call MDL shutdown after mdl_deleted_cb callback
Date: Mon, 25 Aug 2014 11:49:01 +0200
Message-ID: <1711265.HQivQYrQOI@uw000953>
In-Reply-To: <1408698607-23815-2-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1408698607-23815-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1408698607-23815-2-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 22 of August 2014 12:10:06 Ravi kumar Veeramally wrote:
> Shutdown_mdl shutdown io channels and unrefs it. After that related
> callbacks will shutdown or close and free its data. Due to timing
> issue process_md_delete_mdl_req send delete confirmation response to
> peer before properly shutting down all opened data channels.
> ---
>  android/health.c   | 25 ++++---------------------
>  android/mcap-lib.c |  6 ++----
>  2 files changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/android/health.c b/android/health.c
> index ee6c11b..f49110a 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1254,34 +1254,17 @@ static void mcap_mdl_closed_cb(struct mcap_mdl *mdl, void *data)
>  	channel->mdl_conn = false;
>  }
>  
> -static void notify_channel(void *data, void *user_data)
> -{
> -	struct health_channel *channel = data;
> -
> -	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_DESTROYED, -1);
> -}
> -
>  static void mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
>  {
> -	struct health_channel *channel = data;
> -	struct health_device *dev;
> -
> -	if (!channel)
> -		return;
> -
> -	dev = channel->dev;
> +	struct health_channel *channel;
>  
> -	DBG("device %p channel %p mdl %p", dev, channel, mdl);
>  	info("health: MDL deleted");
>  
> -	/* mdl == NULL means, delete all mdls */
> -	if (!mdl) {
> -		queue_foreach(dev->channels, notify_channel, NULL);
> -		queue_remove_all(dev->channels, NULL, NULL,
> -						free_health_channel);
> +	channel = search_channel_by_mdl(mdl);
> +	if (!channel)
>  		return;
> -	}
>  
> +	DBG("channel %p mdl %p", channel, mdl);
>  	destroy_channel(channel);
>  }
>  
> diff --git a/android/mcap-lib.c b/android/mcap-lib.c
> index f208fac..1706d9f 100644
> --- a/android/mcap-lib.c
> +++ b/android/mcap-lib.c
> @@ -1007,10 +1007,10 @@ static void mcap_del_mdl(gpointer elem, gpointer user_data)
>  	struct mcap_mdl *mdl = elem;
>  	gboolean notify = *(gboolean *) user_data;
>  
> -	shutdown_mdl(mdl);
>  	if (notify)
>  		mdl->mcl->cb->mdl_deleted(mdl, mdl->mcl->cb->user_data);
>  
> +	shutdown_mdl(mdl);
>  	mcap_mdl_unref(mdl);
>  }
>  
> @@ -1231,13 +1231,11 @@ static void process_md_delete_mdl_req(struct mcap_mcl *mcl, void *cmd,
>  	req = cmd;
>  	mdlid = ntohs(req->mdl);
>  	if (mdlid == MCAP_ALL_MDLIDS) {
> -		notify = FALSE;
> +		notify = TRUE;
>  		g_slist_foreach(mcl->mdls, mcap_del_mdl, &notify);
>  		g_slist_free(mcl->mdls);
>  		mcl->mdls = NULL;
>  		mcl->state = MCL_CONNECTED;
> -		/* NULL mdl means ALL_MDLS */
> -		mcl->cb->mdl_deleted(NULL, mcl->cb->user_data);
>  		goto resp;
>  	}
>  
> 

Applied. Thanks.

-- 
Best regards, 
Szymon Janc
