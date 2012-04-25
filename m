Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: [RFC 6/8] Bluetooth: Lock the L2CAP channel when sending
Date: Wed, 25 Apr 2012 16:36:17 -0700
Message-Id: <1335396979-11692-7-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The ERTM and streaming mode transmit queue must only be accessed while
the L2CAP channel lock is held.  Adding this lock ensures that
multiple threads cannot simultaneously manipulate the queue when
sending and receiving concurrently.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6aefeaa..8ed6a74 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2035,26 +2035,35 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 	u32 control;
 	int err;
 
+	l2cap_chan_hold(chan);
+
 	/* Connectionless channel */
 	if (chan->chan_type == L2CAP_CHAN_CONN_LESS) {
 		skb = l2cap_create_connless_pdu(chan, msg, len, priority);
-		if (IS_ERR(skb))
-			return PTR_ERR(skb);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+			goto done;
+		}
 
 		l2cap_do_send(chan, skb);
-		return len;
+		err = len;
+		goto done;
 	}
 
 	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
 		/* Check outgoing MTU */
-		if (len > chan->omtu)
-			return -EMSGSIZE;
+		if (len > chan->omtu) {
+			err = -EMSGSIZE;
+			break;
+		}
 
 		/* Create a basic PDU */
 		skb = l2cap_create_basic_pdu(chan, msg, len, priority);
-		if (IS_ERR(skb))
-			return PTR_ERR(skb);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+			break;
+		}
 
 		l2cap_do_send(chan, skb);
 		err = len;
@@ -2067,30 +2076,38 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 			control = __set_ctrl_sar(chan, L2CAP_SAR_UNSEGMENTED);
 			skb = l2cap_create_iframe_pdu(chan, msg, len, control,
 									0);
-			if (IS_ERR(skb))
-				return PTR_ERR(skb);
+			if (IS_ERR(skb)) {
+				err = PTR_ERR(skb);
+				break;
+			}
 
+			l2cap_chan_lock(chan);
 			__skb_queue_tail(&chan->tx_q, skb);
 
 			if (chan->tx_send_head == NULL)
 				chan->tx_send_head = skb;
 
+			l2cap_chan_unlock(chan);
 		} else {
 			/* Segment SDU into multiples PDUs */
 			err = l2cap_sar_segment_sdu(chan, msg, len);
 			if (err < 0)
-				return err;
+				break;
 		}
 
 		if (chan->mode == L2CAP_MODE_STREAMING) {
+			l2cap_chan_lock(chan);
 			l2cap_streaming_send(chan);
+			l2cap_chan_unlock(chan);
 			err = len;
 			break;
 		}
 
+		l2cap_chan_lock(chan);
 		if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state) &&
 				test_bit(CONN_WAIT_F, &chan->conn_state)) {
 			err = len;
+			l2cap_chan_unlock(chan);
 			break;
 		}
 
@@ -2098,6 +2115,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 		if (err >= 0)
 			err = len;
 
+		l2cap_chan_unlock(chan);
 		break;
 
 	default:
@@ -2105,6 +2123,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 		err = -EBADFD;
 	}
 
+done:
+	l2cap_chan_put(chan);
 	return err;
 }
 
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
