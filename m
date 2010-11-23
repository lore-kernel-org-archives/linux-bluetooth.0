Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [RFC 06/20] Bluetooth: Do not send disconn comand over LE links
Date: Tue, 23 Nov 2010 12:06:22 -0300
Message-Id: <1290524796-32246-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

l2cap over LE links can be disconnected without sending
disconnect command first.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/l2cap.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 0b583c4..5894662 100644
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
1.7.3.2

