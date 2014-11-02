Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add hci_reset_dev() for driver triggerd stack reset
Date: Sun,  2 Nov 2014 08:15:38 +0100
Message-Id: <1414912539-1010-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some Bluetooth drivers require to reset the upper stack. To avoid having
all drivers send HCI Hardware Error events, provide a generic function
to wrap the reset functionality.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b8685a77a15e..27ddb905b351 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -856,6 +856,7 @@ int hci_register_dev(struct hci_dev *hdev);
 void hci_unregister_dev(struct hci_dev *hdev);
 int hci_suspend_dev(struct hci_dev *hdev);
 int hci_resume_dev(struct hci_dev *hdev);
+int hci_reset_dev(struct hci_dev *hdev);
 int hci_dev_open(__u16 dev);
 int hci_dev_close(__u16 dev);
 int hci_dev_reset(__u16 dev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 41b147c36d11..a12e018ee21c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4248,6 +4248,24 @@ int hci_resume_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_resume_dev);
 
+/* Reset HCI device */
+int hci_reset_dev(struct hci_dev *hdev)
+{
+	const u8 hw_err[] = { HCI_EV_HARDWARE_ERROR, 0x01, 0x00 };
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(3, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+	memcpy(skb_put(skb, 3), hw_err, 3);
+
+	/* Send Hardware Error to upper stack */
+	return hci_recv_frame(hdev, skb);
+}
+EXPORT_SYMBOL(hci_reset_dev);
+
 /* Receive frame from HCI drivers */
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-- 
1.9.3

