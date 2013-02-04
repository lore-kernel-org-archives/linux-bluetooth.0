Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 2/5] Bluetooth: Add option for SCO socket mode
Date: Mon,  4 Feb 2013 14:56:25 +0100
Message-Id: <1359986188-24432-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends the current SCO socket option to add a 'mode' field. This
field is intended to choose data type at runtime. Current modes are CVSD and
transparent SCO, but adding new modes could allow support for CSA2 and fine
tuning a sco connection, for example latency, bandwith, voice setting. Incoming
connections will be setup during defered setup. Outgoing connections have to
be setup before connect(). The selected type is stored in the sco socket info.
This patch declares needed members, modifies getsockopt() and implements
setsockopt(). Setting the mtu is not supported.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 include/net/bluetooth/sco.h |    7 +++++
 net/bluetooth/sco.c         |   59 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 1e35c43..4de67ef 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -41,8 +41,14 @@ struct sockaddr_sco {
 
 /* SCO socket options */
 #define SCO_OPTIONS	0x01
+
+#define SCO_MODE_CVSD		0x00
+#define SCO_MODE_TRANSPARENT	0x01
+#define SCO_MODE_MAX		0x01
+
 struct sco_options {
 	__u16 mtu;
+	__u8 mode;
 };
 
 #define SCO_CONNINFO	0x02
@@ -73,6 +79,7 @@ struct sco_conn {
 struct sco_pinfo {
 	struct bt_sock	bt;
 	__u32		flags;
+	__u8		mode;
 	struct sco_conn	*conn;
 };
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 97177be6..7d57af5 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -418,6 +418,8 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock, int pro
 	sk->sk_protocol = proto;
 	sk->sk_state    = BT_OPEN;
 
+	sco_pi(sk)->mode = SCO_MODE_CVSD;
+
 	setup_timer(&sk->sk_timer, sco_sock_timeout, (unsigned long)sk);
 
 	bt_sock_link(&sco_sk_list, sk);
@@ -712,6 +714,59 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
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
+		opts.mode = SCO_MODE_CVSD;
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
+		BT_DBG("mode %d", opts.mode);
+
+		if (opts.mode > SCO_MODE_MAX) {
+			err = -EINVAL;
+			break;
+		}
+
+		sco_pi(sk)->mode = opts.mode;
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
@@ -720,6 +775,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char
 
 	BT_DBG("sk %p", sk);
 
+	if (level == SOL_SCO)
+		return sco_sock_setsockopt_old(sock, optname, optval, optlen);
+
 	lock_sock(sk);
 
 	switch (optname) {
@@ -772,6 +830,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname, char __user
 		}
 
 		opts.mtu = sco_pi(sk)->conn->mtu;
+		opts.mode = sco_pi(sk)->mode;
 
 		BT_DBG("mtu %d", opts.mtu);
 
-- 
1.7.9.5

