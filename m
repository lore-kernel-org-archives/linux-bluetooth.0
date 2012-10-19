Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: Fix HCI command sending when powering on LE-only adapters
Date: Fri, 19 Oct 2012 20:15:10 +0300
Message-Id: <1350666911-6334-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
References: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch makes sure that we don't send BR/EDR-only commands for
LE-only adapters when they get powered on. Doing this would just cause
command errors.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e6d8f73..3fe74f4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2872,6 +2872,21 @@ static void settings_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_free(cmd);
 }
 
+static int set_bredr_scan(struct hci_dev *hdev)
+{
+	u8 scan = 0;
+
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+		scan |= SCAN_PAGE;
+	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+		scan |= SCAN_INQUIRY;
+
+	if (!scan)
+		return 0;
+
+	return hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+}
+
 int mgmt_powered(struct hci_dev *hdev, u8 powered)
 {
 	struct cmd_lookup match = { NULL, hdev };
@@ -2883,19 +2898,12 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
 	if (powered) {
-		u8 scan = 0;
-
-		if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-			scan |= SCAN_PAGE;
-		if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
-			scan |= SCAN_INQUIRY;
-
-		if (scan)
-			hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
-
-		update_class(hdev);
-		update_name(hdev, hdev->dev_name);
-		update_eir(hdev);
+		if (lmp_bredr_capable(hdev)) {
+			set_bredr_scan(hdev);
+			update_class(hdev);
+			update_name(hdev, hdev->dev_name);
+			update_eir(hdev);
+		}
 	} else {
 		u8 status = MGMT_STATUS_NOT_POWERED;
 		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
-- 
1.7.10.4

