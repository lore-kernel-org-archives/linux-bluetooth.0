Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 4/7] tools/btgatt-client: Add command parsing.
Date: Fri, 29 Aug 2014 08:34:09 -0700
Message-Id: <1409326452-8534-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1409326452-8534-1-git-send-email-armansito@chromium.org>
References: <1409326452-8534-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added basic support for command parsing, including the "help" command. Also
added a call to bt_gatt_client_set_debug.
---
 tools/btgatt-client.c | 53 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 008cc9f..26f2d14 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -68,7 +68,7 @@ static void att_disconnect_cb(void *user_data)
 	mainloop_quit();
 }
 
-static void att_debug(const char *str, void *user_data)
+static void debug_cb(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
@@ -108,9 +108,6 @@ static struct client *client_create(int fd, uint16_t mtu)
 		return NULL;
 	}
 
-	if (verbose)
-		bt_att_set_debug(att, att_debug, "att: ", NULL);
-
 	cli->fd = fd;
 	cli->gatt = bt_gatt_client_new(att, mtu);
 	if (!cli->gatt) {
@@ -120,6 +117,12 @@ static struct client *client_create(int fd, uint16_t mtu)
 		return NULL;
 	}
 
+	if (verbose) {
+		bt_att_set_debug(att, debug_cb, "att: ", NULL);
+		bt_gatt_client_set_debug(cli->gatt, debug_cb, "gatt-client: ",
+									NULL);
+	}
+
 	/* bt_gatt_client already holds a reference */
 	bt_att_unref(att);
 
@@ -131,21 +134,55 @@ static void client_destroy(struct client *cli)
 	bt_gatt_client_unref(cli->gatt);
 }
 
+
+typedef void (*command_func_t)(struct client *cli);
+
+static void cmd_help(struct client *cli);
+
+static struct {
+	char *cmd;
+	command_func_t func;
+	char *doc;
+} command[] = {
+	{ "help", cmd_help, "\tDisplay help message" },
+	{ }
+};
+
+static void cmd_help(struct client *cli)
+{
+	int i;
+
+	printf("Commands:\n");
+	for (i = 0; command[i].cmd; i++)
+		printf("\t%-15s\t%s\n", command[i].cmd, command[i].doc);
+}
+
 static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 {
+	ssize_t read;
 	size_t len = 0;
 	char *line = NULL;
+	struct client *cli = user_data;
+	int i;
 
 	if (events & (EPOLLRDHUP | EPOLLHUP | EPOLLERR)) {
 		mainloop_quit();
 		return;
 	}
 
-	if (getline(&line, &len, stdin) == -1)
+	if ((read = getline(&line, &len, stdin)) == -1)
 		return;
 
-	/* TODO: Process commands here */
-	printf("  Typed line: %s\n", line);
+	for (i = 0; command[i].cmd; i++) {
+		if (strncmp(command[i].cmd, line, read - 1) == 0)
+			break;
+	}
+
+	if (command[i].cmd)
+		command[i].func(cli);
+	else
+		fprintf(stderr, "Unknown command: %s\n", line);
+
 	print_prompt();
 
 	free(line);
@@ -384,7 +421,7 @@ int main(int argc, char *argv[])
 
 	if (mainloop_add_fd(fileno(stdin),
 				EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLERR,
-				prompt_read_cb, NULL, NULL) < 0) {
+				prompt_read_cb, cli, NULL) < 0) {
 		fprintf(stderr, "Failed to initialize console\n");
 		return EXIT_FAILURE;
 	}
-- 
2.1.0.rc2.206.gedb03e5

