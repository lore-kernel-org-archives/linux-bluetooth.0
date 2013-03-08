Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] Bluetooth: Remove timeout handling from hci_cancel_le_scan
Date: Fri,  8 Mar 2013 20:06:16 -0300
Message-Id: <1362783979-10142-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362783979-10142-1-git-send-email-andre.guedes@openbossa.org>
References: <1362783979-10142-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves the LE scanning timeout handling from hci_cancel_
le_scan helper to stop_discovery.

Since we want discovery code handling LE scanning timeout, we should
handle it in stop_discovery instead of hci_cancel_le_scan.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 14 +++++---------
 net/bluetooth/mgmt.c     | 15 ++++++++++++---
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 59f583b..200ec5a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1905,20 +1905,16 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
 
 int hci_cancel_le_scan(struct hci_dev *hdev)
 {
+	struct hci_cp_le_set_scan_enable cp;
+
 	BT_DBG("%s", hdev->name);
 
 	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
 		return -EALREADY;
 
-	if (cancel_delayed_work(&hdev->le_scan_disable)) {
-		struct hci_cp_le_set_scan_enable cp;
-
-		/* Send HCI command to disable LE Scan */
-		memset(&cp, 0, sizeof(cp));
-		hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
-	}
-
-	return 0;
+	/* Send HCI command to disable LE Scan */
+	memset(&cp, 0, sizeof(cp));
+	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
 
 static void le_scan_disable_work(struct work_struct *work)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0fe7a87..3fec412 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2579,10 +2579,19 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	switch (hdev->discovery.state) {
 	case DISCOVERY_FINDING:
-		if (test_bit(HCI_INQUIRY, &hdev->flags))
+		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
 			err = hci_cancel_inquiry(hdev);
-		else
-			err = hci_cancel_le_scan(hdev);
+		} else {
+			/*
+			 * If delayed work could not be canceled, it means the
+			 * work is running. Therefore, there is no need to send
+			 * another HCI command to disable LE scanning.
+			 */
+			if (!cancel_delayed_work(&hdev->le_scan_disable))
+				err = 0;
+			else
+				err = hci_cancel_le_scan(hdev);
+		}
 
 		break;
 
-- 
1.8.1.2

