Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC obexd 5/8] client: add ftp plugin
Date: Tue,  9 Aug 2011 14:03:46 +0300
Message-Id: <1312887829-4770-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312887829-4770-1-git-send-email-luiz.dentz@gmail.com>
References: <1312887829-4770-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

ftp plugin implements file transfer and Nokia Pc Suite drivers.
---
 Makefile.am                |    4 +-
 client/ftp.h               |   29 -----------
 client/{ => plugins}/ftp.c |  112 ++++++++++++++++++++++++++++++++++++-------
 client/session.c           |    1 -
 4 files changed, 96 insertions(+), 50 deletions(-)
 delete mode 100644 client/ftp.h
 rename client/{ => plugins}/ftp.c (83%)

diff --git a/Makefile.am b/Makefile.am
index 89546ce..1f7071a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -127,6 +127,9 @@ client_builtin_nodist =
 client_builtin_modules += opp
 client_builtin_sources += client/plugins/opp.c
 
+client_builtin_modules += ftp
+client_builtin_sources += client/plugins/ftp.c
+
 libexec_PROGRAMS += client/obex-client
 
 client_obex_client_SOURCES = $(gdbus_sources) $(client_builtin_sources) \
@@ -136,7 +139,6 @@ client_obex_client_SOURCES = $(gdbus_sources) $(client_builtin_sources) \
 				client/session.h client/session.c \
 				client/pbap.h client/pbap.c \
 				client/sync.h client/sync.c \
-				client/ftp.h client/ftp.c \
 				client/transfer.h client/transfer.c \
 				client/agent.h client/agent.c \
 				client/plugin.h client/plugin.c \
diff --git a/client/ftp.h b/client/ftp.h
deleted file mode 100644
index 1af2a3d..0000000
--- a/client/ftp.h
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
-gboolean ftp_register_interface(DBusConnection *connection, const char *path,
-							void *user_data);
-void ftp_unregister_interface(DBusConnection *connection, const char *path);
diff --git a/client/ftp.c b/client/plugins/ftp.c
similarity index 83%
rename from client/ftp.c
rename to client/plugins/ftp.c
index 5d1fa5c..1f804bc 100644
--- a/client/ftp.c
+++ b/client/plugins/ftp.c
@@ -25,17 +25,27 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
 #include <string.h>
 
-#include "session.h"
-#include "transfer.h"
-#include "ftp.h"
+#include <gw-obex.h>
+#include <gdbus.h>
 
-#define FTP_INTERFACE  "org.openobex.FileTransfer"
+#include "log.h"
+
+#include "client/session.h"
+#include "client/transfer.h"
+#include "client/plugin.h"
+#include "client/driver.h"
+
+#define FTP_INTERFACE "org.openobex.FileTransfer"
+#define FTP_UUID "00001106-0000-1000-8000-00805f9b34fb"
+#define PCSUITE_UUID "00005005-0000-1000-8000-0002ee000001"
+
+static DBusConnection *conn = NULL;
 
 struct ftp_data {
 	struct obc_session *session;
-	DBusConnection *conn;
 	DBusMessage *msg;
 };
 
@@ -157,7 +167,7 @@ static void get_file_callback(struct obc_session *session, GError *err,
 	else
 		reply = dbus_message_new_method_return(ftp->msg);
 
-	g_dbus_send_message(ftp->conn, reply);
+	g_dbus_send_message(conn, reply);
 
 	dbus_message_unref(ftp->msg);
 	ftp->msg = NULL;
@@ -194,7 +204,7 @@ static void list_folder_callback(struct obc_session *session,
 	obc_transfer_clear_buffer(transfer);
 
 done:
-	g_dbus_send_message(ftp->conn, reply);
+	g_dbus_send_message(conn, reply);
 	dbus_message_unref(ftp->msg);
 	ftp->msg = NULL;
 }
@@ -352,33 +362,97 @@ static void ftp_free(void *data)
 	struct ftp_data *ftp = data;
 
 	obc_session_unref(ftp->session);
-	dbus_connection_unref(ftp->conn);
 	g_free(ftp);
 }
 
-gboolean ftp_register_interface(DBusConnection *connection, const char *path,
-							void *user_data)
+static int ftp_probe(struct obc_session *session)
 {
-	struct obc_session *session = user_data;
 	struct ftp_data *ftp;
+	const char *path;
+
+	path = obc_session_get_path(session);
+
+	DBG("%s", path);
 
 	ftp = g_try_new0(struct ftp_data, 1);
 	if (!ftp)
-		return FALSE;
+		return -ENOMEM;
 
 	ftp->session = obc_session_ref(session);
-	ftp->conn = dbus_connection_ref(connection);
 
-	if (!g_dbus_register_interface(connection, path, FTP_INTERFACE,
-				ftp_methods, NULL, NULL, ftp, ftp_free)) {
+	if (!g_dbus_register_interface(conn, path, FTP_INTERFACE, ftp_methods,
+						NULL, NULL, ftp, ftp_free)) {
 		ftp_free(ftp);
-		return FALSE;
+		return -ENOMEM;
 	}
 
-	return TRUE;
+	return 0;
 }
 
-void ftp_unregister_interface(DBusConnection *connection, const char *path)
+static void ftp_remove(struct obc_session *session)
 {
-	g_dbus_unregister_interface(connection, path, FTP_INTERFACE);
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	g_dbus_unregister_interface(conn, path, FTP_INTERFACE);
 }
+
+static struct obc_driver ftp = {
+	.service = "FTP",
+	.uuid = FTP_UUID,
+	.target = OBEX_FTP_UUID,
+	.target_len = OBEX_FTP_UUID_LEN,
+	.probe = ftp_probe,
+	.remove = ftp_remove
+};
+
+static struct obc_driver pcsuite = {
+	.service = "PCSUITE",
+	.uuid = PCSUITE_UUID,
+	.target = OBEX_FTP_UUID,
+	.target_len = OBEX_FTP_UUID_LEN,
+	.probe = ftp_probe,
+	.remove = ftp_remove
+};
+
+static int ftp_init(void)
+{
+	int err;
+
+	DBG("");
+
+	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (!conn)
+		return -EIO;
+
+	err = obc_driver_register(&ftp);
+	if (err < 0)
+		goto failed;
+
+	err = obc_driver_register(&pcsuite);
+	if (err < 0) {
+		obc_driver_unregister(&ftp);
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	dbus_connection_unref(conn);
+	conn = NULL;
+	return err;
+}
+
+static void ftp_exit(void)
+{
+	DBG("");
+
+	dbus_connection_unref(conn);
+	conn = NULL;
+
+	obc_driver_unregister(&ftp);
+	obc_driver_unregister(&pcsuite);
+}
+
+OBC_PLUGIN_DEFINE(ftp, ftp_init, ftp_exit)
diff --git a/client/session.c b/client/session.c
index 8141d17..6fa6367 100644
--- a/client/session.c
+++ b/client/session.c
@@ -43,7 +43,6 @@
 #include "log.h"
 #include "pbap.h"
 #include "sync.h"
-#include "ftp.h"
 #include "transfer.h"
 #include "session.h"
 #include "btio.h"
-- 
1.7.6

