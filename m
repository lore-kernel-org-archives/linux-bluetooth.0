Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 5/7] tools/btgatt-client: Add the "register-notify" command.
Date: Mon,  8 Sep 2014 18:03:09 -0700
Message-Id: <1410224591-5402-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1410224591-5402-1-git-send-email-armansito@chromium.org>
References: <1410224591-5402-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the "register-notify" command, which registers a
notification/indication handler for a given characteristic value handle.
---
 tools/btgatt-client.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 8bde1ee..f95cc9c 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -702,6 +702,74 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 	free(value);
 }
 
+static void register_notify_usage(void)
+{
+	printf("Usage: register-notify <chrc value handle>\n");
+}
+
+static void notify_cb(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	int i;
+
+	printf("\n\tHandle Value Not/Ind: 0x%04x - ", value_handle);
+
+	if (length == 0) {
+		PRLOG("(0 bytes)\n");
+		return;
+	}
+
+	printf("(%u bytes): ", length);
+
+	for (i = 0; i < length; i++)
+		printf("%02x ", value[i]);
+
+	PRLOG("\n");
+}
+
+static void register_notify_cb(unsigned int id, uint16_t att_ecode,
+								void *user_data)
+{
+	if (!id) {
+		PRLOG("Failed to register notify handler "
+					"- error code: 9x%02x\n", att_ecode);
+		return;
+	}
+
+	PRLOG("Registered notify handler with id: %u\n", id);
+}
+
+static void cmd_register_notify(struct client *cli, char *cmd_str)
+{
+	char *argv[2];
+	int argc = 0;
+	uint16_t value_handle;
+	char *endptr = NULL;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 1, argv, &argc) || argc != 1) {
+		register_notify_usage();
+		return;
+	}
+
+	value_handle = strtol(argv[0], &endptr, 16);
+	if (!endptr || *endptr != '\0' || !value_handle) {
+		printf("Invalid value handle: %s\n", argv[0]);
+		return;
+	}
+
+	if (!bt_gatt_client_register_notify(cli->gatt, value_handle,
+							register_notify_cb,
+							notify_cb, NULL, NULL))
+		printf("Failed to register notify handler\n");
+
+	printf("\n");
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -721,6 +789,8 @@ static struct {
 			"\tWrite a characteristic or descriptor value" },
 	{ "write-long-value", cmd_write_long_value,
 			"Write long characteristic or descriptor value" },
+	{ "register-notify", cmd_register_notify,
+			"\tSubscribe to not/ind from a characteristic" },
 	{ }
 };
 
-- 
2.1.0.rc2.206.gedb03e5

