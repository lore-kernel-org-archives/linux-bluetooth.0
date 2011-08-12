Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 8/8] client: add sync target
Date: Fri, 12 Aug 2011 11:45:14 +0300
Message-Id: <1313138714-6443-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
References: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

sync target implements sync driver
---
 client/manager.c |    2 +
 client/session.c |    1 -
 client/sync.c    |   79 ++++++++++++++++++++++++++++++++++++++++++++---------
 client/sync.h    |    7 +---
 4 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index 65e7a7f..dfb282b 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -41,6 +41,7 @@
 #include "opp.h"
 #include "ftp.h"
 #include "pbap.h"
+#include "sync.h"
 
 #define CLIENT_SERVICE  "org.openobex.client"
 
@@ -565,6 +566,7 @@ static struct target_module {
 	{ "opp", opp_init, opp_exit },
 	{ "ftp", ftp_init, ftp_exit },
 	{ "pbap", pbap_init, pbap_exit },
+	{ "sync", sync_init, sync_exit },
 	{ }
 };
 
diff --git a/client/session.c b/client/session.c
index 4c7f07d..8ad20d1 100644
--- a/client/session.c
+++ b/client/session.c
@@ -41,7 +41,6 @@
 #include <bluetooth/sdp_lib.h>
 
 #include "log.h"
-#include "sync.h"
 #include "transfer.h"
 #include "session.h"
 #include "btio.h"
diff --git a/client/sync.c b/client/sync.c
index abeb717..349f950 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -26,23 +26,30 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+
 #include <glib.h>
 #include <gdbus.h>
 
+#include "log.h"
+
 #include "transfer.h"
 #include "session.h"
+#include "driver.h"
 #include "sync.h"
 
 #define SYNC_INTERFACE	"org.openobex.Synchronization"
 #define ERROR_INF SYNC_INTERFACE ".Error"
+#define SYNC_UUID "00001104-0000-1000-8000-00805f9b34fb"
 
 struct sync_data {
 	struct obc_session *session;
 	char *phonebook_path;
-	DBusConnection *conn;
 	DBusMessage *msg;
 };
 
+static DBusConnection *conn = NULL;
+
 static DBusMessage *sync_setlocation(DBusConnection *connection,
 			DBusMessage *message, void *user_data)
 {
@@ -92,7 +99,7 @@ static void sync_getphonebook_callback(struct obc_session *session,
 		DBUS_TYPE_STRING, &buf,
 		DBUS_TYPE_INVALID);
 
-	g_dbus_send_message(sync->conn, reply);
+	g_dbus_send_message(conn, reply);
 	dbus_message_unref(sync->msg);
 	sync->msg = NULL;
 }
@@ -160,34 +167,78 @@ static void sync_free(void *data)
 	struct sync_data *sync = data;
 
 	obc_session_unref(sync->session);
-	dbus_connection_unref(sync->conn);
 	g_free(sync->phonebook_path);
 	g_free(sync);
 }
 
-gboolean sync_register_interface(DBusConnection *connection, const char *path,
-							void *user_data)
+static int sync_probe(struct obc_session *session)
 {
-	struct obc_session *session = user_data;
 	struct sync_data *sync;
+	const char *path;
+
+	path = obc_session_get_path(session);
+
+	DBG("%s", path);
 
 	sync = g_try_new0(struct sync_data, 1);
 	if (!sync)
-		return FALSE;
+		return -ENOMEM;
 
 	sync->session = obc_session_ref(session);
-	sync->conn = dbus_connection_ref(connection);
 
-	if (g_dbus_register_interface(connection, path, SYNC_INTERFACE,
-				sync_methods, NULL, NULL, sync, sync_free)) {
+	if (!g_dbus_register_interface(conn, path, SYNC_INTERFACE, sync_methods,
+						NULL, NULL, sync, sync_free)) {
 		sync_free(sync);
-		return FALSE;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void sync_remove(struct obc_session *session)
+{
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	g_dbus_unregister_interface(conn, path, SYNC_INTERFACE);
+}
+
+static struct obc_driver sync = {
+	.service = "SYNC",
+	.uuid = SYNC_UUID,
+	.target = OBEX_SYNC_UUID,
+	.target_len = OBEX_SYNC_UUID_LEN,
+	.probe = sync_probe,
+	.remove = sync_remove
+};
+
+int sync_init(void)
+{
+	int err;
+
+	DBG("");
+
+	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (!conn)
+		return -EIO;
+
+	err = obc_driver_register(&sync);
+	if (err < 0) {
+		dbus_connection_unref(conn);
+		conn = NULL;
+		return err;
 	}
 
-	return TRUE;
+	return 0;
 }
 
-void sync_unregister_interface(DBusConnection *connection, const char *path)
+void sync_exit(void)
 {
-	g_dbus_unregister_interface(connection, path, SYNC_INTERFACE);
+	DBG("");
+
+	dbus_connection_unref(conn);
+	conn = NULL;
+
+	obc_driver_unregister(&sync);
 }
diff --git a/client/sync.h b/client/sync.h
index 01806e6..8adc5f8 100644
--- a/client/sync.h
+++ b/client/sync.h
@@ -22,8 +22,5 @@
  *
  */
 
-#include <gdbus.h>
-
-gboolean sync_register_interface(DBusConnection *connection, const char *path,
-							void *user_data);
-void sync_unregister_interface(DBusConnection *connection, const char *path);
+int sync_init(void);
+void sync_exit(void);
-- 
1.7.6

