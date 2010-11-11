Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2] Fix interleave discovery regression
Date: Thu, 11 Nov 2010 18:45:26 -0200
Message-Id: <1289508326-18143-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Command complete event for LE commands are not being handled properly
due blocking calls of LE Set Scan Parameters and LE Set Scan Enable
Commands. Fix wrong Discovering signal emission in the interleaved
discovery mode.
---
 plugins/hciops.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index fc99275..418c824 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1778,24 +1778,42 @@ static int hciops_stop_inquiry(int index)
 	return err;
 }
 
-static int hciops_start_scanning(int index)
+static int le_set_scan_enable(int index, uint8_t enable)
 {
-	if (hci_le_set_scan_parameters(SK(index), 0x01, htobs(0x0010),
-					htobs(0x0010), 0x00, 0x00) < 0)
-		return -errno;
+	le_set_scan_enable_cp cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = enable;
+	cp.filter_dup = 0;
 
-	if (hci_le_set_scan_enable(SK(index), 0x01, 0x00) < 0)
+	if (hci_send_cmd(SK(index), OGF_LE_CTL, OCF_LE_SET_SCAN_ENABLE,
+				LE_SET_SCAN_ENABLE_CP_SIZE, &cp) < 0)
 		return -errno;
 
 	return 0;
 }
 
-static int hciops_stop_scanning(int index)
+static int hciops_start_scanning(int index)
 {
-	if (hci_le_set_scan_enable(SK(index), 0x00, 0x00) < 0)
+	le_set_scan_parameters_cp cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.type = 0x01;			/* Active scanning */
+	cp.interval = htobs(0x0010);
+	cp.window = htobs(0x0010);
+	cp.own_bdaddr_type = 0;		/* Public address */
+	cp.filter = 0;			/* Accept all adv packets */
+
+	if (hci_send_cmd(SK(index), OGF_LE_CTL, OCF_LE_SET_SCAN_PARAMETERS,
+				LE_SET_SCAN_PARAMETERS_CP_SIZE, &cp) < 0)
 		return -errno;
 
-	return 0;
+	return le_set_scan_enable(index, 1);
+}
+
+static int hciops_stop_scanning(int index)
+{
+	return le_set_scan_enable(index, 0);
 }
 
 static int hciops_resolve_name(int index, bdaddr_t *bdaddr)
-- 
1.7.3.2

