Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/14] client/bluetooth-player: Add list command
Date: Fri, 31 May 2013 13:55:47 +0300
Message-Id: <1369997749-8663-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for list command which can be used to list available players
---
 client/bluetooth-player.c | 59 ++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index 373c49e..7cfaa17 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -289,12 +289,47 @@ static void cmd_rewind(int argc, char *argv[])
 	rl_printf("Rewind playback\n");
 }
 
+static char *player_description(GDBusProxy *proxy, const char *description)
+{
+	const char *path;
+
+	path = g_dbus_proxy_get_path(proxy);
+
+	return g_strdup_printf("%s%s%sPlayer %s ",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					path);
+}
+
+static void print_player(GDBusProxy *proxy, const char *description)
+{
+	char *str;
+
+	str = player_description(proxy, description);
+
+	rl_printf("%s%s\n", str, default_player == proxy ? "[default]" : "");
+
+	g_free(str);
+}
+
+static void cmd_list(int argc, char *arg[])
+{
+	GSList *l;
+
+	for (l = players; l; l = g_slist_next(l)) {
+		GDBusProxy *proxy = l->data;
+		print_player(proxy, NULL);
+	}
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
 	void (*func) (int argc, char *argv[]);
 	const char *desc;
 } cmd_table[] = {
+	{ "list",         NULL,       cmd_list, "List available players" },
 	{ "play",         NULL,       cmd_play, "Start playback" },
 	{ "pause",        NULL,       cmd_pause, "Pause playback" },
 	{ "stop",         NULL,       cmd_stop, "Stop playback" },
@@ -515,30 +550,6 @@ static guint setup_standard_input(void)
 	return source;
 }
 
-static char *player_description(GDBusProxy *proxy, const char *description)
-{
-	const char *path;
-
-	path = g_dbus_proxy_get_path(proxy);
-
-	return g_strdup_printf("%s%s%sPlayer %s ",
-					description ? "[" : "",
-					description ? : "",
-					description ? "] " : "",
-					path);
-}
-
-static void print_player(GDBusProxy *proxy, const char *description)
-{
-	char *str;
-
-	str = player_description(proxy, description);
-
-	rl_printf("%s%s\n", str, default_player == proxy ? "[default]" : "");
-
-	g_free(str);
-}
-
 static void player_added(GDBusProxy *proxy)
 {
 	players = g_slist_append(players, proxy);
-- 
1.8.1.4

