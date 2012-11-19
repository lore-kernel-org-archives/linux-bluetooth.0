Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] gdbus: Automatically register  '/' path
Date: Mon, 19 Nov 2012 10:46:24 +0200
Message-Id: <1353314786-11427-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353314786-11427-1-git-send-email-luiz.dentz@gmail.com>
References: <1353314786-11427-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes g_dbus_setup_bus to automatically register '/' path so
user application that don't export any interface on '/' will have it
registered for ObjectManager.

Note that it is now required to call g_dbus_close before exit.
---
 gdbus/gdbus.h    |  1 +
 gdbus/mainloop.c | 55 ++++++++++++++++++++++++++++++-------------------------
 gdbus/object.c   |  2 +-
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index ba49621..5056340 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -53,6 +53,7 @@ DBusConnection *g_dbus_setup_bus(DBusBusType type, const char *name,
 
 DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
 							DBusError *error);
+void g_dbus_close(DBusConnection *connection);
 
 gboolean g_dbus_request_name(DBusConnection *connection, const char *name,
 							DBusError *error);
diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index 099b67f..49e6538 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -286,27 +286,36 @@ static gboolean setup_bus(DBusConnection *conn, const char *name,
 	return TRUE;
 }
 
-DBusConnection *g_dbus_setup_bus(DBusBusType type, const char *name,
+static gboolean g_dbus_connect(DBusConnection *conn, const char *name,
 							DBusError *error)
 {
-	DBusConnection *conn;
-
-	conn = dbus_bus_get(type, error);
-
 	if (error != NULL) {
 		if (dbus_error_is_set(error) == TRUE)
-			return NULL;
+			return FALSE;
 	}
 
-	if (conn == NULL)
-		return NULL;
+	if (setup_bus(conn, name, error) == FALSE)
+		return FALSE;
 
-	if (setup_bus(conn, name, error) == FALSE) {
-		dbus_connection_unref(conn);
-		return NULL;
-	}
+	if (!g_dbus_register_interface(conn, "/", NULL, NULL, NULL, NULL, NULL,
+									NULL))
+		return FALSE;
 
-	return conn;
+	return TRUE;
+}
+
+DBusConnection *g_dbus_setup_bus(DBusBusType type, const char *name,
+							DBusError *error)
+{
+	DBusConnection *conn;
+
+	conn = dbus_bus_get(type, error);
+
+	if (g_dbus_connect(conn, name, error))
+		return conn;
+
+	dbus_connection_unref(conn);
+	return NULL;
 }
 
 DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
@@ -316,20 +325,16 @@ DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
 
 	conn = dbus_bus_get_private(type, error);
 
-	if (error != NULL) {
-		if (dbus_error_is_set(error) == TRUE)
-			return NULL;
-	}
-
-	if (conn == NULL)
-		return NULL;
+	if (g_dbus_connect(conn, name, error))
+		return conn;
 
-	if (setup_bus(conn, name, error) == FALSE) {
-		dbus_connection_unref(conn);
-		return NULL;
-	}
+	dbus_connection_unref(conn);
+	return NULL;
+}
 
-	return conn;
+void g_dbus_close(DBusConnection *connection)
+{
+	g_dbus_unregister_interface(connection, "/", NULL);
 }
 
 gboolean g_dbus_request_name(DBusConnection *connection, const char *name,
diff --git a/gdbus/object.c b/gdbus/object.c
index 43154f3..2a2982d 100644
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

