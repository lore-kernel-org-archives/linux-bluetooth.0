Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 04/14] client: ObjectPush sessions return transfers
Date: Fri,  1 Jun 2012 12:51:13 +0200
Message-Id: <1338547883-18907-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338547883-18907-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338547883-18907-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Return the D-Bus path of the transfer representing the operation.
---
 client/opp.c |   71 ++++++++++-----------------------------------------------
 1 files changed, 13 insertions(+), 58 deletions(-)

diff --git a/client/opp.c b/client/opp.c
index 67b01a9..a3899f8 100644
--- a/client/opp.c
+++ b/client/opp.c
@@ -45,23 +45,6 @@ struct opp_data {
 
 static DBusConnection *conn = NULL;
 
-static void send_file_callback(struct obc_session *session,
-						struct obc_transfer *transfer,
-						GError *err, void *user_data)
-{
-	DBusMessage *msg = user_data;
-	DBusMessage *reply;
-
-	if (err != NULL)
-		reply = g_dbus_create_error(msg,
-				ERROR_INF ".Failed", "%s", err->message);
-	else
-		reply = dbus_message_new_method_return(msg);
-
-	g_dbus_send_message(conn, reply);
-	dbus_message_unref(msg);
-}
-
 static DBusMessage *opp_send_file(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -87,12 +70,10 @@ static DBusMessage *opp_send_file(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (!obc_session_queue(opp->session, transfer, send_file_callback,
-								message, &err))
+	if (!obc_session_queue(opp->session, transfer, NULL, NULL, &err))
 		goto fail;
 
-	dbus_message_ref(message);
-	return NULL;
+	return obc_transfer_create_dbus_reply(transfer, message);
 
 fail:
 	reply = g_dbus_create_error(message,
@@ -101,55 +82,29 @@ fail:
 	return reply;
 }
 
-static void pull_complete_callback(struct obc_session *session,
-					struct obc_transfer *transfer,
-					GError *err, void *user_data)
-{
-	DBusMessage *message = user_data;
-
-	if (err != NULL) {
-		DBusMessage *error = g_dbus_create_error(message,
-					"org.openobex.Error.Failed",
-					"%s", err->message);
-		g_dbus_send_message(conn, error);
-		goto done;
-	}
-
-	g_dbus_send_reply(conn, message, DBUS_TYPE_INVALID);
-
-done:
-	dbus_message_unref(message);
-}
-
 static DBusMessage *opp_pull_business_card(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct opp_data *opp = user_data;
 	struct obc_transfer *pull;
-	DBusMessageIter iter;
 	DBusMessage *reply;
 	const char *filename = NULL;
 	GError *err = NULL;
 
-	dbus_message_iter_init(message, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_STRING, &filename,
+				DBUS_TYPE_INVALID) == FALSE)
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", NULL);
 
-	dbus_message_iter_get_basic(&iter, &filename);
-
 	pull = obc_transfer_get("text/x-vcard", NULL, filename, &err);
 	if (pull == NULL)
 		goto fail;
 
-	if (!obc_session_queue(opp->session, pull, pull_complete_callback,
-								message, &err))
+	if (!obc_session_queue(opp->session, pull, NULL, NULL, &err))
 		goto fail;
 
-	dbus_message_ref(message);
-
-	return NULL;
+	return obc_transfer_create_dbus_reply(pull, message);
 
 fail:
 	reply = g_dbus_create_error(message,
@@ -165,17 +120,17 @@ static DBusMessage *opp_exchange_business_cards(DBusConnection *connection,
 }
 
 static const GDBusMethodTable opp_methods[] = {
-	{ GDBUS_ASYNC_METHOD("SendFile",
+	{ GDBUS_METHOD("SendFile",
 		GDBUS_ARGS({ "sourcefile", "s" }),
-		NULL,
+		GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }),
 		opp_send_file) },
-	{ GDBUS_ASYNC_METHOD("PullBusinessCard",
+	{ GDBUS_METHOD("PullBusinessCard",
 		GDBUS_ARGS({ "targetfile", "s" }),
-		NULL,
+		GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }),
 		opp_pull_business_card) },
-	{ GDBUS_ASYNC_METHOD("ExchangeBusinessCards",
+	{ GDBUS_METHOD("ExchangeBusinessCards",
 		GDBUS_ARGS({ "clientfile", "s" }, { "targetfile", "s" }),
-		NULL,
+		GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }),
 		opp_exchange_business_cards) },
 	{ }
 };
-- 
1.7.7.6

