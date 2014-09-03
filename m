Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 09/10] tools/btgatt-client: Added the "write-long-value" command.
Date: Wed,  3 Sep 2014 12:46:10 -0700
Message-Id: <1409773571-28417-10-git-send-email-armansito@chromium.org>
In-Reply-To: <1409773571-28417-1-git-send-email-armansito@chromium.org>
References: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added the "write-long-value" command which can be used to perform the "long
write" procedure.
---
 tools/btgatt-client.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 7b3c8ed..3fd492b 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -569,6 +569,134 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 	free(value);
 }
 
+static void write_long_value_usage(void)
+{
+	printf("Usage: write-long-value [options] <value_handle> <offset> "
+				"<value>\n"
+				"Options:\n"
+				"\t-r, --reliable-write\tReliable write\n"
+				"e.g.:\n"
+				"\twrite-long-value 0x0001 0 00 01 00\n");
+}
+
+static struct option write_long_value_options[] = {
+	{ "reliable-write",	0, 0, 'r' },
+	{ }
+};
+
+static void write_long_cb(bool success, bool reliable_error, uint8_t att_ecode,
+								void *user_data)
+{
+	if (success) {
+		PRLOG("Write successful\n");
+	} else if (reliable_error) {
+		PRLOG("Reliable write not verified\n");
+	} else {
+		PRLOG("Write failed: 0x%02x\n", att_ecode);
+	}
+}
+
+static void cmd_write_long_value(struct client *cli, char *cmd_str)
+{
+	int opt, i;
+	char *argvbuf[516];
+	char **argv = argvbuf;
+	int argc = 1;
+	uint16_t handle;
+	uint16_t offset;
+	char *endptr = NULL;
+	int length;
+	uint8_t *value = NULL;
+	bool reliable_writes = false;
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
+	optind = 0;
+	argv[0] = "write-long-value";
+	while ((opt = getopt_long(argc, argv, "+r", write_long_value_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 'r':
+			reliable_writes = true;
+			break;
+		default:
+			write_long_value_usage();
+			return;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc < 2) {
+		write_long_value_usage();
+		return;
+	}
+
+	handle = strtol(argv[0], &endptr, 16);
+	if (!endptr || *endptr != '\0' || !handle) {
+		printf("Invalid handle: %s\n", argv[0]);
+		return;
+	}
+
+	endptr = NULL;
+	offset = strtol(argv[1], &endptr, 10);
+	if (!endptr || *endptr != '\0' || errno == ERANGE) {
+		printf("Invalid offset: %s\n", argv[1]);
+		return;
+	}
+
+	length = argc - 1;
+
+	if (length > 0) {
+		if (length > UINT16_MAX) {
+			printf("Write value too long\n");
+			return;
+		}
+
+		value = malloc(length);
+		if (!value) {
+			printf("Failed to construct write value\n");
+			return;
+		}
+
+		for (i = 2; i < argc; i++) {
+			if (strlen(argv[i]) != 2) {
+				printf("Invalid value byte: %s\n",
+								argv[i]);
+				free(value);
+				return;
+			}
+
+			value[i-2] = strtol(argv[i], &endptr, 16);
+			if (endptr == argv[i] || *endptr != '\0'
+							|| errno == ERANGE) {
+				printf("Invalid value byte: %s\n",
+								argv[i]);
+				free(value);
+				return;
+			}
+		}
+	}
+
+	if (!bt_gatt_client_write_long_value(cli->gatt, reliable_writes, handle,
+							offset, value, length,
+							write_long_cb,
+							NULL, NULL))
+		printf("Failed to initiate long write procedure\n");
+
+	free(value);
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -586,6 +714,8 @@ static struct {
 		"\tRead a long characteristic or desctriptor value" },
 	{ "write-value", cmd_write_value,
 			"\tWrite a characteristic or descriptor value" },
+	{ "write-long-value", cmd_write_long_value,
+			"Write long characteristic or descriptor value" },
 	{ }
 };
 
-- 
2.1.0.rc2.206.gedb03e5

