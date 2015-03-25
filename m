Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 6/7] tools/btmgmt: Add --tx-power option to add-adv
Date: Tue, 24 Mar 2015 20:05:53 -0700
Message-Id: <1427252754-27889-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1427252754-27889-1-git-send-email-armansito@chromium.org>
References: <1427252754-27889-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the --tx-power (-p) option to the add-adv command,
which can be used to request that the "Tx Power" AD field be managed
by the kernel for a given advertising instance.
---
 tools/btmgmt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 22a2c8c..54dd0f2 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3688,7 +3688,7 @@ static void add_adv_rsp(uint8_t status, uint16_t len, const void *param,
 static void add_adv_usage(void)
 {
 	print("Usage: add-adv [-u uuid] [-d adv_data] [-s scan_rsp] "
-			"[-t timeout] [-c] [-d] [-e] [-l] [-m] <instance_id>");
+		"[-t timeout] [-c] [-d] [-e] [-l] [-m] [-p] <instance_id>");
 }
 
 static struct option add_adv_options[] = {
@@ -3701,6 +3701,7 @@ static struct option add_adv_options[] = {
 	{ "discoverable",	0, 0, 'e' },
 	{ "limited-discov",	0, 0, 'l' },
 	{ "managed-flags",	0, 0, 'm' },
+	{ "tx-power",		0, 0, 'p' },
 	{ 0, 0, 0, 0}
 };
 
@@ -3764,7 +3765,7 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 	bool quit = true;
 	uint32_t flags = 0;
 
-	while ((opt = getopt_long(argc, argv, "+u:d:s:t:celmh",
+	while ((opt = getopt_long(argc, argv, "+u:d:s:t:celmph",
 						add_adv_options, NULL)) != -1) {
 		switch (opt) {
 		case 'u':
@@ -3837,6 +3838,9 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 		case 'm':
 			flags |= MGMT_ADV_FLAG_MANAGED_FLAGS;
 			break;
+		case 'p':
+			flags |= MGMT_ADV_FLAG_TX_POWER;
+			break;
 		case 'h':
 			success = true;
 		default:
-- 
2.2.0.rc0.207.ga3a616c

