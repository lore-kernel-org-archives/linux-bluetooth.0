Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 6/6] Bluetooth: Fix deadlock in the ERTM logic
Date: Fri, 24 Sep 2010 22:01:44 -0300
Message-Id: <1285376504-3541-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1285376504-3541-6-git-send-email-gustavo@padovan.org>
References: <1285376504-3541-1-git-send-email-gustavo@padovan.org>
 <1285376504-3541-2-git-send-email-gustavo@padovan.org>
 <1285376504-3541-3-git-send-email-gustavo@padovan.org>
 <1285376504-3541-4-git-send-email-gustavo@padovan.org>
 <1285376504-3541-5-git-send-email-gustavo@padovan.org>
 <1285376504-3541-6-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

The Enhanced Retransmission Mode(ERTM) is a realiable mode of operation
of the Bluetooth L2CAP layer. Think on it like a simplified version of
TCP.
The problem we were facing here was a deadlock. ERTM uses a backlog
queue to queue incomimg packets while the user is helding the lock. At
some moment the sk_sndbuf can be exceeded and we can't alloc new skbs
then the code sleep with the lock to wait for memory, that stalls the
ERTM connection once we can't read the acknowledgements packets in the
backlog queue to free memory and make the allocation of outcoming skb
successful.

This patch actually affect all users of bt_skb_send_alloc(), i.e., all
L2CAP modes and SCO.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
---
 include/net/bluetooth/bluetooth.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 27a902d..118b69b 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -161,10 +161,21 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk, unsigned long l
 {
 	struct sk_buff *skb;
 
+	release_sock(sk);
 	if ((skb = sock_alloc_send_skb(sk, len + BT_SKB_RESERVE, nb, err))) {
 		skb_reserve(skb, BT_SKB_RESERVE);
 		bt_cb(skb)->incoming  = 0;
 	}
+	lock_sock(sk);
+
+	if (*err)
+		return NULL;
+
+	*err = sock_error(sk);
+	if (*err) {
+		kfree_skb(skb);
+		return NULL;
+	}
 
 	return skb;
 }
-- 
1.7.2.2

