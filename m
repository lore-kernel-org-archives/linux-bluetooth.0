Return-Path: <cyrus@holtmann.org>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sunil Kumar Behera <sunil.behera@samsung.com>
Subject: [PATCH obexd 2/2] client: Add SendEvent function
Date: Mon, 17 Sep 2012 20:22:25 +0530
Message-id: <1347893545-13202-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function will allow MSE to notify the MCE
on events affecting message listings within
MSE's folder structure.
---
 client/mns.c       |  138 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/client-api.txt |   12 +++++
 2 files changed, 150 insertions(+)

diff --git a/client/mns.c b/client/mns.c
index f5a5905..96ba1bc 100644
--- a/client/mns.c
+++ b/client/mns.c
@@ -46,6 +46,21 @@
 #define ERROR_INTERFACE "org.bluez.obex.Error"
 #define MNS_UUID "00001133-0000-1000-8000-00805f9b34fb"
 
+#define MASINSTANCEID_TAG	0x0F
+
+enum msg_event_type {
+	EVENT_TYPE_NEW_MESSAGE,
+	EVENT_TYPE_DELIVERY_SUCCESS,
+	EVENT_TYPE_SENDING_SUCCESS,
+	EVENT_TYPE_DELIVERY_FAILURE,
+	EVENT_TYPE_SENDING_FAILURE,
+	EVENT_TYPE_MEMORY_FULL,
+	EVENT_TYPE_MEMORY_AVAILABLE,
+	EVENT_TYPE_MESSAGE_DELETED,
+	EVENT_TYPE_MESSAGE_SHIFT,
+	EVENT_TYPE_UNKNOWN,
+};
+
 struct mns_data {
 	struct obc_session *session;
 	DBusMessage *msg;
@@ -53,7 +68,130 @@ struct mns_data {
 
 static DBusConnection *conn = NULL;
 
+static int get_event_type(gchar *event_type)
+{
+	if (!g_strcmp0(event_type, "NewMessage"))
+		return EVENT_TYPE_NEW_MESSAGE;
+	else if (!g_strcmp0(event_type, "DeliverySuccess"))
+		return EVENT_TYPE_DELIVERY_SUCCESS;
+	else if (!g_strcmp0(event_type, "SendingSuccess"))
+		return EVENT_TYPE_SENDING_SUCCESS;
+	else if (!g_strcmp0(event_type, "DeliveryFailure"))
+		return EVENT_TYPE_DELIVERY_FAILURE;
+	else if (!g_strcmp0(event_type, "SendingFailure"))
+		return EVENT_TYPE_SENDING_FAILURE;
+	else if (!g_strcmp0(event_type, "MemoryFull"))
+		return EVENT_TYPE_MEMORY_FULL;
+	else if (!g_strcmp0(event_type, "MemoryAvailable"))
+		return EVENT_TYPE_MEMORY_AVAILABLE;
+	else if (!g_strcmp0(event_type, "MessageDeleted"))
+		return EVENT_TYPE_MESSAGE_DELETED;
+	else if (!g_strcmp0(event_type, "MessageShift"))
+		return EVENT_TYPE_MESSAGE_SHIFT;
+	else
+		return EVENT_TYPE_UNKNOWN;
+
+}
+
+static gchar *generate_event_report(gchar *event_type, gchar *handle,
+					gchar *folder, gchar *old_folder,
+					gchar *msg_type)
+{
+	GString *buf;
+	int event;
+
+	event = get_event_type(event_type);
+	if (event == EVENT_TYPE_UNKNOWN)
+		return NULL;
+
+	buf = g_string_new("<MAP-event-report version=\"1.0\">\n");
+	g_string_append_printf(buf, "<event type=\"%s\" ", event_type);
+
+	if (event == EVENT_TYPE_MEMORY_FULL ||
+				event == EVENT_TYPE_MEMORY_AVAILABLE)
+		goto done;
+
+	g_string_append_printf(buf, "handle=\"%s\" ", handle);
+	g_string_append_printf(buf, "folder=\"%s\" ", folder);
+
+	if (event == EVENT_TYPE_MESSAGE_SHIFT)
+		g_string_append_printf(buf, "old_folder=\"%s\" ", old_folder);
+
+	g_string_append_printf(buf, "msg_type=\"%s\" ", msg_type);
+
+done:
+	g_string_append(buf, "/>\n</MAP-event-report>\n");
+
+	return g_string_free(buf, FALSE);
+}
+
+static DBusMessage *send_event(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct mns_data *mns = user_data;
+	struct obc_transfer *transfer;
+	gchar *event_type;
+	gchar *handle;
+	gchar *folder;
+	gchar *old_folder;
+	gchar *msg_type;
+	gchar *report_buf;
+	guint8 buf[4];
+	gsize len;
+	GError *err;
+	DBusMessage *reply;
+	GObexApparam *apparam;
+
+	if (dbus_message_get_args(message, NULL, DBUS_TYPE_STRING, &event_type,
+					DBUS_TYPE_STRING, &handle,
+					DBUS_TYPE_STRING, &folder,
+					DBUS_TYPE_STRING, &old_folder,
+					DBUS_TYPE_STRING, &msg_type,
+					DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+					ERROR_INTERFACE ".InvalidArguments",
+					NULL);
+
+	report_buf = generate_event_report(event_type, handle, folder,
+							old_folder, msg_type);
+	if (!report_buf)
+		return g_dbus_create_error(message,
+					ERROR_INTERFACE ".InvalidArguments",
+					NULL);
+
+	transfer = obc_transfer_put("x-bt/MAP-event-report", NULL, NULL,
+					report_buf,  strlen(report_buf), &err);
+	g_free(report_buf);
+
+	if (transfer == NULL)
+		goto fail;
+
+	/* Obexd currently supports single SDP for MAS, so MASInstanceID is 0 */
+	apparam = g_obex_apparam_set_uint8(NULL, MASINSTANCEID_TAG, 0);
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+
+	obc_transfer_set_params(transfer, buf, len);
+
+	g_obex_apparam_free(apparam);
+
+	if (obc_session_queue(mns->session, transfer, NULL, NULL, &err))
+		return dbus_message_new_method_return(message);
+
+fail:
+	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed",
+							"%s", err->message);
+	g_error_free(err);
+	return reply;
+}
+
 static GDBusMethodTable mns_methods[] = {
+	{ GDBUS_ASYNC_METHOD("SendEvent",
+			GDBUS_ARGS({ "event_type", "s" }, { "handle", "s" },
+					{ "folder", "s" },
+					{ "old_folder", "s" },
+					{ "msg_type", "s" }), NULL, send_event)
+	},
 	{ }
 };
 
diff --git a/doc/client-api.txt b/doc/client-api.txt
index f447789..a35df0b 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -471,6 +471,18 @@ Methods		object, dict Get(string targetfile)
 			The properties of this transfer are also returned along
 			with the object path, to avoid a call to GetProperties.
 
+Message Notification hierarchy
+=========================
+
+Service		org.bluez.obex.client
+Interface	org.bluez.obex.MessageNotification
+Object path	[variable prefix]/{session0,session1,...}
+
+Methods		void SendEvent(string event_type, string handle, string folder,
+				 string old_folder, string msg_type)
+
+			Sends event reports to registered MAP Client.
+
 Transfer hierarchy
 ==================
 
-- 
1.7.9.5

