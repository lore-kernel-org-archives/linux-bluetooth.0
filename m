Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 18/25] alert: Add support for calling MuteOnce()
Date: Mon, 24 Sep 2012 14:00:54 -0400
Message-Id: <1348509661-15967-19-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

When BlueZ wants to call MuteOnce() method from org.bluez.AlertAgent
interface for a registered agent, the function agent_ringer_mute_once()
must be called.
---
 profiles/alert/server.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index bf67d7d..75eb414 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -61,6 +61,7 @@
 
 #define ALERT_OBJECT_PATH "/org/bluez"
 #define ALERT_INTERFACE   "org.bluez.Alert"
+#define ALERT_AGENT_INTERFACE "org.bluez.AlertAgent"
 
 /* Maximum length for "Text String Information" */
 #define NEW_ALERT_MAX_INFO_SIZE		18
@@ -403,6 +404,28 @@ static DBusMessage *new_alert(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static int agent_ringer_mute_once(void)
+{
+	struct alert_data *alert;
+	DBusMessage *msg;
+
+	alert = get_alert_data_by_category("ringer");
+	if (!alert) {
+		DBG("Category ringer is not registered");
+		return -EINVAL;
+	}
+
+	msg = dbus_message_new_method_call(alert->srv, alert->path,
+					ALERT_AGENT_INTERFACE, "MuteOnce");
+	if (!msg)
+		return -ENOMEM;
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
+
+	return 0;
+}
+
 static void update_unread_alert(gpointer data, gpointer user_data)
 {
 	struct alert_adapter *al_adapter = data;
@@ -478,6 +501,7 @@ static uint8_t ringer_cp_write(struct attribute *a,
 		break;
 	case RINGER_MUTE_ONCE:
 		DBG("Mute Once");
+		agent_ringer_mute_once();
 		break;
 	case RINGER_CANCEL_SILENT_MODE:
 		DBG("Cancel Silent Mode");
-- 
1.7.9.5

