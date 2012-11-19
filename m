Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] gdbus: Fix having multiple path exporting ObjectManager
Date: Mon, 19 Nov 2012 10:46:23 +0200
Message-Id: <1353314786-11427-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ObjectManager should only be available on the root path so if the
current is a child of the object being registered the root should be
changed.
---
 gdbus/object.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 3101ca6..43154f3 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -84,6 +84,8 @@ struct property_data {
 	DBusMessage *message;
 };
 
+static struct generic_data *root = NULL;
+
 static gboolean process_changes(gpointer user_data);
 static void process_properties_from_interface(struct generic_data *data,
 						struct interface_data *iface);
@@ -574,11 +576,7 @@ static void emit_interfaces_added(struct generic_data *data)
 	if (parent == NULL)
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
@@ -948,11 +946,7 @@ static void emit_interfaces_removed(struct generic_data *data)
 	if (parent == NULL)
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
@@ -1008,6 +1002,9 @@ static void generic_unregister(DBusConnection *connection, void *user_data)
 	g_slist_foreach(data->objects, reset_parent, data->parent);
 	g_slist_free(data->objects);
 
+	if (root == data)
+		root = NULL;
+
 	dbus_connection_unref(data->conn);
 	g_free(data->introspect);
 	g_free(data->path);
@@ -1175,6 +1172,20 @@ static void add_interface(struct generic_data *data,
 	data->process_id = g_idle_add(process_changes, data);
 }
 
+static void set_root(struct generic_data *data)
+{
+	if (root != NULL) {
+		data->objects = g_slist_prepend(data->objects, root);
+		root->parent = data;
+		remove_interface(root, DBUS_INTERFACE_OBJECT_MANAGER);
+	}
+
+	add_interface(data, DBUS_INTERFACE_OBJECT_MANAGER,
+					manager_methods, manager_signals,
+					NULL, data, NULL);
+	root = data;
+}
+
 static struct generic_data *object_path_ref(DBusConnection *connection,
 							const char *path)
 {
@@ -1209,9 +1220,7 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 
 	/* Only root path export ObjectManager interface */
 	if (data->parent == NULL)
-		add_interface(data, DBUS_INTERFACE_OBJECT_MANAGER,
-					manager_methods, manager_signals,
-					NULL, data, NULL);
+		set_root(data);
 
 	add_interface(data, DBUS_INTERFACE_PROPERTIES, properties_methods,
 					properties_signals, NULL, data, NULL);
-- 
1.7.11.7

