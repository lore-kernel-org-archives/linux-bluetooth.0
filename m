Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC -v2 06/16] Bluetooth: use l2cap_chan_ready() instead of duplicate code
Date: Fri, 21 Dec 2012 16:10:49 -0200
Message-Id: <1356113459-7932-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1356113459-7932-1-git-send-email-gustavo@padovan.org>
References: <1356113459-7932-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

l2cap_chan_ready() does exactly what we want here avoiding duplicate code.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2ad952b..af8783a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1399,12 +1399,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 				l2cap_chan_ready(chan);
 
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
-			struct sock *sk = chan->sk;
-			__clear_chan_timer(chan);
-			lock_sock(sk);
-			__l2cap_state_change(chan, BT_CONNECTED);
-			sk->sk_state_change(sk);
-			release_sock(sk);
+			l2cap_chan_ready(chan);
 
 		} else if (chan->state == BT_CONNECT) {
 			l2cap_do_start(chan);
-- 
1.8.0.2

