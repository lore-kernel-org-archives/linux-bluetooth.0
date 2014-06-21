Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 5/7] android/health: Create and connect MDL
Date: Sat, 21 Jun 2014 22:19:18 +0200
Message-ID: <1684458.fN4lC0bvSy@leonov>
In-Reply-To: <1403267016-28422-6-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403267016-28422-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1403267016-28422-6-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 20 of June 2014 15:23:34 Ravi kumar Veeramally wrote:
> Request for md_create_mdl and on successful response
> connect mdl and pass fd. First data channel should be reliable
> data channel.
> ---
>  android/health.c | 122
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed, 120
> insertions(+), 2 deletions(-)
> 
> diff --git a/android/health.c b/android/health.c
> index fff999d..ec5a413 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -87,6 +87,7 @@ struct health_device {
> 
>  	uint16_t ccpsm;
>  	uint16_t dcpsm;
> +	bool fr; /* first reliable channel */

Is this really needed? Couldn't this be decided based on eg. dev->channels 
queue length?

>  };
> 
>  struct health_channel {
> @@ -146,6 +147,16 @@ static void send_channel_state_notify(struct
> health_channel *channel, sizeof(ev), &ev, fd);
>  }
> 
> +static void unref_mdl(struct health_channel *channel)
> +{
> +	if (!channel || !channel->mdl)
> +		return;
> +
> +	mcap_mdl_unref(channel->mdl);
> +	channel->mdl = NULL;
> +	channel->mdl_conn = false;
> +}
> +
>  static void free_health_channel(void *data)
>  {
>  	struct health_channel *channel = data;
> @@ -153,6 +164,7 @@ static void free_health_channel(void *data)
>  	if (!channel)
>  		return;
> 
> +	unref_mdl(channel);
>  	free(channel);
>  }
> 
> @@ -1016,6 +1028,93 @@ static void mcap_mdl_reconn_req_cb(struct mcap_mdl
> *mdl, void *data) DBG("Not Implemeneted");
>  }
> 
> +static void connect_mdl_cb(struct mcap_mdl *mdl, GError *gerr, gpointer
> data) +{
> +	struct health_channel *channel = data;
> +	int fd;
> +
> +	DBG("");
> +
> +	if (gerr) {
> +		error("error connecting to MDL %s", gerr->message);
> +		goto fail;
> +	}
> +
> +	fd = mcap_mdl_get_fd(channel->mdl);
> +	if (fd < 0) {
> +		error("error retrieving fd");
> +		goto fail;
> +	}
> +
> +	DBG("MDL connected");
> +	channel->mdl_conn = true;
> +
> +	/* first data channel should be reliable data channel */
> +	if (!channel->dev->fr)
> +		if (channel->type == CHANNEL_TYPE_RELIABLE)
> +			channel->dev->fr = true;

If first isn't reliable shouldn't this be an error?

> +
> +	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_CONNECTED, fd);
> +
> +	return;
> +
> +fail:
> +	/* TODO: mcap_mdl_abort */
> +	destroy_channel(channel);
> +}
> +
> +static void create_mdl_cb(struct mcap_mdl *mdl, uint8_t type, GError *gerr,
> +								gpointer data)
> +{
> +	struct health_channel *channel = data;
> +	uint8_t mode;
> +	GError *err = NULL;
> +
> +	DBG("");
> +	if (gerr) {
> +		error("error creating MDL %s", gerr->message);
> +		goto fail;
> +	}
> +
> +	if (channel->type == CHANNEL_TYPE_ANY && type != CHANNEL_TYPE_ANY)
> +		channel->type = type;
> +
> +	/*
> +	 * if requested channel type is not same as preferred
> +	 * channel type from remote device, then abort the connection.
> +	 */
> +	if (channel->type != type) {
> +		/* TODO: abort mdl */
> +		error("abort, channel-type requested %d, preferred %d not same",
> +							channel->type, type);
> +		goto fail;
> +	}
> +
> +	if (!channel->mdl)
> +		channel->mdl = mcap_mdl_ref(mdl);
> +
> +	channel->type = type;
> +	channel->mdl_id = mcap_mdl_get_mdlid(mdl);
> +
> +	if (channel->type == CHANNEL_TYPE_RELIABLE)
> +		mode = L2CAP_MODE_ERTM;
> +	else
> +		mode = L2CAP_MODE_STREAMING;
> +
> +	if (!mcap_connect_mdl(channel->mdl, mode, channel->dev->dcpsm,
> +						connect_mdl_cb, channel,
> +						NULL, &err)) {
> +		error("error connecting to mdl");
> +		g_error_free(err);
> +		goto fail;
> +	}
> +
> +	return;
> +
> +fail:
> +	destroy_channel(channel);
> +}
> +
>  static bool check_role(uint8_t rec_role, uint8_t app_role)
>  {
>  	if ((rec_role == HAL_HEALTH_MDEP_ROLE_SINK &&
> @@ -1078,7 +1177,8 @@ static void get_mdep_cb(sdp_list_t *recs, int err,
> gpointer user_data) struct health_channel *channel = user_data;
>  	struct health_app *app;
>  	struct mdep_cfg *mdep;
> -	uint8_t mdep_id;
> +	uint8_t mdep_id, type;
> +	GError *gerr = NULL;
> 
>  	if (err < 0 || !recs) {
>  		error("error getting remote SDP records");
> @@ -1102,7 +1202,18 @@ static void get_mdep_cb(sdp_list_t *recs, int err,
> gpointer user_data)
> 
>  	channel->remote_mdep = mdep_id;
> 
> -	/* TODO : create mdl */
> +	if (mdep->role == HAL_HEALTH_MDEP_ROLE_SOURCE)
> +		type = channel->type;
> +	else
> +		type = CHANNEL_TYPE_ANY;
> +
> +	if (!mcap_create_mdl(channel->dev->mcl, channel->remote_mdep,
> +				type, create_mdl_cb, channel, NULL, &gerr)) {
> +		error("error creating mdl %s", gerr->message);
> +		g_error_free(gerr);
> +		goto fail;
> +	}
> +
>  	return;
> 
>  fail:
> @@ -1321,6 +1432,13 @@ static void bt_health_connect_channel(const void
> *buf, uint16_t len) if (!channel)
>  		goto fail;
> 
> +	if (!dev->fr) {
> +		if (channel->type != CHANNEL_TYPE_RELIABLE) {
> +			error("error, first data shannel should be reliable");
> +			goto fail;
> +		}
> +	}
> +
>  	if (!dev->mcl) {
>  		if (connect_mcl(channel) < 0) {
>  			error("error retrieving HDP SDP record");

-- 
BR
Szymon Janc
