Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/gatt: Keep client notify functions names consistent
Date: Mon, 24 Mar 2014 15:27:23 +0100
Message-Id: <1395671244-2053-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should use consistent names for client notify functions.
---
 android/gatt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2189e8e..302a9b9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -292,7 +292,7 @@ static void connection_cleanup(struct gatt_device *device)
 	}
 }
 
-static void send_disconnect_notify(int32_t id, struct gatt_device *dev,
+static void send_client_disconnect_notify(int32_t id, struct gatt_device *dev,
 								uint8_t status)
 {
 	struct hal_ev_gatt_client_disconnect ev;
@@ -306,12 +306,12 @@ static void send_disconnect_notify(int32_t id, struct gatt_device *dev,
 			HAL_EV_GATT_CLIENT_DISCONNECT, sizeof(ev), &ev);
 }
 
-static void disconnect_notify(void *data, void *user_data)
+static void client_disconnect_notify(void *data, void *user_data)
 {
 	struct gatt_device *dev = user_data;
 	int32_t id = PTR_TO_INT(data);
 
-	send_disconnect_notify(id, dev, HAL_STATUS_SUCCESS);
+	send_client_disconnect_notify(id, dev, HAL_STATUS_SUCCESS);
 }
 
 static bool is_device_wating_for_connect(const bdaddr_t *addr,
@@ -402,7 +402,7 @@ static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
 done:
 	connection_cleanup(dev);
 
-	queue_foreach(dev->clients, disconnect_notify, dev);
+	queue_foreach(dev->clients, client_disconnect_notify, dev);
 	destroy_device(dev);
 
 	return FALSE;
@@ -802,7 +802,7 @@ reply:
 	 * If this is last client, this is still OK to do because on connect
 	 * request we do le scan and wait until remote device start
 	 * advertisement */
-	send_disconnect_notify(cmd->client_if, dev, HAL_STATUS_SUCCESS);
+	send_client_disconnect_notify(cmd->client_if, dev, HAL_STATUS_SUCCESS);
 
 	/* If there is more clients just return */
 	if (!queue_isempty(dev->clients))
-- 
1.8.5.2

