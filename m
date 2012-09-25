Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ v7 9/9] core: Suspend scanning before connect on pairing
Date: Tue, 25 Sep 2012 14:38:06 -0300
Message-Id: <1348594686-26221-9-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
References: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there is a disconnected bonded device there will be a scanning
procedure active due to the General Connection Establishment Procedure.
This scan have to be suspended before trying to connect to the remote
device for pairing.
---
 src/device.c | 107 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 34 deletions(-)

diff --git a/src/device.c b/src/device.c
index d23ea46..1cd9b5a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1959,6 +1959,36 @@ done:
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
+		g_dbus_remove_watch(btd_get_dbus_connection(),
+							bonding->listener_id);
+
+	if (bonding->msg)
+		dbus_message_unref(bonding->msg);
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
@@ -1988,6 +2018,21 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
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
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
+			bonding_request_cancel(device->bonding);
+			bonding_request_free(device->bonding);
+		}
+	}
+
 done:
 	g_free(attcb);
 }
@@ -2039,16 +2084,30 @@ GIOChannel *device_att_connect(gpointer user_data)
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
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
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
@@ -2368,36 +2427,6 @@ static DBusMessage *new_authentication_return(DBusMessage *msg, uint8_t status)
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
-		g_dbus_remove_watch(btd_get_dbus_connection(),
-							bonding->listener_id);
-
-	if (bonding->msg)
-		dbus_message_unref(bonding->msg);
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
 	if (device->paired == value)
@@ -2534,6 +2563,16 @@ DBusMessage *device_create_bonding(struct btd_device *device,
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

