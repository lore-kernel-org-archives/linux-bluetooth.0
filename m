Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btmgmt: Fix endianess in cmd_scan_params()
Date: Tue,  1 Jul 2014 19:25:18 -0300
Message-Id: <1404253518-24132-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The kernel expects Mgmt commands parameters in little-endian byte order
so this patch fixes cp.interval and cp.window in cmd_scan_params().
---
 tools/btmgmt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 066fde9..b0da592 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2404,6 +2404,7 @@ static void cmd_scan_params(struct mgmt *mgmt, uint16_t index,
 							int argc, char **argv)
 {
 	struct mgmt_cp_set_scan_params cp;
+	uint16_t interval, window;
 
 	if (argc < 3) {
 		scan_params_usage();
@@ -2413,8 +2414,11 @@ static void cmd_scan_params(struct mgmt *mgmt, uint16_t index,
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
 
-	cp.interval = strtol(argv[1], NULL, 0);
-	cp.window = strtol(argv[2], NULL, 0);
+	interval = strtol(argv[1], NULL, 0);
+	window = strtol(argv[2], NULL, 0);
+
+	put_le16(interval, &cp.interval);
+	put_le16(window, &cp.window);
 
 	if (mgmt_send(mgmt, MGMT_OP_SET_SCAN_PARAMS, index, sizeof(cp), &cp,
 					scan_params_rsp, NULL, NULL) == 0) {
-- 
1.9.1

