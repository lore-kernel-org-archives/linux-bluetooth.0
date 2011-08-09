Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC obexd 6/8] client: add pbap plugin
Date: Tue,  9 Aug 2011 14:03:47 +0300
Message-Id: <1312887829-4770-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312887829-4770-1-git-send-email-luiz.dentz@gmail.com>
References: <1312887829-4770-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

pbap plugin implements phonebook access driver
---
 Makefile.am                 |    4 +-
 client/pbap.h               |   29 --------------
 client/{ => plugins}/pbap.c |   90 ++++++++++++++++++++++++++++++++++---------
 client/session.c            |    1 -
 4 files changed, 74 insertions(+), 50 deletions(-)
 delete mode 100644 client/pbap.h
 rename client/{ => plugins}/pbap.c (94%)

diff --git a/Makefile.am b/Makefile.am
index 1f7071a..b2cedba 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -130,6 +130,9 @@ client_builtin_sources += client/plugins/opp.c
 client_builtin_modules += ftp
 client_builtin_sources += client/plugins/ftp.c
 
+client_builtin_modules += pbap
+client_builtin_sources += client/plugins/pbap.c
+
 libexec_PROGRAMS += client/obex-client
 
 client_obex_client_SOURCES = $(gdbus_sources) $(client_builtin_sources) \
@@ -137,7 +140,6 @@ client_obex_client_SOURCES = $(gdbus_sources) $(client_builtin_sources) \
 				client/main.c src/log.h src/log.c \
 				client/manager.h client/manager.c \
 				client/session.h client/session.c \
-				client/pbap.h client/pbap.c \
 				client/sync.h client/sync.c \
 				client/transfer.h client/transfer.c \
 				client/agent.h client/agent.c \
diff --git a/client/pbap.h b/client/pbap.h
deleted file mode 100644
index 3ae1159..0000000
--- a/client/pbap.h
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
-gboolean pbap_register_interface(DBusConnection *connection, const char *path,
-							void *user_data);
-void pbap_unregister_interface(DBusConnection *connection, const char *path);
diff --git a/client/pbap.c b/client/plugins/pbap.c
similarity index 94%
rename from client/pbap.c
rename to client/plugins/pbap.c
index 2b8afbf..ab104a4 100644
--- a/client/pbap.c
+++ b/client/plugins/pbap.c
@@ -32,10 +32,14 @@
 #include <glib.h>
 #include <gdbus.h>
 
+#include <bluetooth/bluetooth.h>
+
 #include "log.h"
-#include "transfer.h"
-#include "session.h"
-#include "pbap.h"
+
+#include "client/transfer.h"
+#include "client/session.h"
+#include "client/plugin.h"
+#include "client/driver.h"
 
 #define ERROR_INF PBAP_INTERFACE ".Error"
 
@@ -115,11 +119,11 @@ static const char *filter_list[] = {
 #define FILTER_ALL	0xFFFFFFFFFFFFFFFFULL
 
 #define PBAP_INTERFACE  "org.openobex.PhonebookAccess"
+#define PBAP_UUID "0000112f-0000-1000-8000-00805f9b34fb"
 
 struct pbap_data {
 	struct obc_session *session;
 	char *path;
-	DBusConnection *conn;
 	DBusMessage *msg;
 	guint8 format;
 	guint8 order;
@@ -158,6 +162,8 @@ struct apparam_hdr {
 
 #define APPARAM_HDR_SIZE 2
 
+static DBusConnection *conn = NULL;
+
 static void listing_element(GMarkupParseContext *ctxt,
 				const gchar *element,
 				const gchar **names,
@@ -374,7 +380,7 @@ static void pull_phonebook_callback(struct obc_session *session,
 	obc_transfer_clear_buffer(transfer);
 
 send:
-	g_dbus_send_message(pbap->conn, reply);
+	g_dbus_send_message(conn, reply);
 	dbus_message_unref(pbap->msg);
 	pbap->msg = NULL;
 
@@ -412,7 +418,7 @@ static void phonebook_size_callback(struct obc_session *session,
 	obc_transfer_clear_buffer(transfer);
 
 send:
-	g_dbus_send_message(pbap->conn, reply);
+	g_dbus_send_message(conn, reply);
 	dbus_message_unref(pbap->msg);
 	pbap->msg = NULL;
 
@@ -460,7 +466,7 @@ static void pull_vcard_listing_callback(struct obc_session *session,
 	obc_transfer_clear_buffer(transfer);
 
 send:
-	g_dbus_send_message(pbap->conn, reply);
+	g_dbus_send_message(conn, reply);
 	dbus_message_unref(pbap->msg);
 	pbap->msg = NULL;
 complete:
@@ -986,33 +992,79 @@ static void pbap_free(void *data)
 	struct pbap_data *pbap = data;
 
 	obc_session_unref(pbap->session);
-	dbus_connection_unref(pbap->conn);
 	g_free(pbap);
 }
 
-gboolean pbap_register_interface(DBusConnection *connection, const char *path,
-							void *user_data)
+static int pbap_probe(struct obc_session *session)
 {
-	struct obc_session *session = user_data;
 	struct pbap_data *pbap;
+	const char *path;
+
+	path = obc_session_get_path(session);
+
+	DBG("%s", path);
 
 	pbap = g_try_new0(struct pbap_data, 1);
 	if (!pbap)
-		return FALSE;
+		return -ENOMEM;
 
 	pbap->session = obc_session_ref(session);
-	pbap->conn = dbus_connection_ref(connection);
 
-	if (g_dbus_register_interface(connection, path, PBAP_INTERFACE,
-			pbap_methods, NULL, NULL, pbap, pbap_free) == FALSE) {
+	if (!g_dbus_register_interface(conn, path, PBAP_INTERFACE, pbap_methods,
+						NULL, NULL, pbap, pbap_free)) {
 		pbap_free(pbap);
-		return FALSE;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void pbap_remove(struct obc_session *session)
+{
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	g_dbus_unregister_interface(conn, path, PBAP_INTERFACE);
+}
+
+static struct obc_driver pbap = {
+	.service = "PBAP",
+	.uuid = PBAP_UUID,
+	.target = OBEX_PBAP_UUID,
+	.target_len = OBEX_PBAP_UUID_LEN,
+	.probe = pbap_probe,
+	.remove = pbap_remove
+};
+
+static int pbap_init(void)
+{
+	int err;
+
+	DBG("");
+
+	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (!conn)
+		return -EIO;
+
+	err = obc_driver_register(&pbap);
+	if (err < 0) {
+		dbus_connection_unref(conn);
+		conn = NULL;
+		return err;
 	}
 
-	return TRUE;
+	return 0;
 }
 
-void pbap_unregister_interface(DBusConnection *connection, const char *path)
+static void pbap_exit(void)
 {
-	g_dbus_unregister_interface(connection, path, PBAP_INTERFACE);
+	DBG("");
+
+	dbus_connection_unref(conn);
+	conn = NULL;
+
+	obc_driver_unregister(&pbap);
 }
+
+OBC_PLUGIN_DEFINE(pbap, pbap_init, pbap_exit)
diff --git a/client/session.c b/client/session.c
index 6fa6367..d1807d5 100644
--- a/client/session.c
+++ b/client/session.c
@@ -41,7 +41,6 @@
 #include <bluetooth/sdp_lib.h>
 
 #include "log.h"
-#include "pbap.h"
 #include "sync.h"
 #include "transfer.h"
 #include "session.h"
-- 
1.7.6

