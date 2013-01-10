Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 05/16] Bluetooth: Add missing braces to an "else if"
Date: Thu, 10 Jan 2013 05:47:42 -0200
Message-Id: <1357804073-31582-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1357804073-31582-1-git-send-email-gustavo@padovan.org>
References: <1357804073-31582-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Trivial change in the coding style.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cdd7f44..2ad952b 100644
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
1.8.0.2

