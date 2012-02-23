Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: mgmt: Fix update_eir/class with HCI_AUTO_OFF flag set
Date: Thu, 23 Feb 2012 16:03:00 +0200
Message-Id: <1330005781-8185-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we're powered but still have the HCI_AUTO_OFF flag set the
update_eir and update_class functions should not do anything.
Additionally these functions need to be called when the flag is finally
cleared through set_powered or when powering on for real.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7fdba8f..4e48894 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -532,7 +532,7 @@ static int update_eir(struct hci_dev *hdev)
 {
 	struct hci_cp_write_eir cp;
 
-	if (!test_bit(HCI_UP, &hdev->flags))
+	if (!hdev_is_powered(hdev))
 		return 0;
 
 	if (!(hdev->features[6] & LMP_EXT_INQ))
@@ -573,7 +573,7 @@ static int update_class(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_UP, &hdev->flags))
+	if (!hdev_is_powered(hdev))
 		return 0;
 
 	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
@@ -3121,6 +3121,9 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 
 		if (scan)
 			hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+
+		update_class(hdev);
+		update_eir(hdev);
 	} else {
 		u8 status = ENETDOWN;
 		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
-- 
1.7.9

