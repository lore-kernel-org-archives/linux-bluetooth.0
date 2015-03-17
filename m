Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: Add helper to get HCI channel of a socket
Date: Tue, 17 Mar 2015 13:48:46 +0200
Message-Id: <1426592930-5842-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
References: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll need to have access to which HCI channel a socket is bound to, in
order to manage pending mgmt commands in clean way. This patch adds a
helper for the purpose.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h | 1 +
 net/bluetooth/hci_sock.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index d871ba313f64..33a5e00025aa 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -338,6 +338,7 @@ int bt_to_errno(__u16 code);
 void hci_sock_set_flag(struct sock *sk, int nr);
 void hci_sock_clear_flag(struct sock *sk, int nr);
 int hci_sock_test_flag(struct sock *sk, int nr);
+unsigned short hci_sock_get_channel(struct sock *sk);
 
 int hci_sock_init(void);
 void hci_sock_cleanup(void);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 7c719602dbca..9ba1a2667eaa 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -65,6 +65,11 @@ int hci_sock_test_flag(struct sock *sk, int nr)
 	return test_bit(nr, &hci_pi(sk)->flags);
 }
 
+unsigned short hci_sock_get_channel(struct sock *sk)
+{
+	return hci_pi(sk)->channel;
+}
+
 static inline int hci_test_bit(int nr, const void *addr)
 {
 	return *((const __u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
-- 
2.1.0

