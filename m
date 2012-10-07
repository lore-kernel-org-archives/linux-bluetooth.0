Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 3/6] bt tool: add cmd 'agent'
Date: Mon,  8 Oct 2012 06:49:54 +0800
Message-Id: <1349650197-18751-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1349650197-18751-1-git-send-email-gustavo@padovan.org>
References: <1349650197-18751-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

'bt agent' command register a agent in BlueZ that will loop waiting for
pairing and incoming connection requests.
---
 client/main.c | 352 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 352 insertions(+)

diff --git a/client/main.c b/client/main.c
index 48521fd..6035eda 100644
--- a/client/main.c
+++ b/client/main.c
@@ -82,6 +82,8 @@ struct find_adapter_cb_data {
 static GMainLoop *mainloop = NULL;
 static gchar *program_name = NULL;
 
+static gboolean exit_on_release = TRUE;
+
 static bdaddr_t bdaddr;
 static DBusConnection *conn;
 
@@ -280,6 +282,334 @@ static gboolean send_with_reply_and_set_notify(DBusMessage *msg,
 	return TRUE;
 }
 
+static DBusMessage *agent_request_confirmation(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	const char *path;
+	unsigned int passkey;
+	char conf[16];
+	int ret;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_UINT32, &passkey,
+						DBUS_TYPE_INVALID)) {
+		ERR("Invalid arguments for RequestConfirmation method");
+		reply = dbus_message_new_error(msg,
+					BLUEZ_ERROR".InvalidArguments", "");
+		goto send;
+	}
+
+	printf("Pairing request confirmation for %s.\n"
+		"Confirm the passkey %6.6d (yes/no): ", path, passkey);
+	ret = scanf("%3s", conf);
+	if (!ret)
+		return NULL;
+
+	if (g_str_equal(conf, "yes"))
+		reply = dbus_message_new_method_return(msg);
+	else
+		reply = dbus_message_new_error(msg, BLUEZ_ERROR".Rejected",
+						"Passkey doesn't match");
+
+	if (!reply) {
+		ERR("Can't create reply message");
+		return NULL;
+	}
+
+send:
+	dbus_connection_send(conn, reply, NULL);
+
+	dbus_message_unref(reply);
+
+	return NULL;
+}
+
+static DBusMessage *agent_request_pincode(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	const char *path;
+	char pin[64];
+	char *str;
+	int ret;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID)) {
+		ERR("Invalid arguments for RequestPinCode method");
+		reply = dbus_message_new_error(msg,
+					BLUEZ_ERROR".InvalidArguments", "");
+		goto send;
+	}
+
+	printf("Pairing request for  %s.\nType the PIN code: ", path);
+	ret = scanf("%s", pin);
+	if (!ret)
+		return NULL;
+
+	if (!(reply = dbus_message_new_method_return(msg))) {
+		ERR("Not enough memory to construct message");
+		return NULL;
+	}
+
+	str = pin;
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &str,
+							DBUS_TYPE_INVALID);
+
+send:
+	dbus_connection_send(conn, reply, NULL);
+
+	dbus_message_unref(reply);
+
+	return NULL;
+}
+
+static DBusMessage *agent_request_passkey(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	const char *path;
+	unsigned int passkey;
+	int ret;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID)) {
+		ERR("Invalid arguments for RequestPasskey method");
+		reply = dbus_message_new_error(msg,
+					BLUEZ_ERROR".InvalidArguments", "");
+		goto send;
+	}
+
+	printf("Pairing request for  %s.\nType the Passkey: ", path);
+	ret = scanf("%u", &passkey);
+	if (!ret)
+		return NULL;
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, passkey,
+							DBUS_TYPE_INVALID);
+
+send:
+	if (!dbus_connection_send(conn, reply, NULL))
+		ERR("Not enough memory to send message");
+
+	dbus_message_unref(reply);
+
+	return NULL;
+}
+
+static DBusMessage *agent_authorize(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	DBusMessage *reply;
+	const char *path, *uuid;
+	char conf[16];
+	int ret;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_STRING, &uuid,
+						DBUS_TYPE_INVALID)) {
+		ERR("Invalid arguments for Authorize method");
+		reply = dbus_message_new_error(msg,
+					BLUEZ_ERROR".InvalidArguments", "");
+		goto send;
+	}
+
+	printf("Incoming connection request for %s (%s).\n"
+		"Authorize (yes/no): ", path, uuid);
+	ret = scanf("%3s", conf);
+	if (!ret)
+		return NULL;
+
+	if (g_str_equal(conf, "yes"))
+		reply = dbus_message_new_method_return(msg);
+	else
+		reply = dbus_message_new_error(msg, BLUEZ_ERROR".Rejected",
+						"Connection Rejected");
+
+	if (!reply) {
+		ERR("Can't create reply message");
+		return NULL;
+	}
+
+send:
+	dbus_connection_send(conn, reply, NULL);
+
+	dbus_message_unref(reply);
+
+	return NULL;
+}
+
+static DBusMessage *agent_confirm_mode_change(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	const char *mode;
+	char conf[16];
+	int ret;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &mode,
+							DBUS_TYPE_INVALID)) {
+		ERR("Invalid arguments for ConfirmModeChange");
+		reply = dbus_message_new_error(msg,
+					BLUEZ_ERROR".InvalidArguments", "");
+		goto send;
+	}
+
+	printf("Authorize mode change to %s (yes/no): ", mode);
+	ret = scanf("%3s", conf);
+	if (!ret)
+		return NULL;
+
+	if (g_str_equal(conf, "yes"))
+		reply = dbus_message_new_method_return(msg);
+	else
+		reply = dbus_message_new_error(msg, BLUEZ_ERROR".Rejected",
+						"Mode Change Rejected");
+
+	if (!reply) {
+		ERR("Can't create reply message");
+		return NULL;
+	}
+
+send:
+	dbus_connection_send(conn, reply, NULL);
+
+	dbus_message_unref(reply);
+
+	return NULL;
+}
+
+static DBusMessage *agent_cancel(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	DBusMessage *reply;
+
+	printf("Request canceled\n");
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply) {
+		ERR("Can't create reply message");
+		return NULL;
+	}
+
+	dbus_connection_send(conn, reply, NULL);
+
+	dbus_message_unref(reply);
+
+	g_main_loop_quit(mainloop);
+
+	return NULL;
+}
+
+static DBusMessage *agent_release(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	DBusMessage *reply;
+
+	printf("Agent released\n");
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply) {
+		ERR("Can't create reply message");
+		return NULL;
+	}
+
+	dbus_connection_send(conn, reply, NULL);
+
+	dbus_message_unref(reply);
+
+	/* Only exit the mainloop in case there are no other D-Bus methods, such
+	 * as CreatePairedDevice, pending */
+	if (exit_on_release)
+		g_main_loop_quit(mainloop);
+
+	return NULL;
+}
+
+/* Handle the D-Bus method reply for RegisterAgent. See comments on
+ * get_adapter_reply() for more details */
+static void register_agent_reply(DBusPendingCall *pending, void *user_data)
+{
+	DBusMessage *reply;
+
+	reply = dbus_pending_call_steal_reply(pending);
+
+	if (dbus_message_get_type(reply) == DBUS_MESSAGE_TYPE_ERROR) {
+		ERR("Agent Registration failed.");
+		exit(1);
+	}
+
+	printf("Agent registered\n");
+}
+
+static int register_agent(DBusConnection *conn, const char *adapter_path,
+						const char *agent_path,
+						const char *capabilities)
+{
+	dbus_bool_t success;
+	DBusMessage *msg;
+	DBusPendingCall *pending;
+
+	if (!(msg = create_method_call(adapter_path, BLUEZ_ADAPTER,
+							"RegisterAgent")))
+		return -1;
+
+	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_STRING, &capabilities,
+					DBUS_TYPE_INVALID);
+
+	success = dbus_connection_send_with_reply(conn, msg, &pending, -1);
+	if (pending)
+		dbus_pending_call_set_notify(pending, register_agent_reply,
+								NULL, NULL);
+
+	dbus_message_unref(msg);
+
+	if (!success) {
+		ERR("Not enough memory for message send");
+		return -1;
+	}
+
+	return 0;
+}
+
+/* This is the table of methods that our agent supports, including their name,
+ * and arguments (including their D-Bus types). See the D-Bus documentation for
+ * details on the type notation */
+static const GDBusMethodTable agent_methods[] = {
+	{ GDBUS_ASYNC_METHOD("RequestConfirmation",
+			GDBUS_ARGS({ "device", "o" }, { "passkey", "u" }),
+			NULL,
+			agent_request_confirmation) },
+	{ GDBUS_ASYNC_METHOD("RequestPinCode",
+			GDBUS_ARGS({ "device", "o" }),
+			GDBUS_ARGS({"pincode", "s"}),
+			agent_request_pincode) },
+	{ GDBUS_ASYNC_METHOD("RequestPasskey",
+			GDBUS_ARGS({ "device", "o" }),
+			GDBUS_ARGS({"passkey", "u"}),
+			agent_request_passkey) },
+	{ GDBUS_ASYNC_METHOD("Authorize",
+			GDBUS_ARGS({ "device", "o" }, { "uuid", "s" }),
+			NULL,
+			agent_authorize) },
+	{ GDBUS_ASYNC_METHOD("ConfirmModeChange",
+			GDBUS_ARGS( { "mode", "s" }),
+			NULL,
+			agent_confirm_mode_change) },
+	{ GDBUS_ASYNC_METHOD("Cancel",
+			NULL,
+			NULL,
+			agent_cancel) },
+	{ GDBUS_ASYNC_METHOD("Release",
+			NULL,
+			NULL,
+			agent_release) },
+	{ }
+};
+
 /* Handle BlueZ's DeviceFound signal */
 static gboolean device_found(DBusConnection *conn, DBusMessage *message,
 							void *user_data)
@@ -396,6 +726,27 @@ static gboolean cmd_discover(gpointer data)
 	return FALSE;
 }
 
+/* Register this program as an agent itself, to handle other BlueZ clients'
+ * requests */
+static gboolean cmd_agent(gpointer data)
+{
+	struct cmd_param *param = data;
+
+	if (!g_dbus_register_interface(conn, "/tool/agent", BLUEZ_AGENT,
+					agent_methods, NULL, NULL, NULL,
+									NULL)) {
+		ERR("Agent interface init failed");
+		return FALSE;
+	}
+
+	if (register_agent(conn, param->path, "/tool/agent", "DisplayYesNo")
+									< 0) {
+		exit(1);
+	}
+
+	return FALSE;
+}
+
 static void run_func(const char *adapter_path, GSourceFunc fn,
 							struct cmd_param *param)
 {
@@ -525,6 +876,7 @@ static void bluetoothd_disconnect(DBusConnection *conn, void *user_data)
 
 static struct cmd_struct commands[] = {
 	{ "discover", cmd_discover},
+	{ "agent", cmd_agent},
 };
 
 /* Returns FALSE in case the command could not be parsed. Any failures during
-- 
1.7.11.4

