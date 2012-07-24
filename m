Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 18/20] Bluetooth: AMP: Process Chan Selected event
Date: Tue, 24 Jul 2012 16:21:59 +0300
Message-Id: <1343136121-22476-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Channel Selected event indicates that link information data is available.
Read it with Read Local AMP Assoc command. The data shall be sent in the
A2MP Create Physical Link Request.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h     |    1 +
 include/net/bluetooth/hci_core.h |    6 +++
 net/bluetooth/a2mp.c             |    2 +-
 net/bluetooth/amp.c              |   88 +++++++++++++++++++++++++++++++++++---
 net/bluetooth/hci_core.c         |   12 +++---
 net/bluetooth/hci_event.c        |    9 ++++
 6 files changed, 105 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index bf18a37..2b15642 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -127,6 +127,7 @@ struct a2mp_physlink_rsp {
 
 void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
+u8 __next_ident(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 50b4613..02ec147 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1117,6 +1117,12 @@ int hci_cancel_le_scan(struct hci_dev *hdev);
 
 u8 bdaddr_to_le(u8 bdaddr_type);
 struct hci_cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode);
+int hci_add_cb(struct hci_dev *hdev, __u16 opcode,
+	       void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
+	       void *opt,
+	       void (*destructor)(struct hci_dev *hdev,
+				  struct hci_cb_cmd *cmd),
+	       gfp_t flags);
 int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
 	       void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
 	       void *opt,
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index b29275a..fb785e4 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -64,7 +64,7 @@ void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
 	kfree(cmd);
 }
 
-static u8 __next_ident(struct amp_mgr *mgr)
+u8 __next_ident(struct amp_mgr *mgr)
 {
 	if (++mgr->ident == 0)
 		mgr->ident = 1;
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index e8237fc..350e130 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -123,7 +123,68 @@ void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
 		   GFP_KERNEL);
 }
 
