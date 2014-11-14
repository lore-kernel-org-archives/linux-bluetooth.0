Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 4/6] tools/btgatt-server: Add command support and the notify command.
Date: Fri, 14 Nov 2014 12:20:26 -0800
Message-Id: <1415996428-17528-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1415996428-17528-1-git-send-email-armansito@chromium.org>
References: <1415996428-17528-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a command REPL and introduces the "notify" command which
allows sending notifications and indications.
---
 tools/btgatt-server.c | 230 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 6a63018..c873278 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -26,6 +26,7 @@
 #include <stdlib.h>
 #include <getopt.h>
 #include <unistd.h>
+#include <errno.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -499,6 +500,217 @@ fail:
 	return -1;
 }
 
+static void notify_usage(void)
+{
+	printf("Usage: notify [options] <value_handle> <value>\n"
+					"Options:\n"
+					"\t -i, --indicate\tSend indication\n"
+					"e.g.:\n"
+					"\tnotify 0x0001 00 01 00\n");
+}
+
+static struct option notify_options[] = {
+	{ "indicate",	0, 0, 'i' },
+	{ }
+};
+
+static bool parse_args(char *str, int expected_argc,  char **argv, int *argc)
+{
+	char **ap;
+
+	for (ap = argv; (*ap = strsep(&str, " \t")) != NULL;) {
+		if (**ap == '\0')
+			continue;
+
+		(*argc)++;
+		ap++;
+
+		if (*argc > expected_argc)
+			return false;
+	}
+
+	return true;
+}
+
+static void conf_cb(void *user_data)
+{
+	PRLOG("Received confirmation\n");
+}
+
+static void cmd_notify(struct server *server, char *cmd_str)
+{
+	int opt, i;
+	char *argvbuf[516];
+	char **argv = argvbuf;
+	int argc = 1;
+	uint16_t handle;
+	char *endptr = NULL;
+	int length;
+	uint8_t *value = NULL;
+	bool indicate = false;
+
+	if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
+		printf("Too many arguments\n");
+		notify_usage();
+		return;
+	}
+
+	optind = 0;
+	argv[0] = "notify";
+	while ((opt = getopt_long(argc, argv, "+i", notify_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 'i':
+			indicate = true;
+			break;
+		default:
+			notify_usage();
+			return;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc < 1) {
+		notify_usage();
+		return;
+	}
+
+	handle = strtol(argv[0], &endptr, 16);
+	if (!endptr || *endptr != '\0' || !handle) {
+		printf("Invalid handle: %s\n", argv[0]);
+		return;
+	}
+
+	length = argc - 1;
+
+	if (length > 0) {
+		if (length > UINT16_MAX) {
+			printf("Value too long\n");
+			return;
+		}
+
+		value = malloc(length);
+		if (!value) {
+			printf("Failed to construct value\n");
+			return;
+		}
+
+		for (i = 1; i < argc; i++) {
+			if (strlen(argv[i]) != 2) {
+				printf("Invalid value byte: %s\n",
+								argv[i]);
+				goto done;
+			}
+
+			value[i-1] = strtol(argv[i], &endptr, 16);
+			if (endptr == argv[i] || *endptr != '\0'
+							|| errno == ERANGE) {
+				printf("Invalid value byte: %s\n",
+								argv[i]);
+				goto done;
+			}
+		}
+	}
+
+	if (indicate) {
+		if (!bt_gatt_server_send_indication(server->gatt, handle,
+							value, length,
+							conf_cb, NULL, NULL))
+			printf("Failed to initiate indication\n");
+	} else if (!bt_gatt_server_send_notification(server->gatt, handle,
+								value, length))
+		printf("Failed to initiate notification\n");
+
+done:
+	free(value);
+}
+
+static void cmd_help(struct server *server, char *cmd_str);
+
+typedef void (*command_func_t)(struct server *server, char *cmd_str);
+
+static struct {
+	char *cmd;
+	command_func_t func;
+	char *doc;
+} command[] = {
+	{ "help", cmd_help, "\tDisplay help message" },
+	{ "notify", cmd_notify, "\tSend handle-value notification" },
+	{ }
+};
+
+static void cmd_help(struct server *server, char *cmd_str)
+{
+	int i;
+
+	printf("Commands:\n");
+	for (i = 0; command[i].cmd; i++)
+		printf("\t%-15s\t%s\n", command[i].cmd, command[i].doc);
+}
+
+static void prompt_read_cb(int fd, uint32_t events, void *user_data)
+{
+	ssize_t read;
+	size_t len = 0;
+	char *line = NULL;
+	char *cmd = NULL, *args;
+	struct server *server = user_data;
+	int i;
+
+	if (events & (EPOLLRDHUP | EPOLLHUP | EPOLLERR)) {
+		mainloop_quit();
+		return;
+	}
+
+	if ((read = getline(&line, &len, stdin)) == -1)
+		return;
+
+	if (read <= 1) {
+		cmd_help(server, NULL);
+		print_prompt();
+		return;
+	}
+
+	line[read-1] = '\0';
+	args = line;
+
+	while ((cmd = strsep(&args, " \t")))
+		if (*cmd != '\0')
+			break;
+
+	if (!cmd)
+		goto failed;
+
+	for (i = 0; command[i].cmd; i++) {
+		if (strcmp(command[i].cmd, cmd) == 0)
+			break;
+	}
+
+	if (command[i].cmd)
+		command[i].func(server, args);
+	else
+		fprintf(stderr, "Unknown command: %s\n", line);
+
+failed:
+	print_prompt();
+
+	free(line);
+}
+
+static void signal_cb(int signum, void *user_data)
+{
+	switch (signum) {
+	case SIGINT:
+	case SIGTERM:
+		mainloop_quit();
+		break;
+	default:
+		break;
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	int opt;
@@ -507,6 +719,7 @@ int main(int argc, char *argv[])
 	int fd;
 	int sec = BT_SECURITY_LOW;
 	uint16_t mtu = 0;
+	sigset_t mask;
 	struct server *server;
 
 	while ((opt = getopt_long(argc, argv, "+hvs:m:i:",
@@ -591,8 +804,25 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
+	if (mainloop_add_fd(fileno(stdin),
+				EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLERR,
+				prompt_read_cb, server, NULL) < 0) {
+		fprintf(stderr, "Failed to initialize console\n");
+		server_destroy(server);
+
+		return EXIT_FAILURE;
+	}
+
 	printf("Running GATT server\n");
 
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+
+	mainloop_set_signal(&mask, signal_cb, NULL, NULL);
+
+	print_prompt();
+
 	mainloop_run();
 
 	printf("\n\nShutting down...\n");
-- 
2.1.0.rc2.206.gedb03e5

