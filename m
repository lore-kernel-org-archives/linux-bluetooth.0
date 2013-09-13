Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] obexd: Use pending request in ListFolders
Date: Fri, 13 Sep 2013 17:28:33 +0200
Message-Id: <1379086116-22617-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1379086116-22617-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379086116-22617-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 1b2b25d..29d33fa 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -243,7 +243,7 @@ static void folder_listing_cb(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GError *err, void *user_data)
 {
-	struct map_data *map = user_data;
+	struct pending_request *request = user_data;
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
@@ -252,7 +252,7 @@ static void folder_listing_cb(struct obc_session *session,
 	int perr;
 
 	if (err != NULL) {
-		reply = g_dbus_create_error(map->msg,
+		reply = g_dbus_create_error(request->msg,
 						ERROR_INTERFACE ".Failed",
 						"%s", err->message);
 		goto done;
@@ -260,14 +260,14 @@ static void folder_listing_cb(struct obc_session *session,
 
 	perr = obc_transfer_get_contents(transfer, &contents, &size);
 	if (perr < 0) {
-		reply = g_dbus_create_error(map->msg,
+		reply = g_dbus_create_error(request->msg,
 						ERROR_INTERFACE ".Failed",
 						"Error reading contents: %s",
 						strerror(-perr));
 		goto done;
 	}
 
-	reply = dbus_message_new_method_return(map->msg);
+	reply = dbus_message_new_method_return(request->msg);
 	if (reply == NULL)
 		return;
 
@@ -285,13 +285,14 @@ static void folder_listing_cb(struct obc_session *session,
 
 done:
 	g_dbus_send_message(conn, reply);
-	dbus_message_unref(map->msg);
+	pending_request_free(request);
 }
 
 static DBusMessage *get_folder_listing(struct map_data *map,
 							DBusMessage *message,
 							GObexApparam *apparam)
 {
+	struct pending_request *request;
 	struct obc_transfer *transfer;
 	GError *err = NULL;
 	DBusMessage *reply;
@@ -304,12 +305,16 @@ static DBusMessage *get_folder_listing(struct map_data *map,
 
 	obc_transfer_set_apparam(transfer, apparam);
 
-	if (obc_session_queue(map->session, transfer, folder_listing_cb, map,
-								&err)) {
-		map->msg = dbus_message_ref(message);
-		return NULL;
+	request = pending_request_new(map, message);
+
+	if (!obc_session_queue(map->session, transfer, folder_listing_cb,
+							request, &err)) {
+		pending_request_free(request);
+		goto fail;
 	}
 
+	return NULL;
+
 fail:
 	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
 								err->message);
-- 
1.8.3.4

