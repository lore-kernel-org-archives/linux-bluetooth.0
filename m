Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android/A2DP: Fix sending notification on bt_a2dp_unregister
Date: Mon, 20 Jan 2014 14:25:27 +0200
Message-Id: <1390220727-21494-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390220727-21494-1-git-send-email-luiz.dentz@gmail.com>
References: <1390220727-21494-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

At this point IPC might have been closed already.
---
 android/a2dp.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 8ec03c8..5569691 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -119,8 +119,10 @@ static void unregister_endpoint(void *data)
 	g_free(endpoint);
 }
 
-static void a2dp_device_free(struct a2dp_device *dev)
+static void a2dp_device_free(void *data)
 {
+	struct a2dp_device *dev = data;
+
 	if (dev->idle_id > 0)
 		g_source_remove(dev->idle_id);
 
@@ -1471,13 +1473,6 @@ fail:
 	return false;
 }
 
-static void a2dp_device_disconnected(gpointer data, gpointer user_data)
-{
-	struct a2dp_device *dev = data;
-
-	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
-}
-
 void bt_a2dp_unregister(void)
 {
 	DBG("");
@@ -1488,7 +1483,7 @@ void bt_a2dp_unregister(void)
 	g_slist_free_full(endpoints, unregister_endpoint);
 	endpoints = NULL;
 
-	g_slist_foreach(devices, a2dp_device_disconnected, NULL);
+	g_slist_free_full(devices, a2dp_device_free);
 	devices = NULL;
 
 	ipc_unregister(HAL_SERVICE_ID_A2DP);
-- 
1.8.4.2

