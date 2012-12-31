Return-Path: <cyrus@holtmann.org>
From: Marcin Zawiejski <dragmz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcin Zawiejski <dragmz@gmail.com>
Subject: [PATCH] obexd: Fix crash while removing session
Date: Mon, 31 Dec 2012 15:22:58 +0100
Message-Id: <1356963778-2135-1-git-send-email-dragmz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Crash occurs when removing a session with RemoveSession while another session has been created but not yet registered

Backtrace:
0  __strcmp_ssse3 () at ../sysdeps/i386/i686/multiarch/strcmp-ssse3.S:233
1  0xb758e7c3 in g_str_equal () from /lib/i386-linux-gnu/libglib-2.0.so.0
2  0x08073e56 in find_session (path=0x85c8504 "/org/bluez/obex/session0") at obexd/client/manager.c:146
3  remove_session (connection=0x85bc5e0, message=0x85bca98, user_data=0x0) at obexd/client/manager.c:216
4  0x08055f6f in process_message (connection=0x85bc5e0, message=<optimized out>, iface_user_data=0x0,
    method=<optimized out>, method=<optimized out>) at gdbus/object.c:285
5  0xb7672666 in ?? () from /lib/i386-linux-gnu/libdbus-1.so.3
6  0xb76624d7 in dbus_connection_dispatch () from /lib/i386-linux-gnu/libdbus-1.so.3
7  0x080532f8 in message_dispatch (data=0x85bc5e0) at gdbus/mainloop.c:76
8  0xb759f6bf in ?? () from /lib/i386-linux-gnu/libglib-2.0.so.0
9  0xb759e9e3 in g_main_context_dispatch () from /lib/i386-linux-gnu/libglib-2.0.so.0
10 0xb759ed80 in ?? () from /lib/i386-linux-gnu/libglib-2.0.so.0
11 0xb759f1db in g_main_loop_run () from /lib/i386-linux-gnu/libglib-2.0.so.0
12 0x08052d74 in main (argc=1, argv=0xbfb344e4) at obexd/src/main.c:323
---
 obexd/client/manager.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/obexd/client/manager.c b/obexd/client/manager.c
index 8f62a30..03e60a4 100644
--- a/obexd/client/manager.c
+++ b/obexd/client/manager.c
@@ -59,11 +59,16 @@ static GSList *sessions = NULL;
 
 static void shutdown_session(struct obc_session *session)
 {
-	sessions = g_slist_remove(sessions, session);
 	obc_session_shutdown(session);
 	obc_session_unref(session);
 }
 
+static void release_session(struct obc_session *session)
+{
+	sessions = g_slist_remove(sessions, session);
+	shutdown_session(session);
+}
+
 static void unregister_session(void *data)
 {
 	struct obc_session *session = data;
@@ -93,7 +98,16 @@ static void create_callback(struct obc_session *session,
 
 
 	path = obc_session_register(session, unregister_session);
+	if (path == NULL) {
+		DBusMessage *error = g_dbus_create_error(data->message,
+					ERROR_INTERFACE ".Failed",
+					NULL);
+		g_dbus_send_message(data->connection, error);
+		shutdown_session(session);
+		goto done;
+	}
 
+	sessions = g_slist_append(sessions, session);
 	g_dbus_send_reply(data->connection, data->message,
 				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
@@ -190,7 +204,6 @@ static DBusMessage *create_session(DBusConnection *connection,
 					dbus_message_get_sender(message),
 					create_callback, data);
 	if (session != NULL) {
-		sessions = g_slist_append(sessions, session);
 		return NULL;
 	}
 
@@ -224,7 +237,7 @@ static DBusMessage *remove_session(DBusConnection *connection,
 				ERROR_INTERFACE ".NotAuthorized",
 				"Not Authorized");
 
-	shutdown_session(session);
+	release_session(session);
 
 	return dbus_message_new_method_return(message);
 }
-- 
1.8.0.3

