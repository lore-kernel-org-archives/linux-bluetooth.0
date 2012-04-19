Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Split error handling for L2CAP listen sockets
Date: Thu, 19 Apr 2012 13:43:51 +0200
Message-Id: <1334835833-21828-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Split the checks for sk->sk_state and sk->sk_type for L2CAP listen
sockets. This makes the code more readable.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_sock.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1463b5d..4d03b45 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -148,12 +148,16 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 
 	lock_sock(sk);
 
-	if ((sock->type != SOCK_SEQPACKET && sock->type != SOCK_STREAM)
-			|| sk->sk_state != BT_BOUND) {
+	if (sk->sk_state != BT_BOUND) {
 		err = -EBADFD;
 		goto done;
 	}
 
+	if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM) {
+		err = -EINVAL;
+		goto done;
+	}
+
 	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
 		break;
-- 
1.7.7.6

