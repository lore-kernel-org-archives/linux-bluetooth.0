Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 May 2011 18:09:00 -0400 (EDT)
Message-Id: <20110519.180900.1412544790459751168.davem@davemloft.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: Kill set but not used variable 'l2cap_sk' in
 rfcomm_sock_getsockopt_old()
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 386cfaf..bcf077c 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -741,7 +741,6 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, c
 static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
-	struct sock *l2cap_sk;
 	struct rfcomm_conninfo cinfo;
 	struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;
 	int len, err = 0;
@@ -786,8 +785,6 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 			break;
 		}
 
-		l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;
-
 		cinfo.hci_handle = conn->hcon->handle;
 		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
 
