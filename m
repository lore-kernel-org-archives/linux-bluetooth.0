Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 5/8] obexd: Add RegisterNotifications function
Date: Wed,  6 Feb 2013 15:45:19 +0100
Message-Id: <1360161922-6585-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1360161922-6585-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1360161922-6585-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This allows applications to register for all different types
of MAP event reports.

In response to this call, the MSE should connect to the local MNS
instance.
---
 doc/obex-api.txt   |  7 +++++
 obexd/client/map.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 6246933..ddbb9ab 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -630,6 +630,13 @@ Methods		void SetFolder(string name)
 
 			Possible errors: org.bluez.obex.Error.Failed
 
+		void RegisterNotifications(boolean)
+
+			Register / unregister reception of notifications.
+
+			Possible errors: org.bluez.obex.Error.InvalidArguments
+					 org.bluez.obex.Error.Failed
+
 Filter:		uint16 Offset:
 
 			Offset of the first item, default is 0
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 463d905..776f19c 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1499,6 +1499,86 @@ fail:
 	return reply;
 }
 
+static void notification_registration_cb(struct obc_session *session,
+				struct obc_transfer *transfer,
+				GError *err, void *user_data)
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
+static DBusMessage *set_notification_registration(struct map_data *map,
+							DBusMessage *message,
+							GObexApparam *apparam)
+{
+	struct obc_transfer *transfer;
+	GError *err = NULL;
+	DBusMessage *reply;
+	char contents[2];
+
+	contents[0] = FILLER_BYTE;
+	contents[1] = '\0';
+
+	transfer = obc_transfer_put("x-bt/MAP-NotificationRegistration", NULL,
+					NULL, contents, sizeof(contents), &err);
+
+	if (transfer == NULL) {
+		g_obex_apparam_free(apparam);
+		goto fail;
+	}
+
+	obc_transfer_set_apparam(transfer, apparam);
+
+	if (obc_session_queue(map->session, transfer,
+				notification_registration_cb, map, &err)) {
+		map->msg = dbus_message_ref(message);
+		return NULL;
+	}
+
+fail:
+	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
+								err->message);
+	g_error_free(err);
+	return reply;
+}
+
+static DBusMessage *map_register_notifications(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct map_data *map = user_data;
+	GObexApparam *apparam;
+	gboolean status;
+
+	if (map->mas_instance_id < 0)
+		return g_dbus_create_error(message,
+					ERROR_INTERFACE ".Failed",
+					"Unknown MAS instance id");
+
+	if (dbus_message_get_args(message, NULL, DBUS_TYPE_BOOLEAN, &status,
+					DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+					ERROR_INTERFACE ".InvalidArguments",
+					NULL);
+
+	apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_NOTIFICATIONSTATUS,
+							status ? 0x01 : 0x00);
+
+	return set_notification_registration(map, message, apparam);
+}
+
 static const GDBusMethodTable map_methods[] = {
 	{ GDBUS_ASYNC_METHOD("SetFolder",
 				GDBUS_ARGS({ "name", "s" }), NULL,
@@ -1519,6 +1599,10 @@ static const GDBusMethodTable map_methods[] = {
 			NULL,
 			NULL,
 			map_update_inbox) },
+	{ GDBUS_ASYNC_METHOD("RegisterNotifications",
+			GDBUS_ARGS({ "status", "b" }),
+			NULL,
+			map_register_notifications) },
 	{ }
 };
 
-- 
1.8.1.2

