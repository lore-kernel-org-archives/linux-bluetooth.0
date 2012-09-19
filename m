Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 14/17] sap: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:16 +0200
Message-ID: <1348050139-27883-15-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes redundant references and function parameters for
DBusConnection object and uses btd_get_dbus_connection() call wherever
such object is needed instead.

Pointer returned by this call is guaranteed to be valid for entire
bluetoothd lifetime and thus do not need to be refcounted.
---
 profiles/sap/main.c      | 16 +---------------
 profiles/sap/manager.c   | 17 +----------------
 profiles/sap/manager.h   |  2 +-
 profiles/sap/sap-dummy.c | 19 ++++++-------------
 profiles/sap/server.c    | 21 ++++-----------------
 profiles/sap/server.h    |  2 --
 6 files changed, 13 insertions(+), 64 deletions(-)

diff --git a/profiles/sap/main.c b/profiles/sap/main.c
index c9c90bd..4894f2e 100644
--- a/profiles/sap/main.c
+++ b/profiles/sap/main.c
@@ -27,28 +27,14 @@
 #include "plugin.h"
 #include "manager.h"
 
-static DBusConnection *connection;
-
 static int sap_init(void)
 {
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-
-	if (!connection)
-		return -EIO;
-
-	if (sap_manager_init(connection) < 0) {
-		dbus_connection_unref(connection);
-		return -EIO;
-	}
-
-	return 0;
+	return sap_manager_init();
 }
 
 static void sap_exit(void)
 {
 	sap_manager_exit();
-
-	dbus_connection_unref(connection);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(sap, VERSION,
diff --git a/profiles/sap/manager.c b/profiles/sap/manager.c
index ecf672e..ebfe266 100644
--- a/profiles/sap/manager.c
+++ b/profiles/sap/manager.c
@@ -32,8 +32,6 @@
 #include "manager.h"
 #include "server.h"
 
-static DBusConnection *connection = NULL;
-
 static int sap_server_probe(struct btd_adapter *adapter)
 {
 	const char *path = adapter_get_path(adapter);
@@ -61,16 +59,8 @@ static struct btd_profile sap_profile = {
 	.adapter_remove	= sap_server_remove,
 };
 
-int sap_manager_init(DBusConnection *conn)
+int sap_manager_init(void)
 {
-	connection = dbus_connection_ref(conn);
-
-	if (sap_server_init(connection) < 0) {
-		error("Can't init SAP server");
-		dbus_connection_unref(conn);
-		return -1;
-	}
-
 	btd_profile_register(&sap_profile);
 
 	return 0;
@@ -79,9 +69,4 @@ int sap_manager_init(DBusConnection *conn)
 void sap_manager_exit(void)
 {
 	btd_profile_unregister(&sap_profile);
-
-	dbus_connection_unref(connection);
-	connection = NULL;
-
-	sap_server_exit();
 }
diff --git a/profiles/sap/manager.h b/profiles/sap/manager.h
index e08c882..6601a03 100644
--- a/profiles/sap/manager.h
+++ b/profiles/sap/manager.h
@@ -18,5 +18,5 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-int sap_manager_init(DBusConnection *conn);
+int sap_manager_init(void);
 void sap_manager_exit(void);
diff --git a/profiles/sap/sap-dummy.c b/profiles/sap/sap-dummy.c
index dab5acc..36354b8 100644
--- a/profiles/sap/sap-dummy.c
+++ b/profiles/sap/sap-dummy.c
@@ -28,7 +28,9 @@
 
 #include <glib.h>
 #include <gdbus.h>
+#include <stdint.h>
 
+#include "dbus-common.h"
 #include "log.h"
 #include "sap.h"
 
@@ -42,7 +44,6 @@ enum {
 	SIM_MISSING	 = 0x03
 };
 
-static DBusConnection *connection = NULL;
 static unsigned int init_cnt = 0;
 
 static int sim_card_conn_status = SIM_DISCONNECTED;
@@ -359,18 +360,13 @@ int sap_init(void)
 	if (init_cnt++)
 		return 0;
 
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-
-	if (g_dbus_register_interface(connection, SAP_DUMMY_PATH,
+	if (g_dbus_register_interface(btd_get_dbus_connection(), SAP_DUMMY_PATH,
 				SAP_DUMMY_IFACE, dummy_methods, NULL, NULL,
 				NULL, NULL) == FALSE) {
 		error("sap-dummy interface %s init failed on path %s",
 					SAP_DUMMY_IFACE, SAP_DUMMY_PATH);
 
-		if (init_cnt--) {
-			dbus_connection_unref(connection);
-			connection = NULL;
-		}
+		init_cnt--;
 		return -1;
 	}
 
@@ -382,9 +378,6 @@ void sap_exit(void)
 	if (--init_cnt)
 		return;
 
-	g_dbus_unregister_interface(connection, SAP_DUMMY_PATH,
-							SAP_DUMMY_IFACE);
-
-	dbus_connection_unref(connection);
-	connection = NULL;
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					SAP_DUMMY_PATH, SAP_DUMMY_IFACE);
 }
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index fc3d83c..6c5aa21 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -79,8 +79,6 @@ struct sap_server {
 	struct sap_connection *conn;
 };
 
-static DBusConnection *connection;
-
 static void start_guard_timer(struct sap_server *server, guint interval);
 static void stop_guard_timer(struct sap_server *server);
 static gboolean guard_timeout(gpointer data);
@@ -1410,8 +1408,8 @@ int sap_server_register(const char *path, bdaddr_t *src)
 	}
 	server->listen_io = io;
 
-	if (!g_dbus_register_interface(connection, server->path,
-					SAP_SERVER_INTERFACE,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					server->path, SAP_SERVER_INTERFACE,
 					server_methods, server_signals, NULL,
 					server, destroy_sap_interface)) {
 		error("D-Bus failed to register %s interface",
@@ -1434,19 +1432,8 @@ sdp_err:
 
 void sap_server_unregister(const char *path)
 {
-	g_dbus_unregister_interface(connection, path, SAP_SERVER_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						path, SAP_SERVER_INTERFACE);
 
 	sap_exit();
 }
-
-int sap_server_init(DBusConnection *conn)
-{
-	connection = dbus_connection_ref(conn);
-	return 0;
-}
-
-void sap_server_exit(void)
-{
-	dbus_connection_unref(connection);
-	connection = NULL;
-}
diff --git a/profiles/sap/server.h b/profiles/sap/server.h
index 6d2f5e9..9ea9a78 100644
--- a/profiles/sap/server.h
+++ b/profiles/sap/server.h
@@ -20,7 +20,5 @@
 
 #include <gdbus.h>
 
-int sap_server_init(DBusConnection *conn);
-void sap_server_exit(void);
 int sap_server_register(const char *path, bdaddr_t *src);
 void sap_server_unregister(const char *path);
-- 
1.7.11.3

