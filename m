Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] obexd: Use pending request in UpdateInbox
Date: Fri, 13 Sep 2013 17:28:35 +0200
Message-Id: <1379086116-22617-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1379086116-22617-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379086116-22617-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 290cfee..8b56143 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1559,21 +1559,21 @@ static void update_inbox_cb(struct obc_session *session,
 				struct obc_transfer *transfer,
 				GError *err, void *user_data)
 {
-	struct map_data *map = user_data;
+	struct pending_request *request = user_data;
 	DBusMessage *reply;
 
 	if (err != NULL) {
-		reply = g_dbus_create_error(map->msg,
+		reply = g_dbus_create_error(request->msg,
 						ERROR_INTERFACE ".Failed",
 						"%s", err->message);
 		goto done;
 	}
 
-	reply = dbus_message_new_method_return(map->msg);
+	reply = dbus_message_new_method_return(request->msg);
 
 done:
 	g_dbus_send_message(conn, reply);
-	dbus_message_unref(map->msg);
+	pending_request_free(request);
 }
 
 static DBusMessage *map_update_inbox(DBusConnection *connection,
@@ -1584,6 +1584,7 @@ static DBusMessage *map_update_inbox(DBusConnection *connection,
 	char contents[2];
 	struct obc_transfer *transfer;
 	GError *err = NULL;
+	struct pending_request *request;
 
 	contents[0] = FILLER_BYTE;
 	contents[1] = '\0';
@@ -1594,11 +1595,13 @@ static DBusMessage *map_update_inbox(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
+	request = pending_request_new(map, message);
+
 	if (!obc_session_queue(map->session, transfer, update_inbox_cb,
-								map, &err))
+							request, &err)) {
+		pending_request_free(request);
 		goto fail;
-
-	map->msg = dbus_message_ref(message);
+	}
 
 	return NULL;
 
-- 
1.8.3.4

