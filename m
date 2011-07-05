Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 06/12] Add auto connection based on registered callbacks
Date: Tue,  5 Jul 2011 10:56:02 -0300
Message-Id: <1309874168-32716-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This initial approach uses a hardcoded timer(45s). Passive scanning
or any other mechanism to avoid unnecessary connection attempt is not
supported at the moment. For LE, device discovery needs to be executed
to update the kernel advertising cache to allow re-connections.
---
 src/device.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 86 insertions(+), 20 deletions(-)

diff --git a/src/device.c b/src/device.c
index 20248ed..7543a80 100644
--- a/src/device.c
+++ b/src/device.c
@@ -65,6 +65,7 @@
 
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		2
+#define AUTOCONNECT_INTERVAL	45
 
 /* When all services should trust a remote device */
 #define GLOBAL_TRUST "[all]"
@@ -94,7 +95,6 @@ struct authentication_req {
 struct browse_req {
 	DBusConnection *conn;
 	DBusMessage *msg;
-	GAttrib *attrib;
 	GIOChannel *io;
 	struct btd_device *device;
 	GSList *match_uuids;
@@ -135,6 +135,7 @@ struct btd_device {
 	GSList		*disconnects;		/* disconnects message */
 	GAttrib		*attrib;
 	GSList		*attios;
+	guint		attioid;
 
 	gboolean	connected;
 
@@ -177,9 +178,6 @@ static void browse_request_free(struct browse_req *req, gboolean shutdown)
 	if (req->records)
 		sdp_list_free(req->records, (sdp_free_func_t) sdp_record_free);
 
-	if (req->attrib)
-		g_attrib_unref(req->attrib);
-
 	g_free(req);
 }
 
@@ -218,6 +216,8 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
 
+	g_attrib_unref(device->attrib);
+
 	if (device->tmp_records)
 		sdp_list_free(device->tmp_records,
 					(sdp_free_func_t) sdp_record_free);
@@ -228,6 +228,9 @@ static void device_free(gpointer user_data)
 	if (device->discov_timer)
 		g_source_remove(device->discov_timer);
 
+	if (device->attioid)
+		g_source_remove(device->attioid);
+
 	DBG("%p", device);
 
 	g_free(device->authr);
@@ -1591,6 +1594,15 @@ static void store_services(struct btd_device *device)
 	g_free(str);
 }
 
+static void attio_connected(gpointer data, gpointer user_data)
+{
+	struct attio_data *attio = data;
+	GAttrib *attrib = user_data;
+
+	if (attio->cfunc)
+		attio->cfunc(attrib, attio->user_data);
+}
+
 static void attio_disconnected(gpointer data, gpointer user_data)
 {
 	struct attio_data *attio = data;
@@ -1637,12 +1649,6 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 	g_slist_free(uuids);
 
-	if (device->attios) {
-		device->attrib = g_attrib_ref(req->attrib);
-		g_attrib_set_destroy_function(device->attrib, attrib_destroyed,
-								device);
-	}
-
 	create_device_reply(device, req);
 
 	store_services(device);
@@ -1653,29 +1659,78 @@ done:
 	browse_request_free(req, shutdown);
 }
 
-static void gatt_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
+static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
-	struct browse_req *req = user_data;
-	struct btd_device *device = req->device;
+	struct btd_device *device = user_data;
+	struct browse_req *req = device->browse;
 
 	if (gerr) {
 		DBusMessage *reply;
 
 		DBG("%s", gerr->message);
 
-		reply = btd_error_failed(req->msg, gerr->message);
-		g_dbus_send_message(req->conn, reply);
+		if (req) {
+			reply = btd_error_failed(req->msg, gerr->message);
+			g_dbus_send_message(req->conn, reply);
 
-		device->browse = NULL;
-		browse_request_free(req, TRUE);
+			device->browse = NULL;
+			browse_request_free(req, TRUE);
+		}
 
 		return;
 	}
 
-	req->attrib = g_attrib_new(io);
+	device->attrib = g_attrib_new(io);
+	g_attrib_set_destroy_function(device->attrib, attrib_destroyed, device);
+
+	if (req)
+		gatt_discover_primary(device->attrib, NULL, primary_cb, req);
+	else if (device->attios)
+		g_slist_foreach(device->attios, attio_connected,
+							device->attrib);
+
 	g_io_channel_unref(io);
+}
+
+static gboolean att_auto_connect(gpointer user_data)
+{
+	struct btd_device *device = user_data;
+	struct btd_adapter *adapter = device->adapter;
+	GIOChannel *io;
+	GError *gerr = NULL;
+	char addr[18];
+	bdaddr_t sba;
+
+	adapter_get_address(adapter, &sba);
+	ba2str(&device->bdaddr, addr);
+
+	DBG("Connection attempt to: %s", addr);
+
+	if (device->type != DEVICE_TYPE_LE) {
+		io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
+					device, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, &sba,
+					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
+					BT_IO_OPT_PSM, ATT_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+	} else {
+		io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
+					device, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, &sba,
+					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
+					BT_IO_OPT_CID, ATT_CID,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+	}
+
+	if (io == NULL) {
+		error("ATT bt_io_connect(%s): %s", addr, gerr->message);
+		g_error_free(gerr);
+		return TRUE;
+	}
 
-	gatt_discover_primary(req->attrib, NULL, primary_cb, req);
+	return TRUE;
 }
 
 int device_browse_primary(struct btd_device *device, DBusConnection *conn,
@@ -1696,7 +1751,8 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 
 	sec_level = secure ? BT_IO_SEC_HIGH : BT_IO_SEC_LOW;
 
-	req->io = bt_io_connect(BT_IO_L2CAP, gatt_connect_cb, req, NULL, NULL,
+	req->io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
+				device, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_CID, ATT_CID,
@@ -2505,6 +2561,11 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 	if (device->attrib && cfunc)
 		cfunc(device->attrib, user_data);
 
+	if (device->attioid == 0)
+		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
+							att_auto_connect,
+							device);
+
 	return attio->id;
 }
 
@@ -2532,5 +2593,10 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	g_free(attio);
 
+	if (device->attioid) {
+		g_source_remove(device->attioid);
+		device->attioid = 0;
+	}
+
 	return TRUE;
 }
-- 
1.7.6

