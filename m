Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 5/5] client: Add support for RebondConsent request
Date: Thu,  4 Aug 2016 15:28:39 +0200
Message-Id: <1470317319-3985-6-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1470317319-3985-1-git-send-email-szymon.janc@codecoup.pl>
References: <1470317319-3985-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to accept or reject rebond consent from bluetoothd.
---
 client/agent.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/client/agent.c b/client/agent.c
index 2cbc292..e4b1f01 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -144,6 +144,8 @@ dbus_bool_t agent_input(DBusConnection *conn, const char *input)
 		confirm_response(conn, input);
 	else if (!strcmp(member, "AuthorizeService"))
 		confirm_response(conn, input);
+	else if (!strcmp(member, "RebondConsent"))
+		confirm_response(conn, input);
 	else
 		g_dbus_send_error(conn, pending_message,
 					"org.bluez.Error.Canceled", NULL);
@@ -310,6 +312,23 @@ static DBusMessage *authorize_service(DBusConnection *conn,
 	return NULL;
 }
 
+static DBusMessage *rebond_consent(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	const char *device;
+
+	rl_printf("Rebond Consent\n");
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
+							DBUS_TYPE_INVALID);
+
+	agent_prompt("Remote Device lost bond. Rebond (yes/no): ");
+
+	pending_message = dbus_message_ref(msg);
+
+	return NULL;
+}
+
 static DBusMessage *cancel_request(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -346,6 +365,9 @@ static const GDBusMethodTable methods[] = {
 	{ GDBUS_ASYNC_METHOD("AuthorizeService",
 			GDBUS_ARGS({ "device", "o" }, { "uuid", "s" }),
 			NULL,  authorize_service) },
+	{ GDBUS_ASYNC_METHOD("RebondConsent",
+			GDBUS_ARGS({ "device", "o" }),
+			NULL, rebond_consent) },
 	{ GDBUS_METHOD("Cancel", NULL, NULL, cancel_request) },
 	{ }
 };
-- 
2.7.4

