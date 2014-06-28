Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add tracking of local and piconet clock values
Date: Sat, 28 Jun 2014 17:54:06 +0300
Message-Id: <1403967247-15728-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403967247-15728-1-git-send-email-johan.hedberg@gmail.com>
References: <1403967247-15728-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds support for storing the local and piconet clock values
from the HCI_Read_Clock command response to the hci_dev and hci_conn
structs. This will be later used in another patch to implement support
for the Get Clock Info mgmt command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      | 12 ++++++++++++
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_event.c        | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6933766e7215..58c5930dea60 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1087,6 +1087,18 @@ struct hci_rp_read_rssi {
 	__s8     rssi;
 } __packed;
 
+#define HCI_OP_READ_CLOCK		0x1407
+struct hci_cp_read_clock {
+	__le16   handle;
+	__u8     which;
+} __packed;
+struct hci_rp_read_clock {
+	__u8     status;
+	__le16   handle;
+	__le32   clock;
+	__le16   accuracy;
+} __packed;
+
 #define HCI_OP_READ_LOCAL_AMP_INFO	0x1409
 struct hci_rp_read_local_amp_info {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ca2a99807615..0906990dedd8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -207,6 +207,7 @@ struct hci_dev {
 	__u16		conn_info_min_age;
 	__u16		conn_info_max_age;
 	__u8		ssp_debug_mode;
+	__u32		clock;
 
 	__u16		devid_source;
 	__u16		devid_vendor;
@@ -388,6 +389,9 @@ struct hci_conn {
 	__s8		max_tx_power;
 	unsigned long	flags;
 
+	__u32		clock;
+	__u16		clock_accuracy;
+
 	unsigned long	conn_info_timestamp;
 
 	__u8		remote_cap;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7a23324eac39..315d615ca3f9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -721,6 +721,41 @@ static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 	       hdev->block_cnt, hdev->block_len);
 }
 
+static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_clock *rp = (void *) skb->data;
+	struct hci_cp_read_clock *cp;
+	struct hci_conn *conn;
+
+	BT_DBG("%s", hdev->name);
+
+	if (skb->len < sizeof(*rp))
+		return;
+
+	if (rp->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_READ_CLOCK);
+	if (!cp)
+		goto unlock;
+
+	if (cp->which == 0x00) {
+		hdev->clock = le32_to_cpu(rp->clock);
+		goto unlock;
+	}
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (conn) {
+		conn->clock = le32_to_cpu(rp->clock);
+		conn->clock_accuracy = le16_to_cpu(rp->accuracy);
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
@@ -2597,6 +2632,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_read_local_amp_info(hdev, skb);
 		break;
 
+	case HCI_OP_READ_CLOCK:
+		hci_cc_read_clock(hdev, skb);
+		break;
+
 	case HCI_OP_READ_LOCAL_AMP_ASSOC:
 		hci_cc_read_local_amp_assoc(hdev, skb);
 		break;
-- 
1.9.3

