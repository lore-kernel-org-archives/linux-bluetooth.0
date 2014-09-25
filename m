Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH 2/4]  tools/btgatt-client: Add signed write CSRK option
Date: Thu, 25 Sep 2014 14:35:29 +0800
Message-Id: <1411626931-8290-3-git-send-email-chao.jie.gu@intel.com>
In-Reply-To: <1411626931-8290-1-git-send-email-chao.jie.gu@intel.com>
References: <1411626931-8290-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch Add CSRK option to btgatt-client tool, use -c <key> to set
CSRK for signed write command need. This key from pairing to store 32
byte key string under group "LocalSignatureKey" in the info file.

---
 tools/btgatt-client.c |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index d1395b2..dfc15a3 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -447,11 +447,13 @@ static void write_value_usage(void)
 	printf("Usage: write-value [options] <value_handle> <value>\n"
 		"Options:\n"
 		"\t-w, --without-response\tWrite without response\n"
+		"\t-c, --csrk <key>\tCSRK for signed write command\n"
 		"e.g.:\n"
 		"\twrite-value 0x0001 00 01 00\n");
 }
 
 static struct option write_value_options[] = {
+	{ "csrk",		1, 0, 'c' },
 	{ "without-response",	0, 0, 'w' },
 	{ }
 };
@@ -465,6 +467,24 @@ static void write_cb(bool success, uint8_t att_ecode, void *user_data)
 	}
 }
 
+static bool convert_csrk_key(char *optarg, uint8_t csrk[16])
+{
+	int i;
+	char value[2];
+
+	if (strlen(optarg) != 32) {
+		printf("csrk length is invalid\n");
+		return false;
+	} else {
+		for (i = 0; i < 16; i++) {
+			strncpy(value, optarg + (i * 2), 2);
+			csrk[i] = strtol(value, NULL, 16);
+		}
+	}
+
+	return true;
+}
+
 static void cmd_write_value(struct client *cli, char *cmd_str)
 {
 	int opt, i;
@@ -476,6 +496,11 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 	int length;
 	uint8_t *value = NULL;
 	bool without_response = false;
+	bool signed_write = false;
+	bool valid_csrk = false;
+	uint8_t csrk[16];
+
+	memset(csrk, 0, 16);
 
 	if (!bt_gatt_client_is_ready(cli->gatt)) {
 		printf("GATT client not initialized\n");
@@ -490,12 +515,18 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 
 	optind = 0;
 	argv[0] = "write-value";
-	while ((opt = getopt_long(argc, argv, "+w", write_value_options,
+	while ((opt = getopt_long(argc, argv, "+wc:", write_value_options,
 								NULL)) != -1) {
 		switch (opt) {
 		case 'w':
 			without_response = true;
 			break;
+		case 'c':
+			signed_write = true;
+			valid_csrk = convert_csrk_key(optarg, csrk);
+			bt_gatt_client_set_csrk(cli->gatt, LOCAL_CSRK,
+						valid_csrk, csrk);
+			break;
 		default:
 			write_value_usage();
 			return;
@@ -551,7 +582,7 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 
 	if (without_response) {
 		if (!bt_gatt_client_write_without_response(cli->gatt, handle,
-							false, value, length)) {
+						signed_write, value, length)) {
 			printf("Failed to initiate write without response "
 								"procedure\n");
 			return;
-- 
1.7.10.4

