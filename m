Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/5] Bluetooth: AMP: Send A2MP Create Phylink Rsp after Assoc write
Date: Fri,  7 Dec 2012 14:59:05 +0200
Message-Id: <1354885148-4677-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1354885148-4677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1354885148-4677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Postpone sending A2MP Create Phylink Response till we got successful
HCI Command Complete after HCI Write Remote AMP Assoc.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    2 ++
 net/bluetooth/a2mp.c         |   38 ++++++++++++++++++++++++++++++++++++--
 net/bluetooth/amp.c          |    6 +++++-
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 42f2176..8b39327 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -23,6 +23,7 @@ enum amp_mgr_state {
 	READ_LOC_AMP_INFO,
 	READ_LOC_AMP_ASSOC,
 	READ_LOC_AMP_ASSOC_FINAL,
+	WRITE_REMOTE_AMP_ASSOC,
 };
 
 struct amp_mgr {
@@ -144,5 +145,6 @@ void a2mp_discover_amp(struct l2cap_chan *chan);
 void a2mp_send_getinfo_rsp(struct hci_dev *hdev);
 void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status);
 void a2mp_send_create_phy_link_req(struct hci_dev *hdev, u8 status);
+void a2mp_send_create_phy_link_rsp(struct hci_dev *hdev, u8 status);
 
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 2f67d5e..c960c20 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -499,8 +499,16 @@ send_rsp:
 	if (hdev)
 		hci_dev_put(hdev);
 
-	a2mp_send(mgr, A2MP_CREATEPHYSLINK_RSP, hdr->ident, sizeof(rsp),
-		  &rsp);
+	/* Reply error now and succes after HCI Write Remote AMP Assoc
+	   command complete with success status
+	 */
+	if (rsp.status != A2MP_STATUS_SUCCESS) {
+		a2mp_send(mgr, A2MP_CREATEPHYSLINK_RSP, hdr->ident,
+			  sizeof(rsp), &rsp);
+	} else {
+		mgr->state = WRITE_REMOTE_AMP_ASSOC;
+		mgr->ident = hdr->ident;
+	}
 
 	skb_pull(skb, le16_to_cpu(hdr->len));
 	return 0;
@@ -949,6 +957,32 @@ clean:
 	kfree(req);
 }
 
+void a2mp_send_create_phy_link_rsp(struct hci_dev *hdev, u8 status)
+{
+	struct amp_mgr *mgr;
+	struct a2mp_physlink_rsp rsp;
+	struct hci_conn *hs_hcon;
+
+	mgr = amp_mgr_lookup_by_state(WRITE_REMOTE_AMP_ASSOC);
+	if (!mgr)
+		return;
+
+	hs_hcon = hci_conn_hash_lookup_state(hdev, AMP_LINK, BT_CONNECT);
+	if (!hs_hcon) {
+		rsp.status = A2MP_STATUS_UNABLE_START_LINK_CREATION;
+	} else {
+		rsp.remote_id = hs_hcon->remote_id;
+		rsp.status = A2MP_STATUS_SUCCESS;
+	}
+
+	BT_DBG("%s mgr %p hs_hcon %p status %u", hdev->name, mgr, hs_hcon,
+	       status);
+
+	rsp.local_id = hdev->id;
+	a2mp_send(mgr, A2MP_CREATEPHYSLINK_RSP, mgr->ident, sizeof(rsp), &rsp);
+	amp_mgr_put(mgr);
+}
+
 void a2mp_discover_amp(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 1b0d92c..88720e8 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -317,7 +317,11 @@ void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle)
 	if (!hcon)
 		return;
 
-	amp_write_rem_assoc_frag(hdev, hcon);
+	/* Send A2MP create phylink rsp whan all fragments are
+	   written
+	 */
+	if (amp_write_rem_assoc_frag(hdev, hcon))
+		a2mp_send_create_phy_link_rsp(hdev, 0);
 }
 
 void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle)
-- 
1.7.10.4

