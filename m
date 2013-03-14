Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, marcel@holtmann.org, deymo@chromium.org
Subject: [PATCH 6/6] Agent's RequestPasskey implementation
Date: Thu, 14 Mar 2013 11:22:06 -0700
Message-Id: <1363285326-20089-7-git-send-email-deymo@chromium.org>
In-Reply-To: <1363285326-20089-1-git-send-email-deymo@chromium.org>
References: <1363285326-20089-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements the uint32 RequestPasskey(object device) method.
---
 client/agent.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/client/agent.c b/client/agent.c
index cb710da..fbc8045 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -92,6 +92,20 @@ static void pincode_response(DBusConnection *conn, const char *input)
 							DBUS_TYPE_INVALID);
 }
 
+static void passkey_response(DBusConnection *conn, const char *input)
+{
+	dbus_uint32_t passkey;
+	if (sscanf(input, "%u", &passkey) == 1)
+		g_dbus_send_reply(conn, pending_message, DBUS_TYPE_UINT32,
+						&passkey, DBUS_TYPE_INVALID);
+	else if (!strcmp(input, "no"))
+		g_dbus_send_error(conn, pending_message,
+					"org.bluez.Error.Rejected", NULL);
+	else
+		g_dbus_send_error(conn, pending_message,
+					"org.bluez.Error.Canceled", NULL);
+}
+
 static void confirm_response(DBusConnection *conn, const char *input)
 {
 	if (!strcmp(input, "yes"))
@@ -117,6 +131,8 @@ dbus_bool_t agent_input(DBusConnection *conn, const char *input)
 
 	if (!strcmp(member, "RequestPinCode"))
 		pincode_response(conn, input);
+	else if (!strcmp(member, "RequestPasskey"))
+		passkey_response(conn, input);
 	else if (!strcmp(member, "RequestConfirmation"))
 		confirm_response(conn, input);
 	else if (!strcmp(member, "RequestAuthorization"))
@@ -184,6 +200,23 @@ static DBusMessage *display_pincode(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *request_passkey(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	const char *device;
+
+	rl_printf("Request passkey\n");
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
+							DBUS_TYPE_INVALID);
+
+	rl_agent_prompt("Enter passkey (number in 0-999999): ");
+
+	pending_message = dbus_message_ref(msg);
+
+	return NULL;
+}
+
 static DBusMessage *display_passkey(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -288,6 +321,9 @@ static const GDBusMethodTable methods[] = {
 	{ GDBUS_METHOD("DisplayPinCode",
 			GDBUS_ARGS({ "device", "o" }, { "pincode", "s" }),
 			NULL, display_pincode) },
+	{ GDBUS_ASYNC_METHOD("RequestPasskey",
+			GDBUS_ARGS({ "device", "o" }),
+			GDBUS_ARGS({ "passkey", "u" }), request_passkey) },
 	{ GDBUS_METHOD("DisplayPasskey",
 			GDBUS_ARGS({ "device", "o" }, { "passkey", "u" },
 							{ "entered", "q" }),
-- 
1.8.1.3

