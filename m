Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 03/12] Fix crash when create device is cancelled
Date: Wed,  6 Jul 2011 18:23:08 -0300
Message-Id: <1309987388-9929-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-4-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-4-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the owner leaves the bus or cancels the device creation process
the connection callback is called causing invalid memory access.
---
 src/device.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index f22a7fa..b14e6e7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -95,6 +95,7 @@ struct browse_req {
 	DBusConnection *conn;
 	DBusMessage *msg;
 	GAttrib *attrib;
+	GIOChannel *io;
 	struct btd_device *device;
 	GSList *match_uuids;
 	GSList *profiles_added;
@@ -154,10 +155,15 @@ static uint16_t uuid_list[] = {
 
 static GSList *device_drivers = NULL;
 
-static void browse_request_free(struct browse_req *req)
+static void browse_request_free(struct browse_req *req, gboolean shutdown)
 {
 	if (req->listener_id)
 		g_dbus_remove_watch(req->conn, req->listener_id);
+	if (req->io) {
+		if (shutdown)
+			g_io_channel_shutdown(req->io, FALSE, NULL);
+		g_io_channel_unref(req->io);
+	}
 	if (req->msg)
 		dbus_message_unref(req->msg);
 	if (req->conn)
@@ -189,7 +195,7 @@ static void browse_request_cancel(struct browse_req *req)
 	bt_cancel_discovery(&src, &device->bdaddr);
 
 	device->browse = NULL;
-	browse_request_free(req);
+	browse_request_free(req, TRUE);
 }
 
 static void device_free(gpointer user_data)
@@ -1493,7 +1499,7 @@ cleanup:
 	}
 
 	device->browse = NULL;
-	browse_request_free(req);
+	browse_request_free(req, FALSE);
 }
 
 static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
@@ -1588,11 +1594,13 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	struct browse_req *req = user_data;
 	struct btd_device *device = req->device;
 	GSList *l, *uuids = NULL;
+	gboolean shutdown;
 
 	if (status) {
 		DBusMessage *reply;
 		reply = btd_error_failed(req->msg, att_ecode2str(status));
 		g_dbus_send_message(req->conn, reply);
+		shutdown = TRUE;
 		goto done;
 	}
 
@@ -1613,10 +1621,11 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	create_device_reply(device, req);
 
 	store_services(device);
+	shutdown = FALSE;
 
 done:
 	device->browse = NULL;
-	browse_request_free(req);
+	browse_request_free(req, shutdown);
 }
 
 static void gatt_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
@@ -1633,7 +1642,7 @@ static void gatt_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		g_dbus_send_message(req->conn, reply);
 
 		device->browse = NULL;
-		browse_request_free(req);
+		browse_request_free(req, TRUE);
 
 		return;
 	}
@@ -1650,7 +1659,6 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 	struct btd_adapter *adapter = device->adapter;
 	struct browse_req *req;
 	BtIOSecLevel sec_level;
-	GIOChannel *io;
 	bdaddr_t src;
 
 	if (device->browse)
@@ -1663,15 +1671,15 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 
 	sec_level = secure ? BT_IO_SEC_HIGH : BT_IO_SEC_LOW;
 
-	io = bt_io_connect(BT_IO_L2CAP, gatt_connect_cb, req, NULL, NULL,
+	req->io = bt_io_connect(BT_IO_L2CAP, gatt_connect_cb, req, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_CID, ATT_CID,
 				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 
-	if (io == NULL ) {
-		browse_request_free(req);
+	if (req->io == NULL) {
+		browse_request_free(req, FALSE);
 		return -EIO;
 	}
 
@@ -1724,7 +1732,7 @@ int device_browse_sdp(struct btd_device *device, DBusConnection *conn,
 
 	err = bt_search_service(&src, &device->bdaddr, &uuid, cb, req, NULL);
 	if (err < 0) {
-		browse_request_free(req);
+		browse_request_free(req, FALSE);
 		return err;
 	}
 
-- 
1.7.6

