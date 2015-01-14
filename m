Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] tools/btgatt-client: Add prepare and execute write
Date: Wed, 14 Jan 2015 09:17:24 +0100
Message-Id: <1421223444-9374-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1421223444-9374-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1421223444-9374-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btgatt-client.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 62c4d3e..1cfeaba 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -831,6 +831,140 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 	free(value);
 }
 
+static void write_prepare_usage(void)
+{
+	printf("Usage: write-prepare <value_handle> <offset> <value>\n"
+				"e.g.:\n"
+				"\twrite-prepare 0x0001 00 01 00\n");
+}
+
+static void cmd_write_prepare(struct client *cli, char *cmd_str)
+{
+	int i;
+	char *argvbuf[516];
+	char **argv = argvbuf;
+	int argc = 0;
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
+	if (!parse_args(cmd_str, 514, argv, &argc)) {
+		printf("Too many arguments\n");
+		write_value_usage();
+		return;
+	}
+
+	if (argc < 3) {
+		write_prepare_usage();
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
+	if (!bt_gatt_client_prepare_write(cli->gatt, handle, offset, value,
+						length, write_long_cb, NULL,
+						NULL))
+		printf("Failed to proceed prepare write\n");
+
+	free(value);
+}
+
+static void write_execute_usage(void)
+{
+	printf("Usage: write-execute <execute>\n"
+				"e.g.:\n"
+				"\twrite-execute 1\n");
+}
+
+static void cmd_write_execute(struct client *cli, char *cmd_str)
+{
+	char *argvbuf[516];
+	char **argv = argvbuf;
+	int argc = 0;
+	char *endptr = NULL;
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
+	if (argc < 1) {
+		write_execute_usage();
+		return;
+	}
+
+	execute = !!strtol(argv[0], &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		printf("Invalid execute: %s\n", argv[0]);
+		return;
+	}
+
+	if (!bt_gatt_client_write_execute(cli->gatt, execute, write_cb,
+								NULL, NULL))
+		printf("Failed to proceed write execute\n");
+}
+
 static void register_notify_usage(void)
 {
 	printf("Usage: register-notify <chrc value handle>\n");
@@ -955,6 +1089,10 @@ static struct {
 			"\tWrite a characteristic or descriptor value" },
 	{ "write-long-value", cmd_write_long_value,
 			"Write long characteristic or descriptor value" },
+	{ "write-prepare", cmd_write_prepare,
+			"Write prepare characteristic or descriptor value" },
+	{ "write-execute", cmd_write_execute,
+			"Execute already prepared write" },
 	{ "register-notify", cmd_register_notify,
 			"\tSubscribe to not/ind from a characteristic" },
 	{ "unregister-notify", cmd_unregister_notify,
-- 
1.8.4

