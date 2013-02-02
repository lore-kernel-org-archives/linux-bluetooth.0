Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/7] Bluetooth: Setup LE scan with no timeout
Date: Fri,  1 Feb 2013 21:44:34 -0300
Message-Id: <1359765878-31409-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
References: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch modifies hci_do_le_scan and hci_cancel_le_scan helpers so
we are able to start and stop LE scan with no timeout. This feature
will be used by the LE connection routine.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 22e77a7..3aa0345 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1618,26 +1618,27 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
 	if (err < 0)
 		return err;
 
-	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-			   msecs_to_jiffies(timeout));
+	if (timeout > 0)
+		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
+				   msecs_to_jiffies(timeout));
 
 	return 0;
 }
 
 int hci_cancel_le_scan(struct hci_dev *hdev)
 {
+	struct hci_cp_le_set_scan_enable cp;
+
 	BT_DBG("%s", hdev->name);
 
 	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
 		return -EALREADY;
 
-	if (cancel_delayed_work(&hdev->le_scan_disable)) {
-		struct hci_cp_le_set_scan_enable cp;
+	cancel_delayed_work(&hdev->le_scan_disable);
 
-		/* Send HCI command to disable LE Scan */
-		memset(&cp, 0, sizeof(cp));
-		hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
-	}
+	/* Send HCI command to disable LE Scan */
+	memset(&cp, 0, sizeof(cp));
+	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 
 	return 0;
 }
-- 
1.8.1.1

