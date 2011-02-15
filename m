Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC -v3] Bluetooth: add BT_CONNINFO socketopt
Date: Tue, 15 Feb 2011 12:05:28 -0300
Message-Id: <1297782328-25706-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ATT needs to know to link key type before run some of it procedures.
Using the socket sec_level doesn't work because the socket may not reflect
the real sec_level of the link.

Reported-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/bluetooth.h |    5 +++++
 net/bluetooth/l2cap_sock.c        |   16 ++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 4375043..be7a8ee 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -66,6 +66,11 @@ struct bt_security {
 
 #define BT_FLUSHABLE	8
 
+#define BT_CONNINFO	9
+struct bt_conninfo {
+	__u8 sec_level;
+};
+
 #define BT_FLUSHABLE_OFF	0
 #define BT_FLUSHABLE_ON		1
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 484e717..f09fd97 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -467,7 +467,9 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
+	struct hci_conn *hcon = l2cap_pi(sk)->conn->hcon;
 	struct bt_security sec;
+	struct bt_conninfo conninfo;
 	int len, err = 0;
 
 	BT_DBG("sk %p", sk);
@@ -516,6 +518,20 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 		break;
 
+	case BT_CONNINFO:
+		if (sk->sk_state != BT_CONNECTED) {
+			err = -EINVAL;
+			break;
+		}
+
+		conninfo.sec_level = hcon->sec_level;
+
+		len = min_t(unsigned int, len, sizeof(conninfo));
+		if (copy_to_user(optval, (char *) &conninfo, len))
+			err = -EFAULT;
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
1.7.4

