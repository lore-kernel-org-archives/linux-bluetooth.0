Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v2 09/21] client: replace parameter dict with conventional ones
Date: Thu, 8 Dec 2011 16:27:43 +0100
Message-ID: <1323358075-27857-10-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/manager.c             |   47 +++++++++++++++++++++++++++++------------
 test/exchange-business-cards |    3 +-
 test/ftp-client              |    3 +-
 test/list-folders            |    2 +-
 test/pbap-client             |    2 +-
 test/pull-business-card      |    3 +-
 test/send-files              |    3 +-
 7 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index 99c495a..ce3aa91 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -101,9 +101,7 @@ done:
 	g_free(data);
 }
 
-static int parse_device_dict(DBusMessageIter *iter,
-		const char **source, const char **dest, const char **target,
-		uint8_t *channel)
+static int parse_device_dict(DBusMessageIter *iter, uint8_t *channel)
 {
 	while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter entry, value;
@@ -116,14 +114,6 @@ static int parse_device_dict(DBusMessageIter *iter,
 		dbus_message_iter_recurse(&entry, &value);
 
 		switch (dbus_message_iter_get_arg_type(&value)) {
-		case DBUS_TYPE_STRING:
-			if (g_str_equal(key, "Source") == TRUE)
-				dbus_message_iter_get_basic(&value, source);
-			else if (g_str_equal(key, "Destination") == TRUE)
-				dbus_message_iter_get_basic(&value, dest);
-			else if (g_str_equal(key, "Target") == TRUE)
-				dbus_message_iter_get_basic(&value, target);
-			break;
 		case DBUS_TYPE_BYTE:
 			if (g_str_equal(key, "Channel") == TRUE)
 				dbus_message_iter_get_basic(&value, channel);
@@ -160,10 +150,36 @@ static DBusMessage *create_session(DBusConnection *connection,
 	uint8_t channel = 0;
 
 	dbus_message_iter_init(message, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&iter, &source);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&iter, &dest);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&iter, &target);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
 	dbus_message_iter_recurse(&iter, &dict);
 
-	parse_device_dict(&dict, &source, &dest, &target, &channel);
-	if (dest == NULL || target == NULL)
+	parse_device_dict(&dict, &channel);
+
+	if (*dest == '\0' || *target == '\0')
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
@@ -172,6 +188,9 @@ static DBusMessage *create_session(DBusConnection *connection,
 		return g_dbus_create_error(message,
 					"org.openobex.Error.NoMemory", NULL);
 
+	if (*source == '\0')
+		source = NULL;
+
 	data->connection = dbus_connection_ref(connection);
 	data->message = dbus_message_ref(message);
 
@@ -219,7 +238,7 @@ static DBusMessage *remove_session(DBusConnection *connection,
 }
 
 static GDBusMethodTable client_methods[] = {
-	{ "CreateSession", "a{sv}", "o", create_session,
+	{ "CreateSession", "sssa{sv}", "o", create_session,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "RemoveSession", "o", "", remove_session,
 						G_DBUS_METHOD_FLAG_ASYNC },
diff --git a/test/exchange-business-cards b/test/exchange-business-cards
index 548ad2d..78c8294 100755
--- a/test/exchange-business-cards
+++ b/test/exchange-business-cards
@@ -12,8 +12,7 @@ if (len(sys.argv) < 4):
 	sys.exit(1)
 
 print "Creating Session"
-session_path = client.CreateSession({"Destination": sys.argv[1],
-					"Target": "OPP"})
+session_path = client.CreateSession("", sys.argv[1], "OPP", dict())
 opp = dbus.Interface(bus.get_object("org.openobex.client",
 					session_path),
 					"org.openobex.ObjectPush")
diff --git a/test/ftp-client b/test/ftp-client
index 9bc038d..05f16ad 100755
--- a/test/ftp-client
+++ b/test/ftp-client
@@ -135,8 +135,7 @@ if  __name__ == '__main__':
     client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
                             "org.openobex.Client")
 
-    session_path = client.CreateSession({ "Destination": options.device,
-                                          "Target": "ftp"})
+    session_path = client.CreateSession("", options.device, "ftp", dict())
 
     session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
                  "org.openobex.Session")
diff --git a/test/list-folders b/test/list-folders
index c7eec10..3e185be 100755
--- a/test/list-folders
+++ b/test/list-folders
@@ -9,7 +9,7 @@ def list_folder(folder):
 	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
 				"org.openobex.Client")
 
-	session_path = client.CreateSession({ "Destination": sys.argv[1], "Target": "ftp"})
+	session_path = client.CreateSession("", sys.argv[1], "ftp", dict())
 
 	ftp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
 			     "org.openobex.FileTransfer")
diff --git a/test/pbap-client b/test/pbap-client
index 7456c01..f87f33c 100755
--- a/test/pbap-client
+++ b/test/pbap-client
@@ -9,7 +9,7 @@ client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
 						"org.openobex.Client")
 
 print "Creating Session"
-session_path = client.CreateSession({"Destination": sys.argv[1], "Target": "PBAP"})
+session_path = client.CreateSession("", sys.argv[1], "PBAP", dict())
 pbap = dbus.Interface(bus.get_object("org.openobex.client", session_path),
 						"org.openobex.PhonebookAccess")
 session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
diff --git a/test/pull-business-card b/test/pull-business-card
index 5912155..20e42b7 100755
--- a/test/pull-business-card
+++ b/test/pull-business-card
@@ -29,8 +29,7 @@ if __name__ == '__main__':
 		sys.exit(1)
 
 	print "Creating Session"
-	session_path = client.CreateSession({"Destination": sys.argv[1],
-						"Target": "OPP"})
+	session_path = client.CreateSession("", sys.argv[1], "OPP", dict())
 	opp = dbus.Interface(bus.get_object("org.openobex.client",
 						session_path),
 						"org.openobex.ObjectPush")
diff --git a/test/send-files b/test/send-files
index e84d10f..da12382 100755
--- a/test/send-files
+++ b/test/send-files
@@ -14,8 +14,7 @@ if (len(sys.argv) < 3):
 files = [os.path.realpath(f) for f in sys.argv[2:]]
 
 print "Creating Session"
-session_path = client.CreateSession({"Destination": sys.argv[1],
-					"Target": "OPP"})
+session_path = client.CreateSession("", sys.argv[1], "OPP", dict())
 opp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
 					"org.openobex.ObjectPush")
 for f in files:
-- 
1.7.6.4

