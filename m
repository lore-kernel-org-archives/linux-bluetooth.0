Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v0 2/6] Bluetooth: Remove unnecessary check
Date: Wed, 11 Apr 2012 08:48:48 +0200
Message-Id: <1334126932-27327-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The function already fails if the given size is greater than the MTU, so
there is no need to consider that case afterwards.

Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
---
 net/bluetooth/sco.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8bf26d1..b48370b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -234,7 +234,7 @@ static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
 {
 	struct sco_conn *conn = sco_pi(sk)->conn;
 	struct sk_buff *skb;
-	int err, count;
+	int err;
 
 	/* Check outgoing MTU */
 	if (len > conn->mtu)
@@ -242,20 +242,18 @@ static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
 
 	BT_DBG("sk %p len %d", sk, len);
 
-	count = min_t(unsigned int, conn->mtu, len);
-	skb = bt_skb_send_alloc(sk, count,
-			msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		return err;
 
-	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
+	if (memcpy_fromiovec(skb_put(skb, len), msg->msg_iov, len)) {
 		kfree_skb(skb);
 		return -EFAULT;
 	}
 
 	hci_send_sco(conn->hcon, skb);
 
-	return count;
+	return len;
 }
 
 static inline void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
-- 
1.7.7.6

