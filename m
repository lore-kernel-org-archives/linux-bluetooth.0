Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 10/16] Phone Alert: add GetAlertStatus() call in alert server
Date: Mon, 26 Sep 2011 15:13:36 -0400
Message-Id: <1317064422-1654-11-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The new method GetAlertStatus() is used to initiate the current value of
Alert Status characteristic. This value will be used when reading
operation is required and to update attribute server.

NOTE: Only Ringer State field from Alert Status characteristic is
updated.
---
 alert/server.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index 2466f8b..cc2cd53 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -50,6 +50,12 @@
 #define ALERT_PATH "/test/phonealert"
 
 enum {
+	ALERT_RINGER_STATE = 1 << 0,
+	ALERT_VIBRATOR_STATE = 1 << 1,
+	ALERT_DISPLAY_STATE = 1 << 2,
+};
+
+enum {
 	SET_SILENT_MODE = 1,
 	MUTE_ONCE,
 	CANCEL_SILENT_MODE,
@@ -68,6 +74,7 @@ struct agent {
 
 static DBusConnection *connection = NULL;
 static uint8_t ringer_setting = 0xff;
+static uint8_t alert_status = 0xff;
 static uint16_t handle_ringer_setting = 0x0000;
 static struct agent agent;
 
@@ -115,6 +122,68 @@ static uint8_t control_point_write(struct attribute *a, gpointer user_data)
 	return 0;
 }
 
+static void get_alert_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError derr;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	uint8_t state;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		error("D-Bus replied with error: %s, %s", derr.name,
+								derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	dbus_message_iter_init(reply, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE) {
+		error("Unexpected signature for reply");
+		goto done;
+	}
+
+	dbus_message_iter_get_basic(&iter, &state);
+
+	DBG("Ringer State: %s",
+			state & ALERT_RINGER_STATE ? "Active": "Not Active");
+
+	alert_status = state;
+
+done:
+	dbus_message_unref(reply);
+	dbus_pending_call_unref(call);
+}
+
+static void get_alert_status(DBusConnection *conn, void *user_data)
+{
+	DBusMessage *msg;
+	DBusPendingCall *call;
+
+	if (!agent.name) {
+		error("Agent not registered");
+		return;
+	}
+
+	DBG("Get Alert Status: agent %s, %s", agent.name, agent.path);
+
+	msg = dbus_message_new_method_call(agent.name, agent.path,
+					AGENT_INTERFACE, "GetAlertStatus");
+	if (msg == NULL) {
+		error("Unable to allocate new D-Bus message");
+		return;
+	}
+
+	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
+		error("Failed to send D-Bus message");
+		return;
+	}
+
+	dbus_pending_call_set_notify(call, get_alert_reply, NULL, NULL);
+}
+
 static void get_silent_reply(DBusPendingCall *call, void *user_data)
 {
 	DBusError derr;
@@ -181,7 +250,17 @@ static void get_silent_mode(DBusConnection *conn, void *user_data)
 
 static uint8_t alert_status_read(struct attribute *a, gpointer user_data)
 {
-	DBG("a = %p", a);
+	if (alert_status == 0xff) {
+		get_alert_status(connection, NULL);
+		return ATT_ECODE_IO;
+	}
+
+	DBG("a = %p, state = %s", a,
+		alert_status & ALERT_RINGER_STATE ? "Active": "Not Active");
+
+	if (a->data == NULL || a->data[0] != alert_status)
+		attrib_db_update(a->handle, NULL, &alert_status,
+						sizeof(alert_status), NULL);
 
 	return 0;
 }
-- 
1.7.0.4

