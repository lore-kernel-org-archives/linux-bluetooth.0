Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add hci_cancel_le_scan() to hci_core
Date: Tue,  6 Mar 2012 19:54:33 -0300
Message-Id: <1331074474-12868-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1331074474-12868-1-git-send-email-andre.guedes@openbossa.org>
References: <1331074474-12868-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hci_core the hci_cancel_le_scan function which
should be used to cancel an ongoing LE scan.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 25cb0a1..0db2934 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1072,5 +1072,6 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
 int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 								int timeout);
+int hci_cancel_le_scan(struct hci_dev *hdev);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 661d65f..0c2ceaa 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1672,6 +1672,27 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
 	return 0;
 }
 
+int hci_cancel_le_scan(struct hci_dev *hdev)
+{
+	bool canceled;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return -EPERM;
+
+	canceled = cancel_delayed_work(&hdev->le_scan_disable);
+	if (canceled) {
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
1.7.9.2

