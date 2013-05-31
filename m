Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/14] client/bluetooth-player: Add play command
Date: Fri, 31 May 2013 13:55:40 +0300
Message-Id: <1369997749-8663-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for play command which can be used to resume the playback
---
 client/bluetooth-player.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index e954be0..312adb7 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <stdio.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -75,12 +76,52 @@ static void cmd_quit(int argc, char *argv[])
 	g_main_loop_quit(main_loop);
 }
 
+static bool check_default_player(void)
+{
+	if (!default_player) {
+		rl_printf("No default player available\n");
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void play_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to play: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Play successful\n");
+}
+
+static void cmd_play(int argc, char *argv[])
+{
+	if (!check_default_player())
+		return;
+
+	if (g_dbus_proxy_method_call(default_player, "Play", NULL, play_reply,
+							NULL, NULL) == FALSE) {
+		rl_printf("Failed to play\n");
+		return;
+	}
+
+	rl_printf("Attempting to play\n");
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
 	void (*func) (int argc, char *argv[]);
 	const char *desc;
 } cmd_table[] = {
+	{ "play",         NULL,       cmd_play, "Start playback" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
 	{ "help" },
-- 
1.8.1.4

