Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v18 16/16] audio: Add fast connectable to telephony interface
Date: Thu, 23 Aug 2012 16:39:05 +0200
Message-Id: <1345732745-28706-17-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
References: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/manager.c   |   19 ----------
 audio/manager.h   |    4 --
 audio/telephony.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 doc/audio-api.txt |   26 +++++++++++++
 4 files changed, 132 insertions(+), 24 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index bc6d3e7..5dcf52d 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -833,22 +833,3 @@ gboolean manager_allow_headset_connection(struct audio_device *device)
 
 	return TRUE;
 }
-
-void manager_set_fast_connectable(gboolean enable)
-{
-	GSList *l;
-
-	if (enable && !manager_allow_headset_connection(NULL)) {
-		DBG("Refusing enabling fast connectable");
-		return;
-	}
-
-	for (l = adapters; l != NULL; l = l->next) {
-		struct audio_adapter *adapter = l->data;
-
-		if (btd_adapter_set_fast_connectable(adapter->btd_adapter,
-								enable))
-			error("Changing fast connectable for hci%d failed",
-				adapter_get_dev_id(adapter->btd_adapter));
-	}
-}
diff --git a/audio/manager.h b/audio/manager.h
index f1d3021..85e5065 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -57,7 +57,3 @@ struct audio_device *manager_get_device(const bdaddr_t *src,
 					gboolean create);
 
 gboolean manager_allow_headset_connection(struct audio_device *device);
-
-/* TRUE to enable fast connectable and FALSE to disable fast connectable for all
- * audio adapters. */
-void manager_set_fast_connectable(gboolean enable);
diff --git a/audio/telephony.c b/audio/telephony.c
index 4c0cba1..69b3a61 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -183,8 +183,19 @@ static struct telephony_agent *find_agent(struct btd_adapter *adapter,
 
 static void free_agent(struct telephony_agent *agent)
 {
+	struct btd_adapter *adapter = agent->btd_adapter;
 	DBusMessage *msg;
 
+	/* if there is no more agent for this adapter and it has been set to
+	 * fast connectable mode, reset it to FALSE
+	 */
+	if (find_agent(adapter, NULL, NULL, NULL) == NULL &&
+			btd_adapter_get_fast_connectable(adapter)) {
+		if (btd_adapter_set_fast_connectable(adapter, FALSE))
+			error("Changing fast connectable for hci%d failed",
+				adapter_get_dev_id(adapter));
+	}
+
 	if (agent->record_id)
 		remove_record_from_server(agent->record_id);
 
@@ -1531,12 +1542,106 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *telephony_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct btd_adapter *adapter = data;
+	gboolean fast_connectable;
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
+	fast_connectable = btd_adapter_get_fast_connectable(adapter);
+	dict_append_entry(&dict, "FastConnectable", DBUS_TYPE_BOOLEAN,
+			  &fast_connectable);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *telephony_set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct btd_adapter *adapter = data;
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
 
@@ -1555,7 +1660,7 @@ int telephony_adapter_init(struct btd_adapter *adapter)
 
 	if (!g_dbus_register_interface(connection, path,
 					AUDIO_TELEPHONY_INTERFACE,
-					telsrv_methods, NULL,
+					telsrv_methods, telsrv_signals,
 					NULL, adapter, path_unregister)) {
 		error("D-Bus failed to register %s interface",
 				AUDIO_TELEPHONY_INTERFACE);
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index edcdfd8..4c016be 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -335,6 +335,32 @@ Methods		void RegisterAgent(object path, dict properties)
 
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

