Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 1/7] android/pan: Free device after sending diconnected notification
Date: Wed, 18 Dec 2013 16:53:10 +0200
Message-Id: <1387378396-6259-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index e410f54..2bbba9e 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -103,6 +103,8 @@ static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
 
 	ipc_send_notif(HAL_SERVICE_ID_PAN, HAL_EV_PAN_CONN_STATE, sizeof(ev),
 									&ev);
+	if (dev->conn_state == HAL_PAN_STATE_DISCONNECTED)
+		pan_device_free(dev);
 }
 
 static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
@@ -131,7 +133,6 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 	bnep_if_down(dev->iface);
 	bnep_conndel(&dev->dst);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
-	pan_device_free(dev);
 
 	return FALSE;
 }
@@ -146,7 +147,6 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 		error("bnep connect req failed: %s", strerror(-err));
 		bnep_conndel(&dev->dst);
 		bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
-		pan_device_free(dev);
 		return;
 	}
 
@@ -190,7 +190,6 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 
 fail:
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
-	pan_device_free(dev);
 }
 
 static void bt_pan_connect(const void *buf, uint16_t len)
@@ -284,7 +283,6 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 	}
 
 	dev = l->data;
-
 	if (dev->watch) {
 		g_source_remove(dev->watch);
 		dev->watch = 0;
@@ -292,10 +290,7 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 
 	bnep_if_down(dev->iface);
 	bnep_conndel(&dst);
-
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
-	pan_device_free(dev);
-
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-- 
1.8.3.2

