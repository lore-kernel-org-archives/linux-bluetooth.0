Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Merge similar code in l2cap_conn_ready()
Date: Wed,  8 Jun 2011 19:10:23 -0300
Message-Id: <1307571024-22442-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1307571024-22442-1-git-send-email-padovan@profusion.mobi>
References: <1307571024-22442-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In both conditions we do exacly the same thing, so merge them.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3af8882..28d4cf7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -905,13 +905,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 		bh_lock_sock(sk);
 
-		if (conn->hcon->type == LE_LINK) {
-			__clear_chan_timer(chan);
-			l2cap_state_change(chan, BT_CONNECTED);
-			sk->sk_state_change(sk);
-		}
-
-		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED ||
+						conn->hcon->type == LE_LINK) {
 			__clear_chan_timer(chan);
 			l2cap_state_change(chan, BT_CONNECTED);
 			sk->sk_state_change(sk);
-- 
1.7.5.1

