Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 08/22] Bluetooth: Remove sk_backlog usage from L2CAP
Date: Sat, 17 Dec 2011 19:29:28 -0200
Message-Id: <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

We run everything in the same lock now. The backlog queue is useless now

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ed67ac0..31c94fd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1960,8 +1960,6 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
 static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 {
-	struct sock *sk = chan->sk;
-
 	chan->expected_ack_seq = 0;
 	chan->unacked_frames = 0;
 	chan->buffer_seq = 0;
@@ -1975,9 +1973,6 @@ static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 	skb_queue_head_init(&chan->srej_q);
 
 	INIT_LIST_HEAD(&chan->srej_l);
-
-
-	sk->sk_backlog_rcv = l2cap_ertm_data_rcv;
 }
 
 static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
@@ -4203,12 +4198,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		break;
 
 	case L2CAP_MODE_ERTM:
-		if (!sock_owned_by_user(sk)) {
-			l2cap_ertm_data_rcv(sk, skb);
-		} else {
-			if (sk_add_backlog(sk, skb))
-				goto drop;
-		}
+		l2cap_ertm_data_rcv(sk, skb);
 
 		goto done;
 
-- 
1.7.6.4

