Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] test/agent.c: find given adapter or use default
Date: Thu,  2 Jul 2009 11:14:27 +0200
Message-Id: <1246526068-13364-4-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246526068-13364-1-git-send-email-filippo@esaurito.net>
References: <1246526068-13364-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

modify get_adapter_path to use FindAdapter or use DefaultAdapter if none
is given
---
 test/agent.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index 390b3d8..b625b88 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -406,26 +406,79 @@ static int create_paired_device(DBusConnection *conn, const char *adapter_path,
 	return 0;
 }
 
-static char *get_adapter_path(DBusConnection *conn, const char *adapter)
+static char *get_default_adapter_path(DBusConnection *conn)
 {
 	DBusMessage *msg, *reply;
 	DBusError err;
-	const char *tmppath;
-	char *path, *default_path = "/org/bluez/hci0";
+	const char *reply_path;
+	char *path;
+
+	msg = dbus_message_new_method_call("org.bluez", "/",
+					"org.bluez.Manager", "DefaultAdapter");
+
+	if (!msg) {
+		fprintf(stderr, "Can't allocate new method call\n");
+		return NULL;
+	}
+
+	dbus_error_init(&err);
+
+	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
 
-	if (adapter) {
-		path = strdup(adapter);
-		return path;
+	dbus_message_unref(msg);
+
+	if (!reply) {
+		fprintf(stderr,
+			"Can't get default adapter\n");
+		if (dbus_error_is_set(&err)) {
+			fprintf(stderr, "%s\n", err.message);
+			dbus_error_free(&err);
+		}
+		return NULL;
 	}
 
+	if (!dbus_message_get_args(reply, &err,
+					DBUS_TYPE_OBJECT_PATH, &reply_path,
+					DBUS_TYPE_INVALID)) {
+		fprintf(stderr,
+			"Can't get reply arguments\n");
+		if (dbus_error_is_set(&err)) {
+			fprintf(stderr, "%s\n", err.message);
+			dbus_error_free(&err);
+		}
+		return NULL;
+	}
+
+	path = strdup(reply_path);
+
+	dbus_message_unref(reply);
+
+	dbus_connection_flush(conn);
+
+	return path;
+}
+
+static char *get_adapter_path(DBusConnection *conn, const char *adapter)
+{
+	DBusMessage *msg, *reply;
+	DBusError err;
+	const char *reply_path;
+	char *path;
+
+	if (!adapter)
+		return get_default_adapter_path(conn);
+
 	msg = dbus_message_new_method_call("org.bluez", "/",
-					"org.bluez.Manager", "DefaultAdapter");
+					"org.bluez.Manager", "FindAdapter");
 
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
-		return default_path;
+		return NULL;
 	}
 
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &adapter,
+					DBUS_TYPE_INVALID);
+
 	dbus_error_init(&err);
 
 	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
@@ -434,27 +487,27 @@ static char *get_adapter_path(DBusConnection *conn, const char *adapter)
 
 	if (!reply) {
 		fprintf(stderr,
-			"Can't get default adapter, using default adapter\n");
+			"Can't find adapter %s\n", adapter);
 		if (dbus_error_is_set(&err)) {
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
 		}
-		return default_path;
+		return NULL;
 	}
 
 	if (!dbus_message_get_args(reply, &err,
-					DBUS_TYPE_OBJECT_PATH, &tmppath,
+					DBUS_TYPE_OBJECT_PATH, &reply_path,
 					DBUS_TYPE_INVALID)) {
 		fprintf(stderr,
-			"Can't get reply arguments, using default adapter\n");
+			"Can't get reply arguments\n");
 		if (dbus_error_is_set(&err)) {
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
 		}
-		return default_path;
+		return NULL;
 	}
 
-	path = strdup(tmppath);
+	path = strdup(reply_path);
 
 	dbus_message_unref(reply);
 
@@ -542,8 +595,9 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	adapter_path = get_adapter_path(conn, adapter_id);
 	if (!adapter_path)
-		adapter_path = get_adapter_path(conn, adapter_id);
+		exit(1);
 
 	if (target) {
 		if (create_paired_device(conn, adapter_path, agent_path,
-- 
1.6.3.3

