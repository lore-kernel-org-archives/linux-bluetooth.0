Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 10/38] android/gatt: Add listening socket for GATT
Date: Wed, 30 Apr 2014 11:13:41 +0200
Message-Id: <1398849249-5868-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now we do listen on BLE transport
---
 android/gatt.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 115fb1a..9e950ec 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -156,6 +156,8 @@ static struct queue *app_connections = NULL;
 static struct queue *listen_apps = NULL;
 static struct gatt_db *gatt_db = NULL;
 
+static GIOChannel *listening_sk = NULL;
+
 static void bt_le_discovery_stop_cb(void);
 
 static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
@@ -3574,6 +3576,98 @@ static const struct ipc_handler cmd_handlers[] = {
 		sizeof(struct hal_cmd_gatt_server_send_response) },
 };
 
+static void create_listen_connections(void *data, void *user_data)
+{
+	struct gatt_device *dev = user_data;
+	int32_t id = PTR_TO_INT(data);
+	struct gatt_app *app;
+
+	app = find_app_by_id(id);
+	if (app)
+		create_connection(dev, app);
+}
+
+static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
+{
+	struct gatt_device *dev;
+	GAttrib *attrib;
+	uint8_t dst_type;
+	bdaddr_t src, dst;
+	struct connect_data data;
+
+	DBG("");
+
+	if (gerr) {
+		error("gatt: %s", gerr->message);
+		g_error_free(gerr);
+		return;
+	}
+
+	bt_io_get(io, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_DEST_TYPE, &dst_type,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("gatt: bt_io_get: %s", gerr->message);
+		g_error_free(gerr);
+		return;
+	}
+
+	dev = create_device(&dst);
+	if (!dev) {
+		error("gatt: Could not create device");
+		return;
+	}
+
+	dev->bdaddr_type = dst_type;
+
+	attrib = g_attrib_new(io);
+	if (!attrib) {
+		error("gatt: unable to create new GAttrib instance");
+		destroy_device(dev);
+		return;
+	}
+
+	dev->attrib = attrib;
+	dev->watch_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+							disconnected_cb, dev);
+
+	queue_foreach(listen_apps, create_listen_connections, dev);
+
+	data.dev = dev;
+	data.status = GATT_SUCCESS;
+	device_set_state(dev, DEVICE_CONNECTED);
+
+	queue_foreach(app_connections, send_app_connect_notifications, &data);
+
+	/* TODO: Attach to attrib db */
+}
+
+static int start_listen_socket(void)
+{
+	GError *gerr = NULL;
+
+	DBG("");
+
+	/*For now only listen on BLE */
+	listening_sk = bt_io_listen(connect_event, NULL,
+					&listening_sk, NULL, &gerr,
+					BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
+					BT_IO_OPT_CID, ATT_CID,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+
+	if (!listening_sk) {
+		int ret = gerr->code;
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		return ret;
+	}
+
+	return 0;
+}
+
 bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 {
 	DBG("");
@@ -3613,6 +3707,9 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	ipc_register(hal_ipc, HAL_SERVICE_ID_GATT, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
+	if (start_listen_socket() < 0)
+		error("Could not start GATT listening");
+
 	return true;
 }
 
-- 
1.8.4

