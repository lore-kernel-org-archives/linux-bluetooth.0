Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 1/6] android/health: Check if device and channel already exists or not
Date: Sun, 22 Jun 2014 14:58:56 +0300
Message-Id: <1403438341-14321-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403438341-14321-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403438341-14321-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On channel connect request, check if device is already exists or not.
Also check if channel is already created for remote device or not.
---
 android/health.c | 107 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 83 insertions(+), 24 deletions(-)

diff --git a/android/health.c b/android/health.c
index 7553467..21c3bcd 100644
--- a/android/health.c
+++ b/android/health.c
@@ -213,6 +213,22 @@ static void send_channel_state_notify(struct health_channel *channel,
 					sizeof(ev), &ev, fd);
 }
 
+static bool dev_by_addr(const void *data, const void *user_data)
+{
+	const struct health_device *dev = data;
+	const bdaddr_t *addr = user_data;
+
+	return !bacmp(&dev->dst, addr);
+}
+
+static bool channel_by_mdep_id(const void *data, const void *user_data)
+{
+	const struct health_channel *channel = data;
+	uint16_t mdep_id = PTR_TO_INT(user_data);
+
+	return channel->mdep_id == mdep_id;
+}
+
 static bool mdep_by_mdep_role(const void *data, const void *user_data)
 {
 	const struct mdep_cfg *mdep = data;
@@ -1094,8 +1110,14 @@ static int connect_mcl(struct health_channel *channel)
 
 static struct health_device *create_device(uint16_t app_id, const uint8_t *addr)
 {
+	struct health_app *app;
 	struct health_device *dev;
 
+	app = queue_find(apps, app_by_app_id, INT_TO_PTR(app_id));
+	if (!app)
+		return NULL;
+
+	/* create device and push it to devices queue */
 	dev = new0(struct health_device, 1);
 	if (!dev)
 		return NULL;
@@ -1108,11 +1130,35 @@ static struct health_device *create_device(uint16_t app_id, const uint8_t *addr)
 		return NULL;
 	}
 
+	if (!queue_push_tail(app->devices, dev)) {
+		free_health_device(dev);
+		return NULL;
+	}
+
 	return dev;
 }
 
+static struct health_device *get_device(uint16_t app_id, const uint8_t *addr)
+{
+	struct health_app *app;
+	struct health_device *dev;
+	bdaddr_t bdaddr;
+
+	app = queue_find(apps, app_by_app_id, INT_TO_PTR(app_id));
+	if (!app)
+		return NULL;
+
+	android2bdaddr(addr, &bdaddr);
+	dev = queue_find(app->devices, dev_by_addr, &bdaddr);
+	if (dev)
+		return dev;
+
+	return create_device(app_id, addr);
+}
+
 static struct health_channel *create_channel(uint16_t app_id,
-						uint8_t mdep_index)
+						uint8_t mdep_index,
+						struct health_device *dev)
 {
 	struct health_app *app;
 	struct mdep_cfg *mdep;
@@ -1120,6 +1166,9 @@ static struct health_channel *create_channel(uint16_t app_id,
 	uint8_t index;
 	static unsigned int channel_id = 1;
 
+	if (!dev)
+		return NULL;
+
 	app = queue_find(apps, app_by_app_id, INT_TO_PTR(app_id));
 	if (!app)
 		return NULL;
@@ -1129,53 +1178,64 @@ static struct health_channel *create_channel(uint16_t app_id,
 	if (!mdep)
 		return NULL;
 
+	/* create channel and push it to device */
 	channel = new0(struct health_channel, 1);
 	if (!channel)
 		return NULL;
 
-	channel->mdep_id = mdep_index;
+	channel->mdep_id = mdep->id;
 	channel->type = mdep->channel_type;
 	channel->id = channel_id++;
+	channel->dev = dev;
+
+	if (!queue_push_tail(dev->channels, channel)) {
+		free_health_channel(channel);
+		return NULL;
+	}
 
 	return channel;
 }
 
+static struct health_channel *get_channel(uint16_t app_id,
+						uint8_t mdep_index,
+						struct health_device *dev)
+{
+	struct health_channel *channel;
+	uint8_t index;
+
+	if (!dev)
+		return NULL;
+
+	index = mdep_index + 1;
+	channel = queue_find(dev->channels, channel_by_mdep_id,
+							INT_TO_PTR(index));
+	if (channel)
+		return channel;
+
+	return create_channel(app_id, mdep_index, dev);
+}
 static void bt_health_connect_channel(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_health_connect_channel *cmd = buf;
 	struct hal_rsp_health_connect_channel rsp;
-	struct health_app *app;
 	struct health_device *dev = NULL;
 	struct health_channel *channel = NULL;
 
 	DBG("");
 
-	app = queue_find(apps, app_by_app_id, INT_TO_PTR(cmd->app_id));
-	if (!app)
-		goto fail;
-
-	dev = create_device(cmd->app_id, cmd->bdaddr);
+	dev = get_device(cmd->app_id, cmd->bdaddr);
 	if (!dev)
 		goto fail;
 
-	channel = create_channel(cmd->app_id, cmd->mdep_index);
+	channel = get_channel(cmd->app_id, cmd->mdep_index, dev);
 	if (!channel)
 		goto fail;
 
-	channel->dev = dev;
-
-	if (!queue_push_tail(app->devices, dev))
-		goto fail;
-
-	if (!queue_push_tail(dev->channels, channel)) {
-		queue_remove(app->devices, dev);
-		goto fail;
-	}
-
-	if (connect_mcl(channel) < 0) {
-		error("error retrieving HDP SDP record");
-		queue_remove(app->devices, dev);
-		goto fail;
+	if (!dev->mcl) {
+		if (connect_mcl(channel) < 0) {
+			error("health:error retrieving HDP SDP record");
+			goto fail;
+		}
 	}
 
 	rsp.channel_id = channel->id;
@@ -1186,7 +1246,6 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 
 fail:
 	free_health_channel(channel);
-	free_health_device(dev);
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
 			HAL_OP_HEALTH_CONNECT_CHANNEL, HAL_STATUS_FAILED);
 }
-- 
1.9.1

