Return-Path: <cyrus@holtmann.org>
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 4/5] Bluetooth: Fix locking of SCO channel to connection
Date: Mon,  5 Oct 2015 18:44:18 +0200
Message-Id: <1444063459-28577-5-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1444063459-28577-1-git-send-email-kubax.t.pawlak@intel.com>
References: <088CC8BACB3382439E91D9919CE350243655EB71@IRSMSX107.ger.corp.intel.com>
 <1444063459-28577-1-git-send-email-kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
---
 net/bluetooth/sco.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 75f843d5423a4750f18f698a57130c6a96f71f23..bcc3c6d8066bba0b6d801fe8182734636bf6d94a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -167,17 +167,19 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	/* Kill socket */
 	sco_conn_lock(conn);
 	sk = conn->sk;
-	sco_conn_unlock(conn);
 
 	if (sk) {
 		sock_hold(sk);
 		bh_lock_sock(sk);
+		sco_conn_unlock(conn);
 		sco_sock_clear_timer(sk);
 		sco_chan_del(sk, err);
 		bh_unlock_sock(sk);
 		sco_sock_kill(sk);
 		sock_put(sk);
 	}
+	else
+		sco_conn_unlock(conn);
 
 	hcon->sco_data = NULL;
 	kfree(conn);
@@ -1012,10 +1014,13 @@ static int sco_sock_release(struct socket *sock)
 static void sco_conn_ready(struct sco_conn *conn)
 {
 	struct sock *parent;
-	struct sock *sk = conn->sk;
+	struct sock *sk;
 
 	BT_DBG("conn %p", conn);
 
+	sco_conn_lock(conn);
+	sk = conn->sk;
+
 	if (sk) {
 		sco_sock_clear_timer(sk);
 		bh_lock_sock(sk);
@@ -1023,7 +1028,6 @@ static void sco_conn_ready(struct sco_conn *conn)
 		sk->sk_state_change(sk);
 		bh_unlock_sock(sk);
 	} else {
-		sco_conn_lock(conn);
 
 		parent = sco_get_sock_listen(&conn->hcon->src);
 		if (!parent) {
@@ -1058,9 +1062,9 @@ static void sco_conn_ready(struct sco_conn *conn)
 		parent->sk_data_ready(parent);
 
 		bh_unlock_sock(parent);
-
-		sco_conn_unlock(conn);
 	}
+
+	sco_conn_unlock(conn);
 }
 
 /* ----- SCO interface with lower layer (HCI) ----- */
-- 
1.9.3

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

