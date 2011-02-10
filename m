Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] (NOT FOR UPSTREAM) Do GATT discovery when SDP GATT record is found
Date: Thu, 10 Feb 2011 11:48:40 -0200
Message-Id: <1297345720-15691-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes BR/EDR behavior. When GATT device driver is probed,
or a SDP search finds a GATT record, a second discovery via GATT is
started.

This patch is for testing purposes only; the GATT spec states that
this is not the correct behavior for dual-mode. Services that are
to be exposed in LE and BR/EDR shall have SDP records of their own,
as well, so GATT discovery is not needed.
---
 attrib/gatt.h       |    2 -
 attrib/manager.c    |    8 +++---
 lib/sdp.h           |    4 +++
 src/attrib-server.c |    3 --
 src/device.c        |   54 +++++++++++++++++++++++++++++++++++---------------
 5 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/attrib/gatt.h b/attrib/gatt.h
index 9f69646..a457b62 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -22,8 +22,6 @@
  *
  */
 
-#define GATT_CID 4
-
 typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
 
 guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_cb_t func,
diff --git a/attrib/manager.c b/attrib/manager.c
index f991f8e..0a1964e 100644
--- a/attrib/manager.c
+++ b/attrib/manager.c
@@ -37,8 +37,6 @@
 #include "client.h"
 #include "example.h"
 
-#define GATT_UUID	"00001801-0000-1000-8000-00805f9b34fb"
-
 static DBusConnection *connection;
 
 static int client_probe(struct btd_device *device, GSList *uuids)
@@ -46,7 +44,7 @@ static int client_probe(struct btd_device *device, GSList *uuids)
 	const sdp_record_t *rec;
 	int psm = -1;
 
-	rec = btd_device_get_record(device, GATT_UUID);
+	rec = btd_device_get_record(device, GATT_UUID_STR);
 	if (rec) {
 		sdp_list_t *list;
 		if (sdp_get_access_protos(rec, &list) < 0)
@@ -61,6 +59,8 @@ static int client_probe(struct btd_device *device, GSList *uuids)
 			return -1;
 	}
 
+	device_browse_primary(device, NULL, NULL, FALSE);
+
 	return attrib_client_register(device, psm);
 }
 
@@ -71,7 +71,7 @@ static void client_remove(struct btd_device *device)
 
 static struct btd_device_driver client_driver = {
 	.name = "gatt-client",
-	.uuids = BTD_UUIDS(GATT_UUID),
+	.uuids = BTD_UUIDS(GATT_UUID_STR),
 	.probe = client_probe,
 	.remove = client_remove,
 };
diff --git a/lib/sdp.h b/lib/sdp.h
index 16b59fc..9abfc1f 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -44,6 +44,8 @@ extern "C" {
  * of the Bluetooth Specification
  */
 #define SDP_PSM 		0x0001
+#define GATT_PSM		0x001f
+#define GATT_CID		0x0004
 
 /*
  * Protocol UUIDs
@@ -73,6 +75,8 @@ extern "C" {
 #define MCAP_DATA_UUID	0x001f
 #define L2CAP_UUID	0x0100
 #define ATT_UUID	0x1801
+#define GATT_UUID	0x1801
+#define GATT_UUID_STR	"00001801-0000-1000-8000-00805f9b34fb"
 
 /*
  * Service class identifiers of standard services and service groups
diff --git a/src/attrib-server.c b/src/attrib-server.c
index f03a5b9..bb25d13 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -46,9 +46,6 @@
 
 #include "attrib-server.h"
 
-#define GATT_PSM 0x1f
-#define GATT_CID 4
-
 static GSList *database = NULL;
 
 struct gatt_channel {
diff --git a/src/device.c b/src/device.c
index 0fef71a..bfade65 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1375,6 +1375,9 @@ static void create_device_reply(struct btd_device *device, struct browse_req *re
 {
 	DBusMessage *reply;
 
+	if (!req->msg)
+		return;
+
 	reply = dbus_message_new_method_return(req->msg);
 	if (!reply)
 		return;
@@ -1460,6 +1463,10 @@ cleanup:
 
 	device->browse = NULL;
 	browse_request_free(req);
+
+	if (g_slist_find_custom(device->uuids, GATT_UUID_STR,
+					(GCompareFunc) strcasecmp) != NULL)
+		device_browse_primary(device, NULL, NULL, FALSE);
 }
 
 static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
@@ -1544,9 +1551,11 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	char *str;
 
 	if (status) {
-		DBusMessage *reply;
-		reply = btd_error_failed(req->msg, att_ecode2str(status));
-		g_dbus_send_message(req->conn, reply);
+		if (req->msg) {
+			DBusMessage *reply;
+			reply = btd_error_failed(req->msg, att_ecode2str(status));
+			g_dbus_send_message(req->conn, reply);
+		}
 		goto done;
 	}
 
@@ -1588,8 +1597,10 @@ static void gatt_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 		DBG("%s", gerr->message);
 
-		reply = btd_error_failed(req->msg, gerr->message);
-		g_dbus_send_message(req->conn, reply);
+		if (req->msg) {
+			reply = btd_error_failed(req->msg, gerr->message);
+			g_dbus_send_message(req->conn, reply);
+		}
 
 		device->browse = NULL;
 		browse_request_free(req);
@@ -1619,22 +1630,33 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 
 	sec_level = secure ? BT_IO_SEC_HIGH : BT_IO_SEC_LOW;
 
-	req->io = bt_io_connect(BT_IO_L2CAP, gatt_connect_cb, req, NULL, NULL,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
-				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
-				BT_IO_OPT_CID, GATT_CID,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
-				BT_IO_OPT_INVALID);
-
-	if (req->io == NULL ) {
+	if (device_get_type(device) == DEVICE_TYPE_BREDR)
+		req->io = bt_io_connect(BT_IO_L2CAP, gatt_connect_cb, req, NULL, NULL,
+					BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
+					BT_IO_OPT_PSM, GATT_PSM,
+					BT_IO_OPT_SEC_LEVEL, sec_level,
+					BT_IO_OPT_INVALID);
+	else
+		req->io = bt_io_connect(BT_IO_L2CAP, gatt_connect_cb, req, NULL, NULL,
+					BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
+					BT_IO_OPT_CID, GATT_CID,
+					BT_IO_OPT_SEC_LEVEL, sec_level,
+					BT_IO_OPT_INVALID);
+
+	if (req->io == NULL) {
 		browse_request_free(req);
 		return -EIO;
 	}
 
-	if (conn == NULL)
-		conn = get_dbus_connection();
+	if (msg) {
+		if (conn == NULL)
+			conn = get_dbus_connection();
+
+		req->conn = dbus_connection_ref(conn);
+	}
 
-	req->conn = dbus_connection_ref(conn);
 	device->browse = req;
 
 	if (msg) {
-- 
1.7.1

