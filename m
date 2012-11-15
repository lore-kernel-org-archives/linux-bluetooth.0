Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 04/16] test: Avoid using DefaultAdapter()
Date: Thu, 15 Nov 2012 16:09:07 +0100
Message-Id: <1352992159-11559-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use FindAdapter() with "default" as pattern as a replacement for
DefaultAdapter().
---
 profiles/cups/main.c  | 12 +++++++++--
 test/agent.c          | 55 +--------------------------------------------------
 test/dbusdef.py       |  2 +-
 test/gaptest.c        |  6 +++++-
 test/mpris-player.c   | 53 +------------------------------------------------
 test/simple-agent     |  2 +-
 test/simple-endpoint  |  2 +-
 test/simple-player    |  2 +-
 test/simple-service   |  2 +-
 test/test-adapter     |  2 +-
 test/test-attrib      |  2 +-
 test/test-audio       |  2 +-
 test/test-device      |  2 +-
 test/test-discovery   |  2 +-
 test/test-heartrate   |  2 +-
 test/test-input       |  2 +-
 test/test-manager     |  2 +-
 test/test-nap         |  2 +-
 test/test-network     |  2 +-
 test/test-proximity   |  2 +-
 test/test-service     |  2 +-
 test/test-thermometer |  2 +-
 22 files changed, 35 insertions(+), 127 deletions(-)

diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index 977c057..b8bcbd3 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -526,6 +526,7 @@ static gboolean list_printers(void)
 	DBusMessage *reply, *message;
 	DBusMessageIter reply_iter;
 	char *adapter, *match;
+	const char *pattern = "default";
 
 	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 	if (conn == NULL)
@@ -544,12 +545,15 @@ static gboolean list_printers(void)
 	/* Get the default adapter */
 	message = dbus_message_new_method_call("org.bluez", "/",
 						"org.bluez.Manager",
-						"DefaultAdapter");
+						"FindAdapter");
 	if (message == NULL) {
 		dbus_connection_unref(conn);
 		return FALSE;
 	}
 
+	dbus_message_append_args(message, DBUS_TYPE_STRING, &pattern,
+							DBUS_TYPE_INVALID);
+
 	reply = dbus_connection_send_with_reply_and_block(conn,
 							message, -1, &error);
 
@@ -622,6 +626,7 @@ static gboolean print_ieee1284(const char *bdaddr)
 	char *object_path = NULL;
 	char *adapter;
 	char *id;
+	const char *pattern = "default";
 
 	adapter_reply = NULL;
 
@@ -631,7 +636,10 @@ static gboolean print_ieee1284(const char *bdaddr)
 
 	message = dbus_message_new_method_call("org.bluez", "/",
 			"org.bluez.Manager",
-			"DefaultAdapter");
+			"FindAdapter");
+
+	dbus_message_append_args(message, DBUS_TYPE_STRING, &pattern,
+							DBUS_TYPE_INVALID);
 
 	adapter_reply = dbus_connection_send_with_reply_and_block(conn,
 			message, -1, NULL);
diff --git a/test/agent.c b/test/agent.c
index 5cdeeb4..6ad3bc7 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -464,59 +464,6 @@ static int create_paired_device(DBusConnection *conn, const char *adapter_path,
 	return 0;
 }
 
