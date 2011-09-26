Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 05/16] Phone Alert: add agent operations to alert server
Date: Mon, 26 Sep 2011 15:13:31 -0400
Message-Id: <1317064422-1654-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The operations "Set Silent Mode", "Cancel Silent Mode" and "Mute Once"
can be called via D-Bus. The agent will implement the communication with
the device.
---
 alert/server.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index 66a5e42..8926854 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -44,9 +44,16 @@
 #define RINGER_CP_CHR_UUID		0x2A40
 #define RINGER_SETTING_CHR_UUID		0x2A41
 
+#define AGENT_INTERFACE "org.bluez.PhoneAgent"
 #define ALERT_INTERFACE "org.bluez.PhoneAlert"
 #define ALERT_PATH "/test/phonealert"
 
+enum {
+	SET_SILENT_MODE = 1,
+	MUTE_ONCE,
+	CANCEL_SILENT_MODE,
+};
+
 struct agent {
 	char *name;
 	char *path;
@@ -56,10 +63,47 @@ struct agent {
 static DBusConnection *connection = NULL;
 static struct agent agent;
 
+static void agent_operation(const char *operation)
+{
+	DBusMessage *message;
+
+	if (!agent.name) {
+		error("Agent not registered");
+		return;
+	}
+
+	DBG("%s: agent %s, %s", operation, agent.name, agent.path);
+
+	message = dbus_message_new_method_call(agent.name, agent.path,
+						AGENT_INTERFACE, operation);
+
+	if (message == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return;
+	}
+
+	if (!g_dbus_send_message(connection, message))
+		error("D-Bus error: agent_operation %s", operation);
+}
+
 static uint8_t control_point_write(struct attribute *a, gpointer user_data)
 {
 	DBG("a = %p", a);
 
+	switch (a->data[0]) {
+	case SET_SILENT_MODE:
+		agent_operation("SetSilentMode");
+		break;
+	case MUTE_ONCE:
+		agent_operation("MuteOnce");
+		break;
+	case CANCEL_SILENT_MODE:
+		agent_operation("CancelSilentMode");
+		break;
+	default:
+		DBG("Unknown mode");
+	}
+
 	return 0;
 }
 
-- 
1.7.0.4

