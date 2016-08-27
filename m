Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Store control socket cookie and comm information
Date: Sat, 27 Aug 2016 20:23:38 +0200
Message-Id: <1472322221-86761-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To further allow unique identification and tracking of control socket,
store cookie and comm information when binding the socket.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/hci_sock.c          | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bfd1590821d6..69b5174168b7 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -371,6 +371,7 @@ void hci_sock_set_flag(struct sock *sk, int nr);
 void hci_sock_clear_flag(struct sock *sk, int nr);
 int hci_sock_test_flag(struct sock *sk, int nr);
 unsigned short hci_sock_get_channel(struct sock *sk);
+u32 hci_sock_get_cookie(struct sock *sk);
 
 int hci_sock_init(void);
 void hci_sock_cleanup(void);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 99dd1503ef56..4dce6dfdb0f2 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -26,6 +26,7 @@
 
 #include <linux/export.h>
 #include <linux/utsname.h>
+#include <linux/sched.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -38,6 +39,8 @@
 static LIST_HEAD(mgmt_chan_list);
 static DEFINE_MUTEX(mgmt_chan_list_lock);
 
+static DEFINE_IDA(sock_cookie_ida);
+
 static atomic_t monitor_promisc = ATOMIC_INIT(0);
 
 /* ----- HCI socket interface ----- */
@@ -52,6 +55,8 @@ struct hci_pinfo {
 	__u32             cmsg_mask;
 	unsigned short    channel;
 	unsigned long     flags;
+	__u32             cookie;
+	char              comm[TASK_COMM_LEN];
 };
 
 void hci_sock_set_flag(struct sock *sk, int nr)
@@ -74,6 +79,11 @@ unsigned short hci_sock_get_channel(struct sock *sk)
 	return hci_pi(sk)->channel;
 }
 
+u32 hci_sock_get_cookie(struct sock *sk)
+{
+	return hci_pi(sk)->cookie;
+}
+
 static inline int hci_test_bit(int nr, const void *addr)
 {
 	return *((const __u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
@@ -585,6 +595,7 @@ static int hci_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct hci_dev *hdev;
+	int id;
 
 	BT_DBG("sock %p sk %p", sock, sk);
 
@@ -593,8 +604,17 @@ static int hci_sock_release(struct socket *sock)
 
 	hdev = hci_pi(sk)->hdev;
 
-	if (hci_pi(sk)->channel == HCI_CHANNEL_MONITOR)
+	switch (hci_pi(sk)->channel) {
+	case HCI_CHANNEL_MONITOR:
 		atomic_dec(&monitor_promisc);
+		break;
+	case HCI_CHANNEL_CONTROL:
+		id = hci_pi(sk)->cookie;
+
+		hci_pi(sk)->cookie = 0xffffffff;
+		ida_simple_remove(&sock_cookie_ida, id);
+		break;
+	}
 
 	bt_sock_unlink(&hci_sk_list, sk);
 
@@ -957,6 +977,15 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		 * are changes to settings, class of device, name etc.
 		 */
 		if (haddr.hci_channel == HCI_CHANNEL_CONTROL) {
+			int id;
+
+			id = ida_simple_get(&sock_cookie_ida, 1, 0, GFP_KERNEL);
+			if (id < 0)
+				id = 0xffffffff;
+
+			hci_pi(sk)->cookie = id;
+			get_task_comm(hci_pi(sk)->comm, current);
+
 			hci_sock_set_flag(sk, HCI_MGMT_INDEX_EVENTS);
 			hci_sock_set_flag(sk, HCI_MGMT_UNCONF_INDEX_EVENTS);
 			hci_sock_set_flag(sk, HCI_MGMT_GENERIC_EVENTS);
-- 
2.7.4

