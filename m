Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 12/38] android/gatt: Add ATT msg handler
Date: Wed, 30 Apr 2014 11:13:43 +0200
Message-Id: <1398849249-5868-13-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds skeleton for ATT msg handler and also attach it to the
attrib on connect_cb and connect_event
---
 android/gatt.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index f035e3f..c2f43b5 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -134,6 +134,7 @@ struct gatt_device {
 	struct queue *services;
 
 	guint watch_id;
+	guint server_id;
 
 	int ref;
 	int conn_cnt;
@@ -494,6 +495,9 @@ static void connection_cleanup(struct gatt_device *device)
 		device->att_io = NULL;
 	}
 
+	if (device->server_id > 0)
+		g_attrib_unregister(device->attrib, device->server_id);
+
 	if (device->attrib) {
 		GAttrib *attrib = device->attrib;
 		device->attrib = NULL;
@@ -962,6 +966,8 @@ static void send_app_connect_notifications(void *data, void *user_data)
 		send_app_connect_notify(conn, con_data->status);
 }
 
+static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data);
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -997,6 +1003,12 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	dev->watch_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 							disconnected_cb, dev);
 
+	dev->server_id = g_attrib_register(attrib, GATTRIB_ALL_REQS,
+						GATTRIB_ALL_HANDLES,
+						att_handler, dev, NULL);
+	if (dev->server_id == 0)
+		error("gatt: Could not attach to server");
+
 	device_set_state(dev, DEVICE_CONNECTED);
 
 	status = GATT_SUCCESS;
@@ -3583,6 +3595,45 @@ static const struct ipc_handler cmd_handlers[] = {
 		sizeof(struct hal_cmd_gatt_server_send_response) },
 };
 
+static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
+{
+	struct gatt_device *dev = user_data;
+	uint8_t opdu[ATT_DEFAULT_LE_MTU];
+	uint8_t status;
+	uint16_t length = 0;
+
+	DBG("op 0x%02x", ipdu[0]);
+
+	switch (ipdu[0]) {
+	case ATT_OP_READ_BY_GROUP_REQ:
+	case ATT_OP_READ_BY_TYPE_REQ:
+	case ATT_OP_READ_REQ:
+	case ATT_OP_READ_BLOB_REQ:
+	case ATT_OP_MTU_REQ:
+	case ATT_OP_FIND_INFO_REQ:
+	case ATT_OP_WRITE_REQ:
+	case ATT_OP_WRITE_CMD:
+	case ATT_OP_FIND_BY_TYPE_REQ:
+	case ATT_OP_HANDLE_CNF:
+	case ATT_OP_HANDLE_IND:
+	case ATT_OP_HANDLE_NOTIFY:
+	case ATT_OP_READ_MULTI_REQ:
+	case ATT_OP_PREP_WRITE_REQ:
+	case ATT_OP_EXEC_WRITE_REQ:
+	default:
+		DBG("Unsupported request 0x%02x", ipdu[0]);
+		status = ATT_ECODE_REQ_NOT_SUPP;
+		goto done;
+	}
+
+done:
+	if (status)
+		length = enc_error_resp(ipdu[0], 0x0000, status, opdu,
+							ATT_DEFAULT_LE_MTU);
+
+	g_attrib_send(dev->attrib, 0, opdu, length, NULL, NULL, NULL);
+}
+
 static void create_listen_connections(void *data, void *user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -3648,7 +3699,11 @@ static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
 
 	queue_foreach(app_connections, send_app_connect_notifications, &data);
 
-	/* TODO: Attach to attrib db */
+	dev->server_id = g_attrib_register(attrib, GATTRIB_ALL_REQS,
+						GATTRIB_ALL_HANDLES,
+						att_handler, dev, NULL);
+	if (dev->server_id == 0)
+		error("gatt: Could not attach to server");
 }
 
 static int start_listen_socket(void)
-- 
1.8.4

