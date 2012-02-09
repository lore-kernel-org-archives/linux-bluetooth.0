Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/7] device: Consolidate ATT connection management
Date: Thu,  9 Feb 2012 12:56:03 -0300
Message-Id: <1328802969-20244-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch centralizes the connection management for ATT channels
grouping the common code. Based on the result of the ATT connection
result, error or success callback is called.
---
 src/device.c |  151 ++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 88 insertions(+), 63 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3f4ac76..f57f090 100644
--- a/src/device.c
+++ b/src/device.c
@@ -116,6 +116,15 @@ struct attio_data {
 	gpointer user_data;
 };
 
+typedef void (*attio_error_cb) (const GError *gerr, gpointer user_data);
+typedef void (*attio_success_cb) (gpointer user_data);
+
+struct att_callbacks {
+	attio_error_cb error;		/* Callback for error */
+	attio_success_cb success;	/* Callback for success */
+	gpointer user_data;
+};
+
 struct btd_device {
 	bdaddr_t	bdaddr;
 	addr_type_t	type;
@@ -1810,7 +1819,8 @@ done:
 
 static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
-	struct btd_device *device = user_data;
+	struct att_callbacks *attcb = user_data;
+	struct btd_device *device = attcb->user_data;
 	GAttrib *attrib;
 
 	g_io_channel_unref(device->att_io);
@@ -1819,14 +1829,10 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (gerr) {
 		DBG("%s", gerr->message);
 
-		if (device->auto_connect)
-			device->auto_id = g_timeout_add_seconds_full(
-						G_PRIORITY_DEFAULT_IDLE,
-						AUTO_CONNECTION_INTERVAL,
-						att_connect, device,
-						att_connect_dispatched);
+		if (attcb->error)
+			attcb->error(gerr, user_data);
 
-		return;
+		goto done;
 	}
 
 	attrib = g_attrib_new(io);
@@ -1834,19 +1840,48 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (device->attachid == 0)
 		error("Attribute server attach failure!");
 
-	if (device->attios) {
-		device->attrib = attrib;
-		g_attrib_set_disconnect_function(device->attrib,
-						attrib_disconnected, device);
-		g_slist_foreach(device->attios, attio_connected,
-							device->attrib);
-	}
+	device->attrib = attrib;
+	g_attrib_set_disconnect_function(device->attrib,
+					attrib_disconnected, device);
+
+	if (attcb->success)
+		attcb->success(user_data);
+done:
+	g_free(attcb);
+}
+
+static void att_error_cb(const GError *gerr, gpointer user_data)
+{
+	struct att_callbacks *attcb = user_data;
+	struct btd_device *device = attcb->user_data;
+
+	if (device->auto_connect == FALSE)
+		return;
+
+	device->auto_id = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT_IDLE,
+						AUTO_CONNECTION_INTERVAL,
+						att_connect, device,
+						att_connect_dispatched);
+
+	DBG("Enabling automatic connections");
+}
+
+static void att_success_cb(gpointer user_data)
+{
+	struct att_callbacks *attcb = user_data;
+	struct btd_device *device = attcb->user_data;
+
+	if (device->attios == NULL)
+		return;
+
+	g_slist_foreach(device->attios, attio_connected, device->attrib);
 }
 
 static gboolean att_connect(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 	struct btd_adapter *adapter = device->adapter;
+	struct att_callbacks *attcb;
 	GIOChannel *io;
 	GError *gerr = NULL;
 	char addr[18];
@@ -1857,9 +1892,14 @@ static gboolean att_connect(gpointer user_data)
 
 	DBG("Connection attempt to: %s", addr);
 
+	attcb = g_new0(struct att_callbacks, 1);
+	attcb->error = att_error_cb;
+	attcb->success = att_success_cb;
+	attcb->user_data = device;
+
 	if (device_is_bredr(device)) {
 		io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
-					device, NULL, &gerr,
+					attcb, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, &sba,
 					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 					BT_IO_OPT_PSM, ATT_PSM,
@@ -1867,7 +1907,7 @@ static gboolean att_connect(gpointer user_data)
 					BT_IO_OPT_INVALID);
 	} else {
 		io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
-					device, NULL, &gerr,
+					attcb, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, &sba,
 					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 					BT_IO_OPT_CID, ATT_CID,
@@ -1878,6 +1918,7 @@ static gboolean att_connect(gpointer user_data)
 	if (io == NULL) {
 		error("ATT bt_io_connect(%s): %s", addr, gerr->message);
 		g_error_free(gerr);
+		g_free(attcb);
 		return FALSE;
 	}
 
@@ -1886,41 +1927,37 @@ static gboolean att_connect(gpointer user_data)
 	return FALSE;
 }
 
