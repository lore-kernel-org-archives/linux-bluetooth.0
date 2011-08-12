Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 7/8] client: add pbap target
Date: Fri, 12 Aug 2011 11:45:13 +0300
Message-Id: <1313138714-6443-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
References: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

pbap target implements phonebook access driver
---
 Makefile.am      |    2 +-
 client/manager.c |    2 +
 client/pbap.c    |   82 +++++++++++++++++++++++++++++++++++++++++++----------
 client/pbap.h    |    7 +---
 client/session.c |    1 -
 5 files changed, 71 insertions(+), 23 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 8888401..374fa1d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -127,8 +127,8 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/main.c src/log.h src/log.c \
 				client/manager.h client/manager.c \
 				client/session.h client/session.c \
-				client/pbap.h client/pbap.c \
 				client/sync.h client/sync.c \
+				client/pbap.h client/pbap.c \
 				client/ftp.h client/ftp.c \
 				client/opp.h client/opp.c \
 				client/transfer.h client/transfer.c \
diff --git a/client/manager.c b/client/manager.c
index 44de5d8..65e7a7f 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -40,6 +40,7 @@
 #include "manager.h"
 #include "opp.h"
 #include "ftp.h"
+#include "pbap.h"
 
 #define CLIENT_SERVICE  "org.openobex.client"
 
@@ -563,6 +564,7 @@ static struct target_module {
 } targets[] = {
 	{ "opp", opp_init, opp_exit },
 	{ "ftp", ftp_init, ftp_exit },
+	{ "pbap", pbap_init, pbap_exit },
 	{ }
 };
 
diff --git a/client/pbap.c b/client/pbap.c
index 2b8afbf..1fa4cb3 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -32,9 +32,13 @@
 #include <glib.h>
 #include <gdbus.h>
 
+#include <bluetooth/bluetooth.h>
+
 #include "log.h"
+
 #include "transfer.h"
 #include "session.h"
+#include "driver.h"
 #include "pbap.h"
 
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
@@ -986,33 +992,77 @@ static void pbap_free(void *data)
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
 	}
 
-	return TRUE;
+	return 0;
 }
 
-void pbap_unregister_interface(DBusConnection *connection, const char *path)
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
+int pbap_init(void)
 {
-	g_dbus_unregister_interface(connection, path, PBAP_INTERFACE);
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
+	}
+
+	return 0;
+}
+
+void pbap_exit(void)
+{
+	DBG("");
+
+	dbus_connection_unref(conn);
+	conn = NULL;
+
+	obc_driver_unregister(&pbap);
 }
diff --git a/client/pbap.h b/client/pbap.h
index 3ae1159..ce56258 100644
--- a/client/pbap.h
+++ b/client/pbap.h
@@ -22,8 +22,5 @@
  *
  */
 
-#include <gdbus.h>
-
-gboolean pbap_register_interface(DBusConnection *connection, const char *path,
-							void *user_data);
-void pbap_unregister_interface(DBusConnection *connection, const char *path);
+int pbap_init(void);
+void pbap_exit(void);
diff --git a/client/session.c b/client/session.c
index 9436507..4c7f07d 100644
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

