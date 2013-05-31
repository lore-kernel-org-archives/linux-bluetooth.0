Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/14] client/bluetooth-player: Add next command
Date: Fri, 31 May 2013 13:55:43 +0300
Message-Id: <1369997749-8663-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for next command which can be used to jump to the next item
---
 client/bluetooth-player.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index ebf6cd6..a6eb932 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -173,6 +173,35 @@ static void cmd_stop(int argc, char *argv[])
 	rl_printf("Attempting to stop\n");
 }
 
+static void next_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to jump to next: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Next successful\n");
+}
+
+static void cmd_next(int argc, char *argv[])
+{
+	if (!check_default_player())
+		return;
+
+	if (g_dbus_proxy_method_call(default_player, "Next", NULL, next_reply,
+							NULL, NULL) == FALSE) {
+		rl_printf("Failed to jump to next\n");
+		return;
+	}
+
+	rl_printf("Attempting to jump to next\n");
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -182,6 +211,7 @@ static const struct {
 	{ "play",         NULL,       cmd_play, "Start playback" },
 	{ "pause",        NULL,       cmd_pause, "Pause playback" },
 	{ "stop",         NULL,       cmd_stop, "Stop playback" },
+	{ "next",         NULL,       cmd_next, "Jump to next item" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
 	{ "help" },
-- 
1.8.1.4

