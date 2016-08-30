Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Introduce helper functions for socket cookie handling
Date: Tue, 30 Aug 2016 05:00:34 +0200
Message-Id: <1472526040-21804-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of manually allocating cookie information each time, use helper
functions for generating and releasing cookies.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 222d025f9149..933de46886b3 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -84,6 +84,33 @@ u32 hci_sock_get_cookie(struct sock *sk)
 	return hci_pi(sk)->cookie;
 }
 
+static bool hci_sock_gen_cookie(struct sock *sk)
+{
+	int id = hci_pi(sk)->cookie;
+
+	if (!id) {
+		id = ida_simple_get(&sock_cookie_ida, 1, 0, GFP_KERNEL);
+		if (id < 0)
+			id = 0xffffffff;
+
+		hci_pi(sk)->cookie = id;
+		get_task_comm(hci_pi(sk)->comm, current);
+		return true;
+	}
+
+	return false;
+}
+
+static void hci_sock_free_cookie(struct sock *sk)
+{
+	int id = hci_pi(sk)->cookie;
+
+	if (id) {
+		hci_pi(sk)->cookie = 0xffffffff;
+		ida_simple_remove(&sock_cookie_ida, id);
+	}
+}
+
 static inline int hci_test_bit(int nr, const void *addr)
 {
 	return *((const __u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
@@ -753,7 +780,6 @@ static int hci_sock_release(struct socket *sock)
 	struct sock *sk = sock->sk;
 	struct hci_dev *hdev;
 	struct sk_buff *skb;
-	int id;
 
 	BT_DBG("sock %p sk %p", sock, sk);
 
@@ -767,8 +793,6 @@ static int hci_sock_release(struct socket *sock)
 		atomic_dec(&monitor_promisc);
 		break;
 	case HCI_CHANNEL_CONTROL:
-		id = hci_pi(sk)->cookie;
-
 		/* Send event to monitor */
 		skb = create_monitor_ctrl_close(sk);
 		if (skb) {
@@ -777,8 +801,7 @@ static int hci_sock_release(struct socket *sock)
 			kfree_skb(skb);
 		}
 
-		hci_pi(sk)->cookie = 0xffffffff;
-		ida_simple_remove(&sock_cookie_ida, id);
+		hci_sock_free_cookie(sk);
 		break;
 	}
 
@@ -1145,14 +1168,8 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		 */
 		if (haddr.hci_channel == HCI_CHANNEL_CONTROL) {
 			struct sk_buff *skb;
-			int id;
-
-			id = ida_simple_get(&sock_cookie_ida, 1, 0, GFP_KERNEL);
-			if (id < 0)
-				id = 0xffffffff;
 
-			hci_pi(sk)->cookie = id;
-			get_task_comm(hci_pi(sk)->comm, current);
+			hci_sock_gen_cookie(sk);
 
 			/* Send event to monitor */
 			skb = create_monitor_ctrl_open(sk);
-- 
2.7.4

