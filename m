Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] obexd: Use pending request in ListMessages
Date: Fri, 13 Sep 2013 17:28:34 +0200
Message-Id: <1379086116-22617-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1379086116-22617-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379086116-22617-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 29d33fa..290cfee 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -133,7 +133,7 @@ struct map_msg {
 };
 
 struct map_parser {
-	struct map_data *data;
+	struct pending_request *request;
 	DBusMessageIter *iter;
 };
 
@@ -1082,7 +1082,7 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 				gpointer user_data, GError **gerr)
 {
 	struct map_parser *parser = user_data;
-	struct map_data *data = parser->data;
+	struct map_data *data = parser->request->map;
 	DBusMessageIter entry, *iter = parser->iter;
 	struct map_msg *msg;
 	const char *key;
@@ -1137,7 +1137,7 @@ static void message_listing_cb(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GError *err, void *user_data)
 {
-	struct map_data *map = user_data;
+	struct pending_request *request = user_data;
 	struct map_parser *parser;
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
@@ -1147,7 +1147,7 @@ static void message_listing_cb(struct obc_session *session,
 	int perr;
 
 	if (err != NULL) {
-		reply = g_dbus_create_error(map->msg,
+		reply = g_dbus_create_error(request->msg,
 						ERROR_INTERFACE ".Failed",
 						"%s", err->message);
 		goto done;
@@ -1155,14 +1155,14 @@ static void message_listing_cb(struct obc_session *session,
 
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
 
@@ -1179,7 +1179,7 @@ static void message_listing_cb(struct obc_session *session,
 					&array);
 
 	parser = g_new(struct map_parser, 1);
-	parser->data = map;
+	parser->request = request;
 	parser->iter = &array;
 
 	ctxt = g_markup_parse_context_new(&msg_parser, 0, parser, NULL);
@@ -1191,7 +1191,7 @@ static void message_listing_cb(struct obc_session *session,
 
 done:
 	g_dbus_send_message(conn, reply);
-	dbus_message_unref(map->msg);
+	pending_request_free(request);
 }
 
 static DBusMessage *get_message_listing(struct map_data *map,
@@ -1199,6 +1199,7 @@ static DBusMessage *get_message_listing(struct map_data *map,
 							const char *folder,
 							GObexApparam *apparam)
 {
+	struct pending_request *request;
 	struct obc_transfer *transfer;
 	GError *err = NULL;
 	DBusMessage *reply;
@@ -1211,12 +1212,16 @@ static DBusMessage *get_message_listing(struct map_data *map,
 
 	obc_transfer_set_apparam(transfer, apparam);
 
-	if (obc_session_queue(map->session, transfer, message_listing_cb, map,
-								&err)) {
-		map->msg = dbus_message_ref(message);
-		return NULL;
+	request = pending_request_new(map, message);
+
+	if (!obc_session_queue(map->session, transfer, message_listing_cb,
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

