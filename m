Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org, gustavo@padovan.org
Subject: [PATCHv5 16/17] Bluetooth: A2MP: Add fallback to normal l2cap init sequence
Date: Mon, 17 Sep 2012 16:24:33 +0300
Message-Id: <1347888274-30779-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When there is no remote AMP controller found fallback to normal
L2CAP sequence.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/a2mp.c          |   28 ++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c    |    2 +-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index aba830f..0967f9e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -769,5 +769,6 @@ int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
+void l2cap_send_conn_req(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index bc29246..0904c58 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -181,6 +181,7 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 	u16 len = le16_to_cpu(hdr->len);
 	struct a2mp_cl *cl;
 	u16 ext_feat;
+	bool found = false;
 
 	if (len < sizeof(*rsp))
 		return -EINVAL;
@@ -211,6 +212,7 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 		if (cl->id != HCI_BREDR_ID && cl->type == HCI_AMP) {
 			struct a2mp_info_req req;
 
+			found = true;
 			req.id = cl->id;
 			a2mp_send(mgr, A2MP_GETINFO_REQ, __next_ident(mgr),
 				  sizeof(req), &req);
@@ -220,6 +222,32 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 		cl = (void *) skb_pull(skb, sizeof(*cl));
 	}
 
+	/* Fall back to L2CAP init sequence */
+	if (!found) {
+		struct l2cap_conn *conn = mgr->l2cap_conn;
+		struct l2cap_chan *chan;
+
+		mutex_lock(&conn->chan_lock);
+
+		list_for_each_entry(chan, &conn->chan_l, list) {
+
+			BT_DBG("chan %p state %s", chan,
+			       state_to_string(chan->state));
+
+			if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP)
+				continue;
+
+			l2cap_chan_lock(chan);
+
+			if (chan->state == BT_CONNECT)
+				l2cap_send_conn_req(chan);
+
+			l2cap_chan_unlock(chan);
+		}
+
+		mutex_unlock(&conn->chan_lock);
+	}
+
 	return 0;
 }
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index df27198..8717678 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -958,7 +958,7 @@ static bool __amp_capable(struct l2cap_chan *chan)
 		return false;
 }
 
-static void l2cap_send_conn_req(struct l2cap_chan *chan)
+void l2cap_send_conn_req(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_conn_req req;
-- 
1.7.9.5

