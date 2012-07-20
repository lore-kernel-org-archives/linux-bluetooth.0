Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v14 14/14] audio: Add fast connectable to telephony interface
Date: Fri, 20 Jul 2012 10:57:37 +0200
Message-Id: <1342774657-29392-15-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1342774657-29392-1-git-send-email-frederic.danis@linux.intel.com>
References: <1342774657-29392-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony.c |  146 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 doc/audio-api.txt |   26 ++++++++++
 2 files changed, 160 insertions(+), 12 deletions(-)

diff --git a/audio/telephony.c b/audio/telephony.c
index eb9faeb..605b09a 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -64,6 +64,11 @@
 #define DEFAULT_HF_AG_CHANNEL 13
 #define DEFAULT_SAP_GW_CHANNEL 8
 
+struct tel_adapter {
+	struct btd_adapter *btd_adapter;
+	gboolean fast_connectable;
+};
+
 struct tel_device {
 	void			*device;
 	struct btd_device	*btd_dev;
@@ -91,7 +96,7 @@ struct default_agent {
 };
 
 struct tel_agent {
-	struct btd_adapter	*adapter;
+	struct tel_adapter	*adapter;
 	char			*name;		/* agent DBus bus id */
 	char			*path;		/* agent object path */
 	guint			watch;		/* agent disconnect watcher */
@@ -123,7 +128,7 @@ static struct tel_agent *find_agent(struct btd_adapter *adapter,
 	for (l = agents; l; l = l->next) {
 		struct tel_agent *agent = l->data;
 
-		if (agent->adapter != adapter)
+		if (agent->adapter->btd_adapter != adapter)
 			continue;
 
 		if (sender && g_strcmp0(agent->name, sender) != 0)
@@ -143,8 +148,19 @@ static struct tel_agent *find_agent(struct btd_adapter *adapter,
 
 static void free_agent(struct tel_agent *agent)
 {
+	struct btd_adapter *adapter = agent->adapter->btd_adapter;
 	DBusMessage *msg;
 
+	/* if there is no more agent for this adapter and it has been set to
+	 * fast connectable mode, reset it to FALSE
+	 */
+	if (find_agent(adapter, NULL, NULL, NULL) == NULL &&
+			agent->adapter->fast_connectable) {
+		if (btd_adapter_set_fast_connectable(adapter, FALSE))
+			error("Changing fast connectable for hci%d failed",
+				adapter_get_dev_id(adapter));
+	}
+
 	if (agent->record_id)
 		remove_record_from_server(agent->record_id);
 
@@ -163,7 +179,6 @@ static void free_agent(struct tel_agent *agent)
 		agent->watch = 0;
 	}
 
-	btd_adapter_unref(agent->adapter);
 	g_free(agent->name);
 	g_free(agent->path);
 	g_free(agent);
@@ -1232,7 +1247,7 @@ static void agent_disconnect_cb(DBusConnection *conn, void *user_data)
 	free_agent(agent);
 }
 
-static struct tel_agent *agent_new(struct btd_adapter *adapter,
+static struct tel_agent *agent_new(struct tel_adapter *adapter,
 					const char *sender, const char *path,
 					const char *uuid, uint16_t version,
 					uint16_t features)
@@ -1244,7 +1259,7 @@ static struct tel_agent *agent_new(struct btd_adapter *adapter,
 				sizeof(struct default_agent) ; i++) {
 		if (strcasecmp(uuid, default_properties[i].uuid) == 0) {
 			agent = g_new0(struct tel_agent, 1);
-			agent->adapter = btd_adapter_ref(adapter);
+			agent->adapter = adapter;
 			agent->properties = &default_properties[i];
 			agent->name = g_strdup(sender);
 			agent->path = g_strdup(path);
@@ -1260,7 +1275,8 @@ static struct tel_agent *agent_new(struct btd_adapter *adapter,
 static DBusMessage *register_agent(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	struct btd_adapter *adapter = data;
+	struct tel_adapter *tel_adapter = data;
+	struct btd_adapter *adapter = tel_adapter->btd_adapter;
 	DBusMessageIter args, props;
 	const char *sender, *path, *uuid;
 	uint16_t version = 0;
@@ -1292,7 +1308,7 @@ static DBusMessage *register_agent(DBusConnection *conn,
 		return btd_error_already_exists(msg);
 
 	/* initialize agent properties */
-	agent = agent_new(adapter, sender, path, uuid, version, features);
+	agent = agent_new(tel_adapter, sender, path, uuid, version, features);
 	if (agent == NULL)
 		return btd_error_invalid_args(msg);
 
@@ -1346,7 +1362,8 @@ static DBusMessage *register_agent(DBusConnection *conn,
 static DBusMessage *unregister_agent(DBusConnection *conn,
 				DBusMessage *msg, void *data)
 {
-	struct btd_adapter *adapter = data;
+	struct tel_adapter *tel_adapter = data;
+	struct btd_adapter *adapter = tel_adapter->btd_adapter;
 	const char *sender, *path;
 	struct tel_agent *agent;
 
@@ -1370,35 +1387,140 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *telephony_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct tel_adapter *tel_adapter = data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	/* FastConnectable */
+	dict_append_entry(&dict, "FastConnectable", DBUS_TYPE_BOOLEAN,
+			  &tel_adapter->fast_connectable);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *telephony_set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct tel_adapter *tel_adapter = data;
+	struct btd_adapter *adapter = tel_adapter->btd_adapter;
+	const char *property;
+	DBusMessageIter iter;
+	DBusMessageIter sub;
+	gboolean enable;
+	DBusMessage *reply;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return btd_error_invalid_args(msg);
+	dbus_message_iter_recurse(&iter, &sub);
+
+	if (g_str_equal("FastConnectable", property)) {
+		if (dbus_message_iter_get_arg_type(&sub) !=
+				DBUS_TYPE_BOOLEAN)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&sub, &enable);
+
+		reply = dbus_message_new_method_return(msg);
+		if (!reply)
+			return NULL;
+
+		if (btd_adapter_set_fast_connectable(adapter, enable)) {
+			error("Changing fast connectable for hci%d failed",
+				adapter_get_dev_id(adapter));
+			dbus_message_unref(reply);
+			return btd_error_failed(msg,
+					"Changing to fast connectable failed");
+		}
+
+		tel_adapter->fast_connectable = enable;
+		emit_property_changed(conn, adapter_get_path(adapter),
+					AUDIO_TELEPHONY_INTERFACE,
+					"FastConnectable",
+					DBUS_TYPE_BOOLEAN, &enable);
+		return reply;
+	}
+
+	return btd_error_invalid_args(msg);
+}
+
 static const GDBusMethodTable telsrv_methods[] = {
 	{ GDBUS_METHOD("RegisterAgent",
 			GDBUS_ARGS({ "agent", "o" }, { "properties", "a{sv}" }),
 			NULL, register_agent) },
 	{ GDBUS_METHOD("UnregisterAgent",
 			GDBUS_ARGS({ "agent", "o" }), NULL, unregister_agent) },
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			telephony_get_properties) },
+	{ GDBUS_METHOD("SetProperty",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
+			telephony_set_property) },
+	{ }
+};
+
+static const GDBusSignalTable telsrv_signals[] = {
+	{ GDBUS_SIGNAL("PropertyChanged",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
 };
 
 static void path_unregister(void *data)
 {
+	struct tel_adapter *tel_adapter = data;
+
+	btd_adapter_unref(tel_adapter->btd_adapter);
+	g_free(tel_adapter);
+
 	DBG("Unregistered interface %s", AUDIO_TELEPHONY_INTERFACE);
 }
 
 static int register_interface(struct btd_adapter *adapter)
 {
 	const char *path;
+	struct tel_adapter *tel_adapter;
 
 	if (DBUS_TYPE_UNIX_FD < 0)
 		return -1;
 
 	path = adapter_get_path(adapter);
 
+	tel_adapter = g_new0(struct tel_adapter, 1);
+	tel_adapter->btd_adapter = btd_adapter_ref(adapter);
+
 	if (!g_dbus_register_interface(connection, path,
 					AUDIO_TELEPHONY_INTERFACE,
-					telsrv_methods, NULL,
-					NULL, adapter, path_unregister)) {
+					telsrv_methods, telsrv_signals,
+					NULL, tel_adapter, path_unregister)) {
 		error("D-Bus failed to register %s interface",
 				AUDIO_TELEPHONY_INTERFACE);
+		btd_adapter_unref(tel_adapter->btd_adapter);
+		g_free(tel_adapter);
 		return -1;
 	}
 
@@ -1426,12 +1548,12 @@ void telephony_adapter_exit(struct btd_adapter *adapter)
 
 	DBG("adapter: %p", adapter);
 
-	unregister_interface(adapter);
-
 	while ((agent = find_agent(adapter, NULL, NULL, NULL)) != NULL) {
 		agents = g_slist_remove(agents, agent);
 		free_agent(agent);
 	}
+
+	unregister_interface(adapter);
 }
 
 int telephony_init(void)
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index 8f4dcb2..abbd680 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -334,6 +334,32 @@ Methods		void RegisterAgent(object path, dict properties)
 
 			Unregister sender agent.
 
+		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as read-write are changeable.
+			On success this will emit a PropertyChanged signal.
+
+			Possible Errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.InvalidArguments
+
+Signals		void PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	boolean FastConnectable  [readwrite]
+
+			Indicates if there is adapter is in fast connectable
+			mode.
+
 TelephonyAgent hierarchy
 ========================
 
-- 
1.7.9.5

