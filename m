Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 14/14] client/bluetooth-player: Add select command
Date: Fri, 31 May 2013 13:55:49 +0300
Message-Id: <1369997749-8663-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for select command which can be used to set the default
player
---
 client/bluetooth-player.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index 3e25bba..3daf586 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -438,6 +438,28 @@ static void cmd_show(int argc, char *argv[])
 	print_property(proxy, "Track");
 }
 
+static void cmd_select(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 2) {
+		rl_printf("Missing player address argument\n");
+		return;
+	}
+
+	proxy = find_player(argv[1]);
+	if (proxy == NULL) {
+		rl_printf("Player %s not available\n", argv[1]);
+		return;
+	}
+
+	if (default_player == proxy)
+		return;
+
+	default_player = proxy,
+	print_player(proxy, NULL);
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -446,6 +468,7 @@ static const struct {
 } cmd_table[] = {
 	{ "list",         NULL,       cmd_list, "List available players" },
 	{ "show",         "[player]", cmd_show, "Player information" },
+	{ "select",       "<player>", cmd_select, "Select default player" },
 	{ "play",         NULL,       cmd_play, "Start playback" },
 	{ "pause",        NULL,       cmd_pause, "Pause playback" },
 	{ "stop",         NULL,       cmd_stop, "Stop playback" },
-- 
1.8.1.4

