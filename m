Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 13/16] Phone Alert: implement NotifyAlertStatus() method
Date: Mon, 26 Sep 2011 15:13:39 -0400
Message-Id: <1317064422-1654-14-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Update Alert Status characteristic in alert server. New value will be
notifiable if configured.
---
 alert/server.c      |   23 +++++++++++++++++++++++
 test/phone-agent.py |    5 +++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index cc2cd53..fb088a5 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -76,6 +76,7 @@ static DBusConnection *connection = NULL;
 static uint8_t ringer_setting = 0xff;
 static uint8_t alert_status = 0xff;
 static uint16_t handle_ringer_setting = 0x0000;
+static uint16_t handle_alert_status = 0x0000;
 static struct agent agent;
 
 static void agent_operation(const char *operation)
@@ -292,6 +293,7 @@ static void register_phone_alert_service(void)
 							ATT_CHAR_PROPER_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			alert_status_read,
+			GATT_OPT_CHR_VALUE_GET_HANDLE, &handle_alert_status,
 			/* Ringer Control Point characteristic */
 			GATT_OPT_CHR_UUID, RINGER_CP_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE,
@@ -367,9 +369,30 @@ static DBusMessage *notify_ringer_setting(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *notify_alert_status(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	uint8_t status;
+
+	if (agent.name == NULL)
+		return NULL;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_BYTE, &status,
+							DBUS_TYPE_INVALID))
+		return NULL;
+
+	alert_status = status;
+
+	attrib_db_update(handle_alert_status, NULL, &alert_status,
+						sizeof(alert_status), NULL);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable alert_methods[] = {
 	{ "RegisterAgent",	"o",	"",	register_agent		},
 	{ "NotifyRingerSetting","s",	"",	notify_ringer_setting	},
+	{ "NotifyAlertStatus","y",	"",	notify_alert_status	},
 	{ }
 };
 
diff --git a/test/phone-agent.py b/test/phone-agent.py
index b3b19a8..04a742b 100755
--- a/test/phone-agent.py
+++ b/test/phone-agent.py
@@ -28,11 +28,16 @@ def get_ringer():
 def set_alert_status():
     global ringer_setting, alert_status, on_call
 
+    old_alert_status = alert_status
     if on_call and ringer_setting != "Silent":
         alert_status |= ALERT_RINGER_STATE
     else:
         alert_status &= ~ALERT_RINGER_STATE
 
+    if old_alert_status != alert_status:
+        print "NotifyAlertStatus(%02x)" % alert_status
+        phone.NotifyAlertStatus(dbus.Byte(alert_status))
+
 def silence_ringer():
     print "silence_ringer()"
     global saved_ringer_setting, ringer_setting
-- 
1.7.0.4

