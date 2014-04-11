Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 4/4] android/gatt: Cleanup device lists
Date: Fri, 11 Apr 2014 16:37:09 +0200
Message-Id: <1397227029-12779-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397227029-12779-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397227029-12779-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch, devices from conn_list and conn_wait_queue which are
without a client e.g. because client has unregister without any
cleaning, are move to the disconnected device queue.

Also connected device without clients are disconnected.
And if there is no dev waiting for connect we do stop scan.
---
 android/gatt.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 83a02ec..cb094db 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -284,6 +284,13 @@ static bool match_dev_by_conn_id(const void *data, const void *user_data)
 	return dev->conn_id == conn_id;
 }
 
+static bool match_dev_without_client(const void *data, const void *user_data)
+{
+	const struct gatt_device *dev = data;
+
+	return queue_isempty(dev->clients);
+}
+
 static bool match_srvc_by_element_id(const void *data, const void *user_data)
 {
 	const struct element_id *exp_id = user_data;
@@ -562,19 +569,55 @@ static void put_device_on_disc_list(struct gatt_device *dev)
 	queue_push_tail(disc_dev_list, dev);
 }
 
+static void cleanup_conn_list(int32_t id)
+{
+	struct gatt_device *dev;
+
+	/* Find device without client */
+	dev = queue_remove_if(conn_list, match_dev_without_client, NULL);
+	while (dev) {
+		/* Device is connected, lets disconnect and notify client */
+		connection_cleanup(dev);
+		send_client_disconnect_notify(id, dev, GATT_SUCCESS);
+
+		/* Put device on disconnected device list */
+		put_device_on_disc_list(dev);
+		dev = queue_remove_if(conn_list, match_dev_without_client,
+									NULL);
+	};
+}
+
+static void cleanup_conn_wait_queue(int32_t id)
+{
+	struct gatt_device *dev;
+
+	/* Find device without client */
+	dev = queue_remove_if(conn_wait_queue, match_dev_without_client, NULL);
+	while (dev) {
+		send_client_connect_notify(id, dev, GATT_FAILURE);
+
+		/* Put device on disconnected device list */
+		put_device_on_disc_list(dev);
+		dev = queue_remove_if(conn_wait_queue,
+						match_dev_without_client, NULL);
+	};
+
+	/* Stop scan we had for connecting devices */
+	if (queue_isempty(conn_wait_queue) && !scanning)
+		bt_le_discovery_stop(NULL);
+}
+
 static void remove_client_from_devices(int32_t id)
 {
 	DBG("");
 
 	queue_foreach(conn_list, remove_client_from_device_list,
 							INT_TO_PTR(id));
-
-	/*TODO: Check if there is any zombie device (connected no client)*/
+	cleanup_conn_list(id);
 
 	queue_foreach(conn_wait_queue, remove_client_from_device_list,
 							INT_TO_PTR(id));
-
-	/*TODO: Check if there is not zombie device plus stop scan */
+	cleanup_conn_wait_queue(id);
 }
 
 static void handle_client_unregister(const void *buf, uint16_t len)
-- 
1.8.4

