Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 3/7] tools/btmgmt: Add --discoverable option to add-adv
Date: Tue, 24 Mar 2015 20:05:50 -0700
Message-Id: <1427252754-27889-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1427252754-27889-1-git-send-email-armansito@chromium.org>
References: <1427252754-27889-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the --discoverable (-e) option to the add-adv command,
which can be used to add "general discoverable" advertising instances.
---
 tools/btmgmt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 4d68647..72768c3 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3688,7 +3688,7 @@ static void add_adv_rsp(uint8_t status, uint16_t len, const void *param,
 static void add_adv_usage(void)
 {
 	print("Usage: add-adv [-u uuid] [-d adv_data] [-s scan_rsp] "
-					"[-t timeout] [-c] <instance_id>");
+				"[-t timeout] [-c] [-d] [-e] <instance_id>");
 }
 
 static struct option add_adv_options[] = {
@@ -3698,6 +3698,7 @@ static struct option add_adv_options[] = {
 	{ "scan-rsp",		1, 0, 's' },
 	{ "timeout",		1, 0, 't' },
 	{ "connectable",	0, 0, 'c' },
+	{ "discoverable",	0, 0, 'e' },
 	{ 0, 0, 0, 0}
 };
 
@@ -3761,7 +3762,7 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 	bool quit = true;
 	uint32_t flags = 0;
 
-	while ((opt = getopt_long(argc, argv, "+u:d:s:t:ch",
+	while ((opt = getopt_long(argc, argv, "+u:d:s:t:ceh",
 						add_adv_options, NULL)) != -1) {
 		switch (opt) {
 		case 'u':
@@ -3825,6 +3826,9 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 		case 'c':
 			flags |= MGMT_ADV_FLAG_CONNECTABLE;
 			break;
+		case 'e':
+			flags |= MGMT_ADV_FLAG_DISCOV;
+			break;
 		case 'h':
 			success = true;
 		default:
-- 
2.2.0.rc0.207.ga3a616c

