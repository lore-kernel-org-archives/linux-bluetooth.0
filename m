Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] android/A2DP: Notify when audio state change to started
Date: Fri, 17 Jan 2014 15:33:05 +0200
Message-Id: <1389965587-20066-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389965587-20066-1-git-send-email-luiz.dentz@gmail.com>
References: <1389965587-20066-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 2288912..515cf17 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -85,6 +85,7 @@ struct a2dp_setup {
 	struct a2dp_endpoint *endpoint;
 	struct a2dp_preset *preset;
 	struct avdtp_stream *stream;
+	uint8_t state;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -190,6 +191,26 @@ static void bt_a2dp_notify_state(struct a2dp_device *dev, uint8_t state)
 	a2dp_device_free(dev);
 }
 
+static void bt_audio_notify_state(struct a2dp_setup *setup, uint8_t state)
+{
+	struct hal_ev_a2dp_audio_state ev;
+	char address[18];
+
+	if (setup->state == state)
+		return;
+
+	setup->state = state;
+
+	ba2str(&setup->dev->dst, address);
+	DBG("device %s state %u", address, state);
+
+	bdaddr2android(&setup->dev->dst, ev.bdaddr);
+	ev.state = state;
+
+	ipc_send_notif(HAL_SERVICE_ID_A2DP, HAL_EV_A2DP_AUDIO_STATE, sizeof(ev),
+									&ev);
+}
+
 static void disconnect_cb(void *user_data)
 {
 	struct a2dp_device *dev = user_data;
@@ -962,6 +983,8 @@ static gboolean sep_start_ind(struct avdtp *session,
 		return FALSE;
 	}
 
+	bt_audio_notify_state(setup, HAL_AUDIO_STARTED);
+
 	return TRUE;
 }
 
@@ -1059,13 +1082,23 @@ static void sep_start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			void *user_data)
 {
 	struct a2dp_endpoint *endpoint = user_data;
+	struct a2dp_setup *setup;
 
 	DBG("");
 
-	if (!err)
+	if (err) {
+		setup_remove_by_id(endpoint->id);
 		return;
+	}
 
-	setup_remove_by_id(endpoint->id);
+	setup = find_setup(endpoint->id);
+	if (!setup) {
+		error("Unable to find stream setup for %u endpoint",
+								endpoint->id);
+		return;
+	}
+
+	bt_audio_notify_state(setup, HAL_AUDIO_STARTED);
 }
 
 static void sep_suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
-- 
1.8.4.2

