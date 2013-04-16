Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v6 2/6] Bluetooth: Add bluetooth socket voice option
Date: Tue, 16 Apr 2013 17:28:59 +0200
Message-Id: <1366126143-28545-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1366126143-28545-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1366126143-28545-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends the current bluetooth socket option to add BT_VOICE.
This is intended to choose voice data type at runtime. It only applies to SCO
sockets.
Incoming connections shall be setup during defered setup. Outgoing connections
shall be setup before connect(). The desired setting is stored in the sco
socket info.
This patch declares needed members, modifies getsockopt() and setsockopt().

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 include/net/bluetooth/bluetooth.h |    8 ++++++++
 include/net/bluetooth/sco.h       |    1 +
 net/bluetooth/sco.c               |   38 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 591fee7..e66b9b0 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -107,6 +107,14 @@ struct bt_power {
  */
 #define BT_CHANNEL_POLICY_AMP_PREFERRED		2
 
+#define BT_VOICE		11
+struct bt_voice {
+	__u16 setting;
+};
+
+#define BT_VOICE_TRANSPARENT			0x0003
+#define BT_VOICE_CVSD				0x0060
+
 __printf(1, 2)
 int bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 1e35c43..e252a31 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -73,6 +73,7 @@ struct sco_conn {
 struct sco_pinfo {
 	struct bt_sock	bt;
 	__u32		flags;
+	__u16		setting;
 	struct sco_conn	*conn;
 };
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 9e62102..454ab64 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -417,6 +417,8 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock, int pro
 	sk->sk_protocol = proto;
 	sk->sk_state    = BT_OPEN;
 
+	sco_pi(sk)->setting = 0;
+
 	setup_timer(&sk->sk_timer, sco_sock_timeout, (unsigned long)sk);
 
 	bt_sock_link(&sco_sk_list, sk);
@@ -713,7 +715,8 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
-	int err = 0;
+	int len, err = 0;
+	struct bt_voice voice;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -739,6 +742,29 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char
 			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
 		break;
 
+	case BT_VOICE:
+		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
+		    sk->sk_state != BT_CONNECT2) {
+			err = -EINVAL;
+			break;
+		}
+
+		len = min_t(unsigned int, sizeof(voice), optlen);
+		if (copy_from_user((char *) &voice, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+
+		if (voice.setting != BT_VOICE_TRANSPARENT &&
+		    voice.setting != BT_VOICE_CVSD) {
+			err = -EINVAL;
+			break;
+		}
+
+		sco_pi(sk)->setting = voice.setting;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -808,6 +834,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
 {
 	struct sock *sk = sock->sk;
 	int len, err = 0;
+	struct bt_voice voice;
 
 	BT_DBG("sk %p", sk);
 
@@ -833,6 +860,15 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
 
 		break;
 
+	case BT_VOICE:
+		voice.setting = sco_pi(sk)->setting;
+
+		len = min_t(unsigned int, len, sizeof(voice));
+		if (copy_to_user(optval, (char *)&voice, len))
+			err = -EFAULT;
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
1.7.9.5

