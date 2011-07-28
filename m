Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Mark not declared l2cap_core functions as static
Date: Thu, 28 Jul 2011 16:24:33 +0200
Message-ID: <1311863073-12296-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f7f8e2c..c1d19336 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1239,7 +1239,7 @@ static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
 		__clear_retrans_timer(chan);
 }
 
-void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
+static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct hci_conn *hcon = chan->conn->hcon;
 	u16 flags;
@@ -1255,7 +1255,7 @@ void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 	hci_send_acl(hcon, skb, flags);
 }
 
-void l2cap_streaming_send(struct l2cap_chan *chan)
+static void l2cap_streaming_send(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb;
 	u16 control, fcs;
@@ -1321,7 +1321,7 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 	l2cap_do_send(chan, tx_skb);
 }
 
-int l2cap_ertm_send(struct l2cap_chan *chan)
+static int l2cap_ertm_send(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb, *tx_skb;
 	u16 control, fcs;
@@ -1459,7 +1459,7 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
 	return sent;
 }
 
-struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
+static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
@@ -1489,7 +1489,7 @@ struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr
 	return skb;
 }
 
-struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
+static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
@@ -1518,7 +1518,7 @@ struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *m
 	return skb;
 }
 
-struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
+static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
@@ -1564,7 +1564,7 @@ struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *
 	return skb;
 }
 
-int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
+static int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
 	struct sk_buff *skb;
 	struct sk_buff_head sar_queue;
-- 
on behalf of ST-Ericsson

