Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: patrick.ohly@intel.com
Subject: [PATCH BlueZ 1/8] obexd/transfer: Add Transfer.Suspend method
Date: Fri, 14 Feb 2014 17:52:57 +0200
Message-Id: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This method can be used to suspend ongoing transfers.
---
 obexd/client/transfer.c | 60 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 5a8d4f2..813d20b 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -60,6 +60,7 @@ struct transfer_callback {
 enum {
 	TRANSFER_STATUS_QUEUED = 0,
 	TRANSFER_STATUS_ACTIVE,
+	TRANSFER_STATUS_SUSPENDED,
 	TRANSFER_STATUS_COMPLETE,
 	TRANSFER_STATUS_ERROR
 };
@@ -187,6 +188,41 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 	return NULL;
 }
 
+static void transfer_set_status(struct obc_transfer *transfer, uint8_t status)
+{
+	if (transfer->status == status)
+		return;
+
+	transfer->status = status;
+
+	g_dbus_emit_property_changed(transfer->conn, transfer->path,
+					TRANSFER_INTERFACE, "Status");
+}
+
+static DBusMessage *obc_transfer_suspend(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct obc_transfer *transfer = user_data;
+	const char *sender;
+
+	sender = dbus_message_get_sender(message);
+	if (g_strcmp0(transfer->owner, sender) != 0)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".NotAuthorized",
+				"Not Authorized");
+
+	if (transfer->xfer == 0)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".NotInProgress",
+				"Not in progress");
+
+	g_obex_suspend(transfer->obex);
+
+	transfer_set_status(transfer, TRANSFER_STATUS_SUSPENDED);
+
+	return g_dbus_create_reply(message, DBUS_TYPE_INVALID);
+}
+
 static gboolean name_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct obc_transfer *transfer = data;
@@ -269,6 +305,8 @@ static const char *status2str(uint8_t status)
 		return "queued";
 	case TRANSFER_STATUS_ACTIVE:
 		return "active";
+	case TRANSFER_STATUS_SUSPENDED:
+		return "suspended";
 	case TRANSFER_STATUS_COMPLETE:
 		return "complete";
 	case TRANSFER_STATUS_ERROR:
@@ -300,6 +338,7 @@ static gboolean get_session(const GDBusPropertyTable *property,
 }
 
 static const GDBusMethodTable obc_transfer_methods[] = {
+	{ GDBUS_METHOD("Suspend", NULL, NULL, obc_transfer_suspend) },
 	{ GDBUS_ASYNC_METHOD("Cancel", NULL, NULL,
 				obc_transfer_cancel) },
 	{ }
@@ -549,14 +588,6 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 	return TRUE;
 }
 
-static void transfer_set_status(struct obc_transfer *transfer, uint8_t status)
-{
-	transfer->status = status;
-
-	g_dbus_emit_property_changed(transfer->conn, transfer->path,
-					TRANSFER_INTERFACE, "Status");
-}
-
 static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
@@ -634,13 +665,15 @@ static void get_xfer_progress_first(GObex *obex, GError *err, GObexPacket *rsp,
 		return;
 	}
 
-	if (!g_obex_srm_active(obex)) {
-		req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
+	if (g_obex_srm_active(obex) ||
+				transfer->status == TRANSFER_STATUS_SUSPENDED)
+		return;
 
-		transfer->xfer = g_obex_get_req_pkt(obex, req, get_xfer_progress,
+	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
+
+	transfer->xfer = g_obex_get_req_pkt(obex, req, get_xfer_progress,
 						xfer_complete, transfer,
 						&err);
-	}
 }
 
 static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
@@ -689,7 +722,8 @@ static gboolean report_progress(gpointer data)
 		return FALSE;
 	}
 
-	if (transfer->status != TRANSFER_STATUS_ACTIVE)
+	if (transfer->status != TRANSFER_STATUS_ACTIVE &&
+				transfer->status != TRANSFER_STATUS_SUSPENDED)
 		transfer_set_status(transfer, TRANSFER_STATUS_ACTIVE);
 
 	g_dbus_emit_property_changed(transfer->conn, transfer->path,
-- 
1.8.5.3

