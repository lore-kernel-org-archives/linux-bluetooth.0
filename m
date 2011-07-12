Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 07/11] Remove implicit connection from generic API
Date: Tue, 12 Jul 2011 17:28:37 -0300
Message-Id: <1310502521-462-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Generic attribute API should not actively manage L2CAP connections.
GAttrib instance is notified through registered callbacks. SetProperty
or DiscoverCharacteristic now returns NotConnected error if the link
is down.
---
 attrib/client.c |  121 +++++--------------------------------------------------
 1 files changed, 10 insertions(+), 111 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 29cb34a..7f0dac4 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -72,7 +72,6 @@ struct gatt_service {
 	char *path;
 	GSList *chars;
 	GSList *watchers;
-	gboolean listen;
 };
 
 struct characteristic {
@@ -289,114 +288,18 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 	}
 }
 
-static void attrib_destroy(gpointer user_data)
-{
-	struct gatt_service *gatt = user_data;
-
-	gatt->attrib = NULL;
-}
-
-static void attrib_disconnect(gpointer user_data)
-{
-	struct gatt_service *gatt = user_data;
-
-	/* Remote initiated disconnection only */
-	g_attrib_unref(gatt->attrib);
-}
-
-static void connect_cb(GIOChannel *chan, GError *gerr, gpointer user_data)
-{
-	struct gatt_service *gatt = user_data;
-
-	if (gerr) {
-		error("%s", gerr->message);
-		goto fail;
-	}
-
-	if (gatt->attrib == NULL)
-		return;
-
-	/* Listen mode: used for notification and indication */
-	if (gatt->listen == TRUE) {
-		g_attrib_register(gatt->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					events_handler, gatt, NULL);
-		g_attrib_register(gatt->attrib,
-					ATT_OP_HANDLE_IND,
-					events_handler, gatt, NULL);
-		return;
-	}
-
-	return;
-fail:
-	g_attrib_unref(gatt->attrib);
-}
-
-static int l2cap_connect(struct gatt_service *gatt, GError **gerr,
-								gboolean listen)
-{
-	bdaddr_t sba, dba;
-	GIOChannel *io;
-
-	if (gatt->attrib != NULL) {
-		gatt->attrib = g_attrib_ref(gatt->attrib);
-		gatt->listen = listen;
-		return 0;
-	}
-
-	/*
-	 * FIXME: If the service doesn't support Client Characteristic
-	 * Configuration it is necessary to poll the server from time
-	 * to time checking for modifications.
-	 */
-	gatt_get_address(gatt, &sba, &dba);
-	if (gatt->psm < 0)
-		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, gerr,
-			BT_IO_OPT_SOURCE_BDADDR, &sba,
-			BT_IO_OPT_DEST_BDADDR, &dba,
-			BT_IO_OPT_CID, ATT_CID,
-			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-			BT_IO_OPT_INVALID);
-	else
-		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, gerr,
-			BT_IO_OPT_SOURCE_BDADDR, &sba,
-			BT_IO_OPT_DEST_BDADDR, &dba,
-			BT_IO_OPT_PSM, gatt->psm,
-			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-			BT_IO_OPT_INVALID);
-	if (!io)
-		return -1;
-
-	gatt->attrib = g_attrib_new(io);
-	g_io_channel_unref(io);
-	gatt->listen = listen;
-
-	g_attrib_set_destroy_function(gatt->attrib, attrib_destroy, gatt);
-	g_attrib_set_disconnect_function(gatt->attrib, attrib_disconnect,
-									gatt);
-
-	return 0;
-}
-
 static DBusMessage *register_watcher(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	const char *sender = dbus_message_get_sender(msg);
 	struct gatt_service *gatt = data;
 	struct watcher *watcher;
-	GError *gerr = NULL;
 	char *path;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	if (l2cap_connect(gatt, &gerr, TRUE) < 0) {
-		DBusMessage *reply = btd_error_failed(msg, gerr->message);
-		g_error_free(gerr);
-		return reply;
-	}
-
 	watcher = g_new0(struct watcher, 1);
 	watcher->name = g_strdup(sender);
 	watcher->gatt = gatt;
@@ -443,10 +346,12 @@ static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
 {
 	struct gatt_service *gatt = chr->gatt;
 	DBusMessageIter sub;
-	GError *gerr = NULL;
 	uint8_t *value;
 	int len;
 
+	if (gatt->attrib == NULL)
+		return btd_error_not_connected(msg);
+
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY ||
 			dbus_message_iter_get_element_type(iter) != DBUS_TYPE_BYTE)
 		return btd_error_invalid_args(msg);
@@ -455,12 +360,6 @@ static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
 
 	dbus_message_iter_get_fixed_array(&sub, &value, &len);
 
-	if (l2cap_connect(gatt, &gerr, FALSE) < 0) {
-		DBusMessage *reply = btd_error_failed(msg, gerr->message);
-		g_error_free(gerr);
-		return reply;
-	}
-
 	gatt_write_cmd(gatt->attrib, chr->handle, value, len, NULL, NULL);
 
 	characteristic_set_value(chr, value, len);
@@ -907,13 +806,9 @@ static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 	struct gatt_service *gatt = data;
 	struct att_primary *prim = gatt->prim;
 	struct query_data *qchr;
-	GError *gerr = NULL;
 
-	if (l2cap_connect(gatt, &gerr, FALSE) < 0) {
-		DBusMessage *reply = btd_error_failed(msg, gerr->message);
-		g_error_free(gerr);
-		return reply;
-	}
+	if (gatt->attrib == NULL)
+		return btd_error_not_connected(msg);
 
 	qchr = g_new0(struct query_data, 1);
 	qchr->gatt = gatt;
@@ -983,6 +878,11 @@ static void attio_connected(GAttrib *attrib, gpointer user_data)
 	struct gatt_service *gatt = user_data;
 
 	gatt->attrib = attrib;
+
+	g_attrib_register(gatt->attrib, ATT_OP_HANDLE_NOTIFY,
+					events_handler, gatt, NULL);
+	g_attrib_register(gatt->attrib, ATT_OP_HANDLE_IND,
+					events_handler, gatt, NULL);
 }
 
 static void attio_disconnected(gpointer user_data)
@@ -1006,7 +906,6 @@ static struct gatt_service *primary_register(DBusConnection *conn,
 	gatt->dev = btd_device_ref(device);
 	gatt->prim = prim;
 	gatt->psm = psm;
-	gatt->listen = FALSE;
 	gatt->conn = dbus_connection_ref(conn);
 	gatt->path = g_strdup_printf("%s/service%04x", device_path,
 								prim->start);
-- 
1.7.6

