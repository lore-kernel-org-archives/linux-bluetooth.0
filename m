Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3 v2] Fix telephony maemo6 driver deinitialization
Date: Thu, 25 Nov 2010 18:07:02 +0200
Message-Id: <1290701222-10076-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Remove all match rules and unregister its interface when telephony_exit
is called.
---
 audio/telephony-maemo6.c |  168 +++++++++++++++++++++++----------------------
 1 files changed, 86 insertions(+), 82 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 72c8e36..2e01fb1 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -149,6 +149,7 @@ static int get_property(const char *iface, const char *prop);
 static DBusConnection *connection = NULL;
 
 static GSList *calls = NULL;
+static GSList *watches = NULL;
 
 /* Reference count for determining the call indicator status */
 static GSList *active_calls = NULL;
@@ -1616,59 +1617,6 @@ done:
 	dbus_message_unref(reply);
 }
 
-static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
-{
-	DBusError err;
-	DBusMessage *reply;
-	DBusMessageIter iter, sub;
-	const char *path;
-	char match_string[256];
-	int type;
-
-	reply = dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("hald replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
-		goto done;
-	}
-
-	dbus_message_iter_init(reply, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		error("Unexpected signature in FindDeviceByCapability return");
-		goto done;
-	}
-
-	dbus_message_iter_recurse(&iter, &sub);
-
-	type = dbus_message_iter_get_arg_type(&sub);
-
-	if (type != DBUS_TYPE_OBJECT_PATH && type != DBUS_TYPE_STRING) {
-		error("No hal device with battery capability found");
-		goto done;
-	}
-
-	dbus_message_iter_get_basic(&sub, &path);
-
-	DBG("telephony-maemo6: found battery device at %s", path);
-
-	snprintf(match_string, sizeof(match_string),
-			"type='signal',"
-			"path='%s',"
-			"interface='org.freedesktop.Hal.Device',"
-			"member='PropertyModified'", path);
-	dbus_bus_add_match(connection, match_string, NULL);
-
-	hal_get_integer(path, "battery.charge_level.last_full", &battchg_last);
-	hal_get_integer(path, "battery.charge_level.current", &battchg_cur);
-	hal_get_integer(path, "battery.charge_level.design", &battchg_design);
-
-done:
-	dbus_message_unref(reply);
-}
 
 static void phonebook_read_reply(DBusPendingCall *call, void *user_data)
 {
@@ -1897,14 +1845,11 @@ static void modem_state_reply(DBusPendingCall *call, void *user_data)
 	dbus_message_unref(reply);
 }
 
-static DBusHandlerResult signal_filter(DBusConnection *conn,
-						DBusMessage *msg, void *data)
+static gboolean signal_filter(DBusConnection *conn, DBusMessage *msg,
+								void *data)
 {
 	const char *path = dbus_message_get_path(msg);
 
-	if (dbus_message_get_type(msg) != DBUS_MESSAGE_TYPE_SIGNAL)
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-
 	if (dbus_message_is_signal(msg, CSD_CALL_INTERFACE, "Coming"))
 		handle_incoming_call(msg);
 	else if (dbus_message_is_signal(msg, CSD_CALL_INTERFACE, "Created"))
@@ -1934,7 +1879,67 @@ static DBusHandlerResult signal_filter(DBusConnection *conn,
 						"modem_state_changed_ind"))
 		handle_modem_state(msg);
 
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	return TRUE;
+}
+
+static void add_watch(const char *sender, const char *path,
+				const char *interface, const char *member)
+{
+	guint watch;
+
+	watch = g_dbus_add_signal_watch(connection, sender, path, interface,
+					member, signal_filter, NULL, NULL);
+
+	watches = g_slist_prepend(watches, GUINT_TO_POINTER(watch));
+}
+
+static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	DBusMessageIter iter, sub;
+	const char *path;
+	int type;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		error("hald replied with an error: %s, %s",
+				err.name, err.message);
+		dbus_error_free(&err);
+		goto done;
+	}
+
+	dbus_message_iter_init(reply, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		error("Unexpected signature in FindDeviceByCapability return");
+		goto done;
+	}
+
+	dbus_message_iter_recurse(&iter, &sub);
+
+	type = dbus_message_iter_get_arg_type(&sub);
+
+	if (type != DBUS_TYPE_OBJECT_PATH && type != DBUS_TYPE_STRING) {
+		error("No hal device with battery capability found");
+		goto done;
+	}
+
+	dbus_message_iter_get_basic(&sub, &path);
+
+	DBG("telephony-maemo6: found battery device at %s", path);
+
+	add_watch(NULL, path, "org.freedesktop.Hal.Device",
+							"PropertyModified");
+
+	hal_get_integer(path, "battery.charge_level.last_full", &battchg_last);
+	hal_get_integer(path, "battery.charge_level.current", &battchg_cur);
+	hal_get_integer(path, "battery.charge_level.design", &battchg_design);
+
+done:
+	dbus_message_unref(reply);
 }
 
 int telephony_init(void)
