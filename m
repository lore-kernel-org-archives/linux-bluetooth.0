Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3 v2] Bluetooth: Fix updating advertising state flags and data
Date: Thu,  8 Nov 2012 01:23:01 +0100
Message-Id: <1352334181-19198-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1352334181-19198-1-git-send-email-johan.hedberg@gmail.com>
References: <1352334181-19198-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a callback for the HCI_LE_Set_Advertise_Enable command.
The callback is responsible for updating the HCI_LE_PERIPHERAL flag
updating as well as updating the advertising data flags field to
indicate undirected connectable advertising.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |    2 ++
 net/bluetooth/hci_event.c   |   31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7306078..4bbabd8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -957,6 +957,8 @@ struct hci_cp_le_set_adv_data {
 	__u8	data[HCI_MAX_AD_LENGTH];
 } __packed;
 
+#define HCI_OP_LE_SET_ADV_ENABLE	0x200a
+
 #define HCI_OP_LE_SET_SCAN_PARAM	0x200b
 struct hci_cp_le_set_scan_param {
 	__u8    type;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7caea1a..9f5c5f2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1190,6 +1190,33 @@ static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 *sent, status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_ENABLE);
+	if (!sent)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (!status) {
+		if (*sent)
+			set_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+		else
+			clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+	}
+
+	hci_dev_unlock(hdev);
+
+	if (!test_bit(HCI_INIT, &hdev->flags))
+		hci_update_ad(hdev);
+
+	hci_req_complete(hdev, HCI_OP_LE_SET_ADV_ENABLE, status);
+}
+
 static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2585,6 +2612,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_set_scan_param(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_ADV_ENABLE:
+		hci_cc_le_set_adv_enable(hdev, skb);
+		break;
+
 	case HCI_OP_LE_SET_SCAN_ENABLE:
 		hci_cc_le_set_scan_enable(hdev, skb);
 		break;
-- 
1.7.10.4

