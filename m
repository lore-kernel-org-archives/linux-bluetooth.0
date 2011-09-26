Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH RFC BlueZ 14/16] Phone Alert: Mute once using new NGFD API
Date: Mon, 26 Sep 2011 15:13:40 -0400
Message-Id: <1317064422-1654-15-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

NGFD API has changed and now we have a dbus method to mute the ringer.
---
 alert/server.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index fb088a5..77540a7 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -49,6 +49,11 @@
 #define ALERT_INTERFACE "org.bluez.PhoneAlert"
 #define ALERT_PATH "/test/phonealert"
 
+/* OHM plugin D-Bus definitions */
+#define OHM_BUS_NAME		"com.nokia.NonGraphicFeedback1"
+#define OHM_INTERFACE		"com.nokia.NonGraphicFeedback1"
+#define OHM_PATH		"/com/nokia/NonGraphicFeedback1"
+
 enum {
 	ALERT_RINGER_STATE = 1 << 0,
 	ALERT_VIBRATOR_STATE = 1 << 1,
@@ -102,6 +107,21 @@ static void agent_operation(const char *operation)
 		error("D-Bus error: agent_operation %s", operation);
 }
 
+static void stop_ringtone(void)
+{
+	DBusMessage *message;
+
+	message = dbus_message_new_method_call(OHM_BUS_NAME, OHM_PATH,
+					OHM_INTERFACE, "StopRingtone");
+	if (message == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return;
+	}
+
+	if (!g_dbus_send_message(connection, message))
+		error("Failed to send D-Bus message");
+}
+
 static uint8_t control_point_write(struct attribute *a, gpointer user_data)
 {
 	DBG("a = %p", a);
@@ -111,7 +131,7 @@ static uint8_t control_point_write(struct attribute *a, gpointer user_data)
 		agent_operation("SetSilentMode");
 		break;
 	case MUTE_ONCE:
-		agent_operation("MuteOnce");
+		stop_ringtone();
 		break;
 	case CANCEL_SILENT_MODE:
 		agent_operation("CancelSilentMode");
-- 
1.7.0.4

