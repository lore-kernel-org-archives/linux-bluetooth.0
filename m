Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/14] client/bluetooth-player: Add fast_forward command
Date: Fri, 31 May 2013 13:55:45 +0300
Message-Id: <1369997749-8663-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for fast_forward command which can be used to fast forward
the playback
---
 client/bluetooth-player.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index 92d577a..dcbe301 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -231,6 +231,35 @@ static void cmd_previous(int argc, char *argv[])
 	rl_printf("Attempting to jump to previous\n");
 }
 
+static void fast_forward_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to fast forward: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("FastForward successful\n");
+}
+
+static void cmd_fast_forward(int argc, char *argv[])
+{
+	if (!check_default_player())
+		return;
+
+	if (g_dbus_proxy_method_call(default_player, "FastForward", NULL,
+				fast_forward_reply, NULL, NULL) == FALSE) {
+		rl_printf("Failed to jump to previous\n");
+		return;
+	}
+
+	rl_printf("Fast forward playback\n");
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -242,6 +271,8 @@ static const struct {
 	{ "stop",         NULL,       cmd_stop, "Stop playback" },
 	{ "next",         NULL,       cmd_next, "Jump to next item" },
 	{ "previous",     NULL,       cmd_previous, "Jump to previous item" },
+	{ "fast_forward", NULL,       cmd_fast_forward,
+						"Fast forward playback" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
 	{ "help" },
-- 
1.8.1.4

