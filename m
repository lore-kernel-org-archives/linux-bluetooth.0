Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v2 13/21] client: ObjectPush sessions return transports
Date: Thu, 8 Dec 2011 16:27:47 +0100
Message-ID: <1323358075-27857-14-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/opp.c |   72 +++++++++++++++++++++------------------------------------
 1 files changed, 27 insertions(+), 45 deletions(-)

diff --git a/client/opp.c b/client/opp.c
index a1b1f75..5379222 100644
--- a/client/opp.c
+++ b/client/opp.c
@@ -30,6 +30,7 @@
 #include "log.h"
 
 #include "session.h"
+#include "transfer.h"
 #include "driver.h"
 #include "opp.h"
 
@@ -37,16 +38,10 @@
 #define OPP_INTERFACE "org.openobex.ObjectPush"
 #define ERROR_INF OPP_INTERFACE ".Error"
 
-
 struct opp_data {
 	struct obc_session *session;
 };
 
-struct pull_data {
-	DBusConnection *connection;
-	DBusMessage *message;
-};
-
 static DBusConnection *conn = NULL;
 
 static DBusMessage *opp_send_file(DBusConnection *connection,
@@ -56,6 +51,9 @@ static DBusMessage *opp_send_file(DBusConnection *connection,
 	DBusMessageIter iter;
 	char *filename;
 	char *basename;
+	DBusMessage *reply;
+	struct obc_transfer *transfer;
+	const char *path;
 
 	dbus_message_iter_init(message, &iter);
 
@@ -66,35 +64,21 @@ static DBusMessage *opp_send_file(DBusConnection *connection,
 	dbus_message_iter_get_basic(&iter, &filename);
 	basename = g_path_get_basename(filename);
 
-	if (obc_session_put(opp->session, basename, filename, NULL) < 0) {
+	if (obc_session_put(opp->session, basename, filename, &transfer) < 0) {
 		g_free(basename);
 		return g_dbus_create_error(message,
 				ERROR_INF ".Failed", NULL);
 	}
 
-	return dbus_message_new_method_return(message);
-}
+	path = obc_transfer_get_path(transfer);
 
-static void pull_complete_callback(struct obc_session *session,
-					GError *err,
-					const struct obc_transfer *transfer,
-					void *user_data)
-{
-	struct pull_data *data = user_data;
-
-	if (err != NULL) {
-		DBusMessage *error = g_dbus_create_error(data->message,
-					ERROR_INF ".Failed",
-					"%s", err->message);
-		g_dbus_send_message(data->connection, error);
-		goto done;
-	}
+	reply = dbus_message_new_method_return(message);
 
-	g_dbus_send_reply(data->connection, data->message, DBUS_TYPE_INVALID);
+	dbus_message_append_args(reply,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID);
 
-done:
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
+	return reply;
 }
 
 static DBusMessage *opp_pull_business_card(DBusConnection *connection,
@@ -102,9 +86,11 @@ static DBusMessage *opp_pull_business_card(DBusConnection *connection,
 						void *user_data)
 {
 	struct opp_data *opp = user_data;
-	struct pull_data *data;
 	DBusMessageIter iter;
 	const char *filename = NULL;
+	DBusMessage *reply;
+	struct obc_transfer *transfer;
+	const char *path;
 
 	dbus_message_iter_init(message, &iter);
 
@@ -114,20 +100,19 @@ static DBusMessage *opp_pull_business_card(DBusConnection *connection,
 
 	dbus_message_iter_get_basic(&iter, &filename);
 
-	data = g_try_malloc0(sizeof(*data));
-	if (!data)
-		return g_dbus_create_error(message,
-				ERROR_INF ".Failed", "No Memory");
+	obc_session_get_mem(opp->session, "text/x-vcard", filename,
+						NULL, 0, NULL, NULL,
+						&transfer);
+
+	path = obc_transfer_get_path(transfer);
 
-	data->connection = connection;
-	data->message = dbus_message_ref(message);
+	reply = dbus_message_new_method_return(message);
 
-	obc_session_get(opp->session, "text/x-vcard", filename, NULL,
-						NULL, 0,
-						pull_complete_callback, data,
-						NULL);
+	dbus_message_append_args(reply,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID);
 
-	return NULL;
+	return reply;
 }
 
 static DBusMessage *opp_exchange_business_cards(DBusConnection *connection,
@@ -137,12 +122,9 @@ static DBusMessage *opp_exchange_business_cards(DBusConnection *connection,
 }
 
 static GDBusMethodTable opp_methods[] = {
-	{ "SendFile",		"s",	"",	opp_send_file,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PullBusinessCard",	"s",	"",	opp_pull_business_card,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ExchangeBusinessCards", "ss", "",	opp_exchange_business_cards,
-						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SendFile",		"s",	"o",	opp_send_file },
+	{ "PullBusinessCard",	"s",	"o",	opp_pull_business_card },
+	{ "ExchangeBusinessCards", "ss", "o",	opp_exchange_business_cards },
 	{ }
 };
 
-- 
1.7.6.4

