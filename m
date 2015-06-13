Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v8 03/15] tools/btmgmt: make inst duration configurable
Date: Sat, 13 Jun 2015 05:42:47 +0200
Message-Id: <1434166979-21824-4-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
References: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that the kernel actually does respect the instance's duration
parameter it should be accessible via btmgmt. An additional parameter
for the add-adv command is therefore being introduced.
---
 tools/btmgmt.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 8f8bca1..a100f53 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3890,15 +3890,16 @@ static void add_adv_rsp(uint8_t status, uint16_t len, const void *param,
 static void add_adv_usage(void)
 {
 	print("Usage: add-adv [options] <instance_id>\nOptions:\n"
-		"\t -u, --uuid <uuid>        Service UUID\n"
-		"\t -d, --adv-data <data>    Advertising Data bytes\n"
-		"\t -s, --scan-rsp <data>    Scan Response Data bytes\n"
-		"\t -t, --timeout <timeout>  Timeout in seconds\n"
-		"\t -c, --connectable        \"connectable\" flag\n"
-		"\t -g, --general-discov     \"general-discoverable\" flag\n"
-		"\t -l, --limited-discov     \"limited-discoverable\" flag\n"
-		"\t -m, --managed-flags      \"managed-flags\" flag\n"
-		"\t -p, --tx-power           \"tx-power\" flag\n"
+		"\t -u, --uuid <uuid>         Service UUID\n"
+		"\t -d, --adv-data <data>     Advertising Data bytes\n"
+		"\t -s, --scan-rsp <data>     Scan Response Data bytes\n"
+		"\t -t, --timeout <timeout>   Timeout in seconds\n"
+		"\t -D, --duration <duration> Duration in seconds\n"
+		"\t -c, --connectable         \"connectable\" flag\n"
+		"\t -g, --general-discov      \"general-discoverable\" flag\n"
+		"\t -l, --limited-discov      \"limited-discoverable\" flag\n"
+		"\t -m, --managed-flags       \"managed-flags\" flag\n"
+		"\t -p, --tx-power            \"tx-power\" flag\n"
 		"e.g.:\n"
 		"\tadd-adv -u 180d -u 180f -d 080954657374204C45 1");
 }
@@ -3909,6 +3910,7 @@ static struct option add_adv_options[] = {
 	{ "adv-data",		1, 0, 'd' },
 	{ "scan-rsp",		1, 0, 's' },
 	{ "timeout",		1, 0, 't' },
+	{ "duration",		1, 0, 'D' },
 	{ "connectable",	0, 0, 'c' },
 	{ "general-discov",	0, 0, 'g' },
 	{ "limited-discov",	0, 0, 'l' },
@@ -3970,14 +3972,14 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 	uint8_t uuids[MAX_AD_UUID_BYTES];
 	size_t uuid_bytes = 0;
 	uint8_t uuid_type = 0;
-	uint16_t timeout = 0;
+	uint16_t timeout = 0, duration = 0;
 	uint8_t instance;
 	uuid_t uuid;
 	bool success = false;
 	bool quit = true;
 	uint32_t flags = 0;
 
-	while ((opt = getopt_long(argc, argv, "+u:d:s:t:cglmph",
+	while ((opt = getopt_long(argc, argv, "+u:d:s:t:D:cglmph",
 						add_adv_options, NULL)) != -1) {
 		switch (opt) {
 		case 'u':
@@ -4038,6 +4040,9 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 		case 't':
 			timeout = strtol(optarg, NULL, 0);
 			break;
+		case 'D':
+			duration = strtol(optarg, NULL, 0);
+			break;
 		case 'c':
 			flags |= MGMT_ADV_FLAG_CONNECTABLE;
 			break;
@@ -4086,6 +4091,7 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 	cp->instance = instance;
 	put_le32(flags, &cp->flags);
 	put_le16(timeout, &cp->timeout);
+	put_le16(duration, &cp->duration);
 	cp->adv_data_len = adv_len + uuid_bytes;
 	cp->scan_rsp_len = scan_rsp_len;
 
-- 
1.9.1

