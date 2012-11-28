Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 1/4] Bluetooth: Add option for SCO socket codec
Date: Wed, 28 Nov 2012 19:28:33 +0100
Message-Id: <1354127316-17431-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends the current SCO socket option to add a codec field. This
field is intended to choose between mSBC and CVSD codec at runtime. Incoming
connections will be setup during defered setup. Outgoing connections have to
be setup before connect(). The selected codec is stored in the sco socket info.
This patch declares needed members and implements getsockopt().
---
 include/net/bluetooth/sco.h |    2 ++
 net/bluetooth/sco.c         |    3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 1e35c43..c283de0 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -43,6 +43,7 @@ struct sockaddr_sco {
 #define SCO_OPTIONS	0x01
 struct sco_options {
 	__u16 mtu;
+	__u8 codec;
 };
 
 #define SCO_CONNINFO	0x02
@@ -73,6 +74,7 @@ struct sco_conn {
 struct sco_pinfo {
 	struct bt_sock	bt;
 	__u32		flags;
+	__u8		codec;
 	struct sco_conn	*conn;
 };
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index eea17cd..c2c0c13 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -427,6 +427,8 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock, int pro
 	sk->sk_protocol = proto;
 	sk->sk_state    = BT_OPEN;
 
+	sco_pi(sk)->codec = 0;
+
 	setup_timer(&sk->sk_timer, sco_sock_timeout, (unsigned long)sk);
 
 	bt_sock_link(&sco_sk_list, sk);
@@ -745,6 +747,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname, char __user
 		}
 
 		opts.mtu = sco_pi(sk)->conn->mtu;
+		opts.codec = sco_pi(sk)->codec;
 
 		BT_DBG("mtu %d", opts.mtu);
 
-- 
1.7.9.5

