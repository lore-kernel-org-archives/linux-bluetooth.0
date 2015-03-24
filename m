Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 4/4] tools/btmgmt: Add "--uuid" option to add-adv
Date: Tue, 24 Mar 2015 11:35:11 -0700
Message-Id: <1427222111-15481-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1427222111-15481-1-git-send-email-armansito@chromium.org>
References: <1427222111-15481-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the --uuid (-u) option to the add-adv command. This
allows callers to specify individual 128-bit or 16-bit UUIDs to be
included in the "Complete List of Service CLass UUIDs" field of
advertising data.
---
 tools/btmgmt.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 06f32f3..a769fc3 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3693,6 +3693,7 @@ static void add_adv_usage(void)
 
 static struct option add_adv_options[] = {
 	{ "help",	0, 0, 'h' },
+	{ "uuid",	1, 0, 'u' },
 	{ "adv-data",	1, 0, 'd' },
 	{ "scan-rsp",	1, 0, 's' },
 	{ "timeout",	1, 0, 't' },
@@ -3739,6 +3740,8 @@ static bool parse_bytes(char *optarg, uint8_t **bytes, size_t *len)
 	return true;
 }
 
+#define MAX_AD_UUID_BYTES 32
+
 static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 							int argc, char **argv)
 {
@@ -3747,19 +3750,70 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 	uint8_t *adv_data = NULL, *scan_rsp = NULL;
 	size_t adv_len = 0, scan_rsp_len = 0;
 	size_t cp_len;
+	uint8_t uuids[MAX_AD_UUID_BYTES];
+	size_t uuid_bytes = 0;
+	uint8_t uuid_type = 0;
 	uint16_t timeout = 0;
 	uint8_t instance;
+	uuid_t uuid;
 	bool success = false;
 	bool quit = true;
 
-	while ((opt = getopt_long(argc, argv, "+d:s:t:h",
+	while ((opt = getopt_long(argc, argv, "+u:d:s:t:h",
 						add_adv_options, NULL)) != -1) {
 		switch (opt) {
+		case 'u':
+			if (bt_string2uuid(&uuid, optarg) < 0) {
+				print("Invalid UUID: %s", optarg);
+				goto done;
+			}
+
+			if (uuid_type && uuid_type != uuid.type) {
+				print("UUID types must be consistent");
+				goto done;
+			}
+
+			if (uuid.type == SDP_UUID16) {
+				if (uuid_bytes + 2 >= MAX_AD_UUID_BYTES) {
+					print("Too many UUIDs");
+					goto done;
+				}
+
+				put_le16(uuid.value.uuid16, uuids + uuid_bytes);
+				uuid_bytes += 2;
+			} else if (uuid.type == SDP_UUID128) {
+				if (uuid_bytes + 16 >= MAX_AD_UUID_BYTES) {
+					print("Too many UUIDs");
+					goto done;
+				}
+
+				bswap_128(uuid.value.uuid128.data,
+							uuids + uuid_bytes);
+				uuid_bytes += 16;
+			} else {
+				printf("Unsupported UUID type");
+				goto done;
+			}
+
+			if (!uuid_type)
+				uuid_type = uuid.type;
+
+			break;
 		case 'd':
+			if (adv_len) {
+				print("Only one adv-data option allowed");
+				goto done;
+			}
+
 			if (!parse_bytes(optarg, &adv_data, &adv_len))
 				goto done;
 			break;
 		case 's':
+			if (scan_rsp_len) {
+				print("Only one scan-rsp option allowed");
+				goto done;
+			}
+
 			if (!parse_bytes(optarg, &scan_rsp, &scan_rsp_len))
 				goto done;
 			break;
@@ -3783,23 +3837,32 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 		goto done;
 	}
 
+	if (uuid_bytes)
+		uuid_bytes += 2;
+
 	instance = strtol(argv[0], NULL, 0);
 
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
 
-	cp_len = sizeof(*cp) + (adv_len + scan_rsp_len) * sizeof(uint8_t);
+	cp_len = sizeof(*cp) + uuid_bytes + adv_len + scan_rsp_len;
 	cp = malloc0(cp_len);
 	if (!cp)
 		goto done;
 
 	cp->instance = instance;
 	put_le16(timeout, &cp->timeout);
-	cp->adv_data_len = adv_len;
+	cp->adv_data_len = adv_len + uuid_bytes;
 	cp->scan_rsp_len = scan_rsp_len;
 
-	memcpy(cp->data, adv_data, adv_len * sizeof(uint8_t));
-	memcpy(cp->data + adv_len, scan_rsp, scan_rsp_len * sizeof(uint8_t));
+	if (uuid_bytes) {
+		cp->data[0] = uuid_bytes - 1;
+		cp->data[1] = uuid_type == SDP_UUID16 ? 0x03 : 0x07;
+		memcpy(cp->data + 2, uuids, uuid_bytes - 2);
+	}
+
+	memcpy(cp->data + uuid_bytes, adv_data, adv_len);
+	memcpy(cp->data + uuid_bytes + adv_len, scan_rsp, scan_rsp_len);
 
 	if (!mgmt_send(mgmt, MGMT_OP_ADD_ADVERTISING, index, cp_len, cp,
 						add_adv_rsp, NULL, NULL)) {
-- 
2.2.0.rc0.207.ga3a616c

