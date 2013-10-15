Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 7/7] Bluetooth: use l2cap_chan_ready() instead of duplicate code
Date: Tue, 15 Oct 2013 19:24:51 -0300
Message-Id: <1381875891-27953-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
References: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

In this case the replacement by l2cap_chan_ready() doesn't change the code
flow, the same operations will executed plus two others that have no
effect: the use of the parent socket, that a non-oriented channel doesn't
have and the reset of conf_state, which is also fine since the connection
is ready at this point.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 36ddb25..bd85810 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1450,12 +1450,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
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
1.8.3.1

