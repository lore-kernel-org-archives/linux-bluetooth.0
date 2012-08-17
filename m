Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 19/26] Bluetooth: AMP: Write remote AMP Assoc
Date: Fri, 17 Aug 2012 17:33:14 +0300
Message-Id: <1345214001-7053-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving HCI Command Status after HCI Create Physical Link
execute HCI Write Remote AMP Assoc command to AMP controller.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/amp.c              |   81 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   15 +++++++
 3 files changed, 98 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b1a0d43..75e17d8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -138,6 +138,8 @@ struct hci_cb_cmd {
 struct amp_assoc {
 	__u16	len;
 	__u16	offset;
+	__u16	rem_len;
+	__u16	len_so_far;
 	__u8	data[HCI_MAX_AMP_ASSOC_SIZE];
 };
 
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index f0192cf..652108f 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -124,14 +124,95 @@ void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
 			      cb_destructor, GFP_KERNEL);
 }
 
+static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
+				     struct phy_link *plink);
+
+static void amp_write_rem_assoc_cs_cb(struct hci_dev *hdev,
+				      struct hci_cb_cmd *cmd)
+{
+	struct amp_mgr *mgr = cmd->opt;
+	struct phy_link *plink;
+
+	BT_DBG("mgr %p status 0x%2.2x", mgr, cmd->status);
+
+	if (cmd->status)
+		return;
+
+	plink = phylink_lookup(mgr, hdev->id, 0);
+	if (!plink)
+		return;
+
+	amp_write_rem_assoc_frag(hdev, mgr, plink);
+
+	phylink_put(plink);
+}
+
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
+	hci_dev_hold(hdev);
+	amp_mgr_get(mgr);
+
+	hci_callback_send_cmd(hdev, HCI_OP_WRITE_REMOTE_AMP_ASSOC, len, cp,
+			      amp_write_rem_assoc_cs_cb, mgr, cb_destructor,
+			      GFP_KERNEL);
+
+	kfree(cp);
+}
+
 static void amp_create_phylink_cs_cb(struct hci_dev *hdev,
 				     struct hci_cb_cmd *cmd)
 {
 	struct amp_mgr *mgr = cmd->opt;
+	struct phy_link *plink;
 
 	BT_DBG("mgr %p", mgr);
 
 	/* Write Remote AMP Assoc */
+	plink = phylink_lookup(mgr, hdev->id, 0);
+	if (plink) {
+		amp_write_rem_assoc_frag(hdev, mgr, plink);
+		phylink_put(plink);
+	}
 }
 
 void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8fdd0e0..a03b385 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1215,6 +1215,17 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
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
+	hci_callback_process(hdev, HCI_OP_WRITE_REMOTE_AMP_ASSOC, rp->status);
+}
+
 static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -2421,6 +2432,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
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

