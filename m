Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 3/6] obexd/client/map: Add API Calls for request and handlers
 for response
Date: Tue, 07 Oct 2014 09:36:53 +0530
Message-id: <1412654816-14971-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
References: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 obexd/client/map.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 44db96c..50b498c 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1800,6 +1800,90 @@ static DBusMessage *map_push_message(DBusConnection *connection,
 	return push_message(map, message, filename, folder, apparam);
 }
 
+static void mas_instance_info_cb(struct obc_session *session,
+				struct obc_transfer *transfer,
+				GError *err, void *user_data)
+{
+	struct pending_request *request = user_data;
+	DBusMessage *reply;
+	char *contents;
+	size_t size;
+	int perr;
+
+	if (err != NULL) {
+		reply = g_dbus_create_error(request->msg,
+						ERROR_INTERFACE ".Failed",
+						"%s", err->message);
+		goto done;
+	}
+
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
+	if (perr < 0) {
+		reply = g_dbus_create_error(request->msg,
+						ERROR_INTERFACE ".Failed",
+						"Error reading contents: %s",
+						strerror(-perr));
+		goto done;
+	}
+
+	reply = dbus_message_new_method_return(request->msg);
+	if (reply == NULL) {
+		g_free(contents);
+		goto clean;
+	}
+
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &contents,
+							DBUS_TYPE_INVALID);
+done:
+	g_dbus_send_message(conn, reply);
+clean:
+	pending_request_free(request);
+
+}
+
+static DBusMessage *map_get_mas_instance_info(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct map_data *map = user_data;
+	GObexApparam *apparam;
+	struct pending_request *request;
+	struct obc_transfer *transfer;
+	GError *err = NULL;
+	DBusMessage *reply;
+
+	if (map->mas_instance_id < 0)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	apparam = g_obex_apparam_set_uint16(NULL, MAP_AP_MASINSTANCEID,
+							map->mas_instance_id);
+
+	transfer = obc_transfer_get("x-bt/MASInstanceInformation", NULL, NULL, &err);
+	if (transfer == NULL) {
+		g_obex_apparam_free(apparam);
+		goto fail;
+	}
+
+	obc_transfer_set_apparam(transfer, apparam);
+
+	request = pending_request_new(map, message);
+
+	if (!obc_session_queue(map->session, transfer, mas_instance_info_cb,
+							request, &err)) {
+		pending_request_free(request);
+		goto fail;
+	}
+
+	return NULL;
+
+fail:
+	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
+								err->message);
+	g_error_free(err);
+	return reply;
+
+}
+
 static const GDBusMethodTable map_methods[] = {
 	{ GDBUS_ASYNC_METHOD("SetFolder",
 				GDBUS_ARGS({ "name", "s" }), NULL,
@@ -1826,6 +1910,10 @@ static const GDBusMethodTable map_methods[] = {
 			GDBUS_ARGS({ "transfer", "o" },
 						{ "properties", "a{sv}" }),
 			map_push_message) },
+	{ GDBUS_ASYNC_METHOD("GetMASInstanceInfo",
+			NULL,
+			GDBUS_ARGS({ "description", "s" }),
+			map_get_mas_instance_info) },
 	{ }
 };
 
-- 
1.9.1

