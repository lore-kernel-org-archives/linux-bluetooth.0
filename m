Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 2/3] gdbus: Don't automatically attach ObjectManager
Date: Thu, 29 Nov 2012 11:19:32 -0200
Message-Id: <1354195173-12750-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1354195173-12750-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1354195173-12750-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Let each project attach the object manager interface instead of
registering it automatically.
---
 gdbus/gdbus.h  |  3 +++
 gdbus/object.c | 54 +++++++++++++++++++++++++++++++++---------------------
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index ba49621..6aafc61 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -257,6 +257,9 @@ void g_dbus_emit_property_changed(DBusConnection *connection,
 gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
 				const char *interface, DBusMessageIter *iter);
 
+gboolean g_dbus_attach_object_manager(DBusConnection *connection);
+gboolean g_dbus_detach_object_manager(DBusConnection *connection);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/gdbus/object.c b/gdbus/object.c
index 47116bd..7cbd612 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -84,6 +84,8 @@ struct property_data {
 	DBusMessage *message;
 };
 
+static struct generic_data *root;
+
 static gboolean process_changes(gpointer user_data);
 static void process_properties_from_interface(struct generic_data *data,
 						struct interface_data *iface);
@@ -569,16 +571,11 @@ static void emit_interfaces_added(struct generic_data *data)
 {
 	DBusMessage *signal;
 	DBusMessageIter iter, array;
-	struct generic_data *parent = data->parent;
 
-	if (parent == NULL)
+	if (root == NULL || data == root)
 		return;
 
-	/* Find root data */
-	while (parent->parent)
-		parent = parent->parent;
-
-	signal = dbus_message_new_signal(parent->path,
+	signal = dbus_message_new_signal(root->path,
 					DBUS_INTERFACE_OBJECT_MANAGER,
 					"InterfacesAdded");
 	if (signal == NULL)
@@ -943,16 +940,11 @@ static void emit_interfaces_removed(struct generic_data *data)
 {
 	DBusMessage *signal;
 	DBusMessageIter iter, array;
-	struct generic_data *parent = data->parent;
 
-	if (parent == NULL)
+	if (root == NULL || data == root)
 		return;
 
-	/* Find root data */
-	while (parent->parent)
-		parent = parent->parent;
-
-	signal = dbus_message_new_signal(parent->path,
+	signal = dbus_message_new_signal(root->path,
 					DBUS_INTERFACE_OBJECT_MANAGER,
 					"InterfacesRemoved");
 	if (signal == NULL)
@@ -1207,12 +1199,6 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 	add_interface(data, DBUS_INTERFACE_INTROSPECTABLE, introspect_methods,
 						NULL, NULL, data, NULL);
 
-	/* Only root path export ObjectManager interface */
-	if (data->parent == NULL)
-		add_interface(data, DBUS_INTERFACE_OBJECT_MANAGER,
-					manager_methods, manager_signals,
-					NULL, data, NULL);
-
 	return data;
 }
 
@@ -1234,7 +1220,6 @@ static void object_path_unref(DBusConnection *connection, const char *path)
 
 	remove_interface(data, DBUS_INTERFACE_INTROSPECTABLE);
 	remove_interface(data, DBUS_INTERFACE_PROPERTIES);
-	remove_interface(data, DBUS_INTERFACE_OBJECT_MANAGER);
 
 	invalidate_parent_data(data->conn, data->path);
 
@@ -1645,3 +1630,30 @@ gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
 
 	return TRUE;
 }
+
+gboolean g_dbus_attach_object_manager(DBusConnection *connection)
+{
+	struct generic_data *data;
+
+	data = object_path_ref(connection, "/");
+	if (data == NULL)
+		return FALSE;
+
+	add_interface(data, DBUS_INTERFACE_OBJECT_MANAGER,
+					manager_methods, manager_signals,
+					NULL, data, NULL);
+	root = data;
+
+	return TRUE;
+}
+
+gboolean g_dbus_detach_object_manager(DBusConnection *connection)
+{
+	if (!g_dbus_unregister_interface(connection, "/",
+					DBUS_INTERFACE_OBJECT_MANAGER))
+		return FALSE;
+
+	root = NULL;
+
+	return TRUE;
+}
-- 
1.8.0.1

