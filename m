Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 6/6] Bluetooth: Do not send disconn comand over LE links
Date: Mon, 18 Oct 2010 16:02:56 +0300
Message-Id: <1287406976-13463-7-git-send-email-ville.tervo@nokia.com>
In-Reply-To: <1287406976-13463-1-git-send-email-ville.tervo@nokia.com>
References: <1287406976-13463-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap over LE links can be disconnected without sending
disconnect command first.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/l2cap.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 3f0f036..2bf083e 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -873,6 +873,8 @@ static void l2cap_sock_kill(struct sock *sk)
 
 static void __l2cap_sock_close(struct sock *sk, int reason)
 {
+	struct l2cap_conn *conn;
+
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
 
 	switch (sk->sk_state) {
@@ -882,8 +884,10 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		if (sk->sk_type == SOCK_SEQPACKET ||
-				sk->sk_type == SOCK_STREAM) {
+		conn = l2cap_pi(sk)->conn;
+		if ((sk->sk_type == SOCK_SEQPACKET ||
+				sk->sk_type == SOCK_STREAM) &&
+				conn->hcon->type != LE_LINK) {
 			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 
 			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
@@ -893,9 +897,10 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
 		break;
 
 	case BT_CONNECT2:
-		if (sk->sk_type == SOCK_SEQPACKET ||
-				sk->sk_type == SOCK_STREAM) {
-			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+		conn = l2cap_pi(sk)->conn;
+		if ((sk->sk_type == SOCK_SEQPACKET ||
+				sk->sk_type == SOCK_STREAM) &&
+				conn->hcon->type != LE_LINK) {
 			struct l2cap_conn_rsp rsp;
 			__u16 result;
 
-- 
1.7.1

