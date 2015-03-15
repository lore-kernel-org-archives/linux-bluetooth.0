Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 08/14] Bluetooth: Add hci_sock_test_flag helper function
Date: Sat, 14 Mar 2015 19:28:00 -0700
Message-Id: <1426386486-15962-8-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The management interface will need access to the socket flags and so
provide a helper function for checking them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 1 +
 net/bluetooth/hci_sock.c          | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ae1f2ee1eaf3..d871ba313f64 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -337,6 +337,7 @@ int bt_to_errno(__u16 code);
 
 void hci_sock_set_flag(struct sock *sk, int nr);
 void hci_sock_clear_flag(struct sock *sk, int nr);
+int hci_sock_test_flag(struct sock *sk, int nr);
 
 int hci_sock_init(void);
 void hci_sock_cleanup(void);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index e7f463f6fd69..df23c184c897 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -60,6 +60,11 @@ void hci_sock_clear_flag(struct sock *sk, int nr)
 	clear_bit(nr, &hci_pi(sk)->flags);
 }
 
+int hci_sock_test_flag(struct sock *sk, int nr)
+{
+	return test_bit(nr, &hci_pi(sk)->flags);
+}
+
 static inline int hci_test_bit(int nr, const void *addr)
 {
 	return *((const __u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
@@ -211,7 +216,7 @@ void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 		struct sk_buff *nskb;
 
 		/* Ignore socket without the flag set */
-		if (!test_bit(flag, &hci_pi(sk)->flags))
+		if (!hci_sock_test_flag(sk, flag))
 			continue;
 
 		/* Skip the original socket */
-- 
2.1.0

