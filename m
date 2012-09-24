Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 19/25] alert: Add support for calling SetRinger()
Date: Mon, 24 Sep 2012 14:00:55 -0400
Message-Id: <1348509661-15967-20-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

When BlueZ wants to call SetRinger() method from org.bluez.AlertAgent
interface for a registered agent, the function agent_ringer_set_ringer()
must be called.
---
 profiles/alert/server.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 75eb414..952d982 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -426,6 +426,31 @@ static int agent_ringer_mute_once(void)
 	return 0;
 }
 
+static int agent_ringer_set_ringer(const char *mode)
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
+					ALERT_AGENT_INTERFACE, "SetRinger");
+	if (!msg)
+		return -ENOMEM;
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &mode,
+							DBUS_TYPE_INVALID);
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
@@ -498,6 +523,7 @@ static uint8_t ringer_cp_write(struct attribute *a,
 	switch (a->data[0]) {
 	case RINGER_SILENT_MODE:
 		DBG("Silent Mode");
+		agent_ringer_set_ringer("disabled");
 		break;
 	case RINGER_MUTE_ONCE:
 		DBG("Mute Once");
@@ -505,6 +531,7 @@ static uint8_t ringer_cp_write(struct attribute *a,
 		break;
 	case RINGER_CANCEL_SILENT_MODE:
 		DBG("Cancel Silent Mode");
+		agent_ringer_set_ringer("enabled");
 		break;
 	default:
 		DBG("Invalid command (0x%02x)", a->data[0]);
-- 
1.7.9.5

