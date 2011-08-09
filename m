Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC obexd 7/8] client: add sync plugin
Date: Tue,  9 Aug 2011 14:03:48 +0300
Message-Id: <1312887829-4770-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312887829-4770-1-git-send-email-luiz.dentz@gmail.com>
References: <1312887829-4770-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

sync plugin implements sync driver
---
 Makefile.am                 |    4 +-
 client/{ => plugins}/sync.c |   87 ++++++++++++++++++++++++++++++++++--------
 client/session.c            |    1 -
 client/sync.h               |   29 --------------
 4 files changed, 73 insertions(+), 48 deletions(-)
 rename client/{ => plugins}/sync.c (77%)
 delete mode 100644 client/sync.h

diff --git a/Makefile.am b/Makefile.am
index b2cedba..151865c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -133,6 +133,9 @@ client_builtin_sources += client/plugins/ftp.c
 client_builtin_modules += pbap
 client_builtin_sources += client/plugins/pbap.c
 
+client_builtin_modules += sync
+client_builtin_sources += client/plugins/sync.c
+
 libexec_PROGRAMS += client/obex-client
 
 client_obex_client_SOURCES = $(gdbus_sources) $(client_builtin_sources) \
@@ -140,7 +143,6 @@ client_obex_client_SOURCES = $(gdbus_sources) $(client_builtin_sources) \
 				client/main.c src/log.h src/log.c \
 				client/manager.h client/manager.c \
 				client/session.h client/session.c \
-				client/sync.h client/sync.c \
 				client/transfer.h client/transfer.c \
 				client/agent.h client/agent.c \
 				client/plugin.h client/plugin.c \
diff --git a/client/sync.c b/client/plugins/sync.c
similarity index 77%
rename from client/sync.c
rename to client/plugins/sync.c
index abeb717..107907a 100644
--- a/client/sync.c
+++ b/client/plugins/sync.c
@@ -26,23 +26,30 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+
 #include <glib.h>
 #include <gdbus.h>
 
-#include "transfer.h"
-#include "session.h"
-#include "sync.h"
+#include "log.h"
+
+#include "client/transfer.h"
+#include "client/session.h"
+#include "client/plugin.h"
+#include "client/driver.h"
 
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
@@ -160,34 +167,80 @@ static void sync_free(void *data)
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
 	}
 
-	return TRUE;
+	return 0;
 }
 
-void sync_unregister_interface(DBusConnection *connection, const char *path)
+static void sync_remove(struct obc_session *session)
 {
-	g_dbus_unregister_interface(connection, path, SYNC_INTERFACE);
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	g_dbus_unregister_interface(conn, path, SYNC_INTERFACE);
 }
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
+static int sync_init(void)
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
+	}
+
+	return 0;
+}
+
+static void sync_exit(void)
+{
+	DBG("");
+
+	dbus_connection_unref(conn);
+	conn = NULL;
+
+	obc_driver_unregister(&sync);
+}
+
+OBC_PLUGIN_DEFINE(sync, sync_init, sync_exit)
diff --git a/client/session.c b/client/session.c
index d1807d5..ccd06a9 100644
--- a/client/session.c
+++ b/client/session.c
@@ -41,7 +41,6 @@
 #include <bluetooth/sdp_lib.h>
 
 #include "log.h"
-#include "sync.h"
 #include "transfer.h"
 #include "session.h"
 #include "btio.h"
diff --git a/client/sync.h b/client/sync.h
deleted file mode 100644
index 01806e6..0000000
--- a/client/sync.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- *
- *  OBEX Client
- *
- *  Copyright (C) 2007-2010  Intel Corporation
- *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#include <gdbus.h>
-
-gboolean sync_register_interface(DBusConnection *connection, const char *path,
-							void *user_data);
-void sync_unregister_interface(DBusConnection *connection, const char *path);
-- 
1.7.6

