Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Remove l2cap_conn->dst usage from AMP manager
Date: Sun, 13 Oct 2013 02:23:38 -0700
Message-Id: <1381656221-9821-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The l2cap_conn->dst address is just a pointer into the hci_conn->dst
structure. Use hci_conn->dst directly instead.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 3 ++-
 net/bluetooth/amp.c  | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 7e25be3..60ca528 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -537,7 +537,8 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 		goto send_rsp;
 	}
 
-	hcon = hci_conn_hash_lookup_ba(hdev, AMP_LINK, mgr->l2cap_conn->dst);
+	hcon = hci_conn_hash_lookup_ba(hdev, AMP_LINK,
+				       &mgr->l2cap_conn->hcon->dst);
 	if (!hcon) {
 		BT_ERR("No phys link exist");
 		rsp.status = A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS;
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 5497ed3..bb39509 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -111,7 +111,7 @@ static u8 __next_handle(struct amp_mgr *mgr)
 struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
 			     u8 remote_id, bool out)
 {
-	bdaddr_t *dst = mgr->l2cap_conn->dst;
+	bdaddr_t *dst = &mgr->l2cap_conn->hcon->dst;
 	struct hci_conn *hcon;
 
 	hcon = hci_conn_add(hdev, AMP_LINK, dst);
@@ -410,7 +410,8 @@ void amp_create_logical_link(struct l2cap_chan *chan)
 	struct hci_cp_create_accept_logical_link cp;
 	struct hci_dev *hdev;
 
-	BT_DBG("chan %p hs_hcon %p dst %pMR", chan, hs_hcon, chan->conn->dst);
+	BT_DBG("chan %p hs_hcon %p dst %pMR", chan, hs_hcon,
+	       &chan->conn->hcon->dst);
 
 	if (!hs_hcon)
 		return;
-- 
1.8.3.1

