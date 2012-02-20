Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] Bluetooth: Lock socket when reading HCI socket options
Date: Mon, 20 Feb 2012 11:58:37 +0100
Message-Id: <1329735520-23539-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When reading the HCI raw socket option, the socket was never locked. So
lock the socket and in addition return EINVAL on non raw sockets.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 3d86aa6..d729dd7 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -677,11 +677,20 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname, char
 {
 	struct hci_ufilter uf;
 	struct sock *sk = sock->sk;
-	int len, opt;
+	int len, opt, err = 0;
+
+	BT_DBG("sk %p, opt %d", sk, optname);
 
 	if (get_user(len, optlen))
 		return -EFAULT;
 
+	lock_sock(sk);
+
+	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
+		err = -EINVAL;
+		goto done;
+	}
+
 	switch (optname) {
 	case HCI_DATA_DIR:
 		if (hci_pi(sk)->cmsg_mask & HCI_CMSG_DIR)
@@ -690,7 +699,7 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname, char
 			opt = 0;
 
 		if (put_user(opt, optval))
-			return -EFAULT;
+			err = -EFAULT;
 		break;
 
 	case HCI_TIME_STAMP:
@@ -700,7 +709,7 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname, char
 			opt = 0;
 
 		if (put_user(opt, optval))
-			return -EFAULT;
+			err = -EFAULT;
 		break;
 
 	case HCI_FILTER:
@@ -715,15 +724,17 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname, char
 
 		len = min_t(unsigned int, len, sizeof(uf));
 		if (copy_to_user(optval, &uf, len))
-			return -EFAULT;
+			err = -EFAULT;
 		break;
 
 	default:
-		return -ENOPROTOOPT;
+		err = -ENOPROTOOPT;
 		break;
 	}
 
-	return 0;
+done:
+	release_sock(sk);
+	return err;
 }
 
 static const struct proto_ops hci_sock_ops = {
-- 
1.7.7.6

