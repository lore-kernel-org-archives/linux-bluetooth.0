Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 05/17] manager: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:07 +0200
Message-ID: <1348050139-27883-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes local reference to DBusConnection object and uses
btd_get_dbus_connection() call wherever such object is needed instead.
---
 src/main.c    |  4 ++--
 src/manager.c | 38 ++++++++++++++++++--------------------
 src/manager.h |  4 ++--
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/src/main.c b/src/main.c
index 31af12a..7593b15 100644
--- a/src/main.c
+++ b/src/main.c
@@ -527,7 +527,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!manager_init(btd_get_dbus_connection(), "/")) {
+	if (!manager_init("/")) {
 		error("Can't register manager interface");
 		exit(1);
 	}
@@ -554,7 +554,7 @@ int main(int argc, char *argv[])
 
 	g_source_remove(signal);
 
-	manager_cleanup(btd_get_dbus_connection(), "/");
+	manager_cleanup("/");
 
 	rfkill_exit();
 
diff --git a/src/manager.c b/src/manager.c
index 31feb84..fe8706b 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -53,7 +53,6 @@
 
 static char base_path[50] = "/org/bluez";
 
-static DBusConnection *connection = NULL;
 static int default_adapter_id = -1;
 static GSList *adapters = NULL;
 
@@ -192,15 +191,14 @@ static const GDBusSignalTable manager_signals[] = {
 	{ }
 };
 
-dbus_bool_t manager_init(DBusConnection *conn, const char *path)
+dbus_bool_t manager_init(const char *path)
 {
-	connection = conn;
-
 	snprintf(base_path, sizeof(base_path), "/org/bluez/%d", getpid());
 
-	return g_dbus_register_interface(conn, "/", MANAGER_INTERFACE,
-					manager_methods, manager_signals,
-					NULL, NULL, NULL);
+	return g_dbus_register_interface(btd_get_dbus_connection(),
+					"/", MANAGER_INTERFACE,
+					manager_methods, manager_signals, NULL,
+					NULL, NULL);
 }
 
 static void manager_update_adapters(void)
@@ -236,11 +234,10 @@ static void manager_set_default_adapter(int id)
 
 	path = adapter_get_path(adapter);
 
-	g_dbus_emit_signal(connection, "/",
-			MANAGER_INTERFACE,
-			"DefaultAdapterChanged",
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_INVALID);
+	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
+				MANAGER_INTERFACE, "DefaultAdapterChanged",
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
 }
 
 struct btd_adapter *manager_get_default_adapter(void)
@@ -263,10 +260,10 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 		manager_set_default_adapter(new_default);
 	}
 
-	g_dbus_emit_signal(connection, "/",
-			MANAGER_INTERFACE, "AdapterRemoved",
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_INVALID);
+	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
+				MANAGER_INTERFACE, "AdapterRemoved",
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
 
 	adapter_remove(adapter);
 	btd_adapter_unref(adapter);
@@ -275,7 +272,7 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 		btd_start_exit_timer();
 }
 
-void manager_cleanup(DBusConnection *conn, const char *path)
+void manager_cleanup(const char *path)
 {
 	while (adapters) {
 		struct btd_adapter *adapter = adapters->data;
@@ -287,7 +284,8 @@ void manager_cleanup(DBusConnection *conn, const char *path)
 
 	btd_start_exit_timer();
 
-	g_dbus_unregister_interface(conn, "/", MANAGER_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						"/", MANAGER_INTERFACE);
 }
 
 static gint adapter_id_cmp(gconstpointer a, gconstpointer b)
@@ -354,7 +352,7 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 		return NULL;
 	}
 
-	adapter = adapter_create(connection, id);
+	adapter = adapter_create(btd_get_dbus_connection(), id);
 	if (!adapter)
 		return NULL;
 
@@ -367,7 +365,7 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 	}
 
 	path = adapter_get_path(adapter);
-	g_dbus_emit_signal(connection, "/",
+	g_dbus_emit_signal(btd_get_dbus_connection(), "/",
 				MANAGER_INTERFACE, "AdapterAdded",
 				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
diff --git a/src/manager.h b/src/manager.h
index f3c100e..0bb8b2c 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -29,8 +29,8 @@
 
 typedef void (*adapter_cb) (struct btd_adapter *adapter, gpointer user_data);
 
-dbus_bool_t manager_init(DBusConnection *conn, const char *path);
-void manager_cleanup(DBusConnection *conn, const char *path);
+dbus_bool_t manager_init(const char *path);
+void manager_cleanup(const char *path);
 
 const char *manager_get_base_path(void);
 struct btd_adapter *manager_find_adapter(const bdaddr_t *sba);
-- 
1.7.11.3

