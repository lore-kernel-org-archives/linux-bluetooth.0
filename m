Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 1/6] Bluetooth: Add HCI Read Data Block Size function
Date: Wed,  7 Dec 2011 15:56:51 +0200
Message-Id: <1323266216-25261-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1323266216-25261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323266216-25261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Implement block size read function. Use different variables for
packet-based and block-based flow control.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |    8 ++++++++
 include/net/bluetooth/hci_core.h |    5 +++++
 net/bluetooth/hci_event.c        |   26 ++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 12649d0..9490c2c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -749,6 +749,14 @@ struct hci_rp_read_bd_addr {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define HCI_OP_READ_DATA_BLOCK_SIZE	0x100a
+struct hci_rp_read_data_block_size {
+	__u8     status;
+	__le16   max_acl_len;
+	__le16   block_len;
+	__le16   num_blocks;
+} __packed;
+
 #define HCI_OP_WRITE_PAGE_SCAN_ACTIVITY	0x0c1c
 struct hci_cp_write_page_scan_activity {
 	__le16   interval;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e34cd71..4c61161 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -188,6 +188,11 @@ struct hci_dev {
 	unsigned int	sco_pkts;
 	unsigned int	le_pkts;
 
+	__u16		block_len;
+	__u16		block_mtu;
+	__u16		num_blocks;
+	__u16		block_cnt;
+
 	unsigned long	acl_last_tx;
 	unsigned long	sco_last_tx;
 	unsigned long	le_last_tx;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index afd4731..273e1cb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -776,6 +776,28 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_READ_BD_ADDR, rp->status);
 }
 
+static void hci_cc_read_data_block_size(struct hci_dev *hdev,
+							struct sk_buff *skb)
+{
+	struct hci_rp_read_data_block_size *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->block_mtu = __le16_to_cpu(rp->max_acl_len);
+	hdev->block_len = __le16_to_cpu(rp->block_len);
+	hdev->num_blocks = __le16_to_cpu(rp->num_blocks);
+
+	hdev->block_cnt = hdev->num_blocks;
+
+	BT_DBG("%s blk mtu %d cnt %d len %d", hdev->name, hdev->block_mtu,
+					hdev->block_cnt, hdev->block_len);
+
+	hci_req_complete(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, rp->status);
+}
+
 static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2031,6 +2053,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_read_bd_addr(hdev, skb);
 		break;
 
+	case HCI_OP_READ_DATA_BLOCK_SIZE:
+		hci_cc_read_data_block_size(hdev, skb);
+		break;
+
 	case HCI_OP_WRITE_CA_TIMEOUT:
 		hci_cc_write_ca_timeout(hdev, skb);
 		break;
-- 
1.7.4.1

