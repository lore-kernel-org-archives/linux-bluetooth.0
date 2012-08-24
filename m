Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 19/22] Bluetooth: AMP: Write remote AMP Assoc
Date: Fri, 24 Aug 2012 17:00:18 +0300
Message-Id: <1345816821-32331-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving HCI Command Status after HCI Create Physical Link
execute HCI Write Remote AMP Assoc command to AMP controller.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h      |    2 +
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/amp.c              |   76 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   29 +++++++++++++++
 4 files changed, 109 insertions(+)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index b376cc3..fdf9d03 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -21,5 +21,7 @@ void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
 void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
 void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct phy_link *plink);
+void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
+void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
 
 #endif /* __AMP_H */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0676d90..28b2f98 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -127,6 +127,8 @@ struct le_scan_params {
 struct amp_assoc {
 	__u16	len;
 	__u16	offset;
+	__u16	rem_len;
+	__u16	len_so_far;
 	__u8	data[HCI_MAX_AMP_ASSOC_SIZE];
 };
 
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 71af56c..7839699 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -44,6 +44,82 @@ void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
 }
 
+static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
+				     struct phy_link *plink)
+{
+	struct hci_cp_write_remote_amp_assoc *cp;
+	struct amp_ctrl *ctrl;
+	u16 frag_len, len;
+
+	ctrl = amp_ctrl_lookup(mgr, plink->remote_id);
+	if (!ctrl)
+		return;
+
+	if (!ctrl->assoc_rem_len) {
+		BT_DBG("all fragments are written");
+		ctrl->assoc_rem_len = ctrl->assoc_len;
+		ctrl->assoc_len_so_far = 0;
+
+		amp_ctrl_put(ctrl);
+		return;
+	}
+
+	frag_len = min_t(u16, 248, ctrl->assoc_rem_len);
+	len = frag_len + sizeof(*cp);
+
+	cp = kzalloc(len, GFP_KERNEL);
+	if (!cp) {
+		amp_ctrl_put(ctrl);
+		return;
+	}
+
+	BT_DBG("plink %p ctrl %p frag_len %u assoc_len %u rem_len %u",
+	       plink, ctrl, frag_len, ctrl->assoc_len, ctrl->assoc_rem_len);
+
+	cp->phy_handle = plink->handle;
+	cp->len_so_far = cpu_to_le16(ctrl->assoc_len_so_far);
+	cp->rem_len = cpu_to_le16(ctrl->assoc_rem_len);
+	memcpy(cp->frag, ctrl->assoc, frag_len);
+
+	ctrl->assoc_len_so_far += frag_len;
+	ctrl->assoc_rem_len -= frag_len;
+
+	amp_ctrl_put(ctrl);
+
+	hci_send_cmd(hdev, HCI_OP_WRITE_REMOTE_AMP_ASSOC, len, cp);
+
+	kfree(cp);
+}
+
+void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle)
+{
+	struct phy_link *plink;
+
+	BT_DBG("handle 0x%2.2x", handle);
+
+	plink = phylink_lookup_by_handle(handle);
+	if (!plink)
+		return;
+
+	amp_write_rem_assoc_frag(hdev, plink->mgr, plink);
+
+	phylink_put(plink);
+}
+
+void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle)
+{
+	struct phy_link *plink;
+
+	BT_DBG("hdev %s", hdev->name);
+
+	/* Write Remote AMP Assoc */
+	plink = phylink_lookup_by_handle(handle);
+	if (plink) {
+		amp_write_rem_assoc_frag(hdev, plink->mgr, plink);
+		phylink_put(plink);
+	}
+}
+
 void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct phy_link *plink)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f151ed2..71833fd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1215,6 +1215,20 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 	hci_req_complete(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, status);
 }
 
+static void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev,
+					  struct sk_buff *skb)
+{
+	struct hci_rp_write_remote_amp_assoc *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x phy_handle 0x%2.2x",
+	       hdev->name, rp->status, rp->phy_handle);
+
+	if (rp->status)
+		return;
+
+	amp_write_rem_assoc_continue(hdev, rp->phy_handle);
+}
+
 static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -1688,7 +1702,18 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 
 static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
 {
+	struct hci_cp_create_phy_link *cp;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_DISCONNECT);
+	if (!cp)
+		return;
+
+	amp_write_remote_assoc(hdev, cp->phy_handle);
 }
 
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -2419,6 +2444,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_write_le_host_supported(hdev, skb);
 		break;
 
+	case HCI_OP_WRITE_REMOTE_AMP_ASSOC:
+		hci_cc_write_remote_amp_assoc(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
-- 
1.7.9.5

