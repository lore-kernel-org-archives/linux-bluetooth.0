Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] device: Split att_connect_cb
Date: Wed,  8 Feb 2012 14:55:06 -0300
Message-Id: <1328723708-21731-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to reduce code complexity, all code related to
device_browse_primary was moved to a new function called
browse_primary_connect_cb. This way att_connect_cb has
only code related to att_connect.
---
 src/device.c |   48 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/src/device.c b/src/device.c
index c7c741c..311dca1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1818,21 +1818,12 @@ done:
 static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct btd_device *device = user_data;
-	struct browse_req *req = device->browse;
 	GAttrib *attrib;
 
 	if (gerr) {
-		DBusMessage *reply;
-
 		DBG("%s", gerr->message);
 
-		if (req) {
-			reply = btd_error_failed(req->msg, gerr->message);
-			g_dbus_send_message(req->conn, reply);
-
-			device->browse = NULL;
-			browse_request_free(req, TRUE);
-		} else if (device->auto_connect)
+		if (device->auto_connect)
 			device->auto_id = g_timeout_add_seconds_full(
 						G_PRIORITY_DEFAULT_IDLE,
 						AUTO_CONNECTION_INTERVAL,
@@ -1847,10 +1838,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (device->attachid == 0)
 		error("Attribute server attach failure!");
 
-	if (req) {
-		req->attrib = attrib;
-		gatt_discover_primary(req->attrib, NULL, primary_cb, req);
-	} else if (device->attios) {
+	if (device->attios) {
 		device->attrib = attrib;
 		g_attrib_set_disconnect_function(device->attrib,
 						attrib_disconnected, device);
@@ -1902,6 +1890,36 @@ static gboolean att_connect(gpointer user_data)
 	return FALSE;
 }
 
+static void browse_primary_connect_cb(GIOChannel *io, GError *gerr,
+							gpointer user_data)
+{
+	struct btd_device *device = user_data;
+	struct browse_req *req = device->browse;
+	GAttrib *attrib;
+
+	if (gerr) {
+		DBusMessage *reply;
+
+		DBG("%s", gerr->message);
+
+		reply = btd_error_failed(req->msg, gerr->message);
+		g_dbus_send_message(req->conn, reply);
+
+		device->browse = NULL;
+		browse_request_free(req, TRUE);
+
+		return;
+	}
+
+	attrib = g_attrib_new(io);
+	device->attachid = attrib_channel_attach(attrib, TRUE);
+	if (device->attachid == 0)
+		error("Attribute server attach failure!");
+
+	req->attrib = attrib;
+	gatt_discover_primary(req->attrib, NULL, primary_cb, req);
+}
+
 int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 				DBusMessage *msg, gboolean secure)
 {
@@ -1920,7 +1938,7 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 
 	sec_level = secure ? BT_IO_SEC_HIGH : BT_IO_SEC_LOW;
 
-	req->io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
+	req->io = bt_io_connect(BT_IO_L2CAP, browse_primary_connect_cb,
 				device, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
-- 
1.7.9

