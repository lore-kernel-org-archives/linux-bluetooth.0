Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 11/13 v3] client: remove use of gobex in map module
Date: Wed,  8 Feb 2012 11:44:07 +0200
Message-Id: <1328694249-22225-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328694249-22225-1-git-send-email-luiz.dentz@gmail.com>
References: <1328694249-22225-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gobex should not be use directly as it can interfere with ongoing
requests of the session.
---
 client/map.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/client/map.c b/client/map.c
index 9a76919..68b1fbc 100644
--- a/client/map.c
+++ b/client/map.c
@@ -48,23 +48,16 @@ struct map_data {
 
 static DBusConnection *conn = NULL;
 
-static void simple_cb(GObex *obex, GError *err, GObexPacket *rsp,
+static void simple_cb(struct obc_session *session, GError *err,
 							gpointer user_data)
 {
 	DBusMessage *reply;
 	struct map_data *map = user_data;
-	guint8 err_code = g_obex_packet_get_operation(rsp, NULL);
 
 	if (err != NULL)
 		reply = g_dbus_create_error(map->msg,
 						"org.openobex.Error.Failed",
 						"%s", err->message);
-	else if (err_code != G_OBEX_RSP_SUCCESS)
-		reply = g_dbus_create_error(map->msg,
-						"org.openobex.Error.Failed",
-						"%s (0x%02x)",
-						g_obex_strerror(err_code),
-						err_code);
 	else
 		reply = dbus_message_new_method_return(map->msg);
 
@@ -77,7 +70,6 @@ static DBusMessage *map_setpath(DBusConnection *connection,
 {
 	struct map_data *map = user_data;
 	const char *folder;
-	GObex *obex;
 	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL, DBUS_TYPE_STRING, &folder,
@@ -86,9 +78,7 @@ static DBusMessage *map_setpath(DBusConnection *connection,
 					"org.openobex.Error.InvalidArguments",
 					NULL);
 
-	obex = obc_session_get_obex(map->session);
-
-	g_obex_setpath(obex, folder, simple_cb, map, &err);
+	obc_session_setpath(map->session, folder, simple_cb, map, &err);
 	if (err != NULL) {
 		DBusMessage *reply;
 		reply =  g_dbus_create_error(message,
-- 
1.7.7.6

