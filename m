Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Track changes from HCI Write Simple Pairing Debug Mode command
Date: Sat, 31 Jan 2015 13:39:22 -0800
Message-Id: <1422740362-25024-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the HCI Write Simple Pairing Debug Mode command has been issued,
the result needs to be tracked and stored. The hdev->ssp_debug_mode
variable is already present, but was never updated when the mode in
the controller was actually changed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1305a22c53b3..a3fb094822b6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1489,6 +1489,21 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_write_ssp_debug_mode(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	u8 status = *((u8 *) skb->data);
+	u8 *mode;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	mode = hci_sent_cmd_data(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE);
+	if (mode)
+		hdev->ssp_debug_mode = *mode;
+}
+
 static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -2983,6 +2998,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_read_tx_power(hdev, skb);
 		break;
 
+	case HCI_OP_WRITE_SSP_DEBUG_MODE:
+		hci_cc_write_ssp_debug_mode(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
-- 
2.1.0

