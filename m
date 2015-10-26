Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix some obvious coding style issues in the SCO module
Date: Mon, 26 Oct 2015 02:08:38 +0100
Message-Id: <1445821718-59020-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lets fix this obvious coding style issues in the SCO module and bring it
in line with the rest of the Bluetooth subsystem.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 75f843d5423a..8ec10049bc24 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -74,7 +74,7 @@ struct sco_pinfo {
 
 static void sco_sock_timeout(unsigned long arg)
 {
-	struct sock *sk = (struct sock *) arg;
+	struct sock *sk = (struct sock *)arg;
 
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
 
@@ -183,7 +183,8 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	kfree(conn);
 }
 
-static void __sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent)
+static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
+			   struct sock *parent)
 {
 	BT_DBG("conn %p", conn);
 
@@ -463,7 +464,8 @@ static struct proto sco_proto = {
 	.obj_size	= sizeof(struct sco_pinfo)
 };
 
-static struct sock *sco_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio, int kern)
+static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
+				   int proto, gfp_t prio, int kern)
 {
 	struct sock *sk;
 
@@ -512,7 +514,8 @@ static int sco_sock_create(struct net *net, struct socket *sock, int protocol,
 	return 0;
 }
 
-static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
+static int sco_sock_bind(struct socket *sock, struct sockaddr *addr,
+			 int addr_len)
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
@@ -619,7 +622,8 @@ done:
 	return err;
 }
 
-static int sco_sock_accept(struct socket *sock, struct socket *newsock, int flags)
+static int sco_sock_accept(struct socket *sock, struct socket *newsock,
+			   int flags)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct sock *sk = sock->sk, *ch;
@@ -673,7 +677,8 @@ done:
 	return err;
 }
 
-static int sco_sock_getname(struct socket *sock, struct sockaddr *addr, int *len, int peer)
+static int sco_sock_getname(struct socket *sock, struct sockaddr *addr,
+			    int *len, int peer)
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
@@ -783,7 +788,8 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return bt_sock_recvmsg(sock, msg, len, flags);
 }
 
-static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
+static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	int len, err = 0;
@@ -823,7 +829,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char
 		voice.setting = sco_pi(sk)->setting;
 
 		len = min_t(unsigned int, sizeof(voice), optlen);
-		if (copy_from_user((char *) &voice, optval, len)) {
+		if (copy_from_user((char *)&voice, optval, len)) {
 			err = -EFAULT;
 			break;
 		}
@@ -847,7 +853,8 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char
 	return err;
 }
 
-static int sco_sock_getsockopt_old(struct socket *sock, int optname, char __user *optval, int __user *optlen)
+static int sco_sock_getsockopt_old(struct socket *sock, int optname,
+				   char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
 	struct sco_options opts;
@@ -907,7 +914,8 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname, char __user
 	return err;
 }
 
-static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
+static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
 	int len, err = 0;
@@ -932,7 +940,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
 		}
 
 		if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
-			     (u32 __user *) optval))
+			     (u32 __user *)optval))
 			err = -EFAULT;
 
 		break;
-- 
2.4.3

