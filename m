Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: Add hci_cancel_le_scan() to hci_core
Date: Thu, 15 Mar 2012 16:52:07 -0300
Message-Id: <1331841128-1396-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1331841128-1396-1-git-send-email-andre.guedes@openbossa.org>
References: <1331841128-1396-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hci_core the hci_cancel_le_scan function which
should be used to cancel an ongoing LE scan.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 74dfefa..484e83d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1071,5 +1071,6 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
 int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 		int timeout);
+int hci_cancel_le_scan(struct hci_dev *hdev);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2f3e1bb..3228183 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1667,6 +1667,24 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
 	return 0;
 }
 
+int hci_cancel_le_scan(struct hci_dev *hdev)
+{
+	BT_DBG("%s", hdev->name);
+
+	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return -EALREADY;
+
+	if (cancel_delayed_work(&hdev->le_scan_disable)) {
+		struct hci_cp_le_set_scan_enable cp;
+
+		/* Send HCI command to disable LE Scan */
+		memset(&cp, 0, sizeof(cp));
+		hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	}
+
+	return 0;
+}
+
 static void le_scan_disable_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
-- 
1.7.9.4

