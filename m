Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3 1/3] android/health: Rename matching functions
Date: Thu, 26 Jun 2014 10:28:59 +0200
Message-ID: <1793899.ABTotJyTcV@uw000953>
In-Reply-To: <1403713815-3906-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403713815-3906-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wednesday 25 of June 2014 19:30:13 Ravi kumar Veeramally wrote:
> ---
>  android/health.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 7281dd5..0aa588a 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -229,7 +229,7 @@ static void free_health_app(void *data)
>  	free(app);
>  }
>  
> -static bool dev_by_addr(const void *data, const void *user_data)
> +static bool match_dev_by_addr(const void *data, const void *user_data)
>  {
>  	const struct health_device *dev = data;
>  	const bdaddr_t *addr = user_data;
> @@ -237,7 +237,7 @@ static bool dev_by_addr(const void *data, const void *user_data)
>  	return !bacmp(&dev->dst, addr);
>  }
>  
> -static bool channel_by_mdep_id(const void *data, const void *user_data)
> +static bool match_channel_by_mdep_id(const void *data, const void *user_data)
>  {
>  	const struct health_channel *channel = data;
>  	uint16_t mdep_id = PTR_TO_INT(user_data);
> @@ -245,7 +245,7 @@ static bool channel_by_mdep_id(const void *data, const void *user_data)
>  	return channel->mdep_id == mdep_id;
>  }
>  
> -static bool mdep_by_mdep_role(const void *data, const void *user_data)
> +static bool match_mdep_by_role(const void *data, const void *user_data)
>  {
>  	const struct mdep_cfg *mdep = data;
>  	uint16_t role = PTR_TO_INT(user_data);
> @@ -253,7 +253,7 @@ static bool mdep_by_mdep_role(const void *data, const void *user_data)
>  	return mdep->role == role;
>  }
>  
> -static bool mdep_by_mdep_id(const void *data, const void *user_data)
> +static bool match_mdep_by_id(const void *data, const void *user_data)
>  {
>  	const struct mdep_cfg *mdep = data;
>  	uint16_t mdep_id = PTR_TO_INT(user_data);
> @@ -261,7 +261,7 @@ static bool mdep_by_mdep_id(const void *data, const void *user_data)
>  	return mdep->id == mdep_id;
>  }
>  
> -static bool app_by_app_id(const void *data, const void *user_data)
> +static bool match_app_by_id(const void *data, const void *user_data)
>  {
>  	const struct health_app *app = data;
>  	uint16_t app_id = PTR_TO_INT(user_data);
> @@ -629,11 +629,11 @@ static int update_sdp_record(struct health_app *app)
>  		return -1;
>  
>  	role = HAL_HEALTH_MDEP_ROLE_SOURCE;
> -	if (queue_find(app->mdeps, mdep_by_mdep_role, INT_TO_PTR(role)))
> +	if (queue_find(app->mdeps, match_mdep_by_role, INT_TO_PTR(role)))
>  		set_sdp_services_uuid(rec, role);
>  
>  	role = HAL_HEALTH_MDEP_ROLE_SINK;
> -	if (queue_find(app->mdeps, mdep_by_mdep_role, INT_TO_PTR(role)))
> +	if (queue_find(app->mdeps, match_mdep_by_role, INT_TO_PTR(role)))
>  		set_sdp_services_uuid(rec, role);
>  
>  	sdp_set_info_attr(rec, app->service_name, app->provider_name,
> @@ -802,7 +802,7 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
>  
>  	DBG("");
>  
> -	app = queue_find(apps, app_by_app_id, INT_TO_PTR(cmd->app_id));
> +	app = queue_find(apps, match_app_by_id, INT_TO_PTR(cmd->app_id));
>  	if (!app) {
>  		status = HAL_STATUS_INVALID;
>  		goto fail;
> @@ -871,7 +871,7 @@ static void bt_health_unregister_app(const void *buf, uint16_t len)
>  
>  	DBG("");
>  
> -	app = queue_remove_if(apps, app_by_app_id, INT_TO_PTR(cmd->app_id));
> +	app = queue_remove_if(apps, match_app_by_id, INT_TO_PTR(cmd->app_id));
>  	if (!app) {
>  		ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
>  				HAL_OP_HEALTH_UNREG_APP, HAL_STATUS_INVALID);
> @@ -1208,11 +1208,12 @@ static void get_mdep_cb(sdp_list_t *recs, int err, gpointer user_data)
>  		goto fail;
>  	}
>  
> -	app = queue_find(apps, app_by_app_id, INT_TO_PTR(channel->dev->app_id));
> +	app = queue_find(apps, match_app_by_id,
> +					INT_TO_PTR(channel->dev->app_id));
>  	if (!app)
>  		goto fail;
>  
> -	mdep = queue_find(app->mdeps, mdep_by_mdep_id,
> +	mdep = queue_find(app->mdeps, match_mdep_by_id,
>  						INT_TO_PTR(channel->mdep_id));
>  	if (!mdep)
>  		goto fail;
> @@ -1389,12 +1390,12 @@ static struct health_device *get_device(uint16_t app_id, const uint8_t *addr)
>  	struct health_device *dev;
>  	bdaddr_t bdaddr;
>  
> -	app = queue_find(apps, app_by_app_id, INT_TO_PTR(app_id));
> +	app = queue_find(apps, match_app_by_id, INT_TO_PTR(app_id));
>  	if (!app)
>  		return NULL;
>  
>  	android2bdaddr(addr, &bdaddr);
> -	dev = queue_find(app->devices, dev_by_addr, &bdaddr);
> +	dev = queue_find(app->devices, match_dev_by_addr, &bdaddr);
>  	if (dev)
>  		return dev;
>  
> @@ -1418,12 +1419,12 @@ static struct health_channel *create_channel(uint16_t app_id,
>  	if (!dev)
>  		return NULL;
>  
> -	app = queue_find(apps, app_by_app_id, INT_TO_PTR(app_id));
> +	app = queue_find(apps, match_app_by_id, INT_TO_PTR(app_id));
>  	if (!app)
>  		return NULL;
>  
>  	index = mdep_index + 1;
> -	mdep = queue_find(app->mdeps, mdep_by_mdep_id, INT_TO_PTR(index));
> +	mdep = queue_find(app->mdeps, match_mdep_by_id, INT_TO_PTR(index));
>  	if (!mdep)
>  		return NULL;
>  
> @@ -1456,7 +1457,7 @@ static struct health_channel *get_channel(uint16_t app_id,
>  		return NULL;
>  
>  	index = mdep_index + 1;
> -	channel = queue_find(dev->channels, channel_by_mdep_id,
> +	channel = queue_find(dev->channels, match_channel_by_mdep_id,
>  							INT_TO_PTR(index));
>  	if (channel)
>  		return channel;
> 

This patch is now applied, thanks.

-- 
Best regards, 
Szymon Janc
