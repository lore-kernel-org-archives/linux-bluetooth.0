Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 5/7] tools/btgatt-client: Add "ready" handler.
Date: Fri, 29 Aug 2014 08:34:10 -0700
Message-Id: <1409326452-8534-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1409326452-8534-1-git-send-email-armansito@chromium.org>
References: <1409326452-8534-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added a ready handler which gets called by bt_gatt_client when the MTU exchange
and service discovery procedures complete. Also added some (bad) coloring for
verbose output.
---
 tools/btgatt-client.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 26f2d14..6299586 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -45,8 +45,17 @@
 
 #define ATT_CID 4
 
-#define PRLOG(format, ...) \
-	printf(format, __VA_ARGS__); print_prompt();
+#define PRLOG(...) \
+	printf(__VA_ARGS__); print_prompt();
+
+#define COLOR_OFF	"\x1B[0m"
+#define COLOR_RED	"\x1B[0;91m"
+#define COLOR_GREEN	"\x1B[0;92m"
+#define COLOR_YELLOW	"\x1B[0;93m"
+#define COLOR_BLUE	"\x1B[0;94m"
+#define COLOR_MAGENTA	"\x1B[0;95m"
+#define COLOR_BOLDGRAY	"\x1B[1;30m"
+#define COLOR_BOLDWHITE	"\x1B[1;37m"
 
 static bool verbose = false;
 
@@ -57,7 +66,7 @@ struct client {
 
 static void print_prompt(void)
 {
-	printf("[GATT client]# ");
+	printf(COLOR_BLUE "[GATT client]" COLOR_OFF "# ");
 	fflush(stdout);
 }
 
@@ -68,13 +77,22 @@ static void att_disconnect_cb(void *user_data)
 	mainloop_quit();
 }
 
-static void debug_cb(const char *str, void *user_data)
+static void att_debug_cb(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
-	PRLOG("%s%s\n", prefix, str);
+	PRLOG(COLOR_BOLDGRAY "%s" COLOR_BOLDWHITE "%s\n" COLOR_OFF, prefix, str);
 }
 
+static void gatt_debug_cb(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	PRLOG(COLOR_GREEN "%s%s\n" COLOR_OFF, prefix, str);
+}
+
+static void ready_cb(bool success, uint8_t att_ecode, void *user_data);
+
 static struct client *client_create(int fd, uint16_t mtu)
 {
 	struct client *cli;
@@ -118,11 +136,13 @@ static struct client *client_create(int fd, uint16_t mtu)
 	}
 
 	if (verbose) {
-		bt_att_set_debug(att, debug_cb, "att: ", NULL);
-		bt_gatt_client_set_debug(cli->gatt, debug_cb, "gatt-client: ",
+		bt_att_set_debug(att, att_debug_cb, "att: ", NULL);
+		bt_gatt_client_set_debug(cli->gatt, gatt_debug_cb, "gatt: ",
 									NULL);
 	}
 
+	bt_gatt_client_set_ready_handler(cli->gatt, ready_cb, cli, NULL);
+
 	/* bt_gatt_client already holds a reference */
 	bt_att_unref(att);
 
@@ -134,11 +154,21 @@ static void client_destroy(struct client *cli)
 	bt_gatt_client_unref(cli->gatt);
 }
 
+static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+	if (!success) {
+		PRLOG("GATT discovery procedures failed - error code: 0x02%x\n",
+								att_ecode);
+		return;
+	}
 
-typedef void (*command_func_t)(struct client *cli);
+	PRLOG("GATT discovery procedures complete\n");
+}
 
 static void cmd_help(struct client *cli);
 
+typedef void (*command_func_t)(struct client *cli);
+
 static struct {
 	char *cmd;
 	command_func_t func;
@@ -178,6 +208,8 @@ static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 			break;
 	}
 
+	print_prompt();
+
 	if (command[i].cmd)
 		command[i].func(cli);
 	else
-- 
2.1.0.rc2.206.gedb03e5

