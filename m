Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/5] android/gatt: Refactor send_client_connect_notify
Date: Thu, 10 Apr 2014 17:30:01 +0200
Message-Id: <1397143805-17809-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397143805-17809-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397143805-17809-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Create helper function to send connect notification, similar to the
send_client_disconnect_notify
---
 android/gatt.c | 55 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a33ce25..80fa139 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -480,6 +480,24 @@ failed:
 					HAL_OP_GATT_CLIENT_REGISTER, status);
 }
 
+static void send_client_connect_notify(int32_t id, struct gatt_device *dev,
+								int32_t status)
+{
+	struct hal_ev_gatt_client_connect ev;
+
+	ev.client_if = id;
+	ev.status = status;
+
+	if (status == GATT_SUCCESS) {
+		/* Set address and client id in the event */
+		bdaddr2android(&dev->bdaddr, &ev.bda);
+		ev.conn_id = dev->conn_id;
+	}
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_EV_GATT_CLIENT_CONNECT, sizeof(ev), &ev);
+}
+
 static void handle_client_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_unregister *cmd = buf;
@@ -785,25 +803,26 @@ done:
 	return FALSE;
 }
 
-static void send_client_connect_notify(void *data, void *user_data)
+struct connect_data {
+	struct gatt_device *dev;
+	int32_t status;
+};
+
+static void send_client_connect_notifications(void *data, void *user_data)
 {
-	struct hal_ev_gatt_client_connect *ev = user_data;
 	int32_t id = PTR_TO_INT(data);
+	struct connect_data *c = user_data;
 
-	ev->client_if = id;
-
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-				HAL_EV_GATT_CLIENT_CONNECT, sizeof(*ev), ev);
+	send_client_connect_notify(id, c->dev, c->status);
 }
 
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	bdaddr_t *addr = user_data;
 	struct gatt_device *dev;
-	struct hal_ev_gatt_client_connect ev;
+	struct connect_data data;
 	GAttrib *attrib;
 	static uint32_t conn_id = 0;
-	int32_t status;
 
 	/* Take device from conn waiting queue */
 	dev = queue_remove_if(conn_wait_queue, match_dev_by_bdaddr, addr);
@@ -816,19 +835,16 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	g_io_channel_unref(dev->att_io);
 	dev->att_io = NULL;
 
-	/* Set address and client id in the event */
-	bdaddr2android(&dev->bdaddr, &ev.bda);
-
 	if (gerr) {
 		error("gatt: connection failed %s", gerr->message);
-		status = GATT_FAILURE;
+		data.status = GATT_FAILURE;
 		goto reply;
 	}
 
 	attrib = g_attrib_new(io);
 	if (!attrib) {
 		error("gatt: unable to create new GAttrib instance");
-		status = GATT_FAILURE;
+		data.status = GATT_FAILURE;
 		goto reply;
 	}
 
@@ -841,21 +857,18 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (!queue_push_tail(conn_list, dev)) {
 		error("gatt: Cannot push dev on conn_list");
 		connection_cleanup(dev);
-		status = GATT_FAILURE;
+		data.status = GATT_FAILURE;
 		goto reply;
 	}
 
-	status = GATT_SUCCESS;
-	goto reply;
+	data.status = GATT_SUCCESS;
 
 reply:
-	ev.conn_id = dev ? dev->conn_id : 0;
-	ev.status = status;
-
-	queue_foreach(dev->clients, send_client_connect_notify, &ev);
+	data.dev = dev;
+	queue_foreach(dev->clients, send_client_connect_notifications, &data);
 
 	/* If connection did not succeed, destroy device */
-	if (status)
+	if (data.status)
 		destroy_device(dev);
 
 	/* Check if we should restart scan */
-- 
1.8.4

