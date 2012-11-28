Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 2/4] Bluetooth: Add option for SCO socket socket
Date: Wed, 28 Nov 2012 19:28:34 +0100
Message-Id: <1354127316-17431-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements setsockopt().
---
 net/bluetooth/sco.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c2c0c13..b363712 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -687,6 +687,47 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
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
+		opts.codec = 0;
+
+		len = min_t(unsigned int, sizeof(opts), optlen);
+		if (copy_from_user((char *) &opts, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		sco_pi(sk)->codec = opts.codec;
+		BT_DBG("codec %d", opts.codec);
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
@@ -695,6 +736,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char
 
 	BT_DBG("sk %p", sk);
 
+	if (level == SOL_SCO)
+		return sco_sock_setsockopt_old(sock, optname, optval, optlen);
+
 	lock_sock(sk);
 
 	switch (optname) {
-- 
1.7.9.5

