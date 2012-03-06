Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 1/3] gdbus: Add g_dbus_list_interfaces function
Date: Tue,  6 Mar 2012 14:07:36 +0200
Message-Id: <1331035658-10000-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to list interfaces registered in a given path
---
 gdbus/gdbus.h  |    2 ++
 gdbus/object.c |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index a0583e6..26ed6d2 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -119,6 +119,8 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 					GDBusDestroyFunction destroy);
 gboolean g_dbus_unregister_interface(DBusConnection *connection,
 					const char *path, const char *name);
+char **g_dbus_list_interfaces(DBusConnection *connection, const char *path,
+								int *num);
 
 gboolean g_dbus_register_security(const GDBusSecurityTable *security);
 gboolean g_dbus_unregister_security(const GDBusSecurityTable *security);
diff --git a/gdbus/object.c b/gdbus/object.c
index 8bc12f5..1701b8f 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -723,6 +723,40 @@ gboolean g_dbus_unregister_interface(DBusConnection *connection,
 	return TRUE;
 }
 
+char **g_dbus_list_interfaces(DBusConnection *connection, const char *path,
+								int *num)
+{
+	struct generic_data *data;
+	GSList *l;
+	char **array;
+	int i, n;
+
+	if (!dbus_connection_get_object_path_data(connection, path,
+						(void *) &data))
+		return NULL;
+
+	if (data->interfaces == NULL)
+		return NULL;
+
+	n = g_slist_length(data->interfaces);
+	array = g_new0(char *, n + 1);
+
+	for (i = 0, l = data->interfaces; l; l = l->next) {
+		struct interface_data *iface = l->data;
+
+		if (g_strcmp0(iface->name,
+				DBUS_INTERFACE_INTROSPECTABLE) == 0)
+			continue;
+
+		array[i++] = g_strdup(iface->name);
+	}
+
+	if (num)
+		*num = i;
+
+	return array;
+}
+
 gboolean g_dbus_register_security(const GDBusSecurityTable *security)
 {
 	if (security_table != NULL)
-- 
1.7.7.6

