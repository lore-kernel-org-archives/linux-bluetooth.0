Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] tools/btgatt-client: Add read_multiple_cmd
Date: Wed, 19 Nov 2014 14:01:29 +0100
Message-Id: <1416402095-5137-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btgatt-client.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 7a1204f..ca84780 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -401,6 +401,65 @@ static void cmd_services(struct client *cli, char *cmd_str)
 		services_usage();
 }
 
+static void read_multiple_usage(void)
+{
+	printf("Usage: read-multiple <handle_1> <handle_2> ...\n");
+}
+
+static void read_multiple_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	int i;
+
+	if (!success) {
+		PRLOG("\nRead multiple request failed: 0x%02x\n", att_ecode);
+		return;
+	}
+
+	printf("\nRead multiple value (%u bytes):", length);
+
+	for (i = 0; i < length; i++)
+		printf("%02x ", value[i]);
+
+	PRLOG("\n");
+}
+
+static void cmd_read_multiple(struct client *cli, char *cmd_str)
+{
+	int argc = 0;
+	uint16_t *value;
+	char *argv[512];
+	int i;
+	char *endptr = NULL;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, sizeof(argv), argv, &argc) || argc < 2) {
+		read_multiple_usage();
+		return;
+	}
+
+	value = malloc(sizeof(uint16_t) * argc);
+
+	for (i = 0; i < argc; i++) {
+		value[i] = strtol(argv[i], &endptr, 0);
+		if (endptr == argv[i] || *endptr != '\0' || !value[i]) {
+			printf("Invalid value byte: %s\n", argv[i]);
+			return;
+		}
+	}
+
+	if (!bt_gatt_client_read_multiple(cli->gatt, value, argc,
+						read_multiple_cb, NULL, NULL))
+		printf("Failed to initiate read multiple procedure\n");
+
+	free(value);
+}
+
 static void read_value_usage(void)
 {
 	printf("Usage: read-value <value_handle>\n");
@@ -873,6 +932,7 @@ static struct {
 				"\tRead a characteristic or descriptor value" },
 	{ "read-long-value", cmd_read_long_value,
 		"\tRead a long characteristic or desctriptor value" },
+	{ "read-multiple", cmd_read_multiple, "\tRead Multiple" },
 	{ "write-value", cmd_write_value,
 			"\tWrite a characteristic or descriptor value" },
 	{ "write-long-value", cmd_write_long_value,
-- 
1.9.3

