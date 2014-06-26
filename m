Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4] android/health: Provide a helper funtion to search channel by id
Date: Thu, 26 Jun 2014 12:04:48 +0300
Message-Id: <1403773488-9216-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 54017eb..42c9a6e 100644
--- a/android/health.c
+++ b/android/health.c
@@ -229,6 +229,14 @@ static void free_health_app(void *data)
 	free(app);
 }
 
+static bool match_channel_by_id(const void *data, const void *user_data)
+{
+	const struct health_channel *channel = data;
+	uint16_t channel_id = PTR_TO_INT(user_data);
+
+	return channel->id == channel_id;
+}
+
 static bool match_dev_by_addr(const void *data, const void *user_data)
 {
 	const struct health_device *dev = data;
@@ -269,6 +277,52 @@ static bool match_app_by_id(const void *data, const void *user_data)
 	return app->id == app_id;
 }
 
+/*
+ * Helper struct and utility to search channel when only channel id
+ * is the option. i.e. destroy_channel call from HAL is passing only
+ * channel id.
+ */
+struct channel_search {
+	uint16_t channel_id;
+	struct health_channel *channel;
+};
+
+static void device_search_channel(void *data, void *user_data)
+{
+	struct health_device *dev = data;
+	struct channel_search *search = user_data;
+
+	if (search->channel)
+		return;
+
+	search->channel = queue_find(dev->channels, match_channel_by_id,
+						INT_TO_PTR(search->channel_id));
+}
+
+static void app_search_channel(void *data, void *user_data)
+{
+	struct health_app *app = data;
+	struct channel_search *search = user_data;
+
+	if (search->channel)
+		return;
+
+	queue_foreach(app->devices, device_search_channel, search);
+}
+
+static struct health_channel *search_channel_by_id(uint16_t id)
+{
+	struct channel_search search;
+
+	DBG("");
+
+	search.channel_id = id;
+	search.channel = NULL;
+	queue_foreach(apps, app_search_channel, &search);
+
+	return search.channel;
+}
+
 static int register_service_protocols(sdp_record_t *rec,
 					struct health_app *app)
 {
@@ -1518,10 +1572,23 @@ fail:
 
 static void bt_health_destroy_channel(const void *buf, uint16_t len)
 {
-	DBG("Not implemented");
+	const struct hal_cmd_health_destroy_channel *cmd = buf;
+	struct health_channel *channel;
+
+	DBG("Not Implemented");
+
+	channel = search_channel_by_id(cmd->channel_id);
+	if (!channel)
+		goto fail;
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
 			HAL_OP_HEALTH_DESTROY_CHANNEL, HAL_STATUS_UNSUPPORTED);
+
+	return;
+
+fail:
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
+			HAL_OP_HEALTH_DESTROY_CHANNEL, HAL_STATUS_INVALID);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
-- 
1.9.1

