Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 12/16] Bluetooth: Use chan lock in receiving data
Date: Thu,  9 Feb 2012 16:17:33 +0200
Message-Id: <1328797057-26331-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change locking logic when receiving ACL and L2CAP data.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    7 +++----
 net/bluetooth/l2cap_sock.c |   11 +++++++++--
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 419e2a6..e03c5df 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4285,7 +4285,6 @@ drop:
 static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan;
-	struct sock *sk = NULL;
 	u32 control;
 	u16 tx_seq;
 	int len;
@@ -4296,7 +4295,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		goto drop;
 	}
 
-	sk = chan->sk;
+	l2cap_chan_lock(chan);
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
@@ -4367,8 +4366,7 @@ drop:
 	kfree_skb(skb);
 
 done:
-	if (sk)
-		release_sock(sk);
+	l2cap_chan_unlock(chan);
 
 	return 0;
 }
@@ -4725,6 +4723,7 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 		if (chan && chan->sk) {
 			struct sock *sk = chan->sk;
+			lock_sock(sk);
 
 			if (chan->imtu < len - L2CAP_HDR_SIZE) {
 				BT_ERR("Frame exceeding recv MTU (len %d, "
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 85e4fd7..dea5418 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -864,8 +864,12 @@ static int l2cap_sock_recv_cb(void *data, struct sk_buff *skb)
 	struct sock *sk = data;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 
-	if (pi->rx_busy_skb)
-		return -ENOMEM;
+	lock_sock(sk);
+
+	if (pi->rx_busy_skb) {
+		err = -ENOMEM;
+		goto done;
+	}
 
 	err = sock_queue_rcv_skb(sk, skb);
 
@@ -884,6 +888,9 @@ static int l2cap_sock_recv_cb(void *data, struct sk_buff *skb)
 		err = 0;
 	}
 
+done:
+	release_sock(sk);
+
 	return err;
 }
 
-- 
1.7.8.3

