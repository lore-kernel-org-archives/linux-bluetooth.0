Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 20/22] alert: Add support to call SetRinger()
Date: Mon, 27 Aug 2012 13:12:04 -0400
Message-Id: <1346087526-15107-21-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

When BlueZ want call SetRinger() method from org.bluez.AlertAgent
interface for a registered agent, the function
agent_ringer_set_ringer() must be called.
---
 profiles/alert/server.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index b7660b0..794189a 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -425,6 +425,31 @@ static int agent_ringer_mute_once(void)
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
+	g_dbus_send_message(connection, msg);
+
+	return 0;
+}
+
 static void update_unread_alert(gpointer data, gpointer user_data)
 {
 	struct alert_adapter *al_adapter = data;
@@ -497,6 +522,7 @@ static uint8_t ringer_cp_write(struct attribute *a,
 	switch (a->data[0]) {
 	case RINGER_SILENT_MODE:
 		DBG("Silent Mode");
+		agent_ringer_set_ringer("disabled");
 		break;
 	case RINGER_MUTE_ONCE:
 		DBG("Mute Once");
@@ -504,6 +530,7 @@ static uint8_t ringer_cp_write(struct attribute *a,
 		break;
 	case RINGER_CANCEL_SILENT_MODE:
 		DBG("Cancel Silent Mode");
+		agent_ringer_set_ringer("enabled");
 		break;
 	default:
 		DBG("Invalid command (0x%02x)", a->data[0]);
-- 
1.7.9.5

