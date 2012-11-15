Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] gdbus: Automatically register  '/' path
Date: Thu, 15 Nov 2012 16:05:24 +0200
Message-Id: <1352988325-10782-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352988325-10782-1-git-send-email-luiz.dentz@gmail.com>
References: <1352988325-10782-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes g_dbus_setup_bus to automatically register '/' path so
user application that don't export any interface on '/' will have it
registered for ObjectManager.

Note that it is now required to call g_dbus_disconnect before exit.
---
 gdbus/gdbus.h    |  1 +
 gdbus/mainloop.c | 21 +++++++++++++++++----
 gdbus/object.c   |  2 +-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index ba49621..3fbe3bc 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -53,6 +53,7 @@ DBusConnection *g_dbus_setup_bus(DBusBusType type, const char *name,
 
 DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
 							DBusError *error);
+void g_dbus_disconnect(DBusConnection *connection);
 
 gboolean g_dbus_request_name(DBusConnection *connection, const char *name,
 							DBusError *error);
diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index 099b67f..acea308 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -301,12 +301,25 @@ DBusConnection *g_dbus_setup_bus(DBusBusType type, const char *name,
 	if (conn == NULL)
 		return NULL;
 
-	if (setup_bus(conn, name, error) == FALSE) {
-		dbus_connection_unref(conn);
-		return NULL;
-	}
+	if (setup_bus(conn, name, error) == FALSE)
+		goto fail;
+
+	if (!g_dbus_register_interface(conn, "/", NULL, NULL, NULL, NULL, NULL,
+									NULL))
+		goto fail;
 
 	return conn;
+
+fail:
+	dbus_connection_unref(conn);
+	return NULL;
+
+}
+
+void g_dbus_disconnect(DBusConnection *connection)
+{
+	g_dbus_unregister_interface(connection, "/", NULL);
+	dbus_connection_unref(connection);
 }
 
 DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
diff --git a/gdbus/object.c b/gdbus/object.c
index 1f0ea39..04941c7 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -615,7 +615,7 @@ static struct interface_data *find_interface(GSList *interfaces,
 
 	for (list = interfaces; list; list = list->next) {
 		struct interface_data *iface = list->data;
-		if (!strcmp(name, iface->name))
+		if (g_strcmp0(name, iface->name) == 0)
 			return iface;
 	}
 
-- 
1.7.11.7

