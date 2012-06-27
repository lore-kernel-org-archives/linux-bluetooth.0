Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 09/10] client: Add MessageAccess.GetMessage implementation
Date: Wed, 27 Jun 2012 15:04:54 +0300
Message-Id: <1340798695-6785-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
References: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/map.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/client/map.c b/client/map.c
index b8c0cb8..e5236d0 100644
--- a/client/map.c
+++ b/client/map.c
@@ -378,6 +378,38 @@ fail:
 	return reply;
 }
 
+static DBusMessage *map_get_message(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct map_data *map = user_data;
+	struct obc_transfer *transfer;
+	const char *handle, *target_file;
+	GError *err = NULL;
+	DBusMessage *reply;
+
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_STRING, &handle,
+				DBUS_TYPE_STRING, &target_file,
+				DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	transfer = obc_transfer_get("x-bt/message", handle, target_file, &err);
+	if (transfer == NULL)
+		goto fail;
+
+	if (!obc_session_queue(map->session, transfer, NULL, NULL, &err))
+		goto fail;
+
+	return obc_transfer_create_dbus_reply(transfer, message);
+
+fail:
+	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
+								err->message);
+	g_error_free(err);
+	return reply;
+}
+
 static const GDBusMethodTable map_methods[] = {
 	{ GDBUS_ASYNC_METHOD("SetFolder",
 				GDBUS_ARGS({ "name", "s" }), NULL,
@@ -390,6 +422,11 @@ static const GDBusMethodTable map_methods[] = {
 			GDBUS_ARGS({ "folder", "s" }, { "filter", "a{ss}" }),
 			GDBUS_ARGS({ "messages", "aa{sv}" }),
 			map_get_message_listing) },
+	{ GDBUS_METHOD("GetMessage",
+			GDBUS_ARGS({ "handle", "s" }, { "file", "s" }),
+			GDBUS_ARGS({ "transfer", "o" },
+						{ "properties", "a{sv}" }),
+			map_get_message) },
 	{ }
 };
 
-- 
1.7.10.2

