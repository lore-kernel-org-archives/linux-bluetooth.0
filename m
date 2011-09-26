Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ 16/16] Phone Alert: agent API changes
Date: Mon, 26 Sep 2011 15:13:42 -0400
Message-Id: <1317064422-1654-17-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Remove GetSilentMode() and GetAlertStatus() functions
* Now initial Ringer Setting and Alert Status values are passed as
  arguments for RegisterAgent()
* Register Phone Alert Status Service only when agent is registered.
---
 alert/server.c      |  161 +++++++--------------------------------------------
 test/phone-agent.py |   19 +------
 2 files changed, 22 insertions(+), 158 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index 77540a7..9fa0de6 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -83,6 +83,7 @@ static uint8_t alert_status = 0xff;
 static uint16_t handle_ringer_setting = 0x0000;
 static uint16_t handle_alert_status = 0x0000;
 static struct agent agent;
+static gboolean service_registered = FALSE;
 
 static void agent_operation(const char *operation)
 {
@@ -143,139 +144,8 @@ static uint8_t control_point_write(struct attribute *a, gpointer user_data)
 	return 0;
 }
 
-static void get_alert_reply(DBusPendingCall *call, void *user_data)
-{
-	DBusError derr;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	uint8_t state;
-
-	reply = dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		error("D-Bus replied with error: %s, %s", derr.name,
-								derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	dbus_message_iter_init(reply, &iter);
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE) {
-		error("Unexpected signature for reply");
-		goto done;
-	}
-
-	dbus_message_iter_get_basic(&iter, &state);
-
-	DBG("Ringer State: %s",
-			state & ALERT_RINGER_STATE ? "Active": "Not Active");
-
-	alert_status = state;
-
-done:
-	dbus_message_unref(reply);
-	dbus_pending_call_unref(call);
-}
-
-static void get_alert_status(DBusConnection *conn, void *user_data)
-{
-	DBusMessage *msg;
-	DBusPendingCall *call;
-
-	if (!agent.name) {
-		error("Agent not registered");
-		return;
-	}
-
-	DBG("Get Alert Status: agent %s, %s", agent.name, agent.path);
-
-	msg = dbus_message_new_method_call(agent.name, agent.path,
-					AGENT_INTERFACE, "GetAlertStatus");
-	if (msg == NULL) {
-		error("Unable to allocate new D-Bus message");
-		return;
-	}
-
-	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
-		error("Failed to send D-Bus message");
-		return;
-	}
-
-	dbus_pending_call_set_notify(call, get_alert_reply, NULL, NULL);
-}
-
-static void get_silent_reply(DBusPendingCall *call, void *user_data)
-{
-	DBusError derr;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	const char *setting = NULL;
-
-	reply = dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		error("D-Bus replied with error: %s, %s", derr.name,
-								derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	dbus_message_iter_init(reply, &iter);
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
-		error("Unexpected signature for reply");
-		goto done;
-	}
-
-	dbus_message_iter_get_basic(&iter, &setting);
-
-	DBG("Ringer Setting: %s", setting);
-
-	if (g_str_equal(setting, "Silent"))
-		ringer_setting = RINGER_SILENT;
-	else
-		ringer_setting = RINGER_NORMAL;
-
-done:
-	dbus_message_unref(reply);
-	dbus_pending_call_unref(call);
-}
-
-static void get_silent_mode(DBusConnection *conn, void *user_data)
-{
-	DBusMessage *msg;
-	DBusPendingCall *call;
-
-	if (!agent.name) {
-		error("Agent not registered");
-		return;
-	}
-
-	DBG("Get Silent Mode: agent %s, %s", agent.name, agent.path);
-
-	msg = dbus_message_new_method_call(agent.name, agent.path,
-					AGENT_INTERFACE, "GetSilentMode");
-	if (msg == NULL) {
-		error("Unable to allocate new D-Bus message");
-		return;
-	}
-
-	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
-		error("Failed to send D-Bus message");
-		return;
-	}
-
-	dbus_pending_call_set_notify(call, get_silent_reply, NULL, NULL);
-}
-
 static uint8_t alert_status_read(struct attribute *a, gpointer user_data)
 {
-	if (alert_status == 0xff) {
-		get_alert_status(connection, NULL);
-		return ATT_ECODE_IO;
-	}
-
 	DBG("a = %p, state = %s", a,
 		alert_status & ALERT_RINGER_STATE ? "Active": "Not Active");
 
@@ -288,11 +158,6 @@ static uint8_t alert_status_read(struct attribute *a, gpointer user_data)
 
 static uint8_t ringer_setting_read(struct attribute *a, gpointer user_data)
 {
-	if (ringer_setting == 0xff) {
-		get_silent_mode(connection, NULL);
-		return ATT_ECODE_IO;
-	}
-
 	DBG("a = %p, setting = %s", a,
 			ringer_setting == RINGER_SILENT ? "Silent": "Normal");
 
@@ -343,15 +208,33 @@ static void agent_exited(DBusConnection *conn, void *user_data)
 static DBusMessage *register_agent(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	const char *path, *name;
+	const char *path, *name, *setting;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_BYTE, &alert_status,
+						DBUS_TYPE_STRING, &setting,
 							DBUS_TYPE_INVALID))
 		return NULL;
 
 	if (agent.name != NULL)
 		return btd_error_already_exists(msg);
 
+	DBG("Ringer State (Alert Status): %s",
+		alert_status & ALERT_RINGER_STATE ? "Active": "Not Active");
+
+	DBG("Ringer Setting: %s", setting);
+	if (g_str_equal(setting, "Silent"))
+		ringer_setting = RINGER_SILENT;
+	else
+		ringer_setting = RINGER_NORMAL;
+
+	if (service_registered == FALSE) {
+		/* Register Phone Alert Status Service only when agent is
+		 * registered for the first time. */
+		register_phone_alert_service();
+		service_registered = TRUE;
+	}
+
 	name = dbus_message_get_sender(msg);
 
 	DBG("Registering agent: path = %s, name = %s", path, name);
@@ -410,7 +293,7 @@ static DBusMessage *notify_alert_status(DBusConnection *conn,
 }
 
 static GDBusMethodTable alert_methods[] = {
-	{ "RegisterAgent",	"o",	"",	register_agent		},
+	{ "RegisterAgent",	"oys",	"",	register_agent		},
 	{ "NotifyRingerSetting","s",	"",	notify_ringer_setting	},
 	{ "NotifyAlertStatus","y",	"",	notify_alert_status	},
 	{ }
@@ -434,8 +317,6 @@ int alert_server_init(void)
 
 	DBG("Registered interface %s on path %s", ALERT_INTERFACE, ALERT_PATH);
 
-	register_phone_alert_service();
-
 	return 0;
 }
 
diff --git a/test/phone-agent.py b/test/phone-agent.py
index 372f832..d2bd126 100755
--- a/test/phone-agent.py
+++ b/test/phone-agent.py
@@ -108,23 +108,6 @@ class PhoneAgent(dbus.service.Object):
         silent_mode = False
         restore_ringer()
 
-    @dbus.service.method("org.bluez.PhoneAgent",
-            in_signature="", out_signature="s")
-    def GetSilentMode(self):
-        print "GetSilentMode()"
-
-        global ringer_setting
-        return ringer_setting
-
-    @dbus.service.method("org.bluez.PhoneAgent",
-            in_signature="", out_signature="y")
-    def GetAlertStatus(self):
-        print "GetAlertStatus()"
-
-        global alert_status
-        return alert_status
-
-
 if __name__ == "__main__":
     dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
@@ -151,7 +134,7 @@ if __name__ == "__main__":
             "/test/phonealert"), "org.bluez.PhoneAlert")
 
     agent = PhoneAgent(system_bus, agent_path)
-    phone.RegisterAgent(agent_path)
+    phone.RegisterAgent(agent_path, dbus.Byte(alert_status), ringer_setting)
     print "destination:", system_bus.get_unique_name()
 
     mainloop = gobject.MainLoop()
-- 
1.7.0.4

