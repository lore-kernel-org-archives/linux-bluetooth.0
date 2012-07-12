Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v12 13/13] audio: Add fast connectable to telephony interface
Date: Thu, 12 Jul 2012 12:53:58 +0200
Message-Id: <1342090438-20434-14-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1342090438-20434-1-git-send-email-frederic.danis@linux.intel.com>
References: <1342090438-20434-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/audio.conf  |   11 ++++
 audio/manager.c   |    2 +-
 audio/telephony.c |  145 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 audio/telephony.h |    2 +-
 doc/audio-api.txt |   26 ++++++++++
 5 files changed, 179 insertions(+), 7 deletions(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index 2878030..ca99465 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -27,3 +27,14 @@
 
 # Maximum number of connected HSP/HFP devices per adapter. Defaults to 1
 MaxConnected=1
+
+# Telephony interface specific options (i.e. options which affect how the
+# service interacts with remote devices)
+[Telephony]
+
+# Set to true to enable agent to use of fast connectable mode (faster page
+# scanning) when incoming call starts. Default settings should be restored
+# after call is answered or rejected. Page scan interval is much shorter and
+# page scan type changed to interlaced. Such allows faster connection
+# initiated by a headset.
+FastConnectable=false
diff --git a/audio/manager.c b/audio/manager.c
index 5a90398..2a5636b 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -323,7 +323,7 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
 
 	if (powered) {
 		if (telephony == FALSE) {
-			telephony_init();
+			telephony_init(config);
 			telephony = TRUE;
 		}
 
diff --git a/audio/telephony.c b/audio/telephony.c
index 47920c6..48fbf2e 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -65,6 +65,11 @@
 
 struct tel_agent;
 
+struct tel_adapter {
+	struct btd_adapter *btd_adapter;
+	gboolean fast_connectable;
+};
+
 struct tel_device {
 	void			*au_dev;
 	struct btd_device	*btd_dev;
@@ -110,6 +115,7 @@ struct tel_client {
 };
 
 static DBusConnection *connection = NULL;
+static gboolean fast_connectable = FALSE;
 
 static GSList *agents = NULL;	/* server list */
 
@@ -1326,7 +1332,8 @@ static struct tel_agent *agent_new(struct btd_adapter *adapter,
 static DBusMessage *register_agent(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	struct btd_adapter *adapter = data;
+	struct tel_adapter *tel_adapter = data;
+	struct btd_adapter *adapter = tel_adapter->btd_adapter;
 	DBusMessageIter args, props;
 	const char *sender, *path, *uuid;
 	uint16_t version = 0;
@@ -1412,7 +1419,8 @@ static DBusMessage *register_agent(DBusConnection *conn,
 static DBusMessage *unregister_agent(DBusConnection *conn,
 				DBusMessage *msg, void *data)
 {
-	struct btd_adapter *adapter = data;
+	struct tel_adapter *tel_adapter = data;
+	struct btd_adapter *adapter = tel_adapter->btd_adapter;
 	const char *sender, *path;
 	struct tel_agent *agent;
 
@@ -1436,33 +1444,136 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
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
+		if (fast_connectable == FALSE)
+			return btd_error_not_available(msg);
+
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
+	g_free(data);
+
 	DBG("Unregistered interface %s", AUDIO_TELEPHONY_INTERFACE);
 }
 
 static int register_interface(void *adapter)
 {
 	const char *path;
+	struct tel_adapter *tel_adapter;
 
 	if (DBUS_TYPE_UNIX_FD < 0)
 		return -1;
 
 	path = adapter_get_path(adapter);
 
+	tel_adapter = g_new0(struct tel_adapter, 1);
+	tel_adapter->btd_adapter = adapter;
+
 	if (!g_dbus_register_interface(connection, path,
 					AUDIO_TELEPHONY_INTERFACE,
-					telsrv_methods, NULL,
-					NULL, adapter, path_unregister)) {
+					telsrv_methods, telsrv_signals,
+					NULL, tel_adapter, path_unregister)) {
 		error("D-Bus failed to register %s interface",
 				AUDIO_TELEPHONY_INTERFACE);
 		return -1;
@@ -1470,6 +1581,13 @@ static int register_interface(void *adapter)
 
 	DBG("Registered interface %s", AUDIO_TELEPHONY_INTERFACE);
 
+	if (fast_connectable == FALSE)
+		return 0;
+
+	if (btd_adapter_set_fast_connectable(adapter, FALSE))
+		error("Changing fast connectable for hci%d failed",
+			adapter_get_dev_id(adapter));
+
 	return 0;
 }
 
@@ -1500,12 +1618,29 @@ void telephony_adapter_exit(void *adapter)
 	}
 }
 
-int telephony_init(void)
+int telephony_init(GKeyFile *config)
 {
+	char *str;
+	GError *err = NULL;
+
 	DBG("");
 
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 
+	if (config == NULL)
+		return 0;
+
+	/* Init fast connectable option */
+	str = g_key_file_get_string(config, "Telephony", "FastConnectable",
+					&err);
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else {
+		fast_connectable = strcmp(str, "true") == 0;
+		g_free(str);
+	}
+
 	return 0;
 }
 
diff --git a/audio/telephony.h b/audio/telephony.h
index 695061d..7bbde7e 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -60,5 +60,5 @@ void *telephony_agent_by_uuid(void *adapter, const char *uuid);
 
 int telephony_adapter_init(void *adapter);
 void telephony_adapter_exit(void *adapter);
-int telephony_init(void);
+int telephony_init(GKeyFile *config);
 void telephony_exit(void);
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index 4e65691..709a647 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -354,6 +354,32 @@ Methods		void RegisterAgent(object path, dict properties)
 
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

