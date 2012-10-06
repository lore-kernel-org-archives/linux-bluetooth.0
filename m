Return-Path: <cyrus@holtmann.org>
From: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
Subject: [PATCH 1/3] client: Add implementation for UpdateInbox
Date: Sat,  6 Oct 2012 19:22:09 +0530
Message-Id: <1349531535-706-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/map.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/client/map.c b/client/map.c
index 290eaae..c0a5bfc 100644
--- a/client/map.c
+++ b/client/map.c
@@ -1242,6 +1242,60 @@ static DBusMessage *map_list_filter_fields(DBusConnection *connection,
 	return reply;
 }
 
+static void update_inbox_cb(struct obc_session *session,
+			 struct obc_transfer *transfer,
+			 GError *err, void *user_data)
+{
+	struct map_data *map = user_data;
+	DBusMessage *reply;
+
+	if (err != NULL) {
+		reply = g_dbus_create_error(map->msg,
+						ERROR_INTERFACE ".Failed",
+						"%s", err->message);
+		goto done;
+	}
+
+	reply = dbus_message_new_method_return(map->msg);
+
+done:
+	g_dbus_send_message(conn, reply);
+	dbus_message_unref(map->msg);
+}
+
+static DBusMessage *map_update_inbox(DBusConnection *connection,
+				  DBusMessage *message, void *user_data)
+{
+	struct map_data *map = user_data;
+	DBusMessage *reply;
+	char contents[2];
+	struct obc_transfer *transfer;
+	GError *err = NULL;
+
+	contents[0] = FILLER_BYTE;
+	contents[1] = '\0';
+
+	transfer = obc_transfer_put("x-bt/MAP-messageUpdate", NULL, NULL,
+							contents,
+							sizeof(contents), &err);
+	if (transfer == NULL)
+		goto fail;
+
+	if (!obc_session_queue(map->session, transfer,
+			       update_inbox_cb, map, &err))
+		goto fail;
+
+	map->msg = dbus_message_ref(message);
+
+	return NULL;
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
@@ -1258,6 +1312,10 @@ static const GDBusMethodTable map_methods[] = {
 			NULL,
 			GDBUS_ARGS({ "fields", "as" }),
 			map_list_filter_fields) },
+	{ GDBUS_ASYNC_METHOD("UpdateInbox",
+			NULL,
+			NULL,
+			map_update_inbox) },
 	{ }
 };
 
-- 
1.7.10.4

