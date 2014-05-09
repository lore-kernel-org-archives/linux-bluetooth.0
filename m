Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v1 10/10] tools/btatt: Add "find-by-type-value" command.
Date: Fri,  9 May 2014 13:14:00 -0700
Message-Id: <1399666440-14078-11-git-send-email-armansito@chromium.org>
In-Reply-To: <1399666440-14078-1-git-send-email-armansito@chromium.org>
References: <1399666440-14078-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added command for the "Find By Type Value" request. Sample runs:

$ btatt -d 00:02:5B:00:15:10 -v find-by-type-value 0x0001 0xffff
att: ATT command 0x06
att: < 06 01 00 ff ff 00 28
att: > 01 06 01 00 0a
Error response:
	opcode: 0x06
	handle: 0x0001
	error: 0x0a

$ btatt -d 00:02:5B:00:15:10 -v find-by-type-value 0x0001 0xffff 01 18
att: ATT command 0x06
att: < 06 01 00 ff ff 00 28 01 08
att: > 07 08 00 08 00
Find By Type Value response:
	Handle Information List:
		Attr Handle: 0x0008, Grp End Handle: 0x0008
---
 tools/btatt.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 2 deletions(-)

diff --git a/tools/btatt.c b/tools/btatt.c
index a6aa281..0867d9b 100644
--- a/tools/btatt.c
+++ b/tools/btatt.c
@@ -29,6 +29,7 @@
 #include <stdio.h>
 #include <getopt.h>
 #include <string.h>
+#include <errno.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
@@ -51,8 +52,11 @@ static void handle_error(const void *param, uint16_t len)
 		return;
 	}
 
-	printf("Request failed:\n\topcode:\t%u\n\thandle:\t%u\n\terror:\t%u\n",
-			rp->request_opcode, rp->handle, rp->error_code);
+	printf("Error response:\n"
+				"\topcode:\t0x%02x\n"
+				"\thandle:\t0x%04x\n"
+				"\terror:\t0x%02x\n",
+				rp->request_opcode, rp->handle, rp->error_code);
 }
 
 static void exchange_mtu_cb(uint8_t opcode, const void *param,
@@ -257,6 +261,159 @@ static void cmd_find_info(struct bt_att *att, int argc, char **argv)
 	}
 }
 
+static void find_by_type_val_cb(uint8_t opcode, const void *param,
+						uint16_t len, void *user_data)
+{
+	const struct bt_att_find_by_type_value_rsp_param *rp;
+	uint16_t att_handle, grp_handle;
+	const uint8_t *data_ptr;
+	int num_handle_infos;
+	int i;
+
+	if (opcode == ATT_OP_ERROR_RESP) {
+		handle_error(param, len);
+		goto done;
+	}
+
+	if (opcode != ATT_OP_FIND_BY_TYPE_VALUE_RESP) {
+		fprintf(stderr, "Invalid response opcode (0x%02x)\n", opcode);
+		goto done;
+	}
+
+	rp = param;
+
+	if (len != sizeof(*rp)) {
+		fprintf(stderr, "Invalid \"Find By Type Value\" response length"
+								" (%u)\n", len);
+		goto done;
+	}
+
+	if (rp->length == 0) {
+		fprintf(stderr, "\"Handle Info. List\" field is empty!\n");
+		goto done;
+	}
+
+	if (rp->length % 4) {
+		fprintf(stderr, "Malformed response\n");
+		goto done;
+	}
+
+	num_handle_infos = rp->length / 4;
+
+	printf("Find By Type Value response:\n");
+	printf("\tHandle Information List:\n");
+
+	data_ptr = rp->handles_information_list;
+	for (i = 0; i < num_handle_infos; i++) {
+		printf("\t\tAttr Handle: 0x%04x, Grp End Handle: 0x%04x\n",
+							get_le16(data_ptr),
+							get_le16(data_ptr + 2));
+
+		data_ptr += 4;
+	}
+
+done:
+	mainloop_quit();
+}
+
+static void find_by_type_val_usage(void)
+{
+	printf("Usage: btatt find-by-type-value <start handle> <end handle> "
+							"<uuid> <value>\n");
+
+	printf("e.g. btatt find-by-type-value 0x0001 0xFFFF 0x280C 00 01\n");
+}
+
+static struct option find_by_type_val_options[] = {
+	{ "help",	0, 0, 'h'},
+	{}
+};
+
+static void cmd_find_by_type_val(struct bt_att *att, int argc, char **argv)
+{
+	struct bt_att_find_by_type_value_req_param param;
+	uint16_t start, end, type, length;
+	uint8_t *value = NULL;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "+h", find_by_type_val_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+		default:
+			find_by_type_val_usage();
+			exit(EXIT_SUCCESS);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc < 3) {
+		find_by_type_val_usage();
+		exit(EXIT_FAILURE);
+	}
+
+	start = strtol(argv[0], NULL, 0);
+	if (!start) {
+		fprintf(stderr, "Invalid start handle: %s\n", argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
+	end = strtol(argv[1], NULL, 0);
+	if (!end) {
+		fprintf(stderr, "Invalid end handle: %s\n", argv[1]);
+		exit(EXIT_FAILURE);
+	}
+
+	type = strtol(argv[2], NULL, 0);
+	if (!type) {
+		fprintf(stderr, "Invalid 16-bit UUID: %s\n", argv[2]);
+		exit(EXIT_FAILURE);
+	}
+
+	length = argc - 3;
+
+	if (length > 0) {
+		int i;
+
+		value = malloc(length);
+
+		for (i = 3; i < argc; i++) {
+			if (strlen(argv[i]) != 2) {
+				fprintf(stderr, "Invalid value byte: %s\n",
+								argv[i]);
+				free(value);
+				exit(EXIT_FAILURE);
+			}
+
+			value[i-3] = strtol(argv[i], NULL, 16);
+			if (errno) {
+				perror("Error parsing value");
+				free(value);
+				exit(EXIT_FAILURE);
+			}
+		}
+	}
+
+	memset(&param, 0, sizeof(param));
+	param.start_handle = start;
+	param.end_handle = end;
+	param.type = type;
+	param.value = value;
+	param.length = length;
+
+	if (!bt_att_send(att, ATT_OP_FIND_BY_TYPE_VALUE_REQ, &param,
+			sizeof(param), find_by_type_val_cb, NULL, NULL)) {
+		fprintf(stderr, "Unable to send \"Find By Type Value\" "
+								"request\n");
+		free(value);
+		exit(EXIT_FAILURE);
+	}
+
+	free(value);
+}
+
 static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type)
 {
 	int sock;
@@ -313,6 +470,8 @@ static struct {
 } command[] = {
 	{ "exchange-mtu", cmd_mtu, "\"Exchange MTU\" request" },
 	{ "find-information", cmd_find_info, "\"Find Information\" request" },
+	{ "find-by-type-value", cmd_find_by_type_val,
+						"\"Find By Type Value\" request" },
 	{ }
 };
 
-- 
1.8.3.2

