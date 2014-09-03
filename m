Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 07/10] tools/btgatt-client: Added the "read-long-value" command.
Date: Wed,  3 Sep 2014 12:46:08 -0700
Message-Id: <1409773571-28417-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1409773571-28417-1-git-send-email-armansito@chromium.org>
References: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added the "read-long-value" command which can be used to read long
characteristic and descriptor values.
---
 tools/btgatt-client.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index e0c48be..dec1a29 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -401,6 +401,47 @@ static void cmd_read_value(struct client *cli, char *cmd_str)
 		printf("Failed to initiate read value procedure\n");
 }
 
+static void read_long_value_usage(void)
+{
+	printf("Usage: read-long-value <value_handle> <offset>\n");
+}
+
+static void cmd_read_long_value(struct client *cli, char *cmd_str)
+{
+	char *argv[3];
+	int argc = 0;
+	uint16_t handle;
+	uint16_t offset;
+	char *endptr = NULL;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 2, argv, &argc) || argc != 2) {
+		read_long_value_usage();
+		return;
+	}
+
+	handle = strtol(argv[0], &endptr, 16);
+	if (!endptr || *endptr != '\0' || !handle) {
+		printf("Invalid value handle: %s\n", argv[0]);
+		return;
+	}
+
+	endptr = NULL;
+	offset = strtol(argv[1], &endptr, 16);
+	if (!endptr || *endptr != '\0' || !handle) {
+		printf("Invalid offset: %s\n", argv[1]);
+		return;
+	}
+
+	if (!bt_gatt_client_read_long_value(cli->gatt, handle, offset, read_cb,
+								NULL, NULL))
+		printf("Failed to initiate read long value procedure\n");
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -414,6 +455,8 @@ static struct {
 	{ "services", cmd_services, "\tShow discovered services" },
 	{ "read-value", cmd_read_value,
 				"\tRead a characteristic or descriptor Value" },
+	{ "read-long-value", cmd_read_long_value,
+		"\tRead a long characteristic or desctriptor value" },
 	{ }
 };
 
-- 
2.1.0.rc2.206.gedb03e5

