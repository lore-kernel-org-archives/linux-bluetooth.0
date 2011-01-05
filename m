Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] telephony-ofono: make use of GetModems method
Date: Wed,  5 Jan 2011 17:59:41 +0200
Message-Id: <1294243187-1849-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
References: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Ofono API has changed, modem list is no longer a property
---
 audio/telephony-ofono.c |  271 +++++++++++++++++++++++++++++-----------------
 1 files changed, 171 insertions(+), 100 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 720b32d..b96c504 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -67,6 +67,8 @@ static GSList *calls = NULL;
 static guint registration_watch = 0;
 static guint voice_watch = 0;
 static guint device_watch = 0;
+static guint modem_added_watch = 0;
+static guint modem_removed_watch = 0;
 
 /* HAL battery namespace key values */
 static int battchg_cur = -1;    /* "battery.charge_level.current" */
@@ -454,13 +456,13 @@ static gboolean iter_get_basic_args(DBusMessageIter *iter,
 	return type == DBUS_TYPE_INVALID ? TRUE : FALSE;
 }
 
-static void handle_registration_property(const char *property, DBusMessageIter sub)
+static void handle_network_property(const char *property, DBusMessageIter *variant)
 {
 	const char *status, *operator;
 	unsigned int signals_bar;
 
 	if (g_str_equal(property, "Status")) {
-		dbus_message_iter_get_basic(&sub, &status);
+		dbus_message_iter_get_basic(variant, &status);
 		DBG("Status is %s", status);
 		if (g_str_equal(status, "registered")) {
 			net.status = NETWORK_REG_STATUS_HOME;
@@ -481,13 +483,13 @@ static void handle_registration_property(const char *property, DBusMessageIter s
 			telephony_update_indicator(ofono_indicators,
 						"service", EV_SERVICE_NONE);
 		}
-	} else if (g_str_equal(property, "Operator")) {
-		dbus_message_iter_get_basic(&sub, &operator);
+	} else if (g_str_equal(property, "Name")) {
+		dbus_message_iter_get_basic(variant, &operator);
 		DBG("Operator is %s", operator);
 		g_free(net.operator_name);
 		net.operator_name = g_strdup(operator);
 	} else if (g_str_equal(property, "SignalStrength")) {
-		dbus_message_iter_get_basic(&sub, &signals_bar);
+		dbus_message_iter_get_basic(variant, &signals_bar);
 		DBG("SignalStrength is %d", signals_bar);
 		net.signals_bar = signals_bar;
 		telephony_update_indicator(ofono_indicators, "signal",
@@ -495,16 +497,43 @@ static void handle_registration_property(const char *property, DBusMessageIter s
 	}
 }
 
-static void get_registration_reply(DBusPendingCall *call, void *user_data)
+static int parse_network_properties(DBusMessageIter *properties)
 {
-	DBusError err;
-	DBusMessage *reply;
-	DBusMessageIter iter, iter_entry;
 	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
 				AG_FEATURE_REJECT_A_CALL |
 				AG_FEATURE_ENHANCED_CALL_STATUS |
 				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES;
 
+	while (dbus_message_iter_get_arg_type(properties)
+						== DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+
+		dbus_message_iter_recurse(properties, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		handle_network_property(key, &value);
+
+		dbus_message_iter_next(properties);
+	}
+
+	telephony_ready_ind(features, ofono_indicators, BTRH_NOT_SUPPORTED,
+								chld_str);
+
+	return 0;
+}
+
+static void get_properties_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	DBusMessageIter iter, properties;
+	int ret = 0;
+
+	DBG("");
 	reply = dbus_pending_call_steal_reply(call);
 
 	dbus_error_init(&err);
@@ -517,67 +546,47 @@ static void get_registration_reply(DBusPendingCall *call, void *user_data)
 
 	dbus_message_iter_init(reply, &iter);
 
-	/* ARRAY -> ENTRY -> VARIANT */
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		error("Unexpected signature in GetProperties return");
-		goto done;
-	}
-
-	dbus_message_iter_recurse(&iter, &iter_entry);
-
-	if (dbus_message_iter_get_arg_type(&iter_entry)
-					!= DBUS_TYPE_DICT_ENTRY) {
-		error("Unexpected signature in GetProperties return");
+		error("Unexpected signature");
 		goto done;
 	}
 
-	while (dbus_message_iter_get_arg_type(&iter_entry)
-					!= DBUS_TYPE_INVALID) {
-		DBusMessageIter iter_property, sub;
-		char *property;
+	dbus_message_iter_recurse(&iter, &properties);
 
-		dbus_message_iter_recurse(&iter_entry, &iter_property);
-		if (dbus_message_iter_get_arg_type(&iter_property)
-					!= DBUS_TYPE_STRING) {
-			error("Unexpected signature in GetProperties return");
-			goto done;
-		}
-
-		dbus_message_iter_get_basic(&iter_property, &property);
-
-		dbus_message_iter_next(&iter_property);
-		dbus_message_iter_recurse(&iter_property, &sub);
-
-		handle_registration_property(property, sub);
-
-                dbus_message_iter_next(&iter_entry);
-        }
-
-	telephony_ready_ind(features, ofono_indicators, BTRH_NOT_SUPPORTED,
-								chld_str);
+	ret = parse_network_properties(&properties);
+	if (ret < 0)
+		error("Unable to parse %s.GetProperty reply",
+						OFONO_NETWORKREG_INTERFACE);
 
 done:
 	dbus_message_unref(reply);
 }
 
-static int get_registration_and_signal_status()
+static void modem_added(const char *path)
 {
-	if (!modem_obj_path)
-		return -ENOENT;
+	int ret;
 
-	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
-			OFONO_NETWORKREG_INTERFACE,
-			"GetProperties", get_registration_reply,
-			NULL, DBUS_TYPE_INVALID);
+	DBG("%s", path);
+
+	if (modem_obj_path != NULL)
+		return;
+
+	modem_obj_path = g_strdup(path);
+
+	ret = send_method_call(OFONO_BUS_NAME, path,
+				OFONO_NETWORKREG_INTERFACE, "GetProperties",
+				get_properties_reply, NULL, DBUS_TYPE_INVALID);
+	if (ret < 0)
+		error("Unable to send %s.GetProperties",
+						OFONO_NETWORKREG_INTERFACE);
 }
 
-static void list_modem_reply(DBusPendingCall *call, void *user_data)
+static void get_modems_reply(DBusPendingCall *call, void *user_data)
 {
 	DBusError err;
 	DBusMessage *reply;
-	DBusMessageIter iter, iter_entry, iter_property, iter_arrary, sub;
-	char *property, *modem_obj_path_local;
-	int ret;
+	DBusMessageIter iter, entry;
+	const char *path;
 
 	DBG("list_modem_reply is called\n");
 	reply = dbus_pending_call_steal_reply(call);
@@ -593,49 +602,29 @@ static void list_modem_reply(DBusPendingCall *call, void *user_data)
 	dbus_message_iter_init(reply, &iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		error("Unexpected signature in ListModems return");
+		error("Unexpected signature");
 		goto done;
 	}
 
-	dbus_message_iter_recurse(&iter, &iter_entry);
+	dbus_message_iter_recurse(&iter, &entry);
 
-	if (dbus_message_iter_get_arg_type(&iter_entry)
-					!= DBUS_TYPE_DICT_ENTRY) {
-		error("Unexpected signature in ListModems return 2, %c",
-				dbus_message_iter_get_arg_type(&iter_entry));
+	if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_OBJECT_PATH) {
+		error("Unexpected signature");
 		goto done;
 	}
 
-	dbus_message_iter_recurse(&iter_entry, &iter_property);
-
-	dbus_message_iter_get_basic(&iter_property, &property);
-
-	dbus_message_iter_next(&iter_property);
-	dbus_message_iter_recurse(&iter_property, &iter_arrary);
-	dbus_message_iter_recurse(&iter_arrary, &sub);
-	while (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_INVALID) {
+	dbus_message_iter_get_basic(&entry, &path);
 
-		dbus_message_iter_get_basic(&sub, &modem_obj_path_local);
-		modem_obj_path = g_strdup(modem_obj_path_local);
-		if (modem_obj_path != NULL) {
-			DBG("modem_obj_path is %p, %s\n", modem_obj_path,
-							modem_obj_path);
-			break;
-		}
-		dbus_message_iter_next(&sub);
-	}
+	modem_added(path);
 
-	ret = get_registration_and_signal_status();
-	if (ret < 0)
-		error("get_registration_and_signal_status() failed(%d)", ret);
 done:
 	dbus_message_unref(reply);
 }
 
-static gboolean handle_registration_property_changed(DBusConnection *conn,
+static gboolean handle_network_property_changed(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	DBusMessageIter iter, sub;
+	DBusMessageIter iter, variant;
 	const char *property;
 
 	dbus_message_iter_init(msg, &iter);
@@ -650,9 +639,9 @@ static gboolean handle_registration_property_changed(DBusConnection *conn,
 					" the property is %s", property);
 
 	dbus_message_iter_next(&iter);
-	dbus_message_iter_recurse(&iter, &sub);
+	dbus_message_iter_recurse(&iter, &variant);
 
-	handle_registration_property(property, sub);
+	handle_network_property(property, &variant);
 
 	return TRUE;
 }
@@ -910,6 +899,70 @@ static gboolean handle_vcmanager_property_changed(DBusConnection *conn,
 	return TRUE;
 }
 
+static gboolean handle_manager_modem_added(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter, properties;
+	const char *path;
+
+	if (modem_obj_path != NULL)
+		return TRUE;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter)
+						!= DBUS_TYPE_OBJECT_PATH) {
+		error("Unexpected signature in %s.%s signal",
+					dbus_message_get_interface(msg),
+					dbus_message_get_member(msg));
+		return TRUE;
+	}
+
+	dbus_message_iter_get_basic(&iter, &path);
+	dbus_message_iter_recurse(&iter, &properties);
+
+	modem_added(path);
+
+	return TRUE;
+}
+
+static void modem_removed(const char *path)
+{
+	if (g_strcmp0(modem_obj_path, path) != 0)
+		return;
+
+	DBG("%s", path);
+
+	g_slist_foreach(calls, (GFunc) vc_free, NULL);
+	g_slist_free(calls);
+	calls = NULL;
+
+	g_free(net.operator_name);
+	net.operator_name = NULL;
+
+	g_free(modem_obj_path);
+	modem_obj_path = NULL;
+}
+
+static gboolean handle_manager_modem_removed(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	const char *path;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID)) {
+		error("Unexpected signature in %s.%s signal",
+					dbus_message_get_interface(msg),
+					dbus_message_get_member(msg));
+		return TRUE;
+	}
+
+	modem_removed(path);
+
+	return TRUE;
+}
+
 static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
 {
 	DBusMessage *reply;
@@ -1090,21 +1143,38 @@ int telephony_init(void)
 
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 
-	registration_watch = g_dbus_add_signal_watch(connection, OFONO_BUS_NAME,
-					NULL, OFONO_NETWORKREG_INTERFACE,
-					"PropertyChanged",
-					handle_registration_property_changed,
-					NULL, NULL);
 
-	voice_watch = g_dbus_add_signal_watch(connection, OFONO_BUS_NAME, NULL,
-					OFONO_VCMANAGER_INTERFACE,
-					"PropertyChanged",
-					handle_vcmanager_property_changed,
-					NULL, NULL);
+	registration_watch = g_dbus_add_signal_watch(connection,
+						OFONO_BUS_NAME, NULL,
+						OFONO_NETWORKREG_INTERFACE,
+						"PropertyChanged",
+						handle_network_property_changed,
+						NULL, NULL);
+
+	voice_watch = g_dbus_add_signal_watch(connection,
+						OFONO_BUS_NAME, NULL,
+						OFONO_VCMANAGER_INTERFACE,
+						"PropertyChanged",
+						handle_vcmanager_property_changed,
+						NULL, NULL);
+
+	modem_added_watch = g_dbus_add_signal_watch(connection,
+						OFONO_BUS_NAME, NULL,
+						OFONO_MANAGER_INTERFACE,
+						"ModemAdded",
+						handle_manager_modem_added,
+						NULL, NULL);
+
+	modem_removed_watch = g_dbus_add_signal_watch(connection,
+						OFONO_BUS_NAME, NULL,
+						OFONO_MANAGER_INTERFACE,
+						"ModemRemoved",
+						handle_manager_modem_removed,
+						NULL, NULL);
 
 	ret = send_method_call(OFONO_BUS_NAME, OFONO_PATH,
-				OFONO_MANAGER_INTERFACE, "GetProperties",
-				list_modem_reply, NULL, DBUS_TYPE_INVALID);
+				OFONO_MANAGER_INTERFACE, "GetModems",
+				get_modems_reply, NULL, DBUS_TYPE_INVALID);
 	if (ret < 0)
 		return ret;
 
@@ -1125,17 +1195,18 @@ int telephony_init(void)
 
 void telephony_exit(void)
 {
-	g_free(net.operator_name);
+	DBG("");
 
-	g_free(modem_obj_path);
 	g_free(last_dialed_number);
+	last_dialed_number = NULL;
 
-	g_slist_foreach(calls, (GFunc) vc_free, NULL);
-	g_slist_free(calls);
-	calls = NULL;
+	if (modem_obj_path)
+		modem_removed(modem_obj_path);
 
 	g_dbus_remove_watch(connection, registration_watch);
 	g_dbus_remove_watch(connection, voice_watch);
+	g_dbus_remove_watch(connection, modem_added_watch);
+	g_dbus_remove_watch(connection, modem_removed_watch);
 	g_dbus_remove_watch(connection, device_watch);
 
 	dbus_connection_unref(connection);
-- 
1.7.1

