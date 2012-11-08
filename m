Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 1/7] manager: Expose default adapter using property
Date: Thu,  8 Nov 2012 15:30:09 +0100
Message-Id: <1352385015-2127-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Replace previous method in the Manager interface with a property. If no
default adapter exists, the property will not be present.
---
 doc/manager-api.txt | 20 +++------------
 src/manager.c       | 71 +++++++++++++++++++++++------------------------------
 2 files changed, 35 insertions(+), 56 deletions(-)

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index fe50556..1cebb27 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -14,13 +14,6 @@ Service		org.bluez
 Interface	org.bluez.Manager
 Object path	/
 
-		object DefaultAdapter()
-
-			Returns object path for the default adapter.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NoSuchAdapter
-
 		object FindAdapter(string pattern)
 
 			Returns object path for the specified adapter. Valid
@@ -114,15 +107,10 @@ Signals		AdapterAdded(object adapter)
 
 			Parameter is object path of removed adapter.
 
-		DefaultAdapterChanged(object adapter)
-
-			Parameter is object path of the new default adapter.
-
-			In case all adapters are removed this signal will not
-			be emitted. The AdapterRemoved signal has to be used
-			to detect that no default adapter is selected or
-			available anymore.
-
 Properties	array{object} Adapters [readonly]
 
 			List of adapter object paths.
+
+		object DefaultAdapter [readonly, optional]
+
+			Object path for the default adapter, if any.
diff --git a/src/manager.c b/src/manager.c
index a96115b..598c081 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -64,29 +64,6 @@ const char *manager_get_base_path(void)
 	return base_path;
 }
 
-static DBusMessage *default_adapter(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	DBusMessage *reply;
-	struct btd_adapter *adapter;
-	const gchar *path;
-
-	adapter = manager_find_adapter_by_id(default_adapter_id);
-	if (!adapter)
-		return btd_error_no_such_adapter(msg);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	path = adapter_get_path(adapter);
-
-	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-
-	return reply;
-}
-
 static DBusMessage *find_adapter(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -155,10 +132,32 @@ static gboolean manager_property_get_adapters(
 	return TRUE;
 }
 
+static gboolean manager_property_get_default_adapter(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adapter *adapter;
+	const char *path;
+
+	adapter = manager_find_adapter_by_id(default_adapter_id);
+	path = adapter_get_path(adapter);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
+static gboolean manager_property_exists_default_adapter(
+					const GDBusPropertyTable *property,
+					void *data)
+{
+	if (manager_find_adapter_by_id(default_adapter_id) == NULL)
+		return FALSE;
+	else
+		return TRUE;
+}
+
 static const GDBusMethodTable manager_methods[] = {
-	{ GDBUS_METHOD("DefaultAdapter",
-			NULL, GDBUS_ARGS({ "adapter", "o" }),
-			default_adapter) },
 	{ GDBUS_METHOD("FindAdapter",
 			GDBUS_ARGS({ "pattern", "s" }),
 			GDBUS_ARGS({ "adapter", "o" }),
@@ -177,13 +176,13 @@ static const GDBusSignalTable manager_signals[] = {
 			GDBUS_ARGS({ "adapter", "o" })) },
 	{ GDBUS_SIGNAL("AdapterRemoved",
 			GDBUS_ARGS({ "adapter", "o" })) },
-	{ GDBUS_SIGNAL("DefaultAdapterChanged",
-			GDBUS_ARGS({ "adapter", "o" })) },
 	{ }
 };
 
 static const GDBusPropertyTable manager_properties[] = {
 	{ "Adapters", "ao", manager_property_get_adapters },
+	{ "DefaultAdapter", "o", manager_property_get_default_adapter, NULL,
+				manager_property_exists_default_adapter },
 	{ }
 };
 
@@ -199,21 +198,13 @@ dbus_bool_t manager_init(const char *path)
 
 static void manager_set_default_adapter(int id)
 {
-	struct btd_adapter *adapter;
-	const gchar *path;
-
-	default_adapter_id = id;
-
-	adapter = manager_find_adapter_by_id(id);
-	if (!adapter)
+	if (id == default_adapter_id)
 		return;
 
-	path = adapter_get_path(adapter);
+	default_adapter_id = id;
 
-	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
-				MANAGER_INTERFACE, "DefaultAdapterChanged",
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), "/",
+					MANAGER_INTERFACE, "DefaultAdapter");
 }
 
 struct btd_adapter *manager_get_default_adapter(void)
-- 
1.7.11.7

