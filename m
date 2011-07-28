Return-Path: <cyrus@holtmann.org>
From: chen.ganir@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH] Bluetooth-next:Fixed wrong L2CAP Sock timer value
Date: Thu, 28 Jul 2011 15:42:09 +0300
Message-Id: <1311856929-10464-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

L2CAP connection timeout needs to be assigned as miliseconds
and not as jiffies.

Signed-off-by: Chen Ganir <chen.ganir@ti.com>
---
 net/bluetooth/l2cap_sock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 5c36b3e..e5e8db9 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -993,7 +993,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int p
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
 
 	sk->sk_destruct = l2cap_sock_destruct;
-	sk->sk_sndtimeo = msecs_to_jiffies(L2CAP_CONN_TIMEOUT);
+	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
-- 
1.7.4.1