-static char *get_default_adapter_path(DBusConnection *conn)
-{
-	DBusMessage *msg, *reply;
-	DBusError err;
-	const char *reply_path;
-	char *path;
-
-	msg = dbus_message_new_method_call("org.bluez", "/",
-					"org.bluez.Manager", "DefaultAdapter");
-
-	if (!msg) {
-		fprintf(stderr, "Can't allocate new method call\n");
-		return NULL;
-	}
-
-	dbus_error_init(&err);
-
-	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
-
-	dbus_message_unref(msg);
-
-	if (!reply) {
-		fprintf(stderr,
-			"Can't get default adapter\n");
-		if (dbus_error_is_set(&err)) {
-			fprintf(stderr, "%s\n", err.message);
-			dbus_error_free(&err);
-		}
-		return NULL;
-	}
-
-	if (!dbus_message_get_args(reply, &err,
-					DBUS_TYPE_OBJECT_PATH, &reply_path,
-					DBUS_TYPE_INVALID)) {
-		fprintf(stderr,
-			"Can't get reply arguments\n");
-		if (dbus_error_is_set(&err)) {
-			fprintf(stderr, "%s\n", err.message);
-			dbus_error_free(&err);
-		}
-		dbus_message_unref(reply);
-		return NULL;
-	}
-
-	path = strdup(reply_path);
-
-	dbus_message_unref(reply);
-
-	dbus_connection_flush(conn);
-
-	return path;
-}
-
 static char *get_adapter_path(DBusConnection *conn, const char *adapter)
 {
 	DBusMessage *msg, *reply;
@@ -525,7 +472,7 @@ static char *get_adapter_path(DBusConnection *conn, const char *adapter)
 	char *path;
 
 	if (!adapter)
-		return get_default_adapter_path(conn);
+		adapter = "default";
 
 	msg = dbus_message_new_method_call("org.bluez", "/",
 					"org.bluez.Manager", "FindAdapter");
diff --git a/test/dbusdef.py b/test/dbusdef.py
index 5af6153..1d55f97 100644
--- a/test/dbusdef.py
+++ b/test/dbusdef.py
@@ -11,6 +11,6 @@ dummy = dbus.Interface(bus.get_object('org.bluez', '/'), 'org.freedesktop.DBus.I
 manager = dbus.Interface(bus.get_object('org.bluez', '/'), 'org.bluez.Manager')
 
 try:
-	adapter = dbus.Interface(bus.get_object('org.bluez', manager.DefaultAdapter()), 'org.bluez.Adapter')
+	adapter = dbus.Interface(bus.get_object('org.bluez', manager.FindAdapter("default")), 'org.bluez.Adapter')
 except:
 	pass
diff --git a/test/gaptest.c b/test/gaptest.c
index 3e9f534..bcc3959 100644
--- a/test/gaptest.c
+++ b/test/gaptest.c
@@ -44,13 +44,17 @@ static char *get_adapter(DBusConnection *conn)
 	DBusMessage *message, *reply;
 	DBusError error;
 	const char *path;
+	const char *pattern = "default";
 	char *result = NULL;
 
 	message = dbus_message_new_method_call(BLUEZ_SERVICE, MANAGER_PATH,
-					MANAGER_INTF, "DefaultAdapter");
+						MANAGER_INTF, "FindAdapter");
 	if (!message)
 		return NULL;
 
+	dbus_message_append_args(message, DBUS_TYPE_STRING, &pattern,
+							DBUS_TYPE_INVALID);
+
 	dbus_error_init(&error);
 
 	reply = dbus_connection_send_with_reply_and_block(conn,
diff --git a/test/mpris-player.c b/test/mpris-player.c
index 13f5c85..641db6e 100644
--- a/test/mpris-player.c
+++ b/test/mpris-player.c
@@ -662,57 +662,6 @@ static DBusHandlerResult system_filter(DBusConnection *conn,
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
-static char *get_default_adapter(DBusConnection *conn)
-{
-	DBusMessage *msg, *reply;
-	DBusError err;
-	const char *reply_path;
-	char *path;
-
-	msg = dbus_message_new_method_call("org.bluez", "/",
-					"org.bluez.Manager", "DefaultAdapter");
-
-	if (!msg) {
-		fprintf(stderr, "Can't allocate new method call\n");
-		return NULL;
-	}
-
-	dbus_error_init(&err);
-
-	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
-
-	dbus_message_unref(msg);
-
-	if (!reply) {
-		fprintf(stderr, "Can't get default adapter\n");
-		if (dbus_error_is_set(&err)) {
-			fprintf(stderr, "%s\n", err.message);
-			dbus_error_free(&err);
-		}
-		return NULL;
-	}
-
-	if (!dbus_message_get_args(reply, &err,
-					DBUS_TYPE_OBJECT_PATH, &reply_path,
-					DBUS_TYPE_INVALID)) {
-		fprintf(stderr, "Can't get reply arguments\n");
-		if (dbus_error_is_set(&err)) {
-			fprintf(stderr, "%s\n", err.message);
-			dbus_error_free(&err);
-		}
-		dbus_message_unref(reply);
-		return NULL;
-	}
-
-	path = strdup(reply_path);
-
-	dbus_message_unref(reply);
-
-	dbus_connection_flush(conn);
-
-	return path;
-}
-
 static char *get_adapter(DBusConnection *conn, const char *adapter)
 {
 	DBusMessage *msg, *reply;
@@ -721,7 +670,7 @@ static char *get_adapter(DBusConnection *conn, const char *adapter)
 	char *path;
 
 	if (!adapter)
-		return get_default_adapter(conn);
+		adapter = NULL;
 
 	msg = dbus_message_new_method_call("org.bluez", "/",
 					"org.bluez.Manager", "FindAdapter");
diff --git a/test/simple-agent b/test/simple-agent
index 092dbe2..cad7dc7 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -127,7 +127,7 @@ if __name__ == '__main__':
 	if len(args) > 0:
 		path = manager.FindAdapter(args[0])
 	else:
-		path = manager.DefaultAdapter()
+		path = manager.FindAdapter("default")
 
 	adapter = dbus.Interface(bus.get_object("org.bluez", path),
 							"org.bluez.Adapter")
diff --git a/test/simple-endpoint b/test/simple-endpoint
index 20c8159..013ed8c 100755
--- a/test/simple-endpoint
+++ b/test/simple-endpoint
@@ -85,7 +85,7 @@ if __name__ == '__main__':
 	if len(sys.argv) > 1:
 		path = manager.FindAdapter(sys.argv[1])
 	else:
-		path = manager.DefaultAdapter()
+		path = manager.FindAdapter("default")
 
 	media = dbus.Interface(bus.get_object("org.bluez", path),
 						"org.bluez.Media")
diff --git a/test/simple-player b/test/simple-player
index 9e72f3e..5e10e95 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -143,7 +143,7 @@ if __name__ == '__main__':
 	if len(sys.argv) > 1:
 		path = manager.FindAdapter(sys.argv[1])
 	else:
-		path = manager.DefaultAdapter()
+		path = manager.FindAdapter("default")
 
 	media = dbus.Interface(bus.get_object("org.bluez", path),
 						"org.bluez.Media")
diff --git a/test/simple-service b/test/simple-service
index ed27d0c..9b65e80 100755
--- a/test/simple-service
+++ b/test/simple-service
@@ -109,7 +109,7 @@ manager = dbus.Interface(bus.get_object("org.bluez", "/"),
 if len(sys.argv) > 1:
 	path = manager.FindAdapter(sys.argv[1])
 else:
-	path = manager.DefaultAdapter()
+	path = manager.FindAdapter("default")
 
 service = dbus.Interface(bus.get_object("org.bluez", path),
 						"org.bluez.Service")
diff --git a/test/test-adapter b/test/test-adapter
index a37dd30..8d44dd8 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -22,7 +22,7 @@ parser = OptionParser(option_list=option_list)
 if options.dev_id:
 	adapter_path = manager.FindAdapter(options.dev_id)
 else:
-	adapter_path = manager.DefaultAdapter()
+	adapter_path = manager.FindAdapter("default")
 
 adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 					"org.freedesktop.DBus.Properties")
diff --git a/test/test-attrib b/test/test-attrib
index f83859d..5263c84 100755
--- a/test/test-attrib
+++ b/test/test-attrib
@@ -31,7 +31,7 @@ parser = OptionParser(option_list=option_list)
 if options.dev_id:
 	adapter_path = manager.FindAdapter(options.dev_id)
 else:
-	adapter_path = manager.DefaultAdapter()
+	adapter_path = manager.FindAdapter("default")
 
 adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 							"org.bluez.Adapter")
diff --git a/test/test-audio b/test/test-audio
index e302264..77cc22e 100755
--- a/test/test-audio
+++ b/test/test-audio
@@ -23,7 +23,7 @@ parser = OptionParser(option_list=option_list)
 if options.dev_id:
 	adapter_path = manager.FindAdapter(options.dev_id)
 else:
-	adapter_path = manager.DefaultAdapter()
+	adapter_path = manager.FindAdapter("default")
 
 if options.dev_if:
 	interface = "org.bluez." + options.dev_if
diff --git a/test/test-device b/test/test-device
index c26d7f6..8db1fac 100755
--- a/test/test-device
+++ b/test/test-device
@@ -27,7 +27,7 @@ parser = OptionParser(option_list=option_list)
 if options.dev_id:
 	adapter_path = manager.FindAdapter(options.dev_id)
 else:
-	adapter_path = manager.DefaultAdapter()
+	adapter_path = manager.FindAdapter("default")
 
 adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 							"org.bluez.Adapter")
diff --git a/test/test-discovery b/test/test-discovery
index e85ab60..f262021 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -104,7 +104,7 @@ if __name__ == '__main__':
 	if options.dev_id:
 		adapter_path = manager.FindAdapter(options.dev_id)
 	else:
-		adapter_path = manager.DefaultAdapter()
+		adapter_path = manager.FindAdapter("default")
 
 	if options.compact:
 		compact = True;
diff --git a/test/test-heartrate b/test/test-heartrate
index a7d05b4..aee6a46 100755
--- a/test/test-heartrate
+++ b/test/test-heartrate
@@ -59,7 +59,7 @@ if __name__ == "__main__":
 	if options.adapter:
 		adapter_path = manager.FindAdapter(options.adapter)
 	else:
-		adapter_path = manager.DefaultAdapter()
+		adapter_path = manager.FindAdapter("default")
 
 	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 							"org.bluez.Adapter")
diff --git a/test/test-input b/test/test-input
index 110cbef..783a19f 100755
--- a/test/test-input
+++ b/test/test-input
@@ -21,7 +21,7 @@ parser = OptionParser(option_list=option_list)
 if options.dev_id:
 	adapter_path = manager.FindAdapter(options.dev_id)
 else:
-	adapter_path = manager.DefaultAdapter()
+	adapter_path = manager.FindAdapter("default")
 
 adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 							"org.bluez.Adapter")
