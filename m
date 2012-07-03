Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 09/10] client: Add Message.Get implementation
Date: Tue,  3 Jul 2012 21:28:13 +0300
Message-Id: <1341340094-32522-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
References: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/map.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/client/map.c b/client/map.c
index 4137dbe..e606cb2 100644
--- a/client/map.c
+++ b/client/map.c
@@ -252,7 +252,44 @@ static void map_msg_free(void *data)
 	g_free(msg);
 }
 
+static DBusMessage *map_msg_get(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct map_msg *msg = user_data;
+	struct obc_transfer *transfer;
+	const char *target_file;
+	GError *err = NULL;
+	DBusMessage *reply;
+
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_STRING, &target_file,
+				DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	transfer = obc_transfer_get("x-bt/message", msg->handle, target_file,
+									&err);
+	if (transfer == NULL)
+		goto fail;
+
+	if (!obc_session_queue(msg->data->session, transfer, NULL, NULL, &err))
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
 static const GDBusMethodTable map_msg_methods[] = {
+	{ GDBUS_METHOD("Get",
+			GDBUS_ARGS({ "targetfile", "s" }),
+			GDBUS_ARGS({ "transfer", "o" },
+						{ "properties", "a{sv}" }),
+			map_msg_get) },
 	{ }
 };
 
-- 
1.7.10.4

