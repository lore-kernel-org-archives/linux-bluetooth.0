Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: patrick.ohly@intel.com
Subject: [PATCH BlueZ 2/8] obexd/transfer: Add Transfer.Resume method
Date: Fri, 14 Feb 2014 17:52:58 +0200
Message-Id: <1392393184-15266-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
References: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This method can be used to resume ongoing transfers.
---
 obexd/client/transfer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 813d20b..6295b83 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -223,6 +223,30 @@ static DBusMessage *obc_transfer_suspend(DBusConnection *connection,
 	return g_dbus_create_reply(message, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *obc_transfer_resume(DBusConnection *connection,
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
+	g_obex_resume(transfer->obex);
+
+	transfer_set_status(transfer, TRANSFER_STATUS_ACTIVE);
+
+	return g_dbus_create_reply(message, DBUS_TYPE_INVALID);
+}
+
 static gboolean name_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct obc_transfer *transfer = data;
@@ -339,6 +363,7 @@ static gboolean get_session(const GDBusPropertyTable *property,
 
 static const GDBusMethodTable obc_transfer_methods[] = {
 	{ GDBUS_METHOD("Suspend", NULL, NULL, obc_transfer_suspend) },
+	{ GDBUS_METHOD("Resume", NULL, NULL, obc_transfer_resume) },
 	{ GDBUS_ASYNC_METHOD("Cancel", NULL, NULL,
 				obc_transfer_cancel) },
 	{ }
-- 
1.8.5.3

