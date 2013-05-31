Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/14] client/bluetooth-player: Add previous command
Date: Fri, 31 May 2013 13:55:44 +0300
Message-Id: <1369997749-8663-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for next command which can be used to jump to the previous
item
---
 client/bluetooth-player.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index a6eb932..92d577a 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -202,6 +202,35 @@ static void cmd_next(int argc, char *argv[])
 	rl_printf("Attempting to jump to next\n");
 }
 
+static void previous_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to jump to previous: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Previous successful\n");
+}
+
+static void cmd_previous(int argc, char *argv[])
+{
+	if (!check_default_player())
+		return;
+
+	if (g_dbus_proxy_method_call(default_player, "Previous", NULL,
+					previous_reply, NULL, NULL) == FALSE) {
+		rl_printf("Failed to jump to previous\n");
+		return;
+	}
+
+	rl_printf("Attempting to jump to previous\n");
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -212,6 +241,7 @@ static const struct {
 	{ "pause",        NULL,       cmd_pause, "Pause playback" },
 	{ "stop",         NULL,       cmd_stop, "Stop playback" },
 	{ "next",         NULL,       cmd_next, "Jump to next item" },
+	{ "previous",     NULL,       cmd_previous, "Jump to previous item" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
 	{ "help" },
-- 
1.8.1.4

