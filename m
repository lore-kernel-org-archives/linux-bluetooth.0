Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/14] client/bluetooth-player: Add stop command
Date: Fri, 31 May 2013 13:55:42 +0300
Message-Id: <1369997749-8663-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for stop command which can be used to stop the playback
---
 client/bluetooth-player.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index 62c1110..ebf6cd6 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -144,6 +144,35 @@ static void cmd_pause(int argc, char *argv[])
 	rl_printf("Attempting to pause\n");
 }
 
+static void stop_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to stop: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Stop successful\n");
+}
+
+static void cmd_stop(int argc, char *argv[])
+{
+	if (!check_default_player())
+		return;
+
+	if (g_dbus_proxy_method_call(default_player, "Stop", NULL, stop_reply,
+							NULL, NULL) == FALSE) {
+		rl_printf("Failed to stop\n");
+		return;
+	}
+
+	rl_printf("Attempting to stop\n");
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -152,6 +181,7 @@ static const struct {
 } cmd_table[] = {
 	{ "play",         NULL,       cmd_play, "Start playback" },
 	{ "pause",        NULL,       cmd_pause, "Pause playback" },
+	{ "stop",         NULL,       cmd_stop, "Stop playback" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
 	{ "help" },
-- 
1.8.1.4

