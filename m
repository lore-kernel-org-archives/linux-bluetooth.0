Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/8] Bluetooth: Add HCI Read Data Block Size function
Date: Thu,  1 Dec 2011 14:42:12 +0200
Message-Id: <1322743335-8671-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Upstream Code Aurora function with minor trivial fixes.
Origin: git://codeaurora.org/kernel/msm.git

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h      |    8 ++++++++
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_event.c        |   31 +++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a6a2509..c5de256 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -741,6 +741,14 @@ struct hci_rp_read_bd_addr {
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
index a7fd63a..869ab72 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -172,6 +172,8 @@ struct hci_dev {
 
 	__u8		flow_ctl_mode;
 
+	__u16		block_len;
+
 	unsigned int	auto_accept_delay;
 
 	unsigned long	quirks;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index efad012..a646310 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -774,6 +774,33 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
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
+	if (hdev->flow_ctl_mode == HCI_FLOW_CTL_MODE_BLOCK_BASED) {
+		hdev->acl_mtu  = __le16_to_cpu(rp->max_acl_len);
+		hdev->sco_mtu = 0;
+		hdev->block_len = __le16_to_cpu(rp->block_len);
+		/* acl_pkts indicates the number of blocks */
+		hdev->acl_pkts = __le16_to_cpu(rp->num_blocks);
+		hdev->sco_pkts = 0;
+		hdev->acl_cnt = hdev->acl_pkts;
+		hdev->sco_cnt = 0;
+	}
+
+	BT_DBG("%s acl mtu %d:%d, block len %d", hdev->name, hdev->acl_mtu,
+					hdev->acl_cnt, hdev->block_len);
+
+	hci_req_complete(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, rp->status);
+}
+
 static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -1989,6 +2016,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
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

