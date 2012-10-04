Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ v4 10/15] gdbus: Only export ObjectManager interface on root path
Date: Thu,  4 Oct 2012 04:26:34 -0300
Message-Id: <1349335599-12443-11-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ObjectManager should be exported only in the root path and list all
the children paths.
---
 gdbus/object.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 5b5dc7e..e96a2bf 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -534,6 +534,10 @@ static void emit_interfaces_added(struct generic_data *data)
 	if (parent == NULL)
 		return;
 
+	/* Find root data */
+	while (parent->parent)
+		parent = parent->parent;
+
 	signal = dbus_message_new_signal(parent->path,
 					DBUS_INTERFACE_OBJECT_MANAGER,
 					"InterfacesAdded");
@@ -918,6 +922,10 @@ static void emit_interfaces_removed(struct generic_data *data)
 	if (parent == NULL)
 		return;
 
+	/* Find root data */
+	while (parent->parent)
+		parent = parent->parent;
+
 	signal = dbus_message_new_signal(parent->path,
 					DBUS_INTERFACE_OBJECT_MANAGER,
 					"InterfacesRemoved");
@@ -1054,6 +1062,8 @@ static void append_object(gpointer data, gpointer user_data)
 								&child->path);
 	append_interfaces(child, &entry);
 	dbus_message_iter_close_container(array, &entry);
+
+	g_slist_foreach(child->objects, append_object, user_data);
 }
 
 static DBusMessage *get_objects(DBusConnection *connection,
@@ -1168,8 +1178,11 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
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
1.7.12.2

