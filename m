Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 4/7] android/health: Notify channel status on channel destroy call
Date: Fri, 20 Jun 2014 15:23:33 +0300
Message-Id: <1403267016-28422-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403267016-28422-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403267016-28422-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 64 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/android/health.c b/android/health.c
index 506c859..fff999d 100644
--- a/android/health.c
+++ b/android/health.c
@@ -115,6 +115,37 @@ struct health_app {
 	struct queue *devices;
 };
 
+static void send_app_reg_notify(struct health_app *app, uint8_t state)
+{
+	struct hal_ev_health_app_reg_state ev;
+
+	DBG("");
+
+	ev.id = app->id;
+	ev.state = state;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HEALTH,
+				HAL_EV_HEALTH_APP_REG_STATE, sizeof(ev), &ev);
+}
+
+static void send_channel_state_notify(struct health_channel *channel,
+						uint8_t state, int fd)
+{
+	struct hal_ev_health_channel_state ev;
+
+	DBG("");
+
+	bdaddr2android(&channel->dev->dst, ev.bdaddr);
+	ev.app_id = channel->dev->app_id;
+	ev.mdep_index = channel->mdep_id;
+	ev.channel_id = channel->id;
+	ev.channel_state = state;
+
+	ipc_send_notif_with_fd(hal_ipc, HAL_SERVICE_ID_HEALTH,
+					HAL_EV_HEALTH_CHANNEL_STATE,
+					sizeof(ev), &ev, fd);
+}
+
 static void free_health_channel(void *data)
 {
 	struct health_channel *channel = data;
@@ -132,7 +163,7 @@ static void destroy_channel(void *data)
 	if (!channel)
 		return;
 
-	/* TODO: Notify channel connection status DESTROYED */
+	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_DESTROYED, -1);
 	queue_remove(channel->dev->channels, channel);
 	free_health_channel(channel);
 }
@@ -187,37 +218,6 @@ static void free_health_app(void *data)
 	free(app);
 }
 
-static void send_app_reg_notify(struct health_app *app, uint8_t state)
-{
-	struct hal_ev_health_app_reg_state ev;
-
-	DBG("");
-
-	ev.id = app->id;
-	ev.state = state;
-
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HEALTH,
-				HAL_EV_HEALTH_APP_REG_STATE, sizeof(ev), &ev);
-}
-
-static void send_channel_state_notify(struct health_channel *channel,
-						uint8_t state, int fd)
-{
-	struct hal_ev_health_channel_state ev;
-
-	DBG("");
-
-	bdaddr2android(&channel->dev->dst, ev.bdaddr);
-	ev.app_id = channel->dev->app_id;
-	ev.mdep_index = channel->mdep_id;
-	ev.channel_id = channel->id;
-	ev.channel_state = state;
-
-	ipc_send_notif_with_fd(hal_ipc, HAL_SERVICE_ID_HEALTH,
-					HAL_EV_HEALTH_CHANNEL_STATE,
-					sizeof(ev), &ev, fd);
-}
-
 static bool dev_by_addr(const void *data, const void *user_data)
 {
 	const struct health_device *dev = data;
-- 
1.9.1

