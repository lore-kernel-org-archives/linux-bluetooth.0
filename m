Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Allow L2CAP getpeername() for BT_CONFIG state
Date: Tue,  1 Jul 2014 12:07:23 +0300
Message-Id: <1404205643-31443-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We have all the necessary remote information for getpeername() when we
are in the BT_CONFIG state so this should be allowed. This is
particularly important for LE sockets where changing the security level
will temporarily move the socket into BT_CONFIG state.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index bf72886de6ef..9bb4d1b3a483 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -361,7 +361,8 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
 	BT_DBG("sock %p, sk %p", sock, sk);
 
 	if (peer && sk->sk_state != BT_CONNECTED &&
-	    sk->sk_state != BT_CONNECT && sk->sk_state != BT_CONNECT2)
+	    sk->sk_state != BT_CONNECT && sk->sk_state != BT_CONNECT2 &&
+	    sk->sk_state != BT_CONFIG)
 		return -ENOTCONN;
 
 	memset(la, 0, sizeof(struct sockaddr_l2));
-- 
1.9.3

