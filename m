Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [RFC] Bluetooth: process received S-frames when socket is locked by user process
Date: Mon, 31 Jan 2011 18:42:51 +0530
Message-ID: <1296479571-2971-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch lets L2CAP process received S-frames even when socket is
continuously being locked by user process.

This issue was seen when testing with l2test without using "-D" option.

Since the user process does not expect any Rx packets,
it hogs the socket with continuous call to "send()".

When the TxWindow is full Tx stops untill the I-frames are acked by the receiver.

But the Rx S-Frame acknowleding the Tx frames will stay in the backlog queue
because the "sock_owned_by_user()" call in l2cap_data_channel()
will always return true.

The user process does not have an idea about this
mechanism and keep pumping data and locking the socket and cause a deadlock.

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 net/bluetooth/l2cap.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 1761558..dc22291 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4336,6 +4336,15 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 	int len, next_tx_seq_offset, req_seq_offset;
 
 	control = get_unaligned_le16(skb->data);
+
+	if (sock_owned_by_user(sk)) {
+		if (__is_iframe(control)) {
+			if (sk_add_backlog(sk, skb))
+				goto drop;
+
+			return 0;
+		}
+	}
 	skb_pull(skb, 2);
 	len = skb->len;
 
@@ -4434,12 +4443,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
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
1.7.0.4

