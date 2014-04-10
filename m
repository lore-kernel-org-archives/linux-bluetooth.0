Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/5] android/gatt: Fix handling client unregister
Date: Thu, 10 Apr 2014 17:30:02 +0200
Message-Id: <1397143805-17809-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397143805-17809-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397143805-17809-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When client do unregister we need to make sure that there is no
connected device or outstanding connection request for this client.
---
 android/gatt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 80fa139..3483f5d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -498,6 +498,28 @@ static void send_client_connect_notify(int32_t id, struct gatt_device *dev,
 				HAL_EV_GATT_CLIENT_CONNECT, sizeof(ev), &ev);
 }
 
+static void remove_client_from_device_list(void *data, void *user_data)
+{
+	struct gatt_device *dev = data;
+
+	queue_remove_if(dev->clients, match_by_value, user_data);
+}
+
+static void remove_client_from_devices(int32_t id)
+{
+	DBG("");
+
+	queue_foreach(conn_list, remove_client_from_device_list,
+							INT_TO_PTR(id));
+
+	/*TODO: Check if there is any zombie device (connected no client)*/
+
+	queue_foreach(conn_wait_queue, remove_client_from_device_list,
+							INT_TO_PTR(id));
+
+	/*TODO: Check if there is not zombie device plus stop scan */
+}
+
 static void handle_client_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_unregister *cmd = buf;
@@ -514,6 +536,11 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 		goto failed;
 	}
 
+	/* Check if there is any connect request or connected device for this
+	 * client. If so, remove this client from those lists.
+	 */
+	remove_client_from_devices(cl->id);
+
 	destroy_gatt_client(cl);
 	status = HAL_STATUS_SUCCESS;
 
-- 
1.8.4

