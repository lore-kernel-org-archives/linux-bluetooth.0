Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/8] Bluetooth: Add HCI Read Flow Control Mode function
Date: Thu,  1 Dec 2011 14:42:10 +0200
Message-Id: <1322743335-8671-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Upstream Code Aurora function with minor trivial fixes.
Origin: git://codeaurora.org/kernel/msm.git

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |    6 ++++++
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_event.c        |   19 +++++++++++++++++++
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b8dfdb0..453e7fc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -677,6 +677,12 @@ struct hci_rp_read_local_oob_data {
 
 #define HCI_OP_READ_INQ_RSP_TX_POWER	0x0c58
 
+#define HCI_OP_READ_FLOW_CONTROL_MODE	0x0c66
+struct hci_rp_read_flow_control_mode {
+	__u8     status;
+	__u8     mode;
+} __packed;
+
 #define HCI_OP_WRITE_LE_HOST_SUPPORTED	0x0c6d
 struct hci_cp_write_le_host_supported {
 	__u8 le;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1795257..a7fd63a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -170,6 +170,8 @@ struct hci_dev {
 	__u32		amp_max_flush_to;
 	__u32		amp_be_flush_to;
 
+	__u8		flow_ctl_mode;
+
 	unsigned int	auto_accept_delay;
 
 	unsigned long	quirks;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f81b47b..efad012 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -720,6 +720,21 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, rp->status);
 }
 
+static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
+						struct sk_buff *skb)
+{
+	struct hci_rp_read_flow_control_mode *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->flow_ctl_mode = rp->mode;
+
+	hci_req_complete(hdev, HCI_OP_READ_FLOW_CONTROL_MODE, rp->status);
+}
+
 static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_buffer_size *rp = (void *) skb->data;
@@ -1978,6 +1993,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_write_ca_timeout(hdev, skb);
 		break;
 
+	case HCI_OP_READ_FLOW_CONTROL_MODE:
+		hci_cc_read_flow_control_mode(hdev, skb);
+		break;
+
 	case HCI_OP_READ_LOCAL_AMP_INFO:
 		hci_cc_read_local_amp_info(hdev, skb);
 		break;
-- 
1.7.4.1