diff --git a/test/test-manager b/test/test-manager
index 8a7e2f6..30ca155 100755
--- a/test/test-manager
+++ b/test/test-manager
@@ -31,7 +31,7 @@ if __name__ == "__main__":
 	manager.connect_to_signal("DefaultAdapterChanged", default_changed)
 
 	try:
-		path = manager.DefaultAdapter()
+		path = manager.FindAdapter("default")
 		default_changed(path)
 	except:
 		pass
diff --git a/test/test-nap b/test/test-nap
index dc779ad..b97b165 100755
--- a/test/test-nap
+++ b/test/test-nap
@@ -23,7 +23,7 @@ parser = OptionParser(option_list=option_list)
 if options.dev_id:
 	adapter_path = manager.FindAdapter(options.dev_id)
 else:
-	adapter_path = manager.DefaultAdapter()
+	adapter_path = manager.FindAdapter("default")
 
 server = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 						"org.bluez.NetworkServer")
diff --git a/test/test-network b/test/test-network
index 2ade584..b920901 100755
--- a/test/test-network
+++ b/test/test-network
@@ -23,7 +23,7 @@ parser = OptionParser(option_list=option_list)
 if options.dev_id:
 	adapter_path = manager.FindAdapter(options.dev_id)
 else:
-	adapter_path = manager.DefaultAdapter()
+	adapter_path = manager.FindAdapter("default")
 
 adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 							"org.bluez.Adapter")
