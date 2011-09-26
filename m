Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 06/16] Phone Alert: add GetSilentMode() call in alert server
Date: Mon, 26 Sep 2011 15:13:32 -0400
Message-Id: <1317064422-1654-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The new method GetSilentMode() is used to initiate the current value of
Ringer Setting. This value will be used when reading operation is
required and to update attribute server.
---
 alert/server.c |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 81 insertions(+), 1 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index 8926854..6b39bd4 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -54,6 +54,11 @@ enum {
 	CANCEL_SILENT_MODE,
 };
 
+enum {
+	RINGER_SILENT = 0,
+	RINGER_NORMAL = 1,
+};
+
 struct agent {
 	char *name;
 	char *path;
@@ -61,6 +66,7 @@ struct agent {
 };
 
 static DBusConnection *connection = NULL;
+static uint8_t ringer_setting = 0xff;
 static struct agent agent;
 
 static void agent_operation(const char *operation)
@@ -107,9 +113,83 @@ static uint8_t control_point_write(struct attribute *a, gpointer user_data)
 	return 0;
 }
 
+static void get_silent_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError derr;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	const char *setting = NULL;
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
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
+		error("Unexpected signature for reply");
+		goto done;
+	}
+
+	dbus_message_iter_get_basic(&iter, &setting);
+
+	DBG("Ringer Setting: %s", setting);
+
+	if (g_str_equal(setting, "Silent"))
+		ringer_setting = RINGER_SILENT;
+	else
+		ringer_setting = RINGER_NORMAL;
+
+done:
+	dbus_message_unref(reply);
+	dbus_pending_call_unref(call);
+}
+
+static void get_silent_mode(DBusConnection *conn, void *user_data)
+{
+	DBusMessage *msg;
+	DBusPendingCall *call;
+
+	if (!agent.name) {
+		error("Agent not registered");
+		return;
+	}
+
+	DBG("Get Silent Mode: agent %s, %s", agent.name, agent.path);
+
+	msg = dbus_message_new_method_call(agent.name, agent.path,
+					AGENT_INTERFACE, "GetSilentMode");
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
+	dbus_pending_call_set_notify(call, get_silent_reply, NULL, NULL);
+}
+
 static uint8_t ringer_setting_read(struct attribute *a, gpointer user_data)
 {
-	DBG("a = %p", a);
+	if (ringer_setting == 0xff) {
+		get_silent_mode(connection, NULL);
+		return ATT_ECODE_IO;
+	}
+
+	DBG("a = %p, setting = %s", a,
+			ringer_setting == RINGER_SILENT ? "Silent": "Normal");
+
+	if (a->data == NULL || a->data[0] != ringer_setting)
+		attrib_db_update(a->handle, NULL, &ringer_setting,
+						sizeof(ringer_setting), NULL);
 
 	return 0;
 }
-- 
1.7.0.4

