Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 22/26] Bluetooth: AMP: Process Chan Selected event
Date: Fri, 17 Aug 2012 17:33:17 +0300
Message-Id: <1345214001-7053-23-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Channel Selected event indicates that link information data is available.
Read it with Read Local AMP Assoc command. The data shall be sent in the
A2MP Create Physical Link Request.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    1 +
 include/net/bluetooth/amp.h  |    2 ++
 net/bluetooth/a2mp.c         |    2 +-
 net/bluetooth/amp.c          |   71 ++++++++++++++++++++++++++++++++++++++----
 net/bluetooth/hci_event.c    |   23 ++++++++++++++
 5 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index eaaa3e4..c8ecbe5 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -131,6 +131,7 @@ extern struct mutex amp_mgr_list_lock;
 
 void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
+u8 __next_ident(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index b376cc3..ab4e195 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -19,6 +19,8 @@
 void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
 void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
 void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
+void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
+				   struct phy_link *plink);
 void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct phy_link *plink);
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 40e3c94..a57d99e 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -70,7 +70,7 @@ void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
 	kfree(cmd);
 }
 
-static u8 __next_ident(struct amp_mgr *mgr)
+u8 __next_ident(struct amp_mgr *mgr)
 {
 	if (++mgr->ident == 0)
 		mgr->ident = 1;
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 652108f..07afb21 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -124,7 +124,60 @@ void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
 			      cb_destructor, GFP_KERNEL);
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
+void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
+				   struct phy_link *plink)
+{
+	struct hci_cp_read_local_amp_assoc cp;
+	struct amp_mgr *mgr = plink->mgr;
+
+	cp.phy_handle = plink->handle;
+	cp.len_so_far = cpu_to_le16(0);
+	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
+
+	hci_dev_hold(hdev);
+	amp_mgr_get(mgr);
+
+	/* Read Local AMP Assoc final link information data */
+	hci_callback_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp),
+			      &cp, amp_read_loc_assoc_complete_final_cb,
+			      mgr, cb_destructor, GFP_KERNEL);
+}
+
+static bool amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 				     struct phy_link *plink);
 
 static void amp_write_rem_assoc_cs_cb(struct hci_dev *hdev,
@@ -142,12 +195,16 @@ static void amp_write_rem_assoc_cs_cb(struct hci_dev *hdev,
 	if (!plink)
 		return;
 
-	amp_write_rem_assoc_frag(hdev, mgr, plink);
+	/* All fragments are written */
+	if (amp_write_rem_assoc_frag(hdev, mgr, plink)) {
+		/* Expect Channel Select event */
+	}
 
 	phylink_put(plink);
 }
 
-static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
+/* Write AMP Assoc data fragments, returns true with last fragment written*/
+static bool amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 				     struct phy_link *plink)
 {
 	struct hci_cp_write_remote_amp_assoc *cp;
@@ -156,7 +213,7 @@ static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 
 	ctrl = amp_ctrl_lookup(mgr, plink->remote_id);
 	if (!ctrl)
-		return;
+		return false;
 
 	if (!ctrl->assoc_rem_len) {
 		BT_DBG("all fragments are written");
@@ -164,7 +221,7 @@ static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 		ctrl->assoc_len_so_far = 0;
 
 		amp_ctrl_put(ctrl);
-		return;
+		return true;
 	}
 
 	frag_len = min_t(u16, 248, ctrl->assoc_rem_len);
@@ -173,7 +230,7 @@ static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 	cp = kzalloc(len, GFP_KERNEL);
 	if (!cp) {
 		amp_ctrl_put(ctrl);
-		return;
+		return false;
 	}
 
 	BT_DBG("plink %p ctrl %p frag_len %u assoc_len %u rem_len %u",
@@ -197,6 +254,8 @@ static void amp_write_rem_assoc_frag(struct hci_dev *hdev, struct amp_mgr *mgr,
 			      GFP_KERNEL);
 
 	kfree(cp);
+
+	return false;
 }
 
 static void amp_create_phylink_cs_cb(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a03b385..15c7ce6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3553,6 +3553,25 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
+static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_channel_selected *ev = (void *) skb->data;
+	__u8 phy_handle = ev->phy_handle;
+	struct phy_link *plink;
+
+	BT_DBG("%s handle 0x%2.2x", hdev->name, phy_handle);
+
+	skb_pull(skb, sizeof(*ev));
+
+	plink = phylink_lookup_by_handle(phy_handle);
+	if (!plink)
+		return;
+
+	amp_read_loc_assoc_final_data(hdev, plink);
+
+	phylink_put(plink);
+}
+
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *) skb->data;
@@ -3709,6 +3728,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
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

