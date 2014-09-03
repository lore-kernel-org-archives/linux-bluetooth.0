Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 08/10] tools/btgatt-client: Added the "write-value" command.
Date: Wed,  3 Sep 2014 12:46:09 -0700
Message-Id: <1409773571-28417-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1409773571-28417-1-git-send-email-armansito@chromium.org>
References: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added the "write-value" command which can be used to perform "write" and "write
without response" procedures.
---
 tools/btgatt-client.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index dec1a29..7b3c8ed 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -442,6 +442,133 @@ static void cmd_read_long_value(struct client *cli, char *cmd_str)
 		printf("Failed to initiate read long value procedure\n");
 }
 
+static void write_value_usage(void)
+{
+	printf("Usage: write-value [options] <value_handle> <value>\n"
+		"Options:\n"
+		"\t-w, --without-response\tWrite without response\n"
+		"e.g.:\n"
+		"\twrite-value 0x0001 00 01 00\n");
+}
+
+static struct option write_value_options[] = {
+	{ "without-response",	0, 0, 'w' },
+	{ }
+};
+
+static void write_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+	if (success) {
+		PRLOG("\nWrite successful\n");
+	} else {
+		PRLOG("\nWrite failed: 0x%02x\n", att_ecode);
+	}
+}
+
+static void cmd_write_value(struct client *cli, char *cmd_str)
+{
+	int opt, i;
+	char *argvbuf[516];
+	char **argv = argvbuf;
+	int argc = 1;
+	uint16_t handle;
+	char *endptr = NULL;
+	int length;
+	uint8_t *value = NULL;
+	bool without_response = false;
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
+	argv[0] = "write-value";
+	while ((opt = getopt_long(argc, argv, "+w", write_value_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 'w':
+			without_response = true;
+			break;
+		default:
+			write_value_usage();
+			return;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc < 1) {
+		write_value_usage();
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
+		for (i = 1; i < argc; i++) {
+			if (strlen(argv[i]) != 2) {
+				printf("Invalid value byte: %s\n",
+								argv[i]);
+				free(value);
+				return;
+			}
+
+			value[i-1] = strtol(argv[i], &endptr, 16);
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
+	if (without_response) {
+		if (!bt_gatt_client_write_without_response(cli->gatt, handle,
+							false, value, length)) {
+			printf("Failed to initiate write without response "
+								"procedure\n");
+			return;
+		}
+
+		printf("Write command sent\n");
+		return;
+	}
+
+	if (!bt_gatt_client_write_value(cli->gatt, handle, value, length,
+								write_cb,
+								NULL, NULL))
+		printf("Failed to initiate write procedure\n");
+
+	free(value);
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -454,9 +581,11 @@ static struct {
 	{ "help", cmd_help, "\tDisplay help message" },
 	{ "services", cmd_services, "\tShow discovered services" },
 	{ "read-value", cmd_read_value,
-				"\tRead a characteristic or descriptor Value" },
+				"\tRead a characteristic or descriptor value" },
 	{ "read-long-value", cmd_read_long_value,
 		"\tRead a long characteristic or desctriptor value" },
+	{ "write-value", cmd_write_value,
+			"\tWrite a characteristic or descriptor value" },
 	{ }
 };
 
-- 
2.1.0.rc2.206.gedb03e5

