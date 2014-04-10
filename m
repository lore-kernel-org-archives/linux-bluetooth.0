Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/6] android/gatt: Fix handling client unregister
Date: Thu, 10 Apr 2014 10:42:59 +0200
Message-Id: <1397119381-13294-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397119381-13294-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397119381-13294-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When client do unregister we need to make sure that there is no
connected device for this client or outstanding connection request
---
 android/gatt.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 82299a1..769d392 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -545,6 +545,42 @@ static void send_client_connect_notify(int32_t client_id,
 				HAL_EV_GATT_CLIENT_CONNECT, sizeof(ev), &ev);
 }
 
+static void remove_cl_from_connected_dev_and_notify(void *data, void *user_data)
+{
+	struct gatt_device *dev = data;
+	int32_t id = PTR_TO_INT(user_data);
+
+	if (queue_remove_if(dev->clients, match_by_value, INT_TO_PTR(id))) {
+		if (queue_isempty(dev->clients))
+			connection_cleanup(dev);
+
+		send_client_disconnect_notify(id, dev, GATT_SUCCESS);
+	}
+}
+
+static void remove_cl_from_connecting_dev_and_notify(void *data,
+							void *user_data)
+{
+	struct gatt_device *dev = data;
+	int32_t id = PTR_TO_INT(user_data);
+
+	if (queue_remove_if(dev->clients, match_by_value, INT_TO_PTR(id)))
+		send_client_connect_notify(id, dev, GATT_FAILURE);
+}
+
+static void remove_client_from_devices(int32_t client_id)
+{
+	queue_foreach(conn_list, remove_cl_from_connected_dev_and_notify,
+							INT_TO_PTR(client_id));
+
+	/*TODO: Check if there is any zombie device (connected no client)*/
+
+	queue_foreach(conn_wait_queue, remove_cl_from_connecting_dev_and_notify,
+							INT_TO_PTR(client_id));
+
+	/*TODO: Check if there is not zombie device plus stop scan */
+}
+
 static void handle_client_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_unregister *cmd = buf;
@@ -561,6 +597,11 @@ static void handle_client_unregister(const void *buf, uint16_t len)
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

