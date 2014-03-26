Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix returning peer address in pending connect state
Date: Wed, 26 Mar 2014 15:49:18 +0200
Message-Id: <1395841758-14792-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should let user space request the peer address also in the pending
connect states, i.e. BT_CONNECT and BT_CONNECT2. There is existing user
space code that tries to do this and will fail without extending the set
of allowed states for the peer address information.

This patch adds the two states to the allowed ones in the L2CAP and
RFCOMM sock_getname functions, thereby preventing ENOTCONN from being
returned.

Reported-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Tested-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
This was reported as a regression on its way to 3.15 so we should either
send an immediate pull with it for wireless-next or then have it go in
in the very first patch to the 3.15-rc kernels.

 net/bluetooth/l2cap_sock.c  | 3 ++-
 net/bluetooth/rfcomm/sock.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 33cd5615ff1e..f59e00c2daa9 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -360,7 +360,8 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
-	if (peer && sk->sk_state != BT_CONNECTED)
+	if (peer && sk->sk_state != BT_CONNECTED &&
+	    sk->sk_state != BT_CONNECT && sk->sk_state != BT_CONNECT2)
 		return -ENOTCONN;
 
 	memset(la, 0, sizeof(struct sockaddr_l2));
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index c024e715512f..eabd25ab5ad9 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -534,7 +534,8 @@ static int rfcomm_sock_getname(struct socket *sock, struct sockaddr *addr, int *
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
-	if (peer && sk->sk_state != BT_CONNECTED)
+	if (peer && sk->sk_state != BT_CONNECTED &&
+	    sk->sk_state != BT_CONNECT && sk->sk_state != BT_CONNECT2)
 		return -ENOTCONN;
 
 	memset(sa, 0, sizeof(*sa));
-- 
1.9.0

