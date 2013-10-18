Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Use hcon directly instead of conn->hcon where possible
Date: Fri, 18 Oct 2013 03:43:00 -0700
Message-Id: <1382092981-48006-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the HCI connection hcon is already dereferenced, then use hcon
directly instead of conn->hcon.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 7 +++----
 net/bluetooth/smp.c        | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 763b741..9757297 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6399,8 +6399,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	if (hcon->type != ACL_LINK)
 		goto drop;
 
-	chan = l2cap_global_chan_by_psm(0, psm, &conn->hcon->src,
-					&conn->hcon->dst);
+	chan = l2cap_global_chan_by_psm(0, psm, &hcon->src, &hcon->dst);
 	if (!chan)
 		goto drop;
 
@@ -6413,7 +6412,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 		goto drop;
 
 	/* Store remote BD_ADDR and PSM for msg_name */
-	bacpy(&bt_cb(skb)->bdaddr, &conn->hcon->dst);
+	bacpy(&bt_cb(skb)->bdaddr, &hcon->dst);
 	bt_cb(skb)->psm = psm;
 
 	if (!chan->ops->recv(chan, skb))
@@ -6433,7 +6432,7 @@ static void l2cap_att_channel(struct l2cap_conn *conn,
 		goto drop;
 
 	chan = l2cap_global_chan_by_scid(BT_CONNECTED, L2CAP_CID_ATT,
-					 &conn->hcon->src, &conn->hcon->dst);
+					 &hcon->src, &hcon->dst);
 	if (!chan)
 		goto drop;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fc200e0..85a2796c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -864,7 +864,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 		return -EILSEQ;
 	}
 
-	if (!test_bit(HCI_LE_ENABLED, &conn->hcon->hdev->dev_flags)) {
+	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags)) {
 		err = -ENOTSUPP;
 		reason = SMP_PAIRING_NOTSUPP;
 		goto done;
-- 
1.8.3.1

