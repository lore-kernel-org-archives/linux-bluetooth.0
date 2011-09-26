Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 08/16] Phone Alert: implement NotifyRingerSetting() method
Date: Mon, 26 Sep 2011 15:13:34 -0400
Message-Id: <1317064422-1654-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Update Ringer Setting characteristic in alert server. This new value
will be notifiable if it was configured.
---
 alert/server.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index 6b39bd4..d5b1e7b 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -67,6 +67,7 @@ struct agent {
 
 static DBusConnection *connection = NULL;
 static uint8_t ringer_setting = 0xff;
+static uint16_t handle_ringer_setting = 0x0000;
 static struct agent agent;
 
 static void agent_operation(const char *operation)
@@ -209,6 +210,7 @@ static void register_phone_alert_service(void)
 							ATT_CHAR_PROPER_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			ringer_setting_read,
+			GATT_OPT_CHR_VALUE_GET_HANDLE, &handle_ringer_setting,
 			GATT_OPT_INVALID);
 }
 
@@ -249,8 +251,32 @@ static DBusMessage *register_agent(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *notify_ringer_setting(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	const char *setting;
+
+	if (agent.name == NULL)
+		return NULL;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &setting,
+							DBUS_TYPE_INVALID))
+		return NULL;
+
+	if (g_str_equal(setting, "Silent"))
+		ringer_setting = RINGER_SILENT;
+	else
+		ringer_setting = RINGER_NORMAL;
+
+	attrib_db_update(handle_ringer_setting, NULL, &ringer_setting,
+						sizeof(ringer_setting), NULL);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable alert_methods[] = {
-	{ "RegisterAgent",	"o",	"",	register_agent },
+	{ "RegisterAgent",	"o",	"",	register_agent		},
+	{ "NotifyRingerSetting","s",	"",	notify_ringer_setting	},
 	{ }
 };
 
-- 
1.7.0.4

