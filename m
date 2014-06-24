Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jun 2014 15:48:11 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/health: Provide a helper funtion to search
 channel by id
Message-ID: <20140624124810.GH22942@aemeltch-MOBL1>
References: <1403608946-24769-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <20140624121710.GG22942@aemeltch-MOBL1>
 <53A96FF0.7020407@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53A96FF0.7020407@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Jun 24, 2014 at 03:32:48PM +0300, Ravi kumar Veeramally wrote:
> Hi Andrei,
> 
> On 06/24/2014 03:17 PM, Andrei Emeltchenko wrote:
> >Hi Ravi,
> >
> >On Tue, Jun 24, 2014 at 02:22:26PM +0300, Ravi kumar Veeramally wrote:
> >>---
> >>  android/health.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 65 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/android/health.c b/android/health.c
> >>index f45ae51..4ddcad2 100644
> >>--- a/android/health.c
> >>+++ b/android/health.c
> >>@@ -115,6 +115,12 @@ struct health_app {
> >>  	struct queue *devices;
> >>  };
> >>+/* helper structs */
> >>+struct channel_search {
> >>+	uint16_t channel_id;
> >>+	struct health_channel *channel;
> >>+};
> >>+
> >>  static void send_app_reg_notify(struct health_app *app, uint8_t state)
> >>  {
> >>  	struct hal_ev_health_app_reg_state ev;
> >>@@ -237,6 +243,14 @@ static bool dev_by_addr(const void *data, const void *user_data)
> >>  	return !bacmp(&dev->dst, addr);
> >>  }
> >>+static bool channel_by_channel_id(const void *data, const void *user_data)
> >Should this be cmp_by_channel_id() ?
>   For other api's, it is
>   dev_by_addr, channel_by_mdep_id, mdep_by_mdep_role, app_by_app_id.
>   so continued in similar way (channel_by_channel_id).

This also looks a bit strange, are those cmp_* functions as well?

Best regards 
Andrei Emeltchenko 

> 
>  Thanks,
>  Ravi.
> 
> >Best regards
> >Andrei Emeltchenko
> >
> >>+{
> >>+	const struct health_channel *channel = data;
> >>+	uint16_t channel_id = PTR_TO_INT(user_data);
> >>+
> >>+	return channel->id == channel_id;
> >>+}
> >>+
> >>  static bool channel_by_mdep_id(const void *data, const void *user_data)
> >>  {
> >>  	const struct health_channel *channel = data;
> >>@@ -269,6 +283,42 @@ static bool app_by_app_id(const void *data, const void *user_data)
> >>  	return app->id == app_id;
> >>  }
> >>+static void device_search_channel(void *data, void *user_data)
> >>+{
> >>+	struct health_device *dev = data;
> >>+	struct channel_search *search = user_data;
> >>+
> >>+	if (search->channel)
> >>+		return;
> >>+
> >>+	search->channel = queue_find(dev->channels, channel_by_channel_id,
> >>+						INT_TO_PTR(search->channel_id));
> >>+}
> >>+
> >>+static void app_search_channel(void *data, void *user_data)
> >>+{
> >>+	struct health_app *app = data;
> >>+	struct channel_search *search = user_data;
> >>+
> >>+	if (search->channel)
> >>+		return;
> >>+
> >>+	queue_foreach(app->devices, device_search_channel, search);
> >>+}
> >>+
> >>+static struct health_channel *search_channel_by_id(uint16_t id)
> >>+{
> >>+	struct channel_search search;
> >>+
> >>+	DBG("");
> >>+
> >>+	search.channel_id = id;
> >>+	search.channel = NULL;
> >>+	queue_foreach(apps, app_search_channel, &search);
> >>+
> >>+	return search.channel;
> >>+}
> >>+
> >>  static int register_service_protocols(sdp_record_t *rec,
> >>  					struct health_app *app)
> >>  {
> >>@@ -1459,6 +1509,7 @@ static struct health_channel *get_channel(uint16_t app_id,
> >>  	return create_channel(app_id, mdep_index, dev);
> >>  }
> >>+
> >>  static void bt_health_connect_channel(const void *buf, uint16_t len)
> >>  {
> >>  	const struct hal_cmd_health_connect_channel *cmd = buf;
> >>@@ -1512,10 +1563,23 @@ fail:
> >>  static void bt_health_destroy_channel(const void *buf, uint16_t len)
> >>  {
> >>-	DBG("Not implemented");
> >>+	const struct hal_cmd_health_destroy_channel *cmd = buf;
> >>+	struct health_channel *channel;
> >>+
> >>+	DBG("Not Implemented");
> >>+
> >>+	channel = search_channel_by_id(cmd->channel_id);
> >>+	if (!channel)
> >>+		goto fail;
> >>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
> >>  			HAL_OP_HEALTH_DESTROY_CHANNEL, HAL_STATUS_UNSUPPORTED);
> >>+
> >>+	return;
> >>+
> >>+fail:
> >>+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
> >>+			HAL_OP_HEALTH_DESTROY_CHANNEL, HAL_STATUS_INVALID);
> >>  }
> >>  static const struct ipc_handler cmd_handlers[] = {
> >>-- 
> >>1.9.1
> >>
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
