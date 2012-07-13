Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 19/20] Bluetooth: AMP: Write remote AMP Assoc
Date: Fri, 13 Jul 2012 16:39:21 +0300
Message-Id: <1342186762-32329-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1342186762-32329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1342186762-32329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving HCI Command Status after HCI Create Physical Link
execute HCI Write Remote AMP Assoc command to AMP controller.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/amp.c              |   60 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e333e70..7412085 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -144,6 +144,8 @@ struct hci_cb_cmd {
 struct amp_assoc {
 	__u16	len;
 	__u16	offset;
+	__u16	rem_len;
+	__u16	len_so_far;
 	__u8	data[HCI_MAX_AMP_ASSOC_SIZE];
 };
 
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 89a6604..9f2a875 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -123,6 +123,61 @@ void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
 		   GFP_KERNEL);
 }
 
+static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
+				     struct phy_link *plink);
+
+static void amp_write_rem_assoc_cs(struct hci_dev *hdev,
+				   struct hci_cb_cmd *cmd)
+{
+	struct amp_mgr *mgr = cmd->opt;
+	struct phy_link *plink;
+	u16 frag_len;
+
+	BT_DBG("mgr %p", mgr);
+
+	if (!cmd->status)
+		return;
+
+	plink = phylink_lookup(mgr, hdev->id, 0);
+	if (!plink)
+		return;
+
+	frag_len = min_t(u16, 248, plink->rem_assoc.rem_len);
+	plink->rem_assoc.len_so_far += frag_len;
+	plink->rem_assoc.rem_len -= frag_len;
+
+	if (plink->rem_assoc.rem_len > 0)
+		/* Send another fragment */
+		amp_write_rem_assoc_frag(hdev, mgr, plink);
+
+	phylink_put(plink);
+}
+
+static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
+				     struct phy_link *plink)
+{
+	struct hci_cp_write_remote_amp_assoc *cp;
+	u16 frag_len, len;
+
+	frag_len = min_t(u16, 248, plink->rem_assoc.rem_len);
+	len = frag_len + sizeof(*cp);
+
+	cp = kzalloc(len, GFP_KERNEL);
+	if (!cp)
+		return;
+
+	cp->phy_handle = plink->handle;
+	cp->len_so_far = cpu_to_le16(plink->rem_assoc.len_so_far);
+	cp->rem_len = cpu_to_le16(plink->rem_assoc.rem_len);
+
+	amp_mgr_get(mgr);
+
+	hci_cmd_cb(hdev, HCI_OP_WRITE_REMOTE_AMP_ASSOC, len, &cp,
+		   amp_write_rem_assoc_cs, mgr, cb_destructor, GFP_KERNEL);
+
+	kfree(cp);
+}
+
 static void amp_create_phylink_cs(struct hci_dev *hdev,
 				  struct hci_cb_cmd *cmd)
 {
@@ -132,6 +187,11 @@ static void amp_create_phylink_cs(struct hci_dev *hdev,
 	BT_DBG("mgr %p", mgr);
 
 	/* Write Remote AMP Assoc */
+	plink = phylink_lookup(mgr, hdev->id, 0);
+	if (plink) {
+		amp_write_rem_assoc_frag(hdev, mgr, plink);
+		phylink_put(plink);
+	}
 }
 
 void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
-- 
1.7.9.5

