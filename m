Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/14] client/bluetooth-player: Add rewind command
Date: Fri, 31 May 2013 13:55:46 +0300
Message-Id: <1369997749-8663-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for rewind command which can be used to rewind the playback
---
 client/bluetooth-player.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index dcbe301..373c49e 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -260,6 +260,35 @@ static void cmd_fast_forward(int argc, char *argv[])
 	rl_printf("Fast forward playback\n");
 }
 
+static void rewind_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to rewind: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Rewind successful\n");
+}
+
+static void cmd_rewind(int argc, char *argv[])
+{
+	if (!check_default_player())
+		return;
+
+	if (g_dbus_proxy_method_call(default_player, "Rewind", NULL,
+					rewind_reply, NULL, NULL) == FALSE) {
+		rl_printf("Failed to rewind\n");
+		return;
+	}
+
+	rl_printf("Rewind playback\n");
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -273,6 +302,7 @@ static const struct {
 	{ "previous",     NULL,       cmd_previous, "Jump to previous item" },
 	{ "fast_forward", NULL,       cmd_fast_forward,
 						"Fast forward playback" },
+	{ "rewind",       NULL,       cmd_rewind, "Rewind playback" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
 	{ "help" },
-- 
1.8.1.4

