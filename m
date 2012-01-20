Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use non locking get_chan and explicit lock
Date: Fri, 20 Jan 2012 13:50:26 +0200
Message-Id: <1327060226-16211-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For receiving ACL packets use __l2cap_get_chan_by_scid which is not
locking sk and explicitly lock sk after checking that it is exist.
Code looks nicer since now it is surrounded by lock/release.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d16ad49..53dbfd3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4243,7 +4243,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	u16 tx_seq;
 	int len;
 
-	chan = l2cap_get_chan_by_scid(conn, cid);
+	chan = __l2cap_get_chan_by_scid(conn, cid);
 	if (!chan) {
 		if (cid == L2CAP_CID_A2MP) {
 			chan = a2mp_channel_create(conn, skb);
@@ -4255,6 +4255,8 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	}
 
 	sk = chan->sk;
+	if (sk)
+		lock_sock(sk);
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
@@ -4681,10 +4683,11 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			goto drop;
 		}
 
-		chan = l2cap_get_chan_by_scid(conn, cid);
+		chan = __l2cap_get_chan_by_scid(conn, cid);
 
 		if (chan && chan->sk) {
 			struct sock *sk = chan->sk;
+			lock_sock(sk);
 
 			if (chan->imtu < len - L2CAP_HDR_SIZE) {
 				BT_ERR("Frame exceeding recv MTU (len %d, "
-- 
1.7.4.1

