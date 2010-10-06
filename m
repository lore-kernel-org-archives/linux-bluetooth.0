Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 7/7] Bluetooth: Do not send disconn comand over LE links
Date: Wed,  6 Oct 2010 20:42:15 +0200
Message-Id: <1286390535-27462-8-git-send-email-ville.tervo@nokia.com>
In-Reply-To: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
References: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap over LE links can be disconnected without sending
disconnect command first.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/l2cap_core.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 20be2f9..53860f6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -836,6 +836,8 @@ void l2cap_sock_kill(struct sock *sk)
 
 void __l2cap_sock_close(struct sock *sk, int reason)
 {
+	struct l2cap_conn *conn;
+
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
 
 	switch (sk->sk_state) {
@@ -845,8 +847,10 @@ void __l2cap_sock_close(struct sock *sk, int reason)
 
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
@@ -856,9 +860,10 @@ void __l2cap_sock_close(struct sock *sk, int reason)
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
1.7.0.1

