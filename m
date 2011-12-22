Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 03/12] Bluetooth: Use only mutex lock_sock() in SCO
Date: Thu, 22 Dec 2011 16:56:04 -0200
Message-Id: <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

We are now working only in process context here. So it makes sense use
only mutex lock_sock().

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/sco.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 36fe9eb..90c72fa 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -75,10 +75,10 @@ static void sco_sock_timeout(struct work_struct *work)
 
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
 
-	bh_lock_sock(sk);
+	lock_sock(sk);
 	sk->sk_err = ETIMEDOUT;
 	sk->sk_state_change(sk);
-	bh_unlock_sock(sk);
+	release_sock(sk);
 
 	sco_sock_kill(sk);
 	sock_put(sk);
@@ -154,10 +154,10 @@ static int sco_conn_del(struct hci_conn *hcon, int err)
 	/* Kill socket */
 	sk = sco_chan_get(conn);
 	if (sk) {
-		bh_lock_sock(sk);
+		lock_sock(sk);
 		sco_clear_timer(sk);
 		sco_chan_del(sk, err);
-		bh_unlock_sock(sk);
+		release_sock(sk);
 		sco_sock_kill(sk);
 	}
 
@@ -861,21 +861,21 @@ static void sco_conn_ready(struct sco_conn *conn)
 
 	if (sk) {
 		sco_clear_timer(sk);
-		bh_lock_sock(sk);
+		lock_sock(sk);
 		sk->sk_state = BT_CONNECTED;
 		sk->sk_state_change(sk);
-		bh_unlock_sock(sk);
+		release_sock(sk);
 	} else {
 		parent = sco_get_sock_listen(conn->src);
 		if (!parent)
 			goto done;
 
-		bh_lock_sock(parent);
+		lock_sock(parent);
 
 		sk = sco_sock_alloc(sock_net(parent), NULL,
 				BTPROTO_SCO, GFP_ATOMIC);
 		if (!sk) {
-			bh_unlock_sock(parent);
+			release_sock(parent);
 			goto done;
 		}
 
@@ -892,7 +892,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 		/* Wake up parent */
 		parent->sk_data_ready(parent, 1);
 
-		bh_unlock_sock(parent);
+		release_sock(parent);
 	}
 
 done:
-- 
1.7.6.4

