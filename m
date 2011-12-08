Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 3/6] Add support for SetFolder in MAP client
Date: Thu,  8 Dec 2011 14:07:55 +0100
Message-Id: <1323349678-17905-3-git-send-email-bulislaw@linux.com>
In-Reply-To: <1323349678-17905-1-git-send-email-bulislaw@linux.com>
References: <1323349678-17905-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/map.c       |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/client-api.txt |    5 +++-
 2 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/client/map.c b/client/map.c
index bee49c5..bc45a13 100644
--- a/client/map.c
+++ b/client/map.c
@@ -40,6 +40,9 @@
 #define OBEX_MAS_UUID_LEN 16
 
 #define MAP_INTERFACE  "org.openobex.MessageAccess"
+#define ERROR_INF MAP_INTERFACE ".Error"
+#define ERROR_FAILED_PATH "org.openobex.Error.Failed"
+
 #define MAS_UUID "00001132-0000-1000-8000-00805f9b34fb"
 
 struct map_data {
@@ -49,7 +52,60 @@ struct map_data {
 
 static DBusConnection *conn = NULL;
 
+static void simple_cb(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
+{
+	DBusMessage *reply;
+	struct map_data *map = user_data;
+	guint8 err_code = g_obex_packet_get_operation(rsp, NULL);
+
+	if (err != NULL)
+		reply = g_dbus_create_error(map->msg, ERROR_FAILED_PATH,
+							"%s", err->message);
+	else if (err_code != G_OBEX_RSP_SUCCESS)
+		reply = g_dbus_create_error(map->msg,
+						"org.openobex.Error.Response",
+						"%s (0x%02x)",
+						g_obex_strerror(err_code),
+						err_code);
+	else
+		reply = dbus_message_new_method_return(map->msg);
+
+	g_dbus_send_message(conn, reply);
+	dbus_message_unref(map->msg);
+}
+
+static DBusMessage *map_setpath(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct map_data *map = user_data;
+	const char *folder;
+	GObex *obex;
+	GError *err = NULL;
+
+	if (dbus_message_get_args(message, NULL, DBUS_TYPE_STRING, &folder,
+						DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+					ERROR_INF ".InvalidArguments", NULL);
+
+	obex = obc_session_get_obex(map->session);
+
+	g_obex_setpath(obex, folder, simple_cb, map, &err);
+	if (err != NULL) {
+		DBusMessage *reply;
+		reply =  g_dbus_create_error(message, ERROR_FAILED_PATH,
+							"%s", err->message);
+		g_error_free(err);
+		return reply;
+	}
+
+	map->msg = dbus_message_ref(message);
+
+	return NULL;
+}
+
 static GDBusMethodTable map_methods[] = {
+	{ "SetFolder",	"s",	"",	map_setpath, G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 
diff --git a/doc/client-api.txt b/doc/client-api.txt
index ee8951f..fb5a8b2 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -258,7 +258,10 @@ Service		org.openobex.client
 Interface	org.openobex.MessageAccess
 Object path	[variable prefix]/{session0,session1,...}
 
-Methods
+Methods		void SetFolder(string name)
+
+			Set working directory for current session, *name* may
+			be the directory name or '..[/dir]'.
 
 Transfer hierarchy
 ==================
-- 
1.7.4.1