diff --git a/test/test-proximity b/test/test-proximity
index b08a62a..9afb1d9 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -40,7 +40,7 @@ if __name__ == "__main__":
 	if options.dev_id:
 		adapter_path = manager.FindAdapter(options.dev_id)
 	else:
-		adapter_path = manager.DefaultAdapter()
+		adapter_path = manager.FindAdapter("default")
 
 	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 							"org.bluez.Adapter")
diff --git a/test/test-service b/test/test-service
index 8eea9e2..17e8593 100755
--- a/test/test-service
+++ b/test/test-service
@@ -22,7 +22,7 @@ parser = OptionParser(option_list=option_list)
 if options.dev_id:
 	adapter_path = manager.FindAdapter(options.dev_id)
 else:
-	adapter_path = manager.DefaultAdapter()
+	adapter_path = manager.FindAdapter("default")
 
 service = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 						"org.bluez.Service")
diff --git a/test/test-thermometer b/test/test-thermometer
index 2ca260f..16ab0ac 100755
--- a/test/test-thermometer
+++ b/test/test-thermometer
@@ -61,7 +61,7 @@ if __name__ == "__main__":
 	if options.adapter:
 		adapter_path = manager.FindAdapter(options.adapter)
 	else:
-		adapter_path = manager.DefaultAdapter()
+		adapter_path = manager.FindAdapter("default")
 
 	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 							"org.bluez.Adapter")
-- 
1.7.11.7

