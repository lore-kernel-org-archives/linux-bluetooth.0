Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 18/19] Bluetooth: AMP: Create phy link after A2MP Assoc rsp
Date: Fri, 29 Jun 2012 17:46:51 +0300
Message-Id: <1340981212-21709-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Create AMP Physical Link when receiving A2MP Get AMP Assoc Response.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h     |    1 +
 include/net/bluetooth/amp.h      |    4 ++
 include/net/bluetooth/hci_core.h |    2 +
 include/net/bluetooth/pal.h      |    1 -
 net/bluetooth/a2mp.c             |   12 +++++
 net/bluetooth/amp.c              |   94 +++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c        |   11 +++++
 net/bluetooth/pal.c              |    2 +
 8 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 68866f4..98438a4 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -130,5 +130,6 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
 void l2cap_discover_amp(struct l2cap_conn *conn);
+u8 __next_handle(struct amp_mgr *mgr);
 
 #endif /* __A2MP_H */
diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index e861675..b376cc3 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -14,8 +14,12 @@
 #ifndef __AMP_H
 #define __AMP_H
 
+#include <net/bluetooth/pal.h>
+
 void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
 void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
 void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
+void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
+			struct phy_link *plink);
 
 #endif /* __AMP_H */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fb0b4e4..cb26d61 100644
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
 
diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
index 8bac38b..0245dc8 100644
--- a/include/net/bluetooth/pal.h
+++ b/include/net/bluetooth/pal.h
@@ -18,7 +18,6 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
-#include <net/bluetooth/amp.h>
 
 struct phy_link {
 	struct list_head	list;
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index a4df006..64bdad6 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -72,6 +72,14 @@ static u8 __next_ident(struct amp_mgr *mgr)
 	return mgr->ident;
 }
 
+u8 __next_handle(struct amp_mgr *mgr)
+{
+	if (++mgr->handle == 0)
+		mgr->handle = 1;
+
+	return mgr->handle;
+}
+
 static inline void __a2mp_cl_bredr(struct a2mp_cl *cl)
 {
 	cl->id = 0;
@@ -379,6 +387,10 @@ static int a2mp_getampassoc_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	plink = hci_phylink_add(mgr, hdev->id, rsp->id, ctrl->assoc,
 				ctrl->assoc_len);
+	if (!plink)
+		goto done;
+
+	amp_create_phylink(hdev, mgr, plink);
 
 done:
 	skb_pull(skb, len - sizeof(*rsp));
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index ebe1fd7..0e54b98 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -17,6 +17,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/amp.h>
+#include <net/bluetooth/pal.h>
 
 static void amp_read_loc_info_complete(struct hci_dev *hdev,
 				       struct hci_cb_cmd *cmd)
@@ -118,5 +119,96 @@ void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
 	amp_mgr_get(mgr);
 
 	hci_cmd_cb(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp,
-		amp_read_loc_assoc_complete, mgr, cb_destructor, GFP_KERNEL);
+		   amp_read_loc_assoc_complete, mgr, cb_destructor,
+		   GFP_KERNEL);
+}
+
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
+	plink = hci_phylink_lookup(mgr, hdev->id, 0);
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
+static void amp_create_phylink_cs(struct hci_dev *hdev,
+				  struct hci_cb_cmd *cmd)
+{
+	struct amp_mgr *mgr = cmd->opt;
+	struct phy_link *plink;
+
+	BT_DBG("mgr %p", mgr);
+
+	/* Write Remote AMP Assoc */
+	plink = hci_phylink_lookup(mgr, hdev->id, 0);
+	if (plink) {
+		amp_write_rem_assoc_frag(hdev, mgr, plink);
+		phylink_put(plink);
+	}
+}
+
+void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
+			struct phy_link *plink)
+{
+	struct hci_cp_create_phy_link cp;
+
+	cp.phy_handle = plink->handle;
+
+	if (phylink_security(mgr->l2cap_conn->hcon, cp.key, &cp.key_len,
+			     &cp.key_type)) {
+		BT_DBG("Cannot create link key");
+		return;
+	}
+
+	amp_mgr_get(mgr);
+
+	hci_cmd_cb(hdev, HCI_OP_CREATE_PHY_LINK, sizeof(cp), &cp,
+		   amp_create_phylink_cs, mgr, cb_destructor, GFP_KERNEL);
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cbf4983..e20f26e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1698,6 +1698,13 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 	BT_DBG("%s status 0x%x", hdev->name, status);
 }
 
+static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	hci_process_cb(hdev, HCI_OP_CREATE_PHY_LINK, status);
+}
+
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2488,6 +2495,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_le_start_enc(hdev, ev->status);
 		break;
 
+	case HCI_OP_CREATE_PHY_LINK:
+		hci_cs_create_phylink(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
index a020f97..899574e 100644
--- a/net/bluetooth/pal.c
+++ b/net/bluetooth/pal.c
@@ -12,6 +12,7 @@
 */
 
 #include <net/bluetooth/pal.h>
+#include <crypto/hash.h>
 
 enum pal_states {
 	DISCONNECTED,
@@ -155,6 +156,7 @@ struct phy_link *hci_phylink_add(struct amp_mgr *mgr, u8 local_id,
 	plink->local_id = local_id;
 	plink->remote_id = remote_id;
 	plink->mgr = mgr;
+	plink->handle = __next_handle(mgr);
 
 	plink->rem_assoc.len = min_t(u16, assoc_size, HCI_MAX_AMP_ASSOC_SIZE);
 	memcpy(plink->rem_assoc.data, rem_assoc, plink->rem_assoc.len);
-- 
1.7.9.5

