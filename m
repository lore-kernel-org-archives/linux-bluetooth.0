Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] telephony-ofono: add handling for Modem.Interfaces property
Date: Wed,  5 Jan 2011 17:59:46 +0200
Message-Id: <1294243187-1849-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
References: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This should make sure a modem is only used if a network is available
---
 audio/telephony-ofono.c |  185 +++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 155 insertions(+), 30 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index b6bea91..6492081 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -61,6 +61,7 @@ static GSList *pending = NULL;
 
 #define OFONO_BUS_NAME "org.ofono"
 #define OFONO_PATH "/"
+#define OFONO_MODEM_INTERFACE "org.ofono.Modem"
 #define OFONO_MANAGER_INTERFACE "org.ofono.Manager"
 #define OFONO_NETWORKREG_INTERFACE "org.ofono.NetworkRegistration"
 #define OFONO_VCMANAGER_INTERFACE "org.ofono.VoiceCallManager"
@@ -788,15 +789,12 @@ done:
 	remove_pending(call);
 }
 
-static void modem_added(const char *path)
+static void network_found(const char *path)
 {
 	int ret;
 
 	DBG("%s", path);
 
-	if (modem_obj_path != NULL)
-		return;
-
 	modem_obj_path = g_strdup(path);
 
 	ret = send_method_call(OFONO_BUS_NAME, path,
@@ -807,12 +805,90 @@ static void modem_added(const char *path)
 						OFONO_NETWORKREG_INTERFACE);
 }
 
+static void modem_removed(const char *path)
+{
+	if (g_strcmp0(modem_obj_path, path) != 0)
+		return;
+
+	DBG("%s", path);
+
+	g_slist_foreach(calls, (GFunc) call_free, NULL);
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
+static void parse_modem_interfaces(const char *path, DBusMessageIter *ifaces)
+{
+	DBG("%s", path);
+
+	while (dbus_message_iter_get_arg_type(ifaces) == DBUS_TYPE_STRING) {
+		const char *iface;
+
+		dbus_message_iter_get_basic(ifaces, &iface);
+
+		if (g_str_equal(iface, OFONO_NETWORKREG_INTERFACE)) {
+			network_found(path);
+			return;
+		}
+
+		dbus_message_iter_next(ifaces);
+	}
+
+	modem_removed(path);
+}
+
+static void modem_added(const char *path, DBusMessageIter *properties)
+{
+	if (modem_obj_path != NULL) {
+		DBG("Ignoring, modem already exist");
+		return;
+	}
+
+	DBG("%s", path);
+
+	while (dbus_message_iter_get_arg_type(properties)
+						== DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter interfaces, value, entry;
+
+		dbus_message_iter_recurse(properties, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (strcasecmp(key, "Interfaces") != 0)
+			goto next;
+
+		if (dbus_message_iter_get_arg_type(&value)
+							!= DBUS_TYPE_ARRAY) {
+			error("Invalid Signature");
+			return;
+		}
+
+		dbus_message_iter_recurse(&value, &interfaces);
+
+		parse_modem_interfaces(path, &interfaces);
+
+		if (modem_obj_path != NULL)
+			return;
+
+	next:
+		dbus_message_iter_next(properties);
+	}
+}
+
 static void get_modems_reply(DBusPendingCall *call, void *user_data)
 {
 	DBusError err;
 	DBusMessage *reply;
 	DBusMessageIter iter, entry;
-	const char *path;
 
 	DBG("list_modem_reply is called\n");
 	reply = dbus_pending_call_steal_reply(call);
@@ -825,6 +901,10 @@ static void get_modems_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
+	/* Skip modem selection if a modem already exist */
+	if (modem_obj_path != NULL)
+		goto done;
+
 	dbus_message_iter_init(reply, &iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
@@ -834,14 +914,23 @@ static void get_modems_reply(DBusPendingCall *call, void *user_data)
 
 	dbus_message_iter_recurse(&iter, &entry);
 
-	if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_OBJECT_PATH) {
-		error("Unexpected signature");
-		goto done;
-	}
+	while (dbus_message_iter_get_arg_type(&entry)
+						== DBUS_TYPE_STRUCT) {
+		const char *path;
+		DBusMessageIter item, properties;
+
+		dbus_message_iter_recurse(&entry, &item);
+		dbus_message_iter_get_basic(&item, &path);
+
+		dbus_message_iter_next(&item);
+		dbus_message_iter_recurse(&item, &properties);
 
-	dbus_message_iter_get_basic(&entry, &path);
+		modem_added(path, &properties);
+		if (modem_obj_path != NULL)
+			break;
 
-	modem_added(path);
+		dbus_message_iter_next(&entry);
+	}
 
 done:
 	dbus_message_unref(reply);
@@ -873,6 +962,57 @@ static gboolean handle_network_property_changed(DBusConnection *conn,
 	return TRUE;
 }
 
+static void handle_modem_property(const char *path, const char *property,
+						DBusMessageIter *variant)
+{
+	DBG("%s", property);
+
+	if (g_str_equal(property, "Interfaces")) {
+		DBusMessageIter interfaces;
+
+		if (dbus_message_iter_get_arg_type(variant)
+							!= DBUS_TYPE_ARRAY) {
+			error("Invalid signature");
+			return;
+		}
+
+		dbus_message_iter_recurse(variant, &interfaces);
+		parse_modem_interfaces(path, &interfaces);
+	}
+}
+
+static gboolean handle_modem_property_changed(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter, variant;
+	const char *property, *path;
+
+	path = dbus_message_get_path(msg);
+
+	/* Ignore if modem already exist and paths doesn't match */
+	if (modem_obj_path != NULL &&
+				g_str_equal(path, modem_obj_path) == FALSE)
+		return TRUE;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
+		error("Unexpected signature in %s.%s PropertyChanged signal",
+					dbus_message_get_interface(msg),
+					dbus_message_get_member(msg));
+		return TRUE;
+	}
+
+	dbus_message_iter_get_basic(&iter, &property);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &variant);
+
+	handle_modem_property(path, property, &variant);
+
+	return TRUE;
+}
+
 static gboolean handle_vcmanager_call_added(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -959,31 +1099,14 @@ static gboolean handle_manager_modem_added(DBusConnection *conn,
 	}
 
 	dbus_message_iter_get_basic(&iter, &path);
+	dbus_message_iter_next(&iter);
 	dbus_message_iter_recurse(&iter, &properties);
 
-	modem_added(path);
+	modem_added(path, &properties);
 
 	return TRUE;
 }
 
-static void modem_removed(const char *path)
-{
-	if (g_strcmp0(modem_obj_path, path) != 0)
-		return;
-
-	DBG("%s", path);
-
-	g_slist_foreach(calls, (GFunc) call_free, NULL);
-	g_slist_free(calls);
-	calls = NULL;
-
-	g_free(net.operator_name);
-	net.operator_name = NULL;
-
-	g_free(modem_obj_path);
-	modem_obj_path = NULL;
-}
-
 static gboolean handle_manager_modem_removed(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -1212,6 +1335,8 @@ int telephony_init(void)
 
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 
+	add_watch(OFONO_BUS_NAME, NULL, OFONO_MODEM_INTERFACE,
+			"PropertyChanged", handle_modem_property_changed);
 	add_watch(OFONO_BUS_NAME, NULL, OFONO_NETWORKREG_INTERFACE,
 			"PropertyChanged", handle_network_property_changed);
 	add_watch(OFONO_BUS_NAME, NULL, OFONO_MANAGER_INTERFACE,
-- 
1.7.1

