Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/5] Bluetooth: Add option for SCO socket mode
Date: Thu, 17 Jan 2013 13:39:45 +0100
Message-Id: <1358426389-25903-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1358426389-25903-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1358426389-25903-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends the current SCO socket option to add a 'mode' field. This
field is intended to choose data type at runtime. Current modes are CVSD and
transparent SCO, but adding new modes could allow support for CSA2 and fine
tuning a sco connection, for example latency, bandwith, voice setting. Incoming
connections will be setup during defered setup. Outgoing connections have to
be setup before connect(). The selected type is stored in the sco socket info.
This patch declares needed members and implements getsockopt().
---
 include/net/bluetooth/sco.h |   20 ++++++++++++++++++++
 net/bluetooth/sco.c         |    3 +++
 2 files changed, 23 insertions(+)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 1e35c43..bc5d3d6 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -41,8 +41,27 @@ struct sockaddr_sco {
 
 /* SCO socket options */
 #define SCO_OPTIONS	0x01
+
+#define SCO_MODE_CVSD		0x00
+#define SCO_MODE_TRANSPARENT	0x01
+#define SCO_MODE_ENHANCED	0x02
+
 struct sco_options {
 	__u16 mtu;
+	__u8 mode;
+};
+
+struct sco_coding {
+	__u8 format;
+	__u16 vid;
+	__u16 cid;
+};
+
+struct sco_options_enhanced {
+	__u16 mtu;
+	__u8 mode;
+	struct sco_coding host;
+	struct sco_coding air;
 };
 
 #define SCO_CONNINFO	0x02
@@ -73,6 +92,7 @@ struct sco_conn {
 struct sco_pinfo {
 	struct bt_sock	bt;
 	__u32		flags;
+	__u8		mode;
 	struct sco_conn	*conn;
 };
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 531a93d..bdb21b2 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -418,6 +418,8 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock, int pro
 	sk->sk_protocol = proto;
 	sk->sk_state    = BT_OPEN;
 
+	sco_pi(sk)->mode = SCO_MODE_CVSD;
+
 	setup_timer(&sk->sk_timer, sco_sock_timeout, (unsigned long)sk);
 
 	bt_sock_link(&sco_sk_list, sk);
@@ -736,6 +738,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname, char __user
 		}
 
 		opts.mtu = sco_pi(sk)->conn->mtu;
+		opts.mode = sco_pi(sk)->mode;
 
 		BT_DBG("mtu %d", opts.mtu);
 
-- 
1.7.9.5

