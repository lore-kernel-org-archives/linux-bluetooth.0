Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 2/6] Bluetooth: Add SCO socket voice_setting option
Date: Tue, 19 Mar 2013 19:04:11 +0100
Message-Id: <1363716255-21332-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends the current SCO socket option to add a 'voice_setting'
member. This member is intended to choose data type at runtime.
Incoming connections will be setup during defered setup. Outgoing connections
have to be setup before connect(). The desired setting is stored in the sco
socket info.
This patch declares needed members, modifies getsockopt() and implements
setsockopt(). Setting the mtu is not supported.
---
 include/net/bluetooth/sco.h |    2 ++
 net/bluetooth/sco.c         |   54 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 1e35c43..41dbdfa 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -43,6 +43,7 @@ struct sockaddr_sco {
 #define SCO_OPTIONS	0x01
 struct sco_options {
 	__u16 mtu;
+	__u16 voice_setting;
 };
 
 #define SCO_CONNINFO	0x02
@@ -73,6 +74,7 @@ struct sco_conn {
 struct sco_pinfo {
 	struct bt_sock	bt;
 	__u32		flags;
+	__u16		voice_setting;
 	struct sco_conn	*conn;
 };
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 2738014..dc92073 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -417,6 +417,8 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock, int pro
 	sk->sk_protocol = proto;
 	sk->sk_state    = BT_OPEN;
 
+	sco_pi(sk)->voice_setting = 0;
+
 	setup_timer(&sk->sk_timer, sco_sock_timeout, (unsigned long)sk);
 
 	bt_sock_link(&sco_sk_list, sk);
@@ -711,6 +713,54 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
 }
 
+static int sco_sock_setsockopt_old(struct socket *sock, int optname,
+				   char __user *optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	struct sco_options opts;
+	int len, err = 0;
+
+	BT_DBG("sk %p", sk);
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case SCO_OPTIONS:
+		if (sk->sk_state != BT_OPEN &&
+		    sk->sk_state != BT_BOUND &&
+		    sk->sk_state != BT_CONNECT2) {
+			err = -EINVAL;
+			break;
+		}
+
+		opts.mtu = 0;
+		opts.voice_setting = 0;
+
+		len = min_t(unsigned int, sizeof(opts), optlen);
+		if (copy_from_user((char *) &opts, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opts.mtu != 0) {
+			err = -EINVAL;
+			break;
+		}
+
+		BT_DBG("voice_setting %d", opts.voice_setting);
+
+		sco_pi(sk)->voice_setting = opts.voice_setting;
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+	return err;
+}
+
 static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
@@ -719,6 +769,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char
 
 	BT_DBG("sk %p", sk);
 
+	if (level == SOL_SCO)
+		return sco_sock_setsockopt_old(sock, optname, optval, optlen);
+
 	lock_sock(sk);
 
 	switch (optname) {
@@ -771,6 +824,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname, char __user
 		}
 
 		opts.mtu = sco_pi(sk)->conn->mtu;
+		opts.voice_setting = sco_pi(sk)->voice_setting;
 
 		BT_DBG("mtu %d", opts.mtu);
 
-- 
1.7.9.5

