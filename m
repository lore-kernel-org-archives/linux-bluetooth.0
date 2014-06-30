Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/5] android/health: Implement MDL reconnection from remote device
Date: Mon, 30 Jun 2014 18:36:55 +0200
Message-ID: <1911162.pGpMQERvKR@uw000953>
In-Reply-To: <1404142314-20795-5-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1404142314-20795-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1404142314-20795-5-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Monday 30 of June 2014 18:31:53 Ravi kumar Veeramally wrote:
> ---
>  android/health.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 0327542..b77ab4e 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -235,6 +235,14 @@ static void free_health_app(void *data)
>  	free(app);
>  }
>  
> +static bool match_channel_by_mdl(const void *data, const void *user_data)
> +{
> +	const struct health_channel *channel = data;
> +	const struct mcap_mdl *mdl = user_data;
> +
> +	return channel->mdl == mdl;
> +}
> +
>  static bool match_channel_by_id(const void *data, const void *user_data)
>  {
>  	const struct health_channel *channel = data;
> @@ -298,6 +306,7 @@ static bool match_app_by_id(const void *data, const void *user_data)
>   */
>  struct channel_search {
>  	uint16_t channel_id;
> +	struct mcap_mdl *mdl;
>  	struct health_channel *channel;
>  };
>  
> @@ -309,8 +318,13 @@ static void device_search_channel(void *data, void *user_data)
>  	if (search->channel)
>  		return;
>  
> -	search->channel = queue_find(dev->channels, match_channel_by_id,
> +	if (search->channel_id)
> +		search->channel = queue_find(dev->channels, match_channel_by_id,
>  						INT_TO_PTR(search->channel_id));
> +	else if (search->mdl)
> +		search->channel = queue_find(dev->channels,
> +						match_channel_by_mdl,
> +						search->mdl);
>  }
>  
>  static void app_search_channel(void *data, void *user_data)
> @@ -331,6 +345,21 @@ static struct health_channel *search_channel_by_id(uint16_t id)
>  	DBG("");
>  
>  	search.channel_id = id;
> +	search.mdl = NULL;
> +	search.channel = NULL;
> +	queue_foreach(apps, app_search_channel, &search);
> +
> +	return search.channel;
> +}
> +
> +static struct health_channel *search_channel_by_mdl(struct mcap_mdl *mdl)
> +{
> +	struct channel_search search;
> +
> +	DBG("");
> +
> +	search.channel_id = 0;
> +	search.mdl = mdl;
>  	search.channel = NULL;
>  	queue_foreach(apps, app_search_channel, &search);
>  
> @@ -1176,11 +1205,14 @@ static void mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
>  	struct health_channel *channel = data;
>  	int fd;
>  
> +	DBG("Data channel connected: mdl %p channel %p", mdl, channel);
> +
> +	if (!channel)
> +		channel = search_channel_by_mdl(mdl);
> +

This can return NULL if matching channel is not found.

>  	if (!channel->mdl)
>  		channel->mdl = mcap_mdl_ref(mdl);
>  
> -	DBG("Data channel connected: mdl %p channel %p", mdl, channel);
> -
>  	fd = mcap_mdl_get_fd(channel->mdl);
>  	if (fd < 0) {
>  		error("health: error retrieving fd");
> @@ -1475,7 +1507,23 @@ static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
>  
>  static uint8_t mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
>  {
> -	DBG("Not Implemeneted");
> +	struct health_channel *channel;
> +	GError *err = NULL;
> +
> +	DBG("");
> +
> +	channel = search_channel_by_mdl(mdl);
> +	if (!channel) {
> +		error("health: channel data does not exist");
> +		return MCAP_UNSPECIFIED_ERROR;
> +	}
> +
> +	if (!mcap_set_data_chan_mode(mcap,
> +			conf_to_l2cap(channel->type), &err)) {
> +		error("health: %s", err->message);
> +		g_error_free(err);
> +		return MCAP_MDL_BUSY;
> +	}
>  
>  	return MCAP_SUCCESS;
>  }
> 

-- 
Best regards, 
Szymon Janc
