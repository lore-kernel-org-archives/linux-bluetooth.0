Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ v6 11/11] core: Suspend scanning before connect on pairing
Date: Tue, 11 Sep 2012 10:33:07 -0300
Message-Id: <1347370387-17670-11-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1347370387-17670-1-git-send-email-jprvita@openbossa.org>
References: <1347370387-17670-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there is a disconnected bonded device there will be a scanning
procedure active due to the General Connection Establishment Procedure.
This scan have to be suspended before trying to connect to the remote
device for pairing.
---
 src/device.c | 150 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 77 insertions(+), 73 deletions(-)

diff --git a/src/device.c b/src/device.c
index 04ed96f..726f95b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1675,8 +1675,8 @@ send_reply:
 	else if (dbus_message_is_method_call(req->msg, ADAPTER_INTERFACE,
 						"CreateDevice")) {
 		if (err < 0) {
-			DBusMessage *reply;
-			reply = btd_error_failed(req->msg, strerror(-err));
+			DBusMessage *reply = btd_error_failed(req->msg,
+							strerror(-err));
 			g_dbus_send_message(req->conn, reply);
 			goto cleanup;
 		}
@@ -1888,6 +1888,38 @@ done:
 	browse_request_free(req);
 }
 
+static void bonding_request_free(struct bonding_req *bonding)
+{
+	struct btd_device *device;
+
+	if (!bonding)
+		return;
+
+	if (bonding->listener_id)
+		g_dbus_remove_watch(bonding->conn, bonding->listener_id);
+
+	if (bonding->msg)
+		dbus_message_unref(bonding->msg);
+
+	if (bonding->conn)
+		dbus_connection_unref(bonding->conn);
+
+	device = bonding->device;
+	g_free(bonding);
+
+	if (!device)
+		return;
+
+	device->bonding = NULL;
+
+	if (!device->agent)
+		return;
+
+	agent_cancel(device->agent);
+	agent_free(device->agent);
+	device->agent = NULL;
+}
+
 static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct att_callbacks *attcb = user_data;
@@ -1917,6 +1949,21 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	if (attcb->success)
 		attcb->success(user_data);
+
+	if (device->bonding) {
+		/* this is a LE device during pairing */
+		int err = adapter_create_bonding(device->adapter,
+				&device->bdaddr, device->bdaddr_type,
+				agent_get_io_capability(device->agent));
+		if (err < 0) {
+			DBusMessage *reply = btd_error_failed(
+					device->bonding->msg, strerror(-err));
+			g_dbus_send_message(device->bonding->conn, reply);
+			bonding_request_cancel(device->bonding);
+			bonding_request_free(device->bonding);
+		}
+	}
+
 done:
 	g_free(attcb);
 }
@@ -1968,16 +2015,30 @@ GIOChannel *device_att_connect(gpointer user_data)
 	attcb->user_data = device;
 
 	if (device_is_bredr(device)) {
-		io = bt_io_connect(att_connect_cb,
-					attcb, NULL, &gerr,
+		io = bt_io_connect(att_connect_cb, attcb, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, &sba,
 					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 					BT_IO_OPT_PSM, ATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID);
+	} else if (device->bonding) {
+		/* this is a LE device during pairing, using low sec level */
+		io = bt_io_connect(att_connect_cb, attcb, NULL, &gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &sba,
+				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
+				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
+				BT_IO_OPT_CID, ATT_CID,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+		if (io == NULL) {
+			DBusMessage *reply = btd_error_failed(
+					device->bonding->msg, gerr->message);
+			g_dbus_send_message(device->bonding->conn, reply);
+			bonding_request_cancel(device->bonding);
+			bonding_request_free(device->bonding);
+		}
 	} else {
-		io = bt_io_connect(att_connect_cb,
-				attcb, NULL, &gerr,
+		io = bt_io_connect(att_connect_cb, attcb, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
@@ -2303,38 +2364,6 @@ static DBusMessage *new_authentication_return(DBusMessage *msg, uint8_t status)
 	}
 }
 
-static void bonding_request_free(struct bonding_req *bonding)
-{
-	struct btd_device *device;
-
-	if (!bonding)
-		return;
-
-	if (bonding->listener_id)
-		g_dbus_remove_watch(bonding->conn, bonding->listener_id);
-
-	if (bonding->msg)
-		dbus_message_unref(bonding->msg);
-
-	if (bonding->conn)
-		dbus_connection_unref(bonding->conn);
-
-	device = bonding->device;
-	g_free(bonding);
-
-	if (!device)
-		return;
-
-	device->bonding = NULL;
-
-	if (!device->agent)
-		return;
-
-	agent_cancel(device->agent);
-	agent_free(device->agent);
-	device->agent = NULL;
-}
-
 void device_set_paired(struct btd_device *device, gboolean value)
 {
 	DBusConnection *conn = get_dbus_connection();
@@ -2428,41 +2457,6 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 	if (device_is_bonded(device))
 		return btd_error_already_exists(msg);
 
-	if (device_is_le(device)) {
-		struct att_callbacks *attcb;
-		GError *gerr = NULL;
-		bdaddr_t sba;
-
-		adapter_get_address(adapter, &sba);
-
-		attcb = g_new0(struct att_callbacks, 1);
-		attcb->user_data = device;
-
-		device->att_io = bt_io_connect(att_connect_cb,
-				attcb, NULL, &gerr,
-				BT_IO_OPT_SOURCE_BDADDR, &sba,
-				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
-				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
-				BT_IO_OPT_CID, ATT_CID,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-				BT_IO_OPT_INVALID);
-
-		if (device->att_io == NULL) {
-			DBusMessage *reply = btd_error_failed(msg,
-								gerr->message);
-
-			error("Bonding bt_io_connect(): %s", gerr->message);
-			g_error_free(gerr);
-			g_free(attcb);
-			return reply;
-		}
-	}
-
-	err = adapter_create_bonding(adapter, &device->bdaddr,
-					device->bdaddr_type, capability);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
 	bonding = bonding_request_new(conn, msg, device, agent_path,
 					capability);
 
@@ -2474,6 +2468,16 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 	device->bonding = bonding;
 	bonding->device = device;
 
+	if (device_is_le(device)) {
+		adapter_connect_list_add(adapter, device);
+		return NULL;
+	}
+
+	err = adapter_create_bonding(adapter, &device->bdaddr,
+					device->bdaddr_type, capability);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
 	return NULL;
 }
 
-- 
1.7.11.4

