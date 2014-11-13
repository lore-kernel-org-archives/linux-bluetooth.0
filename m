Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 02/11] tools/btgatt-client: Add read-by-uuid cmd
Date: Thu, 13 Nov 2014 12:27:04 +0100
Message-Id: <1415878033-6766-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1415878033-6766-1-git-send-email-marcin.kraglak@tieto.com>
References: <1415878033-6766-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is used to read characteristic values with known UUID.
---
 tools/btgatt-client.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 7a1204f..f069189 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -401,6 +401,89 @@ static void cmd_services(struct client *cli, char *cmd_str)
 		services_usage();
 }
 
+static void read_by_uuid_usage(void)
+{
+	printf("Usage: read-by-uuid <start_handle> <end_handle> <uuid>\n");
+}
+
+static void read_by_uuid_cb(bool success, uint8_t att_ecode,
+			struct read_by_uuid_res *result, void *user_data)
+{
+	uint16_t handle;
+	uint8_t length;
+	uint8_t *data;
+	int i;
+
+	if (!success) {
+		PRLOG("\nRead by UUID request failed: 0x%02x\n", att_ecode);
+		return;
+	}
+
+	if (!result) {
+		PRLOG("\nNo attribute found\n");
+		return;
+	}
+
+	for (; result; result = read_by_uuid_res_next(result)) {
+		read_by_uuid_res_get(result, &handle, &length, &data);
+		printf("\nHandle 0x%04X Read value", handle);
+
+		if (length == 0) {
+			PRLOG(": 0 bytes\n");
+			return;
+		}
+
+		printf(" (%u bytes): ", length);
+
+		for (i = 0; i < length; i++)
+			printf("%02x ", data[i]);
+
+		PRLOG("\n");
+	}
+}
+
+static void cmd_read_by_uuid(struct client *cli, char *cmd_str)
+{
+	char *argv[3];
+	int argc = 0;
+	uint16_t start_handle, end_handle;
+	bt_uuid_t tmp, uuid;
+	char *endptr = NULL;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 3, argv, &argc) || argc != 3) {
+		read_by_uuid_usage();
+		return;
+	}
+
+	start_handle = strtol(argv[0], &endptr, 0);
+	if (!endptr || *endptr != '\0' || !start_handle) {
+		printf("Invalid value handle: %s\n", argv[0]);
+		return;
+	}
+
+	end_handle = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || !end_handle) {
+		printf("Invalid value handle: %s\n", argv[1]);
+		return;
+	}
+
+	if (bt_string_to_uuid(&tmp, argv[2]) < 0) {
+		printf("Invalid UUID: %s\n", argv[2]);
+		return;
+	}
+
+	bt_uuid_to_uuid128(&tmp, &uuid);
+
+	if (!bt_gatt_client_read_by_uuid(cli->gatt, start_handle, end_handle,
+			uuid.value.u128.data, read_by_uuid_cb, NULL, NULL))
+		printf("Failed to initiate read value procedure\n");
+}
+
 static void read_value_usage(void)
 {
 	printf("Usage: read-value <value_handle>\n");
@@ -873,6 +956,7 @@ static struct {
 				"\tRead a characteristic or descriptor value" },
 	{ "read-long-value", cmd_read_long_value,
 		"\tRead a long characteristic or desctriptor value" },
+	{ "read-by-uuid", cmd_read_by_uuid, "\tRead by UUID" },
 	{ "write-value", cmd_write_value,
 			"\tWrite a characteristic or descriptor value" },
 	{ "write-long-value", cmd_write_long_value,
-- 
1.9.3

