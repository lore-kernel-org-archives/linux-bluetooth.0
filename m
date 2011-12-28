Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Keep chan->state and sk->sk_state in sync
Date: Wed, 28 Dec 2011 13:59:11 -0200
Message-Id: <1325087951-23660-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Those vars need to be in sync, otherwise l2cap_core.c can get the wrong
state.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_sock.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9ca5616..c61d967 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -587,6 +587,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 			if (smp_conn_security(conn, sec.level))
 				break;
 			sk->sk_state = BT_CONFIG;
+			chan->state = BT_CONFIG;
 
 		/* or for ACL link, under defer_setup time */
 		} else if (sk->sk_state == BT_CONNECT2 &&
@@ -731,6 +732,7 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 	if (sk->sk_state == BT_CONNECT2 && bt_sk(sk)->defer_setup) {
 		sk->sk_state = BT_CONFIG;
+		pi->chan->state = BT_CONFIG;
 
 		__l2cap_connect_rsp_defer(pi->chan);
 		release_sock(sk);
-- 
1.7.7.5

