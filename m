Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/a2dp: Free device outside of notify function
Date: Thu, 23 Jan 2014 17:26:19 +0200
Message-Id: <1390490779-28954-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

device_free() was used inside notify_state() function based on parameter
which makes it complex to follow. Change logic so that notify_state()
only notifies and the other code makes device_free().
---
 android/a2dp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 572e0d1..d043c04 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -189,11 +189,6 @@ static void bt_a2dp_notify_state(struct a2dp_device *dev, uint8_t state)
 
 	ipc_send_notif(HAL_SERVICE_ID_A2DP, HAL_EV_A2DP_CONN_STATE, sizeof(ev),
 									&ev);
-
-	if (state != HAL_A2DP_STATE_DISCONNECTED)
-		return;
-
-	a2dp_device_free(dev);
 }
 
 static void bt_audio_notify_state(struct a2dp_setup *setup, uint8_t state)
@@ -221,6 +216,7 @@ static void disconnect_cb(void *user_data)
 	struct a2dp_device *dev = user_data;
 
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
+	a2dp_device_free(dev);
 }
 
 static int sbc_check_config(void *caps, uint8_t caps_len, void *conf,
@@ -460,6 +456,7 @@ static gboolean idle_timeout(gpointer user_data)
 
 	error("avdtp_discover: %s", strerror(-err));
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
+	a2dp_device_free(dev);
 
 	return FALSE;
 }
@@ -474,6 +471,7 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 
 	if (err) {
 		bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
+		a2dp_device_free(dev);
 		error("%s", err->message);
 		return;
 	}
@@ -519,6 +517,7 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 
 failed:
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
+	a2dp_device_free(dev);
 }
 
 static void bt_a2dp_connect(const void *buf, uint16_t len)
@@ -581,6 +580,7 @@ static void bt_a2dp_disconnect(const void *buf, uint16_t len)
 
 	if (dev->io) {
 		bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
+		a2dp_device_free(dev);
 		goto failed;
 	}
 
-- 
1.8.3.2

