Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] obexd: Use pending request in SetFolder
Date: Fri, 13 Sep 2013 17:28:32 +0200
Message-Id: <1379086116-22617-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1379086116-22617-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379086116-22617-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

diff --git a/obexd/client/map.c b/obexd/client/map.c
index f969aad..1b2b25d 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -162,18 +162,18 @@ static void simple_cb(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GError *err, void *user_data)
 {
+	struct pending_request *request = user_data;
 	DBusMessage *reply;
-	struct map_data *map = user_data;
 
 	if (err != NULL)
-		reply = g_dbus_create_error(map->msg,
+		reply = g_dbus_create_error(request->msg,
 						ERROR_INTERFACE ".Failed",
 						"%s", err->message);
 	else
-		reply = dbus_message_new_method_return(map->msg);
+		reply = dbus_message_new_method_return(request->msg);
 
 	g_dbus_send_message(conn, reply);
-	dbus_message_unref(map->msg);
+	pending_request_free(request);
 }
 
 static DBusMessage *map_setpath(DBusConnection *connection,
@@ -181,6 +181,7 @@ static DBusMessage *map_setpath(DBusConnection *connection,
 {
 	struct map_data *map = user_data;
 	const char *folder;
+	struct pending_request *request;
 	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL, DBUS_TYPE_STRING, &folder,
@@ -189,18 +190,19 @@ static DBusMessage *map_setpath(DBusConnection *connection,
 					ERROR_INTERFACE ".InvalidArguments",
 					NULL);
 
-	obc_session_setpath(map->session, folder, simple_cb, map, &err);
+	request = pending_request_new(map, message);
+
+	obc_session_setpath(map->session, folder, simple_cb, request, &err);
 	if (err != NULL) {
 		DBusMessage *reply;
 		reply =  g_dbus_create_error(message,
 						ERROR_INTERFACE ".Failed",
 						"%s", err->message);
 		g_error_free(err);
+		pending_request_free(request);
 		return reply;
 	}
 
-	map->msg = dbus_message_ref(message);
-
 	return NULL;
 }
 
-- 
1.8.3.4

