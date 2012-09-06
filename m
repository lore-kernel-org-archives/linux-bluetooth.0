Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 17/19] Bluetooth: AMP: Process Chan Selected event
Date: Thu,  6 Sep 2012 15:19:55 +0300
Message-Id: <1346933997-14369-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Channel Selected event indicates that link information data is available.
Read it with Read Local AMP Assoc command. The data shall be sent in the
A2MP Create Physical Link Request.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    3 +++
 include/net/bluetooth/amp.h  |    2 ++
 net/bluetooth/a2mp.c         |   39 ++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/amp.c          |   15 +++++++++++++++
 net/bluetooth/hci_event.c    |   21 +++++++++++++++++++++
 5 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 6e88a80..c955f1f 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -30,6 +30,7 @@ struct amp_mgr {
 	enum {
 		READ_LOC_AMP_INFO,
 		READ_LOC_AMP_ASSOC,
+		READ_LOC_AMP_ASSOC_FINAL,
 	} state;
 	unsigned long		flags;
 
@@ -132,6 +133,7 @@ extern struct mutex amp_mgr_list_lock;
 
 void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
+u8 __next_ident(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 struct amp_mgr *amp_mgr_lookup_by_state(u8 state);
@@ -139,5 +141,6 @@ void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
 void a2mp_discover_amp(struct l2cap_chan *chan);
 void a2mp_send_getinfo_rsp(struct hci_dev *hdev);
 void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status);
+void a2mp_send_create_phy_link_req(struct hci_dev *hdev, u8 status);
 
 #endif /* __A2MP_H */
diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index 74fcf98..70d33d4 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -19,6 +19,8 @@
 void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
 void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
 void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
+void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
+				   struct hci_conn *hcon);
 void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct hci_conn *hcon);
 void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 05522ea..c9a3bc8 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -68,7 +68,7 @@ void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
 	kfree(cmd);
 }
 
-static u8 __next_ident(struct amp_mgr *mgr)
+u8 __next_ident(struct amp_mgr *mgr)
 {
 	if (++mgr->ident == 0)
 		mgr->ident = 1;
@@ -867,6 +867,43 @@ void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status)
 	kfree(rsp);
 }
 
+void a2mp_send_create_phy_link_req(struct hci_dev *hdev, u8 status)
+{
+	struct amp_mgr *mgr;
+	struct amp_assoc *loc_assoc = &hdev->loc_assoc;
+	struct a2mp_physlink_req *req;
+	struct hci_conn *hcon;
+	size_t len;
+
+	mgr = amp_mgr_lookup_by_state(READ_LOC_AMP_ASSOC_FINAL);
+	if (!mgr)
+		return;
+
+	len = sizeof(*req) + loc_assoc->len;
+
+	BT_DBG("%s mgr %p assoc_len %zu", hdev->name, mgr, len);
+
+	req = kzalloc(len, GFP_KERNEL);
+	if (!req) {
+		amp_mgr_put(mgr);
+		return;
+	}
+
+	hcon = hci_conn_hash_lookup_id(hdev, hdev->id);
+	if (!hcon)
+		goto clean;
+
+	req->local_id = hdev->id;
+	req->remote_id = hcon->remote_id;
+	memcpy(req->amp_assoc, loc_assoc->data, loc_assoc->len);
+
+	a2mp_send(mgr, A2MP_CREATEPHYSLINK_REQ, __next_ident(mgr), len, req);
+
+clean:
+	amp_mgr_put(mgr);
+	kfree(req);
+}
+
 void a2mp_discover_amp(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 6f03fb3..9e2e639 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -44,6 +44,21 @@ void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
 }
 
+void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
+				   struct hci_conn *hcon)
+{
+	struct hci_cp_read_local_amp_assoc cp;
+	struct amp_mgr *mgr = hcon->amp_mgr;
+
+	cp.phy_handle = hcon->handle;
+	cp.len_so_far = cpu_to_le16(0);
+	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
+
+	mgr->state = READ_LOC_AMP_ASSOC_FINAL;
+
+	/* Read Local AMP Assoc final link information data */
+	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
+}
 
 /* Write AMP Assoc data fragments, returns true with last fragment written*/
 static bool amp_write_rem_assoc_frag(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8cfaf19..0841b25 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -901,6 +901,7 @@ static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
 a2mp_rsp:
 	/* Send A2MP Rsp when all fragments are received */
 	a2mp_send_getampassoc_rsp(hdev, rp->status);
+	a2mp_send_create_phy_link_req(hdev, rp->status);
 }
 
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
@@ -3565,6 +3566,22 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
+static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_channel_selected *ev = (void *) skb->data;
+	struct hci_conn *hcon;
+
+	BT_DBG("%s handle 0x%2.2x", hdev->name, ev->phy_handle);
+
+	skb_pull(skb, sizeof(*ev));
+
+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
+	if (!hcon)
+		return;
+
+	amp_read_loc_assoc_final_data(hdev, hcon);
+}
+
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *) skb->data;
@@ -3721,6 +3738,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
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

