Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 12/14] Bluetooth: Fix l2cap_ertm_send() behavior
Date: Sat,  5 Jun 2010 04:50:16 -0300
Message-Id: <1275724218-29453-13-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275724218-29453-12-git-send-email-gustavo@padovan.org>
References: <1275724218-29453-1-git-send-email-gustavo@padovan.org>
 <1275724218-29453-2-git-send-email-gustavo@padovan.org>
 <1275724218-29453-3-git-send-email-gustavo@padovan.org>
 <1275724218-29453-4-git-send-email-gustavo@padovan.org>
 <1275724218-29453-5-git-send-email-gustavo@padovan.org>
 <1275724218-29453-6-git-send-email-gustavo@padovan.org>
 <1275724218-29453-7-git-send-email-gustavo@padovan.org>
 <1275724218-29453-8-git-send-email-gustavo@padovan.org>
 <1275724218-29453-9-git-send-email-gustavo@padovan.org>
 <1275724218-29453-10-git-send-email-gustavo@padovan.org>
 <1275724218-29453-11-git-send-email-gustavo@padovan.org>
 <1275724218-29453-12-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

This patch makes l2cap_ertm_send() similar to the Send-Data action of
the ERTM spec. We do not have to check for RemoteBusy or WAIT_F state
inside l2cap_ertm_send(). Such check was causing a bug in the
retransmission logic of ERTM.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index f116307..59c4690 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1449,11 +1449,7 @@ static int l2cap_ertm_send(struct sock *sk)
 	if (sk->sk_state != BT_CONNECTED)
 		return -ENOTCONN;
 
-	if (pi->conn_state & L2CAP_CONN_WAIT_F)
-		return 0;
-
-	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(sk)) &&
-			!(pi->conn_state & L2CAP_CONN_REMOTE_BUSY)) {
+	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(sk))) {
 
 		if (pi->remote_max_tx &&
 				bt_cb(skb)->retries == pi->remote_max_tx) {
@@ -1828,6 +1824,11 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		if (pi->mode == L2CAP_MODE_STREAMING) {
 			err = l2cap_streaming_send(sk);
 		} else {
+			if (pi->conn_state & L2CAP_CONN_REMOTE_BUSY &&
+					pi->conn_state && L2CAP_CONN_WAIT_F) {
+				err = len;
+				break;
+			}
 			spin_lock_bh(&pi->send_lock);
 			err = l2cap_ertm_send(sk);
 			spin_unlock_bh(&pi->send_lock);
@@ -3403,8 +3404,6 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct sock *sk)
 	if (pi->conn_state & L2CAP_CONN_REMOTE_BUSY && pi->unacked_frames > 0)
 		__mod_retrans_timer();
 
-	pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
-
 	spin_lock_bh(&pi->send_lock);
 	l2cap_ertm_send(sk);
 	spin_unlock_bh(&pi->send_lock);
-- 
1.7.1
