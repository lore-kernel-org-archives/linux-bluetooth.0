Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [bluetooth-next -v2 06/24] Bluetooth: Do not send disconn comand over LE links
Date: Thu, 10 Feb 2011 22:38:51 -0300
Message-Id: <1297388349-14878-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297388349-14878-6-git-send-email-vinicius.gomes@openbossa.org>
References: <1297388349-14878-1-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-2-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-3-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-4-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-5-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-6-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

l2cap over LE links can be disconnected without sending
disconnect command first.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/l2cap_sock.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 0c695be..a7eeacc 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -884,6 +884,8 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 
 void __l2cap_sock_close(struct sock *sk, int reason)
 {
+	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
 
 	switch (sk->sk_state) {
@@ -893,10 +895,9 @@ void __l2cap_sock_close(struct sock *sk, int reason)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		if (sk->sk_type == SOCK_SEQPACKET ||
-				sk->sk_type == SOCK_STREAM) {
-			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-
+		if ((sk->sk_type == SOCK_SEQPACKET ||
+					sk->sk_type == SOCK_STREAM) &&
+					conn->hcon->type == ACL_LINK) {
 			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 			l2cap_send_disconn_req(conn, sk, reason);
 		} else
@@ -904,9 +905,9 @@ void __l2cap_sock_close(struct sock *sk, int reason)
 		break;
 
 	case BT_CONNECT2:
-		if (sk->sk_type == SOCK_SEQPACKET ||
-				sk->sk_type == SOCK_STREAM) {
-			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+		if ((sk->sk_type == SOCK_SEQPACKET ||
+					sk->sk_type == SOCK_STREAM) &&
+					conn->hcon->type == ACL_LINK) {
 			struct l2cap_conn_rsp rsp;
 			__u16 result;
 
-- 
1.7.4

