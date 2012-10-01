Return-Path: <cyrus@holtmann.org>
From: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
Subject: [PATCH] client: Add Message.MarkAsRead and Message.MarkAsDeleted implementation and documentation.
Date: Mon,  1 Oct 2012 12:40:05 +0530
Message-Id: <1349075405-31674-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/map.c       |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/transfer.c  |    3 +-
 doc/client-api.txt |   11 ++++++
 3 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/client/map.c b/client/map.c
index 4f07fcb..69a9a21 100644
--- a/client/map.c
+++ b/client/map.c
@@ -26,7 +26,9 @@
 
 #include <errno.h>
 #include <string.h>
+#include <fcntl.h>
 #include <glib.h>
+#include <glib/gstdio.h>
 #include <gdbus.h>
 
 #include "dbus.h"
@@ -36,6 +38,8 @@
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
+#include "src/map_ap.h"
+#include "gobex/gobex-apparam.h"
 
 #define OBEX_MAS_UUID \
 	"\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
@@ -46,6 +50,10 @@
 #define ERROR_INTERFACE "org.bluez.obex.Error"
 #define MAS_UUID "00001132-0000-1000-8000-00805f9b34fb"
 
+#define STATUS_READ 0
+#define STATUS_DELETE 1
+#define FILLER_BYTE 0x30
+
 struct map_data {
 	struct obc_session *session;
 	DBusMessage *msg;
@@ -72,6 +80,7 @@ struct map_msg {
 	uint64_t size;
 	char *status;
 	uint8_t flags;
+	DBusMessage *msg;	
 };
 
 struct map_parser {
@@ -284,12 +293,115 @@ fail:
 	return reply;
 }
 
+static void set_message_flag_cb(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
+{
+	struct map_msg *msg = user_data;
+	DBusMessage *reply;
+	char *target_file;
+
+	if (err != NULL) {
+		reply = g_dbus_create_error(msg->msg,
+						ERROR_INTERFACE ".Failed",
+						"%s", err->message);
+		goto done;
+	}
+
+	/* Get rid of the tmp file */
+	target_file = g_build_filename (g_get_tmp_dir(), "bt-msg-status", NULL);
+	g_unlink (target_file);
+	g_free (target_file);
+
+	reply = dbus_message_new_method_return(msg->msg);
+	if (reply == NULL)
+		return;
+
+done:
+	g_dbus_send_message(conn, reply);
+	dbus_message_unref(msg->msg);
+	msg->msg = NULL;
+}
+
+static DBusMessage *map_msg_mark_flag (DBusConnection *connection,
+						DBusMessage *message, int op, void *user_data)
+{
+	struct map_msg *msg = user_data;
+	struct obc_transfer *transfer;
+	char *target_file;
+	gboolean status;
+	GError *err = NULL;
+	DBusMessage *reply;
+	GObexApparam *apparam;
+	guint8 buf[6];
+	gsize len;
+	char contents[2];
+
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_BOOLEAN, &status,
+				DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	target_file = g_build_filename (g_get_tmp_dir(), "bt-msg-status", NULL);
+
+	contents[0] = FILLER_BYTE;
+	contents[1] = '\0';
+	
+	transfer = obc_transfer_put("x-bt/messageStatus", msg->handle, target_file,
+							contents, sizeof(contents), &err);
+	if (transfer == NULL)
+		goto fail;
+
+	apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_STATUSINDICATOR,
+								op);
+	apparam = g_obex_apparam_set_uint8(apparam, MAP_AP_STATUSVALUE,
+								status);
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+
+	obc_transfer_set_params(transfer, buf, len);
+
+	g_obex_apparam_free(apparam);
+
+	if (!obc_session_queue(msg->data->session, transfer, set_message_flag_cb, msg, &err))
+		goto fail;
+
+	msg->msg = dbus_message_ref (message);
+
+	return NULL;
+
+fail:
+	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
+								err->message);
+	g_free (target_file);
+	g_error_free(err);
+	return reply;
+}
+
+static DBusMessage *map_msg_mark_deleted (DBusConnection *connection,
+						DBusMessage *message, void *user_data)
+{
+	return map_msg_mark_flag (connection, message, STATUS_DELETE, user_data);
+}
+
+static DBusMessage *map_msg_mark_read (DBusConnection *connection,
+						DBusMessage *message, void *user_data)
+{
+	return map_msg_mark_flag (connection, message, STATUS_READ, user_data);
+}
+
 static const GDBusMethodTable map_msg_methods[] = {
 	{ GDBUS_METHOD("Get",
 			GDBUS_ARGS({ "targetfile", "s" }),
 			GDBUS_ARGS({ "transfer", "o" },
 						{ "properties", "a{sv}" }),
 			map_msg_get) },
+	{ GDBUS_ASYNC_METHOD("MarkAsRead",
+			GDBUS_ARGS({ "read", "b" }), NULL,
+			map_msg_mark_read) },
+	{ GDBUS_ASYNC_METHOD("MarkAsDeleted",
+			GDBUS_ARGS({ "deleted", "b" }), NULL,
+			map_msg_mark_deleted) },
 	{ }
 };
 
diff --git a/client/transfer.c b/client/transfer.c
index e9fabfb..0040f74 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -416,7 +416,7 @@ struct obc_transfer *obc_transfer_put(const char *type, const char *name,
 	if (contents != NULL) {
 		ssize_t w;
 
-		if (!transfer_open(transfer, O_RDWR, 0, err))
+		if (!transfer_open(transfer, O_RDWR|O_CREAT|O_TRUNC, 0, err))
 			goto fail;
 
 		w = write(transfer->fd, contents, size);
@@ -432,6 +432,7 @@ struct obc_transfer *obc_transfer_put(const char *type, const char *name,
 					"Writing all contents to file failed");
 			goto fail;
 		}
+		lseek(transfer->fd, 0, SEEK_SET);
 	} else {
 		if (!transfer_open(transfer, O_RDONLY, 0, err))
 			goto fail;
diff --git a/doc/client-api.txt b/doc/client-api.txt
index f447789..aa98399 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -471,6 +471,17 @@ Methods		object, dict Get(string targetfile)
 			The properties of this transfer are also returned along
 			with the object path, to avoid a call to GetProperties.
 
+		void MarkAsRead(boolean read)
+
+			Mark the message as read or unread depending on the *read*
+			flag.
+
+		void MarkAsDeleted(boolean deleted)
+
+			Mark the message as deleted or undeleted depending on the 
+			*deleted* flag.
+
+
 Transfer hierarchy
 ==================
 
-- 
1.7.10.4

