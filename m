Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 13/20] client: ObjectPush sessions return transfers
Date: Tue, 13 Dec 2011 17:44:16 +0100
Message-ID: <1323794663-2711-14-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/opp.c            |   74 ++++++++++++++---------------------
 test/opp-client         |  100 +++++++++++++++++++++++++++++++++++++++++++++++
 test/pull-business-card |   40 -------------------
 test/send-files         |   22 ----------
 4 files changed, 129 insertions(+), 107 deletions(-)
 create mode 100755 test/opp-client
 delete mode 100755 test/pull-business-card
 delete mode 100755 test/send-files

diff --git a/client/opp.c b/client/opp.c
index a8251f9..5000281 100644
--- a/client/opp.c
+++ b/client/opp.c
@@ -31,6 +31,7 @@
 #include "log.h"
 
 #include "session.h"
+#include "transfer.h"
 #include "driver.h"
 #include "opp.h"
 
@@ -42,11 +43,6 @@ struct opp_data {
 	struct obc_session *session;
 };
 
-struct pull_data {
-	DBusConnection *connection;
-	DBusMessage *message;
-};
-
 static DBusConnection *conn = NULL;
 
 static DBusMessage *opp_send_file(DBusConnection *connection,
@@ -56,6 +52,9 @@ static DBusMessage *opp_send_file(DBusConnection *connection,
 	DBusMessageIter iter;
 	char *filename;
 	char *basename;
+	DBusMessage *reply;
+	struct obc_transfer *transfer;
+	const char *path;
 	int err;
 
 	dbus_message_iter_init(message, &iter);
@@ -67,7 +66,8 @@ static DBusMessage *opp_send_file(DBusConnection *connection,
 	dbus_message_iter_get_basic(&iter, &filename);
 	basename = g_path_get_basename(filename);
 
-	obc_session_put(opp->session, basename, filename, TRUE, &err);
+	transfer = obc_session_put(opp->session, basename, filename, TRUE,
+									&err);
 
 	g_free(basename);
 
@@ -76,29 +76,15 @@ static DBusMessage *opp_send_file(DBusConnection *connection,
 						ERROR_INF ".Failed",
 						"%s", strerror(err));
 
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
@@ -106,9 +92,11 @@ static DBusMessage *opp_pull_business_card(DBusConnection *connection,
 						void *user_data)
 {
 	struct opp_data *opp = user_data;
-	struct pull_data *data;
 	DBusMessageIter iter;
 	const char *filename = NULL;
+	DBusMessage *reply;
+	struct obc_transfer *transfer;
+	const char *path;
 	int err;
 
 	dbus_message_iter_init(message, &iter);
@@ -119,17 +107,8 @@ static DBusMessage *opp_pull_business_card(DBusConnection *connection,
 
 	dbus_message_iter_get_basic(&iter, &filename);
 
-	data = g_try_malloc0(sizeof(*data));
-	if (!data)
-		return g_dbus_create_error(message,
-				ERROR_INF ".Failed", "No Memory");
-
-	data->connection = connection;
-	data->message = dbus_message_ref(message);
-
-	obc_session_get(opp->session, "text/x-vcard", filename, NULL,
-						NULL, 0,
-						pull_complete_callback, data,
+	transfer = obc_session_get(opp->session, "text/x-vcard", NULL, filename,
+						NULL, 0, NULL, NULL,
 						TRUE, &err);
 
 	if (err < 0)
@@ -137,7 +116,15 @@ static DBusMessage *opp_pull_business_card(DBusConnection *connection,
 						ERROR_INF ".Failed",
 						"%s", strerror(err));
 
-	return NULL;
+	path = obc_transfer_get_path(transfer);
+
+	reply = dbus_message_new_method_return(message);
+
+	dbus_message_append_args(reply,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static DBusMessage *opp_exchange_business_cards(DBusConnection *connection,
@@ -147,12 +134,9 @@ static DBusMessage *opp_exchange_business_cards(DBusConnection *connection,
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
 
diff --git a/test/opp-client b/test/opp-client
new file mode 100755
index 0000000..894b824
--- /dev/null
+++ b/test/opp-client
@@ -0,0 +1,100 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+import gobject
+import dbus.mainloop.glib
+import os.path
+from optparse import OptionParser
+
+def parse_options():
+    parser.add_option("-d", "--device", dest="device",
+                      help="Device to connect", metavar="DEVICE")
+    parser.add_option("-g", "--pull", dest="pull_to_file",
+                      help="Pull vcard and store in FILE", metavar="FILE")
+    parser.add_option("-p", "--send", dest="send_file",
+                      help="Send FILE", metavar="FILE")
+
+    return parser.parse_args()
+
+class OppClient:
+    def __init__(self, session_path):
+        self.transfer_path = None
+        bus = dbus.SessionBus()
+        self.session = dbus.Interface(bus.get_object("org.openobex.client",
+                                                     session_path),
+                                      "org.openobex.Session")
+        self.opp = dbus.Interface(bus.get_object("org.openobex.client",
+                                                 session_path),
+                                  "org.openobex.ObjectPush")
+        bus.add_signal_receiver(
+            self.transfer_complete,
+            dbus_interface="org.openobex.Transfer",
+            signal_name="Complete",
+            path_keyword="path")
+        bus.add_signal_receiver(
+            self.transfer_error,
+            dbus_interface="org.openobex.Transfer",
+            signal_name="Error",
+            path_keyword="path")
+
+    def create_transfer_reply(self, path):
+        self.transfer_path = path
+        print "Transfer created: %s" % path
+
+    def error(self, err):
+        print err
+        mainloop.quit()
+
+    def transfer_complete(self, path):
+        if path != self.transfer_path:
+            return
+        print "Transfer finished"
+        mainloop.quit()
+
+    def transfer_error(self, error, path):
+        if path != self.transfer_path:
+            return
+        print "Transfer finished with an error: %s" % (error)
+        mainloop.quit()
+
+    def pull_business_card(self, filename):
+        self.opp.PullBusinessCard(os.path.abspath(filename),
+				  reply_handler=self.create_transfer_reply,
+				  error_handler=self.error)
+
+    def send_file(self, filename):
+        self.opp.SendFile(os.path.abspath(filename),
+                          reply_handler=self.create_transfer_reply,
+                          error_handler=self.error)
+
+if  __name__ == '__main__':
+
+    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+    parser = OptionParser()
+
+    (options, args) = parse_options()
+
+    if not options.device:
+        parser.print_help()
+        sys.exit(0)
+
+    bus = dbus.SessionBus()
+    mainloop = gobject.MainLoop()
+
+    client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
+                            "org.openobex.Client")
+
+    print "Creating Session"
+    session_path = client.CreateSession(options.device, { "Target": "OPP" })
+
+    opp_client = OppClient(session_path)
+
+    if options.pull_to_file:
+        opp_client.pull_business_card(options.pull_to_file)
+
+    if options.send_file:
+        opp_client.send_file(options.send_file)
+
+    mainloop.run()
diff --git a/test/pull-business-card b/test/pull-business-card
deleted file mode 100755
index 6f9267b..0000000
--- a/test/pull-business-card
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/usr/bin/python
-
-import sys
-import dbus
-import gobject
-import dbus.mainloop.glib
-
-def success():
-	mainloop.quit()
-	return
-
-def failure(error):
-	print error
-	mainloop.quit()
-	return
-
-
-if __name__ == '__main__':
-	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
-
-	mainloop = gobject.MainLoop()
-
-	bus = dbus.SessionBus()
-	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-							"org.openobex.Client")
-
-	if (len(sys.argv) < 3):
-		print "Usage: %s <device> <file>" % (sys.argv[0])
-		sys.exit(1)
-
-	print "Creating Session"
-	session_path = client.CreateSession(sys.argv[1], { "Target": "OPP" })
-	opp = dbus.Interface(bus.get_object("org.openobex.client",
-						session_path),
-						"org.openobex.ObjectPush")
-
-	opp.PullBusinessCard(sys.argv[2],
-				reply_handler=success, error_handler=failure)
-
-	mainloop.run()
diff --git a/test/send-files b/test/send-files
deleted file mode 100755
index f1e8aed..0000000
--- a/test/send-files
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/usr/bin/python
-
-import os
-import sys
-import dbus
-
-bus = dbus.SessionBus()
-client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-						"org.openobex.Client")
-
-if (len(sys.argv) < 3):
-	print "Usage: %s <device> <file> [file*]" % (sys.argv[0])
-	sys.exit(1)
-
-files = [os.path.realpath(f) for f in sys.argv[2:]]
-
-print "Creating Session"
-session_path = client.CreateSession(sys.argv[1], { "Target": "OPP" })
-opp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
-					"org.openobex.ObjectPush")
-
-opp.SendFiles(files)
-- 
1.7.6.4

