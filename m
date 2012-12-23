Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] gdbus: Check if the interface being registered is valid
Date: Sun, 23 Dec 2012 22:15:14 +0200
Message-Id: <1356293718-9348-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356293718-9348-1-git-send-email-luiz.dentz@gmail.com>
References: <1356293718-9348-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prevent registering interfaces that are empty or have all members
marked as experiemental.
---
 gdbus/object.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 7b58eea..d864bf5 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1177,7 +1177,7 @@ static const GDBusSignalTable manager_signals[] = {
 	{ }
 };
 
-static void add_interface(struct generic_data *data,
+static gboolean add_interface(struct generic_data *data,
 				const char *name,
 				const GDBusMethodTable *methods,
 				const GDBusSignalTable *signals,
@@ -1186,7 +1186,32 @@ static void add_interface(struct generic_data *data,
 				GDBusDestroyFunction destroy)
 {
 	struct interface_data *iface;
+	const GDBusMethodTable *method;
+	const GDBusSignalTable *signal;
+	const GDBusPropertyTable *property;
+
+	for (method = methods; method && method->name; method++) {
+		if (!check_experimental(method->flags,
+					G_DBUS_METHOD_FLAG_EXPERIMENTAL))
+			goto done;
+	}
+
+	for (signal = signals; signal && signal->name; signal++) {
+		if (!check_experimental(signal->flags,
+					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL))
+			goto done;
+	}
+
+	for (property = properties; property && property->name; property++) {
+		if (!check_experimental(property->flags,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
+			goto done;
+	}
 
+	/* Nothing to register */
+	return FALSE;
+
+done:
 	iface = g_new0(struct interface_data, 1);
 	iface->name = g_strdup(name);
 	iface->methods = methods;
@@ -1197,13 +1222,15 @@ static void add_interface(struct generic_data *data,
 
 	data->interfaces = g_slist_append(data->interfaces, iface);
 	if (data->parent == NULL)
-		return;
+		return TRUE;
 
 	data->added = g_slist_append(data->added, iface);
 	if (data->process_id > 0)
-		return;
+		return TRUE;
 
 	data->process_id = g_idle_add(process_changes, data);
+
+	return TRUE;
 }
 
 static struct generic_data *object_path_ref(DBusConnection *connection,
@@ -1364,15 +1391,18 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 		return FALSE;
 	}
 
+	if (!add_interface(data, name, methods, signals, properties, user_data,
+								destroy)) {
+		object_path_unref(connection, path);
+		return FALSE;
+	}
+
 	if (properties != NULL && !find_interface(data->interfaces,
 						DBUS_INTERFACE_PROPERTIES))
 		add_interface(data, DBUS_INTERFACE_PROPERTIES,
 				properties_methods, properties_signals, NULL,
 				data, NULL);
 
-	add_interface(data, name, methods, signals, properties, user_data,
-								destroy);
-
 	g_free(data->introspect);
 	data->introspect = NULL;
 
-- 
1.7.11.7

