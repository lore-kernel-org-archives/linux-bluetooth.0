Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/8] client: add ftp target
Date: Fri, 12 Aug 2011 11:45:12 +0300
Message-Id: <1313138714-6443-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
References: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ftp target implements file transfer and Nokia Pc Suite drivers.
---
 client/ftp.c     |  104 +++++++++++++++++++++++++++++++++++++++++++++--------
 client/ftp.h     |    8 +---
 client/manager.c |    2 +
 client/session.c |    1 -
 4 files changed, 92 insertions(+), 23 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 5d1fa5c..e81d443 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -25,17 +25,27 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
 #include <string.h>
 
+#include <gw-obex.h>
+#include <gdbus.h>
+
+#include "log.h"
+
 #include "session.h"
 #include "transfer.h"
+#include "driver.h"
 #include "ftp.h"
 
-#define FTP_INTERFACE  "org.openobex.FileTransfer"
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
@@ -352,33 +362,95 @@ static void ftp_free(void *data)
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
+	}
+
+	return 0;
+}
+
+static void ftp_remove(struct obc_session *session)
+{
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	g_dbus_unregister_interface(conn, path, FTP_INTERFACE);
+}
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
+int ftp_init(void)
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
 	}
 
-	return TRUE;
+	return 0;
+
+failed:
+	dbus_connection_unref(conn);
+	conn = NULL;
+	return err;
 }
 
-void ftp_unregister_interface(DBusConnection *connection, const char *path)
+void ftp_exit(void)
 {
-	g_dbus_unregister_interface(connection, path, FTP_INTERFACE);
+	DBG("");
+
+	dbus_connection_unref(conn);
+	conn = NULL;
+
+	obc_driver_unregister(&ftp);
+	obc_driver_unregister(&pcsuite);
 }
diff --git a/client/ftp.h b/client/ftp.h
index 1af2a3d..3d90968 100644
--- a/client/ftp.h
+++ b/client/ftp.h
@@ -2,7 +2,6 @@
  *
  *  OBEX Client
  *
- *  Copyright (C) 2007-2010  Intel Corporation
  *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
  *
  *
@@ -22,8 +21,5 @@
  *
  */
 
-#include <gdbus.h>
-
-gboolean ftp_register_interface(DBusConnection *connection, const char *path,
-							void *user_data);
-void ftp_unregister_interface(DBusConnection *connection, const char *path);
+int ftp_init(void);
+void ftp_exit(void);
diff --git a/client/manager.c b/client/manager.c
index 7e1eb1b..44de5d8 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -39,6 +39,7 @@
 #include "session.h"
 #include "manager.h"
 #include "opp.h"
+#include "ftp.h"
 
 #define CLIENT_SERVICE  "org.openobex.client"
 
@@ -561,6 +562,7 @@ static struct target_module {
 	void (*exit) (void);
 } targets[] = {
 	{ "opp", opp_init, opp_exit },
+	{ "ftp", ftp_init, ftp_exit },
 	{ }
 };
 
diff --git a/client/session.c b/client/session.c
index 4bcf225..9436507 100644
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

