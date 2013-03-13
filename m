Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 21/26] Bluetooth: Add reading of page scan parameters
Date: Wed, 13 Mar 2013 11:12:12 -0700
Message-Id: <1363198337-3896-22-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

These parameters are related to the "fast connectable" mode that can be
changed through the mgmt interface. Not all controllers properly reset
these values with HCI_Reset so they need to be read in order to be able
to verify whether the values are correct or not before enabling page
scan.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |   13 +++++++++++++
 include/net/bluetooth/hci_core.h |    4 ++++
 net/bluetooth/hci_core.c         |    6 ++++++
 net/bluetooth/hci_event.c        |   32 ++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3570367..08373f3 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -887,12 +887,25 @@ struct hci_rp_read_data_block_size {
 	__le16   num_blocks;
 } __packed;
 
+#define HCI_OP_READ_PAGE_SCAN_ACTIVITY	0x0c1b
+struct hci_rp_read_page_scan_activity {
+	__u8     status;
+	__le16   interval;
+	__le16   window;
+} __packed;
+
 #define HCI_OP_WRITE_PAGE_SCAN_ACTIVITY	0x0c1c
 struct hci_cp_write_page_scan_activity {
 	__le16   interval;
 	__le16   window;
 } __packed;
 
+#define HCI_OP_READ_PAGE_SCAN_TYPE	0x0c46
+struct hci_rp_read_page_scan_type {
+	__u8     status;
+	__u8     type;
+} __packed;
+
 #define HCI_OP_WRITE_PAGE_SCAN_TYPE	0x0c47
 	#define PAGE_SCAN_TYPE_STANDARD		0x00
 	#define PAGE_SCAN_TYPE_INTERLACED	0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cb99193..358a698 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -165,6 +165,10 @@ struct hci_dev {
 	__u16		voice_setting;
 	__u8		io_capability;
 	__s8		inq_tx_power;
+	__u16		page_scan_interval;
+	__u16		page_scan_window;
+	__u8		page_scan_type;
+
 	__u16		devid_source;
 	__u16		devid_vendor;
 	__u16		devid_product;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d828e49..7aeff36 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -272,6 +272,12 @@ static void bredr_setup(struct hci_request *req)
 	bacpy(&cp.bdaddr, BDADDR_ANY);
 	cp.delete_all = 0x01;
 	hci_req_add(req, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
+
+	/* Read page scan parameters */
+	if (req->hdev->hci_ver > BLUETOOTH_VER_1_1) {
+		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
+		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_TYPE, 0, NULL);
+	}
 }
 
 static void le_setup(struct hci_request *req)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4debf4a..4a57913 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -601,6 +601,30 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 		bacpy(&hdev->bdaddr, &rp->bdaddr);
 }
 
+static void hci_cc_read_page_scan_activity(struct hci_dev *hdev,
+					   struct sk_buff *skb)
+{
+	struct hci_rp_read_page_scan_activity *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (test_bit(HCI_INIT, &hdev->flags) && !rp->status) {
+		hdev->page_scan_interval = __le16_to_cpu(rp->interval);
+		hdev->page_scan_window = __le16_to_cpu(rp->window);
+	}
+}
+
+static void hci_cc_read_page_scan_type(struct hci_dev *hdev,
+					   struct sk_buff *skb)
+{
+	struct hci_rp_read_page_scan_type *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (test_bit(HCI_INIT, &hdev->flags) && !rp->status)
+		hdev->page_scan_type = __le16_to_cpu(rp->type);
+}
+
 static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
@@ -2204,6 +2228,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_read_bd_addr(hdev, skb);
 		break;
 
+	case HCI_OP_READ_PAGE_SCAN_ACTIVITY:
+		hci_cc_read_page_scan_activity(hdev, skb);
+		break;
+
+	case HCI_OP_READ_PAGE_SCAN_TYPE:
+		hci_cc_read_page_scan_type(hdev, skb);
+		break;
+
 	case HCI_OP_READ_DATA_BLOCK_SIZE:
 		hci_cc_read_data_block_size(hdev, skb);
 		break;
-- 
1.7.10.4