-static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
+/* Read Local AMP Assoc final link information data callback */
+static void amp_read_loc_assoc_complete_final_cb(struct hci_dev *hdev,
+						 struct hci_cb_cmd *cmd)
+{
+	struct amp_mgr *mgr = cmd->opt;
+	struct amp_assoc *loc_assoc = &hdev->loc_assoc;
+	struct a2mp_physlink_req *req;
+	struct phy_link *plink;
+	size_t len;
+
+	len = sizeof(*req) + loc_assoc->len;
+
+	BT_DBG("%s mgr %p assoc_len %zu", hdev->name, mgr, len);
+
+	req = kzalloc(len, GFP_KERNEL);
+	if (!req)
+		return;
+
+	plink = phylink_lookup(mgr, hdev->id, 0);
+	if (!plink)
+		goto clean;
+
+	req->local_id = plink->local_id;
+	req->remote_id = plink->remote_id;
+	memcpy(req->amp_assoc, loc_assoc->data, loc_assoc->len);
+
+	phylink_put(plink);
+
+	a2mp_send(mgr, A2MP_CREATEPHYSLINK_REQ, __next_ident(mgr), len, req);
+
+clean:
+	kfree(req);
+}
+
+static void amp_chan_sel_evt_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd)
+{
+	struct amp_mgr *mgr = cmd->opt;
+	struct hci_cp_read_local_amp_assoc cp;
+	struct phy_link *plink;
+
+	BT_DBG("mgr %p", mgr);
+
+	/* We should have phy link */
+	plink = phylink_lookup(mgr, hdev->id, 0);
+	if (!plink)
+		return;
+
+	cp.phy_handle = plink->handle;
+	cp.len_so_far = cpu_to_le16(0);
+	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
+
+	phylink_put(plink);
+
+	amp_mgr_get(mgr);
+
+	/* Read Local AMP Assoc final link information data */
+	hci_cmd_cb(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp,
+		   amp_read_loc_assoc_complete_final_cb, mgr, cb_destructor,
+		   GFP_KERNEL);
+}
+
+static bool amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 				     struct phy_link *plink);
 
 static void amp_write_rem_assoc_cs(struct hci_dev *hdev,
@@ -141,12 +202,24 @@ static void amp_write_rem_assoc_cs(struct hci_dev *hdev,
 	if (!plink)
 		return;
 
-	amp_write_rem_assoc_frag(hdev, mgr, plink);
+	/* All fragments are written */
+	if (amp_write_rem_assoc_frag(hdev, mgr, plink)) {
+		struct amp_mgr *mgr = plink->mgr;
+
+		/* Expect Channel Select event */
+		hci_dev_hold(hdev);
+		amp_mgr_get(mgr);
+
+		hci_add_cb(hdev, HCI_EV_CHANNEL_SELECTED,
+			   amp_chan_sel_evt_cb, mgr,
+			   cb_destructor, GFP_KERNEL);
+	}
 
 	phylink_put(plink);
 }
 
-static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
+/* Write AMP Assoc data fragments, returns true with last fragment written*/
+static bool amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 				     struct phy_link *plink)
 {
 	struct hci_cp_write_remote_amp_assoc *cp;
@@ -155,7 +228,7 @@ static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 
 	ctrl = amp_ctrl_lookup(mgr, plink->remote_id);
 	if (!ctrl)
-		return;
+		return false;
 
 	if (!ctrl->assoc_rem_len) {
 		BT_DBG("all fragments are written");
@@ -163,7 +236,7 @@ static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 		ctrl->assoc_len_so_far = 0;
 
 		amp_ctrl_put(ctrl);
-		return;
+		return true;
 	}
 
 	frag_len = min_t(u16, 248, ctrl->assoc_rem_len);
@@ -172,7 +245,7 @@ static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 	cp = kzalloc(len, GFP_KERNEL);
 	if (!cp) {
 		amp_ctrl_put(ctrl);
-		return;
+		return false;
 	}
 
 	BT_DBG("plink %p ctrl %p frag_len %u assoc_len %u rem_len %u",
@@ -194,6 +267,8 @@ static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 		   amp_write_rem_assoc_cs, mgr, cb_destructor, GFP_KERNEL);
 
 	kfree(cp);
+
+	return false;
 }
 
 static void amp_create_phylink_cs(struct hci_dev *hdev,
@@ -207,6 +282,7 @@ static void amp_create_phylink_cs(struct hci_dev *hdev,
 	/* Write Remote AMP Assoc */
 	plink = phylink_lookup(mgr, hdev->id, 0);
 	if (plink) {
+		hci_dev_hold(hdev);
 		amp_write_rem_assoc_frag(hdev, mgr, plink);
 		phylink_put(plink);
 	}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ccd4bd7..58f884e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2121,12 +2121,12 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	return 0;
 }
 
-static int hci_add_cb(struct hci_dev *hdev, __u16 opcode,
-		      void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
-		      void *opt,
-		      void (*destructor)(struct hci_dev *hdev,
-					 struct hci_cb_cmd *cmd),
-		      gfp_t flags)
+int hci_add_cb(struct hci_dev *hdev, __u16 opcode,
+	       void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
+	       void *opt,
+	       void (*destructor)(struct hci_dev *hdev,
+				  struct hci_cb_cmd *cmd),
+	       gfp_t flags)
 {
 	struct hci_cb_cmd *cmd;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3c00b79..6615be6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3550,6 +3550,11 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
+static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	hci_process_cb(hdev, HCI_EV_CHANNEL_SELECTED, 0);
+}
+
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *) skb->data;
@@ -3706,6 +3711,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_meta_evt(hdev, skb);
 		break;
 
+	case HCI_EV_CHANNEL_SELECTED:
+		hci_chan_selected_evt(hdev, skb);
+		break;
+
 	case HCI_EV_REMOTE_OOB_DATA_REQUEST:
 		hci_remote_oob_data_request_evt(hdev, skb);
 		break;
-- 
1.7.9.5

