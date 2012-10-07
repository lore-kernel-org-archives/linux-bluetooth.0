Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Travis Reitter <travis.reitter@collabora.co.uk>
Subject: [PATCH -v2 4/6] bt tool: add cmd 'pair'
Date: Mon,  8 Oct 2012 06:49:55 +0800
Message-Id: <1349650197-18751-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1349650197-18751-1-git-send-email-gustavo@padovan.org>
References: <1349650197-18751-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Travis Reitter <travis.reitter@collabora.co.uk>

'bt pair <device address>' starts a pairing procedure with a remote
device.
---
 client/main.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/client/main.c b/client/main.c
index 6035eda..11d26c5 100644
--- a/client/main.c
+++ b/client/main.c
@@ -575,6 +575,65 @@ static int register_agent(DBusConnection *conn, const char *adapter_path,
 	return 0;
 }
 
+/* Handle the D-Bus method reply for CreatePairedDevice. See comments on
+ * get_adapter_reply() for more details */
+static void create_paired_device_reply(DBusPendingCall *pending,
+								void *user_data)
+{
+	const char *device = user_data;
+	const char *device_path;
+	DBusMessage *reply;
+	DBusError err;
+
+	reply = dbus_pending_call_steal_reply(pending);
+
+	if (dbus_message_get_type(reply) == DBUS_MESSAGE_TYPE_ERROR) {
+		ERR("Pairing Failed.");
+		exit(1);
+	}
+
+	dbus_error_init(&err);
+	if (!dbus_message_get_args(reply, &err, DBUS_TYPE_OBJECT_PATH,
+					&device_path, DBUS_TYPE_INVALID)) {
+		if (dbus_error_is_set(&err)) {
+			ERR("Paring failed: %s", err.message);
+			dbus_error_free(&err);
+		}
+		exit(1);
+	}
+
+	printf("Device %s successfully paired.\n", device);
+	g_main_loop_quit(mainloop);
+}
+
+static int create_paired_device(DBusConnection *conn, const char *adapter_path,
+						const char *agent_path,
+						const char *capabilities,
+						const char *device)
+{
+	DBusMessage *msg;
+	int retval = 0;
+
+	if (!(msg = create_method_call(adapter_path, BLUEZ_ADAPTER,
+							"CreatePairedDevice")))
+		return -1;
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &device,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_STRING, &capabilities,
+					DBUS_TYPE_INVALID);
+
+	if (!send_with_reply_and_set_notify(msg, create_paired_device_reply,
+						g_strdup(device), g_free))
+		retval = -1;
+
+	dbus_message_unref(msg);
+
+	exit_on_release = FALSE;
+
+	return retval;
+}
+
 /* This is the table of methods that our agent supports, including their name,
  * and arguments (including their D-Bus types). See the D-Bus documentation for
  * details on the type notation */
@@ -726,6 +785,29 @@ static gboolean cmd_discover(gpointer data)
 	return FALSE;
 }
 
+/* Pair (connect) our Bluetooth adapter with an external Bluetooth device */
+static gboolean cmd_pair(gpointer data)
+{
+	struct cmd_param *param = data;
+	char *device;
+
+	if (!g_dbus_register_interface(conn, "/tool/agent", BLUEZ_AGENT,
+					agent_methods, NULL, NULL, NULL,
+									NULL)) {
+		ERR("Adapter interface init failed on path %s", param->path);
+		return FALSE;
+	}
+
+	device = param->argv[0];
+
+	if (create_paired_device(conn, param->path, "/tool/agent",
+						"DisplayYesNo", device) < 0) {
+		exit(1);
+	}
+
+	return FALSE;
+}
+
 /* Register this program as an agent itself, to handle other BlueZ clients'
  * requests */
 static gboolean cmd_agent(gpointer data)
@@ -876,6 +958,7 @@ static void bluetoothd_disconnect(DBusConnection *conn, void *user_data)
 
 static struct cmd_struct commands[] = {
 	{ "discover", cmd_discover},
+	{ "pair", cmd_pair},
 	{ "agent", cmd_agent},
 };
 
-- 
1.7.11.4

