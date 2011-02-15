Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC -v2] Bluetooth: add BT_CONNINFO socketopt
Date: Tue, 15 Feb 2011 11:23:26 -0300
Message-Id: <1297779806-7165-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ATT needs to know to link key type before run some of it procedures.
Using the socket sec_level doesn't work because the socket may not reflect
the real sec_level of the link.

Reported-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/bluetooth.h |    2 ++
 net/bluetooth/l2cap_sock.c        |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 4375043..dea93df 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -66,6 +66,8 @@ struct bt_security {
 
 #define BT_FLUSHABLE	8
 
+#define BT_CONNINFO	9
+
 #define BT_FLUSHABLE_OFF	0
 #define BT_FLUSHABLE_ON		1
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 484e717..c249617 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -468,6 +468,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 {
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
+	struct hci_conn *hconn = (void *)l2cap_pi(sk)->conn;
 	int len, err = 0;
 
 	BT_DBG("sk %p", sk);
@@ -516,6 +517,16 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 		break;
 
+	case BT_CONNINFO:
+		if (sk->sk_state != BT_CONNECTED) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (put_user(hconn->sec_level, (u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
1.7.4

