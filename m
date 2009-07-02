Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] test/agent.c: rename device into adapter in functions
Date: Thu,  2 Jul 2009 11:14:26 +0200
Message-Id: <1246526068-13364-3-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246526068-13364-1-git-send-email-filippo@esaurito.net>
References: <1246526068-13364-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/agent.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index b9485d2..390b3d8 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -285,7 +285,7 @@ static const DBusObjectPathVTable agent_table = {
 	.message_function = agent_message,
 };
 
-static int register_agent(DBusConnection *conn, const char *device_path,
+static int register_agent(DBusConnection *conn, const char *adapter_path,
 						const char *agent_path,
 						const char *capabilities)
 {
@@ -298,7 +298,7 @@ static int register_agent(DBusConnection *conn, const char *device_path,
 		return -1;
 	}
 
-	msg = dbus_message_new_method_call("org.bluez", device_path,
+	msg = dbus_message_new_method_call("org.bluez", adapter_path,
 					"org.bluez.Adapter", "RegisterAgent");
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
@@ -331,13 +331,13 @@ static int register_agent(DBusConnection *conn, const char *device_path,
 	return 0;
 }
 
-static int unregister_agent(DBusConnection *conn, const char *device_path,
+static int unregister_agent(DBusConnection *conn, const char *adapter_path,
 							const char *agent_path)
 {
 	DBusMessage *msg, *reply;
 	DBusError err;
 
-	msg = dbus_message_new_method_call("org.bluez", device_path,
+	msg = dbus_message_new_method_call("org.bluez", adapter_path,
 					"org.bluez.Adapter", "UnregisterAgent");
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
@@ -371,7 +371,7 @@ static int unregister_agent(DBusConnection *conn, const char *device_path,
 	return 0;
 }
 
-static int create_paired_device(DBusConnection *conn, const char *device_path,
+static int create_paired_device(DBusConnection *conn, const char *adapter_path,
 						const char *agent_path,
 						const char *capabilities,
 						const char *target)
@@ -379,7 +379,7 @@ static int create_paired_device(DBusConnection *conn, const char *device_path,
 	dbus_bool_t success;
 	DBusMessage *msg;
 
-	msg = dbus_message_new_method_call("org.bluez", device_path,
+	msg = dbus_message_new_method_call("org.bluez", adapter_path,
 						"org.bluez.Adapter",
 						"CreatePairedDevice");
 	if (!msg) {
@@ -406,15 +406,15 @@ static int create_paired_device(DBusConnection *conn, const char *device_path,
 	return 0;
 }
 
-static char *get_device(DBusConnection *conn, const char *device)
+static char *get_adapter_path(DBusConnection *conn, const char *adapter)
 {
 	DBusMessage *msg, *reply;
 	DBusError err;
 	const char *tmppath;
 	char *path, *default_path = "/org/bluez/hci0";
 
-	if (device) {
-		path = strdup(device);
+	if (adapter) {
+		path = strdup(adapter);
 		return path;
 	}
 
@@ -543,7 +543,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (!adapter_path)
-		adapter_path = get_device(conn, adapter_id);
+		adapter_path = get_adapter_path(conn, adapter_id);
 
 	if (target) {
 		if (create_paired_device(conn, adapter_path, agent_path,
-- 
1.6.3.3

