Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ v3 10/15] gdbus: Only export ObjectManager interface on root path
Date: Sat, 18 Aug 2012 03:50:57 -0300
Message-Id: <1345272662-2850-11-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ObjectManager should be exported only in the root path and list all
the children paths.
---
 gdbus/object.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 11c317f..69bad68 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -456,6 +456,10 @@ static void emit_interfaces_added(struct generic_data *data)
 	if (parent == NULL)
 		return;
 
+	/* Find root data */
+	while (parent->parent)
+		parent = parent->parent;
+
 	signal = dbus_message_new_signal(parent->path,
 					DBUS_INTERFACE_OBJECT_MANAGER,
 					"InterfacesAdded");
@@ -835,6 +839,10 @@ static void emit_interfaces_removed(struct generic_data *data)
 	if (parent == NULL)
 		return;
 
+	/* Find root data */
+	while (parent->parent)
+		parent = parent->parent;
+
 	signal = dbus_message_new_signal(parent->path,
 					DBUS_INTERFACE_OBJECT_MANAGER,
 					"InterfacesRemoved");
@@ -971,6 +979,8 @@ static void append_object(gpointer data, gpointer user_data)
 								&child->path);
 	append_interfaces(child, &entry);
 	dbus_message_iter_close_container(array, &entry);
+
+	g_slist_foreach(child->objects, append_object, user_data);
 }
 
 static DBusMessage *get_objects(DBusConnection *connection,
@@ -1085,8 +1095,11 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 	add_interface(data, DBUS_INTERFACE_INTROSPECTABLE, introspect_methods,
 						NULL, NULL, data, NULL);
 
-	add_interface(data, DBUS_INTERFACE_OBJECT_MANAGER, manager_methods,
-					manager_signals, NULL, data, NULL);
+	/* Only root path export ObjectManager interface */
+	if (data->parent == NULL)
+		add_interface(data, DBUS_INTERFACE_OBJECT_MANAGER,
+					manager_methods, manager_signals,
+					NULL, data, NULL);
 
 	add_interface(data, DBUS_INTERFACE_PROPERTIES, properties_methods,
 					properties_signals, NULL, data, NULL);
-- 
1.7.11.5

