Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 05/16] Bluetooth: Add missing braces to an "else if"
Date: Wed, 20 Feb 2013 17:11:32 -0300
Message-Id: <1361391103-30738-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1361391103-30738-1-git-send-email-gustavo@padovan.org>
References: <1361391103-30738-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Trivial change in the coding style.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index adf7fbb..ac3205e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1406,8 +1406,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 			sk->sk_state_change(sk);
 			release_sock(sk);
 
-		} else if (chan->state == BT_CONNECT)
+		} else if (chan->state == BT_CONNECT) {
 			l2cap_do_start(chan);
+		}
 
 		l2cap_chan_unlock(chan);
 	}
-- 
1.8.1.2

