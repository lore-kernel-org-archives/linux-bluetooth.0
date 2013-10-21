Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 2/5] Bluetooth: Do not access chan->sk directly
Date: Mon, 21 Oct 2013 14:21:38 -0200
Message-Id: <1382372501-28562-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1382372501-28562-1-git-send-email-gustavo@padovan.org>
References: <1382372501-28562-1-git-send-email-gustavo@padovan.org>
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
index 1f326d9..a0b31db 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1159,11 +1159,12 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
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

