Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5 v2] Bluetooth: Read adversiting channel TX power during init sequence
Date: Fri, 19 Oct 2012 20:57:49 +0300
Message-Id: <1350669469-7719-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1350669469-7719-1-git-send-email-johan.hedberg@gmail.com>
References: <1350669469-7719-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the reading of the LE advertising channel TX power to
the HCI init sequence of LE-capable controllers. This data will be used
e.g. for inclusion in the advertising data packets when advertising is
enabled.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |    6 ++++++
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_event.c        |   20 ++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 88cbbda..348f4bf 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -932,6 +932,12 @@ struct hci_rp_le_read_buffer_size {
 	__u8     le_max_pkt;
 } __packed;
 
+#define HCI_OP_LE_READ_ADV_TX_POWER	0x2007
+struct hci_rp_le_read_adv_tx_power {
+	__u8	status;
+	__s8	tx_power;
+} __packed;
+
 #define HCI_OP_LE_SET_SCAN_PARAM	0x200b
 struct hci_cp_le_set_scan_param {
 	__u8    type;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9fe8e2d..8260bf2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -278,6 +278,8 @@ struct hci_dev {
 	struct work_struct	le_scan;
 	struct le_scan_params	le_scan_params;
 
+	__s8			adv_tx_power;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 78f1af5..fd5a51c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -594,6 +594,9 @@ static void le_init(struct hci_dev *hdev)
 {
 	/* Read LE Buffer Size */
 	hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
+
+	/* Read LE Advertising Channel TX Power */
+	hci_send_cmd(hdev, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 }
 
 static void hci_setup(struct hci_dev *hdev)
@@ -1073,6 +1076,19 @@ static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
 	hci_req_complete(hdev, HCI_OP_LE_READ_BUFFER_SIZE, rp->status);
 }
 
+static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_rp_le_read_adv_tx_power *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (!rp->status)
+		hdev->adv_tx_power = rp->tx_power;
+
+	hci_req_complete(hdev, HCI_OP_LE_READ_ADV_TX_POWER, rp->status);
+}
+
 static void hci_cc_le_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2505,6 +2521,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_read_buffer_size(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_ADV_TX_POWER:
+		hci_cc_le_read_adv_tx_power(hdev, skb);
+		break;
+
 	case HCI_OP_LE_SET_EVENT_MASK:
 		hci_cc_le_set_event_mask(hdev, skb);
 		break;
-- 
1.7.10.4

