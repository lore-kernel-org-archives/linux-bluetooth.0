Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add hci_cancel_le_scan() to hci_core
Date: Fri, 13 Jan 2012 18:03:50 -0300
Message-Id: <1326488632-16759-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1326488632-16759-1-git-send-email-andre.guedes@openbossa.org>
References: <1326488632-16759-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hci_core the hci_cancel_le_scan function which
should be used to cancel an ongoing LE scan.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 114d1a5..a29ecaa 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -992,5 +992,6 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
 int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 								int timeout);
+int hci_cancel_le_scan(struct hci_dev *hdev);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ca0fffb..ae765c4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2819,5 +2819,23 @@ int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 	return 0;
 }
 
+int hci_cancel_le_scan(struct hci_dev *hdev)
+{
+	int pending;
+
+	BT_DBG("%s", hdev->name);
+
+	pending = cancel_work_sync(&hdev->le_scan_enable);
+	if (pending)
+		return 0;
+
+	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return -EPERM;
+
+	flush_delayed_work_sync(&hdev->le_scan_disable);
+
+	return 0;
+}
+
 module_param(enable_hs, bool, 0644);
 MODULE_PARM_DESC(enable_hs, "Enable High Speed");
-- 
1.7.8.3

