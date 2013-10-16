Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 6/7] Bluetooth: Do not access chan->sk directly
Date: Wed, 16 Oct 2013 16:08:34 -0300
Message-Id: <1381950515-25256-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1381950515-25256-1-git-send-email-gustavo@padovan.org>
References: <1381950515-25256-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

In the process of removing socket usage from L2CAP we now access the L2CAP
socket from the data member of struct l2cap_chan. For the L2CAP socket
user the data member points to the L2CAP socket.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b8be4fb..5c84f8a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1161,11 +1161,12 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 					       unsigned long len, int nb)
 {
+	struct sock *sk = chan->data;
 	struct sk_buff *skb;
 	int err;
 
 	l2cap_chan_unlock(chan);
-	skb = bt_skb_send_alloc(chan->sk, len, nb, &err);
+	skb = bt_skb_send_alloc(sk, len, nb, &err);
 	l2cap_chan_lock(chan);
 
 	if (!skb)
-- 
1.8.3.1

