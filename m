Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 01/14] Bluetooth: Add flags field and setting function for HCI sockets
Date: Sat, 14 Mar 2015 19:27:53 -0700
Message-Id: <1426386486-15962-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To filter out certain actions for certain HCI sockets introcuce a flags
field that allows to configure specific settings on individual sockets.

Since the hci_pinfo structure is private in hci_sock.c, provide helper
functions for setting and clearing a given flag.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h |  3 +++
 net/bluetooth/hci_sock.c          | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e598ca096ec9..ae1f2ee1eaf3 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -335,6 +335,9 @@ out:
 
 int bt_to_errno(__u16 code);
 
+void hci_sock_set_flag(struct sock *sk, int nr);
+void hci_sock_clear_flag(struct sock *sk, int nr);
+
 int hci_sock_init(void);
 void hci_sock_cleanup(void);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index b614543b4fe3..bf5365c49c9c 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -47,8 +47,19 @@ struct hci_pinfo {
 	struct hci_filter filter;
 	__u32             cmsg_mask;
 	unsigned short    channel;
+	unsigned long     flags;
 };
 
+void hci_sock_set_flag(struct sock *sk, int nr)
+{
+	set_bit(nr, &hci_pi(sk)->flags);
+}
+
+void hci_sock_clear_flag(struct sock *sk, int nr)
+{
+	clear_bit(nr, &hci_pi(sk)->flags);
+}
+
 static inline int hci_test_bit(int nr, const void *addr)
 {
 	return *((const __u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
-- 
2.1.0

