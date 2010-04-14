Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 5/7] Bluetooth: Add SOCK_STREAM support to L2CAP
Date: Wed, 14 Apr 2010 16:41:50 -0300
Message-Id: <1271274112-7806-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1271274112-7806-5-git-send-email-padovan@profusion.mobi>
References: <1271274112-7806-1-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-2-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-3-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-4-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-5-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

if enable_ertm is true and we have SOCK_STREAM the default mode will be
ERTM, otherwise Basic Mode.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   40 ++++++++++++++++++++++++++--------------
 1 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 63248aa..0e24ee3 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -224,7 +224,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct so
 
 	l2cap_pi(sk)->conn = conn;
 
-	if (sk->sk_type == SOCK_SEQPACKET) {
+	if (sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM) {
 		/* Alloc CID for connection-oriented socket */
 		l2cap_pi(sk)->scid = l2cap_alloc_cid(l);
 	} else if (sk->sk_type == SOCK_DGRAM) {
@@ -452,7 +452,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
-		if (sk->sk_type != SOCK_SEQPACKET) {
+		if (sk->sk_type != SOCK_SEQPACKET &&
+				sk->sk_type != SOCK_STREAM) {
 			bh_unlock_sock(sk);
 			continue;
 		}
@@ -512,7 +513,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
-		if (sk->sk_type != SOCK_SEQPACKET) {
+		if (sk->sk_type != SOCK_SEQPACKET &&
+				sk->sk_type != SOCK_STREAM) {
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
 			sk->sk_state_change(sk);
@@ -721,7 +723,8 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		if (sk->sk_type == SOCK_SEQPACKET) {
+		if (sk->sk_type == SOCK_SEQPACKET ||
+				sk->sk_type == SOCK_STREAM) {
 			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 
 			sk->sk_state = BT_DISCONN;
@@ -732,7 +735,8 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
 		break;
 
 	case BT_CONNECT2:
-		if (sk->sk_type == SOCK_SEQPACKET) {
+		if (sk->sk_type == SOCK_SEQPACKET ||
+				sk->sk_type == SOCK_STREAM) {
 			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 			struct l2cap_conn_rsp rsp;
 			__u16 result;
@@ -795,7 +799,10 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 	} else {
 		pi->imtu = L2CAP_DEFAULT_MTU;
 		pi->omtu = 0;
-		pi->mode = L2CAP_MODE_BASIC;
+		if (enable_ertm && sk->sk_type == SOCK_STREAM)
+			pi->mode = L2CAP_MODE_ERTM;
+		else
+			pi->mode = L2CAP_MODE_BASIC;
 		pi->max_tx = max_transmit;
 		pi->fcs  = L2CAP_FCS_CRC16;
 		pi->tx_win = tx_window;
@@ -852,7 +859,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->state = SS_UNCONNECTED;
 
-	if (sock->type != SOCK_SEQPACKET &&
+	if (sock->type != SOCK_SEQPACKET && sock->type != SOCK_STREAM &&
 			sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
@@ -1000,7 +1007,8 @@ static int l2cap_do_connect(struct sock *sk)
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
-		if (sk->sk_type != SOCK_SEQPACKET) {
+		if (sk->sk_type != SOCK_SEQPACKET &&
+				sk->sk_type != SOCK_STREAM) {
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
 		} else
@@ -1033,7 +1041,8 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 
 	lock_sock(sk);
 
-	if (sk->sk_type == SOCK_SEQPACKET && !la.l2_psm) {
+	if ((sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM)
+			&& !la.l2_psm) {
 		err = -EINVAL;
 		goto done;
 	}
@@ -1097,7 +1106,8 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 
 	lock_sock(sk);
 
-	if (sk->sk_state != BT_BOUND || sock->type != SOCK_SEQPACKET) {
+	if ((sock->type != SOCK_SEQPACKET && sock->type != SOCK_STREAM)
+			|| sk->sk_state != BT_BOUND) {
 		err = -EBADFD;
 		goto done;
 	}
@@ -1832,7 +1842,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 
 	switch (optname) {
 	case BT_SECURITY:
-		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_RAW) {
+		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM
+				&& sk->sk_type != SOCK_RAW) {
 			err = -EINVAL;
 			break;
 		}
@@ -1982,7 +1993,8 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 	switch (optname) {
 	case BT_SECURITY:
-		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_RAW) {
+		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM
+				&& sk->sk_type != SOCK_RAW) {
 			err = -EINVAL;
 			break;
 		}
@@ -2289,7 +2301,7 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
-	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
+	struct l2cap_conf_rfc rfc = { .mode = pi->mode };
 	void *ptr = req->data;
 
 	BT_DBG("sk %p", sk);
@@ -3979,7 +3991,7 @@ static int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 
 static inline void l2cap_check_encryption(struct sock *sk, u8 encrypt)
 {
-	if (sk->sk_type != SOCK_SEQPACKET)
+	if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM)
 		return;
 
 	if (encrypt == 0x00) {
-- 
1.6.4.4
