Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH v3 4/6] client: Agent's DisplayPincode implementation
Date: Tue, 19 Mar 2013 13:55:03 -0700
Message-Id: <1363726505-15171-5-git-send-email-deymo@chromium.org>
In-Reply-To: <1363726505-15171-1-git-send-email-deymo@chromium.org>
References: <1363726505-15171-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements the DisplayPinCode(object device, string pincode) method.
---
 client/agent.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/client/agent.c b/client/agent.c
index dc27079..1414eba 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -172,6 +172,20 @@ static DBusMessage *request_pincode(DBusConnection *conn,
 	return NULL;
 }
 
+static DBusMessage *display_pincode(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	const char *device;
+	const char *pincode;
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
+				DBUS_TYPE_STRING, &pincode, DBUS_TYPE_INVALID);
+
+	rl_printf(AGENT_PROMPT "PIN code: %s\n", pincode);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static DBusMessage *request_confirmation(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -247,6 +261,9 @@ static const GDBusMethodTable methods[] = {
 	{ GDBUS_ASYNC_METHOD("RequestPinCode",
 			GDBUS_ARGS({ "device", "o" }),
 			GDBUS_ARGS({ "pincode", "s" }), request_pincode) },
+	{ GDBUS_METHOD("DisplayPinCode",
+			GDBUS_ARGS({ "device", "o" }, { "pincode", "s" }),
+			NULL, display_pincode) },
 	{ GDBUS_ASYNC_METHOD("RequestConfirmation",
 			GDBUS_ARGS({ "device", "o" }, { "passkey", "u" }),
 			NULL, request_confirmation) },
-- 
1.8.1.3