@@ -1948,30 +1953,17 @@ int telephony_init(void)
 				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES |
 				AG_FEATURE_THREE_WAY_CALLING;
 
+	DBG("");
+
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 
-	if (!dbus_connection_add_filter(connection, signal_filter,
-						NULL, NULL))
-		error("Can't add signal filter");
-
-	dbus_bus_add_match(connection,
-			"type=signal,interface=" CSD_CALL_INTERFACE, NULL);
-	dbus_bus_add_match(connection,
-			"type=signal,interface=" CSD_CALL_INSTANCE, NULL);
-	dbus_bus_add_match(connection,
-			"type=signal,interface=" CSD_CALL_CONFERENCE, NULL);
-	dbus_bus_add_match(connection,
-			"type=signal,interface=" CSD_CSNET_REGISTRATION,
-			NULL);
-	dbus_bus_add_match(connection,
-			"type=signal,interface=" CSD_CSNET_OPERATOR,
-			NULL);
-	dbus_bus_add_match(connection,
-			"type=signal,interface=" CSD_CSNET_SIGNAL,
-			NULL);
-	dbus_bus_add_match(connection,
-				"type=signal,interface=" SSC_DBUS_IFACE
-				",member=modem_state_changed_ind", NULL);
+	add_watch(NULL, NULL, CSD_CALL_INTERFACE, NULL);
+	add_watch(NULL, NULL, CSD_CALL_INSTANCE, NULL);
+	add_watch(NULL, NULL, CSD_CALL_CONFERENCE, NULL);
+	add_watch(NULL, NULL, CSD_CSNET_REGISTRATION, NULL);
+	add_watch(NULL, NULL, CSD_CSNET_OPERATOR, NULL);
+	add_watch(NULL, NULL, CSD_CSNET_SIGNAL, NULL);
+	add_watch(NULL, NULL, CSD_CSNET_SIGNAL, "modem_state_changed_ind");
 
 	if (send_method_call(SSC_DBUS_NAME, SSC_DBUS_PATH, SSC_DBUS_IFACE,
 					"get_modem_state", modem_state_reply,
@@ -2005,8 +1997,15 @@ int telephony_init(void)
 	return 0;
 }
 
+static void remove_watch(gpointer data)
+{
+	g_dbus_remove_watch(connection, GPOINTER_TO_UINT(data));
+}
+
 void telephony_exit(void)
 {
+	DBG("");
+
 	g_free(net.operator_name);
 	net.operator_name = NULL;
 
@@ -2017,7 +2016,12 @@ void telephony_exit(void)
 	g_slist_free(calls);
 	calls = NULL;
 
-	dbus_connection_remove_filter(connection, signal_filter, NULL);
+	g_slist_foreach(watches, (GFunc) remove_watch, NULL);
+	g_slist_free(watches);
+	watches = NULL;
+
+	g_dbus_unregister_interface(connection, TELEPHONY_MAEMO_PATH,
+						TELEPHONY_MAEMO_INTERFACE);
 
 	dbus_connection_unref(connection);
 	connection = NULL;
-- 
1.7.1

