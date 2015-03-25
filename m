Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 2/7] tools/btmgmt: Add --connectable option to add-adv
Date: Tue, 24 Mar 2015 20:05:49 -0700
Message-Id: <1427252754-27889-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1427252754-27889-1-git-send-email-armansito@chromium.org>
References: <1427252754-27889-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the --connectable (-c) option to the add-adv command,
which can be used to add connectable advertising instances.
---
 tools/btmgmt.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index a769fc3..4d68647 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3687,16 +3687,17 @@ static void add_adv_rsp(uint8_t status, uint16_t len, const void *param,
 
 static void add_adv_usage(void)
 {
-	print("Usage: add-adv [-d adv_data] [-s scan_rsp] "
-						"[-t timeout] <instance_id>");
+	print("Usage: add-adv [-u uuid] [-d adv_data] [-s scan_rsp] "
+					"[-t timeout] [-c] <instance_id>");
 }
 
 static struct option add_adv_options[] = {
-	{ "help",	0, 0, 'h' },
-	{ "uuid",	1, 0, 'u' },
-	{ "adv-data",	1, 0, 'd' },
-	{ "scan-rsp",	1, 0, 's' },
-	{ "timeout",	1, 0, 't' },
+	{ "help",		0, 0, 'h' },
+	{ "uuid",		1, 0, 'u' },
+	{ "adv-data",		1, 0, 'd' },
+	{ "scan-rsp",		1, 0, 's' },
+	{ "timeout",		1, 0, 't' },
+	{ "connectable",	0, 0, 'c' },
 	{ 0, 0, 0, 0}
 };
 
@@ -3758,8 +3759,9 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 	uuid_t uuid;
 	bool success = false;
 	bool quit = true;
+	uint32_t flags = 0;
 
-	while ((opt = getopt_long(argc, argv, "+u:d:s:t:h",
+	while ((opt = getopt_long(argc, argv, "+u:d:s:t:ch",
 						add_adv_options, NULL)) != -1) {
 		switch (opt) {
 		case 'u':
@@ -3820,6 +3822,9 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 		case 't':
 			timeout = strtol(optarg, NULL, 0);
 			break;
+		case 'c':
+			flags |= MGMT_ADV_FLAG_CONNECTABLE;
+			break;
 		case 'h':
 			success = true;
 		default:
@@ -3851,6 +3856,7 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 		goto done;
 
 	cp->instance = instance;
+	put_le32(flags, &cp->flags);
 	put_le16(timeout, &cp->timeout);
 	cp->adv_data_len = adv_len + uuid_bytes;
 	cp->scan_rsp_len = scan_rsp_len;
-- 
2.2.0.rc0.207.ga3a616c

