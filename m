Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Add hci_do_le_scan() to hci_core
Date: Wed, 14 Dec 2011 13:25:25 -0300
Message-Id: <1323879926-15971-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hci_core the hci_do_le_scan function which should
be used to scan LE devices.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0ef3c7c..eab90b8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1008,5 +1008,7 @@ void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
+int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
+								int timeout);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 56fcc59..9b659af 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2688,5 +2688,26 @@ int hci_cancel_inquiry(struct hci_dev *hdev)
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 }
 
+int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
+								int timeout)
+{
+	struct le_scan_params *params = &hdev->le_scan_params;
+
+	BT_DBG("%s", hdev->name);
+
+	if (work_busy(&hdev->le_scan_wk) ||
+				test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return -EINPROGRESS;
+
+	params->type = type;
+	params->interval = interval;
+	params->window = window;
+	params->timeout = timeout;
+
+	queue_work(hdev->workqueue, &hdev->le_scan_wk);
+
+	return 0;
+}
+
 module_param(enable_hs, bool, 0644);
 MODULE_PARM_DESC(enable_hs, "Enable High Speed");
-- 
1.7.8

