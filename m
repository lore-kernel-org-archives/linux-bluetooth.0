Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add LE Local Features reading support
Date: Tue, 22 Jan 2013 14:01:59 +0200
Message-Id: <1358856121-1928-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To be able to make the appropriate decisions for some LE procedures we
need to know the LE features that the local controller supports.
Therefore, it's important to have the LE Read Local Supported Features
HCI comand as part of the HCI init sequence.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |    6 ++++++
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |   20 ++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 45eee08..521eefa 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -943,6 +943,12 @@ struct hci_rp_le_read_buffer_size {
 	__u8     le_max_pkt;
 } __packed;
 
+#define HCI_OP_LE_READ_LOCAL_FEATURES	0x2003
+struct hci_rp_le_read_local_features {
+	__u8     status;
+	__u8     features[8];
+} __packed;
+
 #define HCI_OP_LE_READ_ADV_TX_POWER	0x2007
 struct hci_rp_le_read_adv_tx_power {
 	__u8	status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 769a740..3f607c9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -152,6 +152,7 @@ struct hci_dev {
 	__u8		minor_class;
 	__u8		features[8];
 	__u8		host_features[8];
+	__u8		le_features[8];
 	__u8		commands[64];
 	__u8		hci_ver;
 	__u16		hci_rev;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 705078a..07c8c79 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -609,6 +609,9 @@ static void le_setup(struct hci_dev *hdev)
 	/* Read LE Buffer Size */
 	hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
 
+	/* Read LE Local Supported Features */
+	hci_send_cmd(hdev, HCI_OP_LE_READ_LOCAL_FEATURES, 0, NULL);
+
 	/* Read LE Advertising Channel TX Power */
 	hci_send_cmd(hdev, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 }
@@ -1090,6 +1093,19 @@ static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
 	hci_req_complete(hdev, HCI_OP_LE_READ_BUFFER_SIZE, rp->status);
 }
 
+static void hci_cc_le_read_local_features(struct hci_dev *hdev,
+					  struct sk_buff *skb)
+{
+	struct hci_rp_le_read_local_features *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (!rp->status)
+		memcpy(hdev->le_features, rp->features, 8);
+
+	hci_req_complete(hdev, HCI_OP_LE_READ_LOCAL_FEATURES, rp->status);
+}
+
 static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
@@ -2628,6 +2644,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_read_buffer_size(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_LOCAL_FEATURES:
+		hci_cc_le_read_local_features(hdev, skb);
+		break;
+
 	case HCI_OP_LE_READ_ADV_TX_POWER:
 		hci_cc_le_read_adv_tx_power(hdev, skb);
 		break;
-- 
1.7.10.4

