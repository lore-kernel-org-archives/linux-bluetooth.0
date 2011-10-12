Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 2/4] Bluetooth: AMP: read local amp info HCI command
Date: Wed, 12 Oct 2011 10:53:57 +0300
Message-Id: <1318406039-24843-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318406039-24843-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318406039-24843-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Implementation of Read Local AMP Info Command

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h      |   15 +++++++++++++++
 include/net/bluetooth/hci_core.h |   11 +++++++++++
 net/bluetooth/hci_event.c        |   28 ++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f8adc8e..5a6fa24 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -729,6 +729,21 @@ struct hci_cp_write_page_scan_activity {
 	#define PAGE_SCAN_TYPE_STANDARD		0x00
 	#define PAGE_SCAN_TYPE_INTERLACED	0x01
 
+#define HCI_OP_READ_LOCAL_AMP_INFO	0x1409
+struct hci_rp_read_local_amp_info {
+	__u8     status;
+	__u8     amp_status;
+	__le32   total_bw;
+	__le32   max_bw;
+	__le32   min_latency;
+	__le32   max_pdu;
+	__u8     amp_type;
+	__le16   pal_cap;
+	__le16   max_assoc_size;
+	__le32   max_flush_to;
+	__le32   be_flush_to;
+} __packed;
+
 #define HCI_OP_LE_SET_EVENT_MASK	0x2001
 struct hci_cp_le_set_event_mask {
 	__u8     mask[8];
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5b92442..32cddb0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -150,6 +150,17 @@ struct hci_dev {
 	__u16		sniff_min_interval;
 	__u16		sniff_max_interval;
 
+	__u8		amp_status;
+	__u32		amp_total_bw;
+	__u32		amp_max_bw;
+	__u32		amp_min_latency;
+	__u32		amp_max_pdu;
+	__u8		amp_type;
+	__u16		amp_pal_cap;
+	__u16		amp_assoc_size;
+	__u32		amp_max_flush_to;
+	__u32		amp_be_flush_to;
+
 	unsigned int	auto_accept_delay;
 
 	unsigned long	quirks;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d7d96b6..4149de6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -748,6 +748,30 @@ static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_WRITE_CA_TIMEOUT, status);
 }
 
+static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
+		struct sk_buff *skb)
+{
+	struct hci_rp_read_local_amp_info *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->amp_status = rp->amp_status;
+	hdev->amp_total_bw = __le32_to_cpu(rp->total_bw);
+	hdev->amp_max_bw = __le32_to_cpu(rp->max_bw);
+	hdev->amp_min_latency = __le32_to_cpu(rp->min_latency);
+	hdev->amp_max_pdu = __le32_to_cpu(rp->max_pdu);
+	hdev->amp_type = rp->amp_type;
+	hdev->amp_pal_cap = __le16_to_cpu(rp->pal_cap);
+	hdev->amp_assoc_size = __le16_to_cpu(rp->max_assoc_size);
+	hdev->amp_be_flush_to = __le32_to_cpu(rp->be_flush_to);
+	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
+
+	hci_req_complete(hdev, HCI_OP_READ_LOCAL_AMP_INFO, rp->status);
+}
+
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 							struct sk_buff *skb)
 {
@@ -1898,6 +1922,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_write_ca_timeout(hdev, skb);
 		break;
 
+	case HCI_OP_READ_LOCAL_AMP_INFO:
+		hci_cc_read_local_amp_info(hdev, skb);
+		break;
+
 	case HCI_OP_DELETE_STORED_LINK_KEY:
 		hci_cc_delete_stored_link_key(hdev, skb);
 		break;
-- 
1.7.4.1

