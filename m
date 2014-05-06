Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 07/10] tools/btatt: Add "find-information" command.
Date: Mon,  5 May 2014 21:46:00 -0700
Message-Id: <1399351563-25991-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1399351563-25991-1-git-send-email-armansito@chromium.org>
References: <1399351563-25991-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added command for the "Find Information" request. Sample run:

$ btatt -d 00:02:5B:00:15:10 -v find-information 0x0001 0xffff
att: ATT command 0x04
att: < 04 01 00 ff ff
att: > 05 01 01 00 00 28 02 00 03 28 03 00 00 2a 04 00 03 28 05 00 01 2a
Find Information response:
	Format: 0x01
	Information Data:
		handle: 0x0001, uuid: 2800
		handle: 0x0002, uuid: 2803
		handle: 0x0003, uuid: 2a00
		handle: 0x0004, uuid: 2803
		handle: 0x0005, uuid: 2a01
---
 tools/btatt.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 2 deletions(-)

diff --git a/tools/btatt.c b/tools/btatt.c
index a21625f..517ef6b 100644
--- a/tools/btatt.c
+++ b/tools/btatt.c
@@ -33,6 +33,8 @@
 #include <bluetooth/l2cap.h>
 
 #include "monitor/mainloop.h"
+#include "lib/uuid.h"
+#include "src/shared/util.h"
 #include "src/shared/att.h"
 
 #define ATT_CID 4
@@ -63,7 +65,7 @@ static void exchange_mtu_cb(uint8_t opcode, const void *param,
 	}
 
 	if (opcode != ATT_OP_EXCHANGE_MTU_RESP) {
-		fprintf(stderr, "Invalid response opcode (%u)\n", opcode);
+		fprintf(stderr, "Invalid response opcode (0x%02x)\n", opcode);
 		goto done;
 	}
 
@@ -130,6 +132,130 @@ static void cmd_mtu(struct bt_att *att, int argc, char **argv)
 	}
 }
 
+static void find_info_cb(uint8_t opcode, const void *param,
+						uint16_t len, void *user_data)
+{
+	const struct bt_att_find_information_rsp_param *rp;
+	bt_uuid_t uuid;
+	char uuidstr[MAX_LEN_UUID_STR];
+	int pair_count, pair_size;
+	uint128_t u128;
+	const uint8_t *data_ptr;
+	int i;
+
+	if (opcode == ATT_OP_ERROR_RESP) {
+		handle_error(param, len);
+		goto done;
+	}
+
+	if (opcode != ATT_OP_FIND_INFORMATION_RESP) {
+		fprintf(stderr, "Invalid response opcode (0x%02x)\n", opcode);
+		goto done;
+	}
+
+	rp = param;
+
+	if (len != sizeof(*rp)) {
+		fprintf(stderr, "Invalid \"Find Information\" response length "
+								"(%u)\n", len);
+		goto done;
+	}
+
+	pair_size = 2;
+	if (rp->format == 0x01)
+		pair_size += 2;
+	else if (rp->format == 0x02)
+		pair_size += 16;
+	else {
+		fprintf(stderr, "Invalid \"Find Information\" response format "
+						"(0x%02x)\n", rp->format);
+		goto done;
+	}
+
+	pair_count = rp->length / pair_size;
+
+	printf("Find Information response:\n" "\tFormat: 0x%02x\n", rp->format);
+	printf("\tInformation Data:\n");
+
+	data_ptr = rp->information_data;
+	for (i = 0; i < pair_count; i++) {
+		printf("\t\thandle: 0x%04x", get_le16(data_ptr));
+
+		if (rp->format == 0x01) {
+			bt_uuid16_create(&uuid, get_le16(data_ptr + 2));
+		} else {
+			bswap_128(data_ptr + 2, &u128);
+			bt_uuid128_create(&uuid, u128);
+		}
+
+		bt_uuid_to_string(&uuid, uuidstr, MAX_LEN_UUID_STR);
+		printf(", uuid: %s\n", uuidstr);
+
+		data_ptr += pair_size;
+	}
+
+done:
+	mainloop_quit();
+}
+
+static void find_info_usage(void)
+{
+	printf("Usage: btatt find-information <start handle> <end handle>\n");
+}
+
+static struct option find_info_options[] = {
+	{ "help", 	0, 0, 'h'},
+	{}
+};
+
+static void cmd_find_info(struct bt_att *att, int argc, char **argv)
+{
+	struct bt_att_find_information_req_param param;
+	uint16_t start, end;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "+h", find_info_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+		default:
+			find_info_usage();
+			exit(EXIT_SUCCESS);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 2) {
+		find_info_usage();
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
+	memset(&param, 0, sizeof(param));
+	param.start_handle = start;
+	param.end_handle = end;
+
+	if (bt_att_send(att, ATT_OP_FIND_INFORMATION_REQ, &param,
+				sizeof(param), find_info_cb, NULL, NULL) == 0) {
+		fprintf(stderr, "Unable to send \"Find Information\" request\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type)
 {
 	int sock;
@@ -184,7 +310,8 @@ static struct {
 	void (*func)(struct bt_att *att, int argc, char **argv);
 	char *doc;
 } command[] = {
-	{ "exchange-mtu",	cmd_mtu,	"\"Exchange MTU\" request." },
+	{ "exchange-mtu", cmd_mtu, "\"Exchange MTU\" request" },
+	{ "find-information", cmd_find_info, "\"Find Information\" request" },
 	{ }
 };
 
-- 
1.9.1.423.g4596e3a