-static void browse_primary_connect_cb(GIOChannel *io, GError *gerr,
-							gpointer user_data)
+static void att_browse_error_cb(const GError *gerr, gpointer user_data)
 {
-	struct btd_device *device = user_data;
+	struct att_callbacks *attcb = user_data;
+	struct btd_device *device = attcb->user_data;
 	struct browse_req *req = device->browse;
 
-	g_io_channel_unref(device->att_io);
-	device->att_io = NULL;
-
-	if (gerr) {
+	if (req->msg) {
 		DBusMessage *reply;
 
-		DBG("%s", gerr->message);
-
 		reply = btd_error_failed(req->msg, gerr->message);
 		g_dbus_send_message(req->conn, reply);
-
-		device->browse = NULL;
-		browse_request_free(req);
-
-		return;
 	}
 
-	device->attrib = g_attrib_new(io);
-	device->attachid = attrib_channel_attach(device->attrib, TRUE);
-	if (device->attachid == 0)
-		error("Attribute server attach failure!");
+	device->browse = NULL;
+	browse_request_free(req);
+}
 
-	gatt_discover_primary(device->attrib, NULL, primary_cb, req);
+static void att_browse_cb(gpointer user_data)
+{
+	struct att_callbacks *attcb = user_data;
+	struct btd_device *device = attcb->user_data;
+
+	gatt_discover_primary(device->attrib, NULL, primary_cb,
+							device->browse);
 }
 
 int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 				DBusMessage *msg, gboolean secure)
 {
 	struct btd_adapter *adapter = device->adapter;
+	struct att_callbacks *attcb;
 	struct browse_req *req;
 	BtIOSecLevel sec_level;
 	bdaddr_t src;
@@ -1935,8 +1972,13 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 
 	sec_level = secure ? BT_IO_SEC_HIGH : BT_IO_SEC_LOW;
 
-	device->att_io = bt_io_connect(BT_IO_L2CAP, browse_primary_connect_cb,
-				device, NULL, NULL,
+	attcb = g_new0(struct att_callbacks, 1);
+	attcb->error = att_browse_error_cb;
+	attcb->success = att_browse_cb;
+	attcb->user_data = device;
+
+	device->att_io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
+				attcb, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_CID, ATT_CID,
@@ -1945,6 +1987,7 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 
 	if (device->att_io == NULL) {
 		browse_request_free(req);
+		g_free(attcb);
 		return -EIO;
 	}
 
@@ -2308,29 +2351,6 @@ static void create_bond_req_exit(DBusConnection *conn, void *user_data)
 	}
 }
 
-static void bonding_connect_cb(GIOChannel *io, GError *gerr,
-							gpointer user_data)
-{
-	struct btd_device *device = user_data;
-
-	g_io_channel_unref(device->att_io);
-	device->att_io = NULL;
-
-	if (gerr) {
-		DBusMessage *reply = btd_error_failed(device->bonding->msg,
-								gerr->message);
-
-		g_dbus_send_message(device->bonding->conn, reply);
-		DBG("%s", gerr->message);
-		return;
-	}
-
-	device->attrib = g_attrib_new(io);
-	device->attachid = attrib_channel_attach(device->attrib, TRUE);
-	if (device->attachid == 0)
-		error("Attribute server attach failure!");
-}
-
 DBusMessage *device_create_bonding(struct btd_device *device,
 					DBusConnection *conn,
 					DBusMessage *msg,
@@ -2348,13 +2368,17 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 		return btd_error_already_exists(msg);
 
 	if (device_is_le(device)) {
+		struct att_callbacks *attcb;
 		GError *gerr = NULL;
 		bdaddr_t sba;
 
 		adapter_get_address(adapter, &sba);
 
-		device->att_io = bt_io_connect(BT_IO_L2CAP, bonding_connect_cb,
-					device, NULL, &gerr,
+		attcb = g_new0(struct att_callbacks, 1);
+		attcb->user_data = device;
+
+		device->att_io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
+					attcb, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, &sba,
 					BT_IO_OPT_DEST_BDADDR,&device->bdaddr,
 					BT_IO_OPT_CID, ATT_CID,
@@ -2367,6 +2391,7 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 
 			error("Bonding bt_io_connect(): %s", gerr->message);
 			g_error_free(gerr);
+			g_free(attcb);
 			return reply;
 		}
 	}
-- 
1.7.8.4

