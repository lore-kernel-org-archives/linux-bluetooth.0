Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android/a2dp: Cleanup devices on unregister
Date: Wed, 20 Nov 2013 11:39:54 +0200
Message-Id: <1384940394-24668-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This cleanup any existing devices in bt_a2dp_unregister
---
 android/a2dp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index a9e7c65..55a433e 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -109,6 +109,11 @@ static void bt_a2dp_notify_state(struct a2dp_device *dev, uint8_t state)
 
 	ipc_send(notification_sk, HAL_SERVICE_ID_A2DP,
 			HAL_EV_A2DP_CONN_STATE, sizeof(ev), &ev, -1);
+
+	if (state != HAL_A2DP_STATE_DISCONNECTED)
+		return;
+
+	a2dp_device_free(dev);
 }
 
 static gboolean watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
@@ -117,8 +122,6 @@ static gboolean watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
 
-	a2dp_device_free(dev);
-
 	return FALSE;
 }
 
@@ -130,7 +133,6 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 	if (err) {
 		bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
 		error("%s", err->message);
-		a2dp_device_free(dev);
 		return;
 	}
 
@@ -364,6 +366,13 @@ bool bt_a2dp_register(int sk, const bdaddr_t *addr)
 	return true;
 }
 
+static void a2dp_device_disconnected(gpointer data, gpointer user_data)
+{
+	struct a2dp_device *dev = data;
+
+	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
+}
+
 void bt_a2dp_unregister(void)
 {
 	DBG("");
@@ -371,6 +380,9 @@ void bt_a2dp_unregister(void)
 	if (notification_sk < 0)
 		return;
 
+	g_slist_foreach(devices, a2dp_device_disconnected, NULL);
+	devices = NULL;
+
 	notification_sk = -1;
 
 	bt_adapter_remove_record(record_id);
-- 
1.8.3.1

