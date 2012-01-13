Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] Bluetooth: Use chan instead of sk
Date: Fri, 13 Jan 2012 17:21:42 +0200
Message-Id: <1326468103-12731-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove unneeded conversion from sk to chan.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a75ee3b..52c7412 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -73,7 +73,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
 static void l2cap_send_disconn_req(struct l2cap_conn *conn,
 				struct l2cap_chan *chan, int err);
 
-static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
+static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb);
 
 /* ---- L2CAP channels ---- */
 
@@ -4138,9 +4138,8 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u32 rx_cont
 	return 0;
 }
 
-static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
+int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	u32 control;
 	u16 req_seq;
 	int len, next_tx_seq_offset, req_seq_offset;
@@ -4241,7 +4240,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		break;
 
 	case L2CAP_MODE_ERTM:
-		l2cap_ertm_data_rcv(sk, skb);
+		l2cap_ertm_data_rcv(chan, skb);
 
 		goto done;
 
-- 
1.7.4.1

