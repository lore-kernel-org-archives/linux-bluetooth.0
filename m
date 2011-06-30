Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 1/5] Bluetooth: Add extfeatures to struct hci_dev
Date: Thu, 30 Jun 2011 19:20:52 -0300
Message-Id: <1309472456-24674-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This new field holds the extended LMP features value. Some LE
mechanism such as discovery procedure needs to read the extended
LMP features to work properly.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    4 ++++
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |   27 +++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 65345cd..741a2d6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -216,6 +216,7 @@ enum {
 
 #define LMP_LSTO	0x01
 #define LMP_INQ_TX_PWR	0x02
+#define LMP_EXTFEATURES	0x80
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
@@ -676,6 +677,9 @@ struct hci_rp_read_local_features {
 } __packed;
 
 #define HCI_OP_READ_LOCAL_EXT_FEATURES	0x1004
+struct hci_cp_read_local_ext_features {
+	__u8     page;
+} __packed;
 struct hci_rp_read_local_ext_features {
 	__u8     status;
 	__u8     page;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 26233d4..cd65f0e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -113,6 +113,7 @@ struct hci_dev {
 	__u8		major_class;
 	__u8		minor_class;
 	__u8		features[8];
+	__u8		extfeatures[8];
 	__u8		commands[64];
 	__u8		ssp_mode;
 	__u8		hci_ver;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ac2c5e8..93d528c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -542,6 +542,14 @@ static void hci_setup(struct hci_dev *hdev)
 
 	if (hdev->features[7] & LMP_INQ_TX_PWR)
 		hci_send_cmd(hdev, HCI_OP_READ_INQ_RSP_TX_POWER, 0, NULL);
+
+	if (hdev->features[7] & LMP_EXTFEATURES) {
+		struct hci_cp_read_local_ext_features cp;
+
+		cp.page = 0x01;
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES,
+							sizeof(cp), &cp);
+	}
 }
 
 static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
@@ -658,6 +666,21 @@ static void hci_cc_read_local_features(struct hci_dev *hdev, struct sk_buff *skb
 					hdev->features[6], hdev->features[7]);
 }
 
+static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
+							struct sk_buff *skb)
+{
+	struct hci_rp_read_local_ext_features *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	memcpy(hdev->extfeatures, rp->features, 8);
+
+	hci_req_complete(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, rp->status);
+}
+
 static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_buffer_size *rp = (void *) skb->data;
@@ -1826,6 +1849,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_read_local_features(hdev, skb);
 		break;
 
+	case HCI_OP_READ_LOCAL_EXT_FEATURES:
+		hci_cc_read_local_ext_features(hdev, skb);
+		break;
+
 	case HCI_OP_READ_BUFFER_SIZE:
 		hci_cc_read_buffer_size(hdev, skb);
 		break;
-- 
1.7.4.1

