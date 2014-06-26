Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3 2/3] android/health: Provide a helper funtion to search channel by id
Date: Thu, 26 Jun 2014 10:32:36 +0200
Message-ID: <2378622.TiPmLcVzkP@uw000953>
In-Reply-To: <1403713815-3906-2-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403713815-3906-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1403713815-3906-2-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wednesday 25 of June 2014 19:30:14 Ravi kumar Veeramally wrote:
> ---
>  android/health.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 0aa588a..1ab5af1 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -115,6 +115,12 @@ struct health_app {
>  	struct queue *devices;
>  };
>  
> +/* helper structs */
> +struct channel_search {
> +	uint16_t channel_id;
> +	struct health_channel *channel;
> +};
> +

Just define this helper struct right before first function that is using
structure. Then, also comment for file section is not really need (and those
tends to get obsolete quite quickly anyway).

>  static void send_app_reg_notify(struct health_app *app, uint8_t state)
>  {
>  	struct hal_ev_health_app_reg_state ev;
> @@ -229,6 +235,14 @@ static void free_health_app(void *data)
>  	free(app);
>  }
>  
> +static bool match_channel_by_id(const void *data, const void *user_data)
> +{
> +	const struct health_channel *channel = data;
> +	uint16_t channel_id = PTR_TO_INT(user_data);
> +
> +	return channel->id == channel_id;
> +}
> +
>  static bool match_dev_by_addr(const void *data, const void *user_data)
>  {
>  	const struct health_device *dev = data;
> @@ -269,6 +283,42 @@ static bool match_app_by_id(const void *data, const void *user_data)
>  	return app->id == app_id;
>  }
>  
> +static void device_search_channel(void *data, void *user_data)
> +{
> +	struct health_device *dev = data;
> +	struct channel_search *search = user_data;
> +
> +	if (search->channel)
> +		return;
> +
> +	search->channel = queue_find(dev->channels, match_channel_by_id,
> +						INT_TO_PTR(search->channel_id));
> +}
> +
> +static void app_search_channel(void *data, void *user_data)
> +{
> +	struct health_app *app = data;
> +	struct channel_search *search = user_data;
> +
> +	if (search->channel)
> +		return;
> +
> +	queue_foreach(app->devices, device_search_channel, search);
> +}
> +
> +static struct health_channel *search_channel_by_id(uint16_t id)
> +{
> +	struct channel_search search;
> +
> +	DBG("");
> +
> +	search.channel_id = id;
> +	search.channel = NULL;
> +	queue_foreach(apps, app_search_channel, &search);
> +
> +	return search.channel;
> +}
> +
>  static int register_service_protocols(sdp_record_t *rec,
>  					struct health_app *app)
>  {
> @@ -1518,10 +1568,23 @@ fail:
>  
>  static void bt_health_destroy_channel(const void *buf, uint16_t len)
>  {
> -	DBG("Not implemented");
> +	const struct hal_cmd_health_destroy_channel *cmd = buf;
> +	struct health_channel *channel;
> +
> +	DBG("Not Implemented");
> +
> +	channel = search_channel_by_id(cmd->channel_id);
> +	if (!channel)
> +		goto fail;
>  
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
>  			HAL_OP_HEALTH_DESTROY_CHANNEL, HAL_STATUS_UNSUPPORTED);
> +
> +	return;
> +
> +fail:
> +	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
> +			HAL_OP_HEALTH_DESTROY_CHANNEL, HAL_STATUS_INVALID);
>  }
>  
>  static const struct ipc_handler cmd_handlers[] = {
> 

-- 
Best regards, 
Szymon Janc
