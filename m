Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 7/7] tools/btgatt-client: Add prepare and execute write
Date: Tue, 10 Mar 2015 15:04:15 +0100
Message-Id: <1425996255-12146-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1425996255-12146-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1425996255-12146-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btgatt-client.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index e2e0d15..ee5315d 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -67,6 +67,8 @@ struct client {
 	struct bt_att *att;
 	struct gatt_db *db;
 	struct bt_gatt_client *gatt;
+
+	unsigned int reliable_session_id;
 };
 
 static void print_prompt(void)
@@ -884,6 +886,208 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 	free(value);
 }
 
+static void write_prepare_usage(void)
+{
+	printf("Usage: write-prepare [options] <value_handle> <offset> "
+				"<value>\n"
+				"Options:\n"
+				"\t-s, --session-id\tSession id\n"
+				"e.g.:\n"
+				"\twrite-prepare -s 1 0x0001 00 01 00\n");
+}
+
+static struct option write_prepare_options[] = {
+	{ "session-id",		1, 0, 's' },
+	{ }
+};
+
+static void cmd_write_prepare(struct client *cli, char *cmd_str)
+{
+	int opt, i;
+	char *argvbuf[516];
+	char **argv = argvbuf;
+	int argc = 0;
+	unsigned int id = 0;
+	uint16_t handle;
+	uint16_t offset;
+	char *endptr = NULL;
+	unsigned int length;
+	uint8_t *value = NULL;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
+		printf("Too many arguments\n");
+		write_value_usage();
+		return;
+	}
+
+	/* Add command name for getopt_long */
+	argc++;
+	argv[0] = "write-prepare";
+
+	optind = 0;
+	while ((opt = getopt_long(argc, argv , "s:", write_prepare_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 's':
+			if (!optarg) {
+				write_prepare_usage();
+				return;
+			}
+
+			id = atoi(optarg);
+
+			break;
+		default:
+			write_prepare_usage();
+			return;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc < 3) {
+		write_prepare_usage();
+		return;
+	}
+
+	if (cli->reliable_session_id != id) {
+		printf("Session id != Ongoing session id (%u!=%u)\n", id,
+						cli->reliable_session_id);
+		return;
+	}
+
+	handle = strtol(argv[0], &endptr, 0);
+	if (!endptr || *endptr != '\0' || !handle) {
+		printf("Invalid handle: %s\n", argv[0]);
+		return;
+	}
+
+	endptr = NULL;
+	offset = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || errno == ERANGE) {
+		printf("Invalid offset: %s\n", argv[1]);
+		return;
+	}
+
+	/*
+	 * First two arguments are handle and offset. What remains is the value
+	 * length
+	 */
+	length = argc - 2;
+
+	if (length == 0)
+		goto done;
+
+	if (length > UINT16_MAX) {
+		printf("Write value too long\n");
+		return;
+	}
+
+	value = malloc(length);
+	if (!value) {
+		printf("Failed to allocate memory for value\n");
+		return;
+	}
+
+	for (i = 2; i < argc; i++) {
+		if (strlen(argv[i]) != 2) {
+			printf("Invalid value byte: %s\n", argv[i]);
+			free(value);
+			return;
+		}
+
+		value[i-2] = strtol(argv[i], &endptr, 0);
+		if (endptr == argv[i] || *endptr != '\0' || errno == ERANGE) {
+			printf("Invalid value byte: %s\n", argv[i]);
+			free(value);
+			return;
+		}
+	}
+
+done:
+	cli->reliable_session_id =
+			bt_gatt_client_prepare_write(cli->gatt, id,
+							handle, offset,
+							value, length,
+							write_long_cb, NULL,
+							NULL);
+	if (!cli->reliable_session_id)
+		printf("Failed to proceed prepare write\n");
+	else
+		printf("Prepare write success.\n"
+				"Session id: %d to be used on next write\n",
+						cli->reliable_session_id);
+
+	free(value);
+}
+
+static void write_execute_usage(void)
+{
+	printf("Usage: write-execute <session_id> <execute>\n"
+				"e.g.:\n"
+				"\twrite-execute 1 0\n");
+}
+
+static void cmd_write_execute(struct client *cli, char *cmd_str)
+{
+	char *argvbuf[516];
+	char **argv = argvbuf;
+	int argc = 0;
+	char *endptr = NULL;
+	unsigned int session_id;
+	bool execute;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 514, argv, &argc)) {
+		printf("Too many arguments\n");
+		write_value_usage();
+		return;
+	}
+
+	if (argc < 2) {
+		write_execute_usage();
+		return;
+	}
+
+	session_id = strtol(argv[0], &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		printf("Invalid session id: %s\n", argv[0]);
+		return;
+	}
+
+	if (session_id != cli->reliable_session_id) {
+		printf("Invalid session id: %u != %u\n", session_id,
+						cli->reliable_session_id);
+		return;
+	}
+
+	execute = !!strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		printf("Invalid execute: %s\n", argv[1]);
+		return;
+	}
+
+	if (execute) {
+		if (!bt_gatt_client_write_execute(cli->gatt, session_id,
+							write_cb, NULL, NULL))
+			printf("Failed to proceed write execute\n");
+	} else {
+		bt_gatt_client_cancel(cli->gatt, session_id);
+	}
+
+	cli->reliable_session_id = 0;
+}
+
 static void register_notify_usage(void)
 {
 	printf("Usage: register-notify <chrc value handle>\n");
@@ -1130,6 +1334,10 @@ static struct {
 			"\tWrite a characteristic or descriptor value" },
 	{ "write-long-value", cmd_write_long_value,
 			"Write long characteristic or descriptor value" },
+	{ "write-prepare", cmd_write_prepare,
+			"\tWrite prepare characteristic or descriptor value" },
+	{ "write-execute", cmd_write_execute,
+			"\tExecute already prepared write" },
 	{ "register-notify", cmd_register_notify,
 			"\tSubscribe to not/ind from a characteristic" },
 	{ "unregister-notify", cmd_unregister_notify,
-- 
1.8.4

