Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 4/4] android/health: Notify channel connection status
Date: Tue, 17 Jun 2014 01:02:50 +0300
Message-Id: <1402956170-18356-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402956170-18356-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402956170-18356-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/android/health.c b/android/health.c
index 94154c3..e833cc3 100644
--- a/android/health.c
+++ b/android/health.c
@@ -195,6 +195,24 @@ static void send_app_reg_notify(struct health_app *app, uint8_t state)
 				HAL_EV_HEALTH_APP_REG_STATE, sizeof(ev), &ev);
 }
 
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
 static bool mdep_by_mdep_role(const void *data, const void *user_data)
 {
 	const struct mdep_cfg *mdep = data;
@@ -1047,11 +1065,11 @@ static void search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
-	/* TODO: send channel state CONNECTING */
+	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_CONNECTING, -1);
 	return;
 
 fail:
-	/* TODO: send channel state DESTROYED*/
+	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_DESTROYED, -1);
 
 	queue_remove(channel->dev->channels, channel);
 	free_health_channel(channel);
-- 
1.9.1

