Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Split error handling for SCO listen sockets
Date: Thu, 19 Apr 2012 13:43:52 +0200
Message-Id: <1334835833-21828-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Split the checks for sk->sk_state and sk->sk_type for SCO listen
sockets. This makes the code more readable.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 32c0e31..2fb9636 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -540,11 +540,16 @@ static int sco_sock_listen(struct socket *sock, int backlog)
 
 	lock_sock(sk);
 
-	if (sk->sk_state != BT_BOUND || sock->type != SOCK_SEQPACKET) {
+	if (sk->sk_state != BT_BOUND) {
 		err = -EBADFD;
 		goto done;
 	}
 
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = -EINVAL;
+		goto done;
+	}
+
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	sk->sk_state = BT_LISTEN;
-- 
1.7.7.6

