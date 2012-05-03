Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v0 2/2] client: Use new D-Bus helper function
Date: Thu,  3 May 2012 11:44:35 +0200
Message-Id: <1336038275-19591-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336038275-19591-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336038275-19591-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This refactoring makes use of the recently introduced helper function to
remove boilerplate error-handling code.
---
 client/ftp.c     |   85 +++++++++++++++--------------------------------------
 client/manager.c |   12 ++-----
 client/map.c     |   31 ++++++--------------
 client/pbap.c    |   29 +++++-------------
 client/sync.c    |   20 ++++---------
 5 files changed, 51 insertions(+), 126 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 0e6af47..7607107 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -80,14 +80,9 @@ static DBusMessage *change_folder(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments", NULL);
 
 	obc_session_setpath(session, folder, async_cb, message, &err);
-	if (err != NULL) {
-		DBusMessage *reply;
-		reply =  g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+					 "org.openobex.Error.Failed", &err);
 
 	dbus_message_ref(message);
 
@@ -236,14 +231,9 @@ static DBusMessage *create_folder(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments", NULL);
 
 	obc_session_mkdir(session, folder, async_cb, message, &err);
-	if (err != NULL) {
-		DBusMessage *reply;
-		reply = g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"%s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+					 "org.openobex.Error.Failed", &err);
 
 	dbus_message_ref(message);
 
@@ -259,13 +249,9 @@ static DBusMessage *list_folder(DBusConnection *connection,
 
 	obc_session_get(session, "x-obex/folder-listing", NULL, NULL,
 				NULL, 0, list_folder_callback, message, &err);
-	if (err != NULL) {
-		DBusMessage *reply = g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+					 "org.openobex.Error.Failed", &err);
 
 	dbus_message_ref(message);
 
@@ -289,13 +275,9 @@ static DBusMessage *get_file(DBusConnection *connection,
 
 	obc_session_get(session, NULL, source_file, target_file, NULL, 0,
 					get_file_callback, message, &err);
-	if (err != NULL) {
-		DBusMessage *reply = g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+					 "org.openobex.Error.Failed", &err);
 
 	dbus_message_ref(message);
 
@@ -319,13 +301,9 @@ static DBusMessage *put_file(DBusConnection *connection,
 				"Invalid arguments in method call");
 
 	obc_session_send(session, sourcefile, targetfile, &err);
-	if (err != NULL) {
-		DBusMessage *reply = g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+					 "org.openobex.Error.Failed", &err);
 
 	return dbus_message_new_method_return(message);
 }
@@ -346,14 +324,9 @@ static DBusMessage *copy_file(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments", NULL);
 
 	obc_session_copy(session, filename, destname, async_cb, message, &err);
-	if (err != NULL) {
-		DBusMessage *reply;
-		reply = g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+					 "org.openobex.Error.Failed", &err);
 
 	dbus_message_ref(message);
 
@@ -376,14 +349,9 @@ static DBusMessage *move_file(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments", NULL);
 
 	obc_session_move(session, filename, destname, async_cb, message, &err);
-	if (err != NULL) {
-		DBusMessage *reply;
-		reply = g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+					 "org.openobex.Error.Failed", &err);
 
 	dbus_message_ref(message);
 
@@ -405,14 +373,9 @@ static DBusMessage *delete(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments", NULL);
 
 	obc_session_delete(session, file, async_cb, message, &err);
-	if (err != NULL) {
-		DBusMessage *reply;
-		reply = g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+					 "org.openobex.Error.Failed", &err);
 
 	dbus_message_ref(message);
 
diff --git a/client/manager.c b/client/manager.c
index 6d08702..1447a09 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -287,10 +287,8 @@ static void pull_obc_session_callback(struct obc_session *session,
 	obc_session_pull(session, "text/x-vcard", data->filename,
 					pull_complete_callback, data, &gerr);
 	if (gerr != NULL) {
-		reply = g_dbus_create_error(data->message,
-						"org.openobex.Error.Failed",
-						"%s", gerr->message);
-		g_error_free(gerr);
+		reply = g_dbus_steal_from_gerror(data->message,
+					"org.openobex.Error.Failed", &gerr);
 		goto fail;
 	}
 
@@ -504,10 +502,8 @@ static void capability_obc_session_callback(struct obc_session *session,
 	obc_session_pull(session, "x-obex/capability", NULL,
 				capabilities_complete_callback, data, &gerr);
 	if (gerr != NULL) {
-		reply = g_dbus_create_error(data->message,
-					"org.openobex.Error.Failed",
-					"%s", gerr->message);
-		g_error_free(gerr);
+		reply = g_dbus_steal_from_gerror(data->message,
+					"org.openobex.Error.Failed", &gerr);
 		goto fail;
 	}
 
diff --git a/client/map.c b/client/map.c
index 1b4e404..4be73e4 100644
--- a/client/map.c
+++ b/client/map.c
@@ -80,14 +80,9 @@ static DBusMessage *map_setpath(DBusConnection *connection,
 					NULL);
 
 	obc_session_setpath(map->session, folder, simple_cb, map, &err);
-	if (err != NULL) {
-		DBusMessage *reply;
-		reply =  g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+					"org.openobex.Error.Failed", &err);
 
 	map->msg = dbus_message_ref(message);
 
@@ -137,13 +132,9 @@ static DBusMessage *map_get_folder_listing(DBusConnection *connection,
 	obc_session_get(map->session, "x-obex/folder-listing", NULL,
 							NULL, NULL, 0,
 							buffer_cb, map, &err);
-	if (err != NULL) {
-		DBusMessage *reply = g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+					"org.openobex.Error.Failed", &err);
 
 	map->msg = dbus_message_ref(message);
 
@@ -169,13 +160,9 @@ static DBusMessage *map_get_message_listing(DBusConnection *connection,
 	obc_session_get(map->session, "x-bt/MAP-msg-listing", folder,
 							NULL, NULL, 0,
 							buffer_cb, map, &err);
-	if (err != NULL) {
-		DBusMessage *reply = g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+					"org.openobex.Error.Failed", &err);
 
 	map->msg = dbus_message_ref(message);
 
diff --git a/client/pbap.c b/client/pbap.c
index baf2ca6..ccca69c 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -491,12 +491,9 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 				(guint8 *) &apparam, sizeof(apparam),
 				func, request, &err);
 	if (err != NULL) {
-		DBusMessage *reply = g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
 		pending_request_free(request);
-		return reply;
+		return g_dbus_steal_from_gerror(message,
+					 "org.openobex.Error.Failed", &err);
 	}
 
 	return NULL;
@@ -557,13 +554,9 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 				pull_vcard_listing_callback, request, &err);
 	g_free(apparam);
 	if (err != NULL) {
-		DBusMessage *reply = g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
 		pending_request_free(request);
-		return reply;
-
+		return g_dbus_steal_from_gerror(message,
+					 "org.openobex.Error.Failed", &err);
 	}
 
 	return NULL;
@@ -713,13 +706,10 @@ static DBusMessage *pbap_select(DBusConnection *connection,
 	obc_session_setpath(pbap->session, path, pbap_setpath_cb, request,
 									&err);
 	if (err != NULL) {
-		DBusMessage *reply;
-		reply =  g_dbus_create_error(message, ERROR_INF ".Failed",
-							"%s", err->message);
-		g_error_free(err);
 		g_free(path);
 		pending_request_free(request);
-		return reply;
+		return g_dbus_steal_from_gerror(message,
+						 ERROR_INF ".Failed", &err);
 	}
 
 	g_free(pbap->path);
@@ -781,12 +771,9 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 				(guint8 *)&apparam, sizeof(apparam),
 				pull_phonebook_callback, request, &err);
 	if (err != NULL) {
-		DBusMessage *reply = g_dbus_create_error(message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		g_error_free(err);
 		pending_request_free(request);
-		return reply;
+		return g_dbus_steal_from_gerror(message,
+					"org.openobex.Error.Failed", &err);
 	}
 
 	return NULL;
diff --git a/client/sync.c b/client/sync.c
index 9a26f5b..3ef4e0a 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -139,13 +139,9 @@ static DBusMessage *sync_getphonebook(DBusConnection *connection,
 					NULL, NULL, 0,
 					sync_getphonebook_callback, sync,
 					&err);
-	if (err != 0) {
-		DBusMessage *reply = g_dbus_create_error(message,
-						ERROR_INF ".Failed",
-						err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != 0)
+		return g_dbus_steal_from_gerror(message,
+						ERROR_INF ".Failed", &err);
 
 	sync->msg = dbus_message_ref(message);
 
@@ -171,13 +167,9 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 
 	obc_session_put(sync->session, buf, strlen(buf), sync->phonebook_path,
 									&err);
-	if (err != NULL) {
-		DBusMessage *reply = g_dbus_create_error(message,
-						ERROR_INF ".Failed",
-						err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (err != NULL)
+		return g_dbus_steal_from_gerror(message,
+						ERROR_INF ".Failed", &err);
 
 	return dbus_message_new_method_return(message);
 }
-- 
1.7.7.6

