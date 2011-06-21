Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 1/3] Bluetooth: Add extfeatures to struct hci_dev
Date: Tue, 21 Jun 2011 17:07:48 -0300
Message-Id: <1308686870-26101-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This new field holds the extended LMP features value. Some LE
mechanism such as discovery procedure needs to read the extended
LMP features to work properly.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    3 +++
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    6 ++++++
 net/bluetooth/hci_event.c        |   21 +++++++++++++++++++++
 4 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 65345cd..acf589c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -676,6 +676,9 @@ struct hci_rp_read_local_features {
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
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0029e17..5c5ba74 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -195,6 +195,7 @@ static void hci_reset_req(struct hci_dev *hdev, unsigned long opt)
 static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 {
 	struct hci_cp_delete_stored_link_key cp;
+	struct hci_cp_read_local_ext_features ext_cp;
 	struct sk_buff *skb;
 	__le16 param;
 	__u8 flt_type;
@@ -224,6 +225,11 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 	/* Read Local Supported Features */
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
 
+	/* Read Local Extended Features */
+	ext_cp.page = 0x01;
+	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, sizeof(ext_cp),
+								&ext_cp);
+
 	/* Read Local Version */
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ac2c5e8..10d867d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -658,6 +658,23 @@ static void hci_cc_read_local_features(struct hci_dev *hdev, struct sk_buff *skb
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
+	hci_dev_lock(hdev);
+
+	memcpy(hdev->extfeatures, rp->features, 8);
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_buffer_size *rp = (void *) skb->data;
@@ -1826,6 +1843,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
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

