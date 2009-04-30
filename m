Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH 10/10] Allow opening an L2CAP socket with type SOCK_STREAM
Date: Thu, 30 Apr 2009 17:16:47 -0400
Message-Id: <1241126207-19996-11-git-send-email-ngh@isomerica.net>
In-Reply-To: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
References: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

This patch enables use of Enhanced Retransmission and Streaming modes on an
L2CAP socket. If a socket is created with SOCK_STREAM, it will be treated as
an Enhanced Retransmission mode L2CAP connection.

Signed-off-by: Nathan Holstein <nathan@lampreynetworks.com>
---
 net/bluetooth/l2cap.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index b7c2e94..85493ea 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -53,7 +53,11 @@
 
 #define VERSION "2.13"
 
-static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_FCS;
+static u32 l2cap_feat_mask =
+		L2CAP_FEAT_FCS |
+		L2CAP_FEAT_ERTM |
+		L2CAP_FEAT_STREAM |
+		L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
 
 static const struct proto_ops l2cap_sock_ops;
@@ -215,7 +219,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct so
 
 	l2cap_pi(sk)->conn = conn;
 
-	if (sk->sk_type == SOCK_SEQPACKET) {
+	if (sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM) {
 		/* Alloc CID for connection-oriented socket */
 		l2cap_pi(sk)->scid = l2cap_alloc_cid(l);
 	} else if (sk->sk_type == SOCK_DGRAM) {
@@ -391,7 +395,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
-		if (sk->sk_type != SOCK_SEQPACKET) {
+		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM) {
 			bh_unlock_sock(sk);
 			continue;
 		}
@@ -451,7 +455,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
-		if (sk->sk_type != SOCK_SEQPACKET) {
+		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM) {
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
 			sk->sk_state_change(sk);
@@ -660,7 +664,7 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		if (sk->sk_type == SOCK_SEQPACKET) {
+		if (sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM) {
 			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 			struct l2cap_disconn_req req;
 
@@ -676,7 +680,7 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
 		break;
 
 	case BT_CONNECT2:
-		if (sk->sk_type == SOCK_SEQPACKET) {
+		if (sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM) {
 			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 			struct l2cap_conn_rsp rsp;
 			__u16 result;
@@ -794,7 +798,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol)
 
 	sock->state = SS_UNCONNECTED;
 
-	if (sock->type != SOCK_SEQPACKET &&
+	if (sock->type != SOCK_SEQPACKET && sock->type != SOCK_STREAM &&
 			sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
@@ -941,7 +945,7 @@ static int l2cap_do_connect(struct sock *sk)
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
-		if (sk->sk_type != SOCK_SEQPACKET) {
+		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM) {
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
 		} else
@@ -974,7 +978,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 
 	lock_sock(sk);
 
-	if (sk->sk_type == SOCK_SEQPACKET && !la.l2_psm) {
+	if ((sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM) && !la.l2_psm) {
 		err = -EINVAL;
 		goto done;
 	}
@@ -1025,7 +1029,9 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 
 	lock_sock(sk);
 
-	if (sk->sk_state != BT_BOUND || sock->type != SOCK_SEQPACKET) {
+	if (sk->sk_state != BT_BOUND
+			|| (sock->type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM)
+			|| sock->type != SOCK_STREAM) {
 		err = -EBADFD;
 		goto done;
 	}
@@ -1436,7 +1442,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 
 	switch (optname) {
 	case BT_SECURITY:
-		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_RAW) {
+		if (sk->sk_type != SOCK_SEQPACKET  && sk->sk_type != SOCK_STREAM
+				&& sk->sk_type != SOCK_RAW) {
 			err = -EINVAL;
 			break;
 		}
@@ -1583,7 +1590,8 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 	switch (optname) {
 	case BT_SECURITY:
-		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_RAW) {
+		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM
+				&& sk->sk_type != SOCK_RAW) {
 			err = -EINVAL;
 			break;
 		}
@@ -3029,7 +3037,7 @@ static int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 
 static inline void l2cap_check_encryption(struct sock *sk, u8 encrypt)
 {
-	if (sk->sk_type != SOCK_SEQPACKET)
+	if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM)
 		return;
 
 	if (encrypt == 0x00) {
-- 
1.6.0.6

