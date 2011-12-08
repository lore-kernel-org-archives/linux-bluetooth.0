Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v2 05/21] client: replace SendFiles with SendFile
Date: Thu, 8 Dec 2011 16:27:39 +0100
Message-ID: <1323358075-27857-6-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/opp.c    |   28 +++++++++++++---------------
 test/send-files |    5 +++--
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/client/opp.c b/client/opp.c
index 5af18b5..bd83c25 100644
--- a/client/opp.c
+++ b/client/opp.c
@@ -49,29 +49,27 @@ struct pull_data {
 
 static DBusConnection *conn = NULL;
 
-static DBusMessage *opp_send_files(DBusConnection *connection,
+static DBusMessage *opp_send_file(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct opp_data *opp = user_data;
-	DBusMessageIter iter, array;
+	DBusMessageIter iter;
+	char *filename;
+	char *basename;
 
 	dbus_message_iter_init(message, &iter);
-	dbus_message_iter_recurse(&iter, &array);
-
-	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
-		char *filename;
-		char *basename;
 
-		dbus_message_iter_get_basic(&array, &filename);
-		basename = g_path_get_basename(filename);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				ERROR_INF ".InvalidArguments", NULL);
 
-		if (obc_session_send(opp->session, filename, basename) < 0) {
-			g_free(basename);
-			break;
-		}
+	dbus_message_iter_get_basic(&iter, &filename);
+	basename = g_path_get_basename(filename);
 
+	if (obc_session_send(opp->session, filename, basename) < 0) {
 		g_free(basename);
-		dbus_message_iter_next(&array);
+		return g_dbus_create_error(message,
+				ERROR_INF ".Failed", NULL);
 	}
 
 	return dbus_message_new_method_return(message);
@@ -135,7 +133,7 @@ static DBusMessage *opp_exchange_business_cards(DBusConnection *connection,
 }
 
 static GDBusMethodTable opp_methods[] = {
-	{ "SendFiles",		"as",	"",	opp_send_files,
+	{ "SendFile",		"s",	"",	opp_send_file,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "PullBusinessCard",	"s",	"",	opp_pull_business_card,
 						G_DBUS_METHOD_FLAG_ASYNC },
diff --git a/test/send-files b/test/send-files
index 6d634f5..e84d10f 100755
--- a/test/send-files
+++ b/test/send-files
@@ -18,5 +18,6 @@ session_path = client.CreateSession({"Destination": sys.argv[1],
 					"Target": "OPP"})
 opp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
 					"org.openobex.ObjectPush")
-
-opp.SendFiles(files)
+for f in files:
+	print "Queueing '%s'" % f
+	opp.SendFile(f)
-- 
1.7.6.4

