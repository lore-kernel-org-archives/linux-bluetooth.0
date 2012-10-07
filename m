Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Travis Reitter <travis.reitter@collabora.co.uk>
Subject: [PATCH -v2 5/6] bt tool: add cmd 'remove'
Date: Mon,  8 Oct 2012 06:49:56 +0800
Message-Id: <1349650197-18751-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1349650197-18751-1-git-send-email-gustavo@padovan.org>
References: <1349650197-18751-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Travis Reitter <travis.reitter@collabora.co.uk>

'bt remove <device address>' will remove a previous paired device
---
 client/main.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/client/main.c b/client/main.c
index 11d26c5..aeb47e4 100644
--- a/client/main.c
+++ b/client/main.c
@@ -102,6 +102,7 @@ static void show_help()
 	"	discover				Scan for devices\n"
 	"	pair <device address>			Start pairing\n"
 	"	agent					Run BlueZ agent\n"
+	"	remove					Remove a paired device\n"
 							"\n", program_name);
 
 	if(mainloop != NULL)
@@ -740,6 +741,94 @@ static gboolean stop_discovery_cb(gpointer data)
 	return FALSE;
 }
 
+/* Handle the D-Bus method reply for RemoveDevice. See comments on
+ * get_adapter_reply() for more details */
+static void remove_device_reply(DBusPendingCall *pending, void *user_data)
+{
+	const char *device_path = user_data;
+	DBusMessage *reply;
+
+	reply = dbus_pending_call_steal_reply(pending);
+	if (!reply) {
+		ERR("Failed to get RemoveDevice reply");
+		exit(1);
+	}
+
+	if (dbus_message_get_type(reply) == DBUS_MESSAGE_TYPE_ERROR) {
+		ERR("Remove device failed.");
+		exit(1);
+	}
+
+	printf("Device %s successfully removed.\n", device_path);
+	g_main_loop_quit(mainloop);
+}
+
+static int remove_device(DBusConnection *conn, const char *adapter_path,
+							const char *device_path)
+{
+	DBusMessage *msg;
+	int retval = 0;
+
+	if (!(msg = create_method_call(adapter_path, BLUEZ_ADAPTER,
+							"RemoveDevice")))
+		return -1;
+
+	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &device_path,
+							DBUS_TYPE_INVALID);
+
+	if (!send_with_reply_and_set_notify(msg, remove_device_reply,
+						g_strdup(device_path), g_free))
+		retval = -1;
+
+	dbus_message_unref(msg);
+
+	return retval;
+}
+
+/* Handle the D-Bus method reply for FindDevice. See comments on
+ * get_adapter_reply() for more details */
+static void find_device_reply(DBusPendingCall *pending, void *user_data)
+{
+	const char *adapter_path = user_data;
+	DBusMessage *reply;
+	const char *device_path;
+
+	if (!pending)
+		return;
+
+	dbus_pending_call_ref(pending);
+
+	reply = dbus_pending_call_steal_reply(pending);
+	if (!reply) {
+		ERR("Failed to get FindDevice() reply");
+		exit(1);
+	}
+
+	if (dbus_message_get_type(reply) == DBUS_MESSAGE_TYPE_ERROR) {
+		ERR("Failed to find device.");
+		exit(1);
+	} else {
+		struct DBusError err;
+		dbus_error_init(&err);
+
+		if (!dbus_message_get_args(reply, &err,
+					DBUS_TYPE_OBJECT_PATH, &device_path,
+					DBUS_TYPE_INVALID)) {
+			if (dbus_error_is_set(&err)) {
+				ERR("Failed to find device %s", err.message);
+				dbus_error_free(&err);
+			}
+			exit(1);
+		}
+	}
+
+	if (remove_device(conn, adapter_path, device_path) < 0)
+		exit(1);
+
+	dbus_message_unref(reply);
+	dbus_pending_call_unref(pending);
+}
+
 /* Listen for Bluetooth devices broadcasting their availability, then display
  * the results */
 static gboolean cmd_discover(gpointer data)
@@ -829,6 +918,52 @@ static gboolean cmd_agent(gpointer data)
 	return FALSE;
 }
 
+/* Remove a pairing with a given Bluetooth device */
+static gboolean cmd_remove(gpointer data)
+{
+	struct cmd_param *param = data;
+	char *device_addr;
+	DBusMessage *msg;
+	gboolean retval = FALSE;
+
+	device_addr = param->argv[0];
+	if (!device_addr) {
+		ERR("%s: missing device address paramenter", program_name);
+		show_help();
+		exit(1);
+	}
+
+	/* Register a D-Bus interface for our agent to handle our removal
+	 * request */
+	if (!g_dbus_register_interface(conn, "/tool/agent", BLUEZ_AGENT,
+					agent_methods, NULL, NULL, NULL,
+									NULL)) {
+		ERR("Adapter interface init failed for path %s", param->path);
+		return FALSE;
+	}
+
+	device_addr = param->argv[0];
+
+	if (!(msg = create_method_call(param->path, BLUEZ_ADAPTER,
+								"FindDevice")))
+		return FALSE;
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &device_addr,
+							DBUS_TYPE_INVALID);
+
+	/* Set up our notify function and provide it both the extra data it
+	 * requires and another function to free this data when our notify
+	 * function is done with it */
+	if (!send_with_reply_and_set_notify(msg, find_device_reply,
+							g_strdup(param->path),
+							g_free))
+		retval = FALSE;
+
+	dbus_message_unref(msg);
+
+	return retval;
+}
+
 static void run_func(const char *adapter_path, GSourceFunc fn,
 							struct cmd_param *param)
 {
@@ -960,6 +1095,7 @@ static struct cmd_struct commands[] = {
 	{ "discover", cmd_discover},
 	{ "pair", cmd_pair},
 	{ "agent", cmd_agent},
+	{ "remove", cmd_remove},
 };
 
 /* Returns FALSE in case the command could not be parsed. Any failures during
-- 
1.7.11.4

