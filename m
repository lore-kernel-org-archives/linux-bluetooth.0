Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/7] Bluetooth: Add clarifying comment to bt_sock_wait_state()
Date: Wed, 25 Sep 2013 13:26:04 +0300
Message-Id: <1380104770-8022-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com>
References: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The bt_sock_wait_state requires the sk lock to be held (through
lock_sock) so document it clearly in the code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/af_bluetooth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index c600631..e6e1278 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -490,6 +490,7 @@ int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 }
 EXPORT_SYMBOL(bt_sock_ioctl);
 
+/* This function expects the sk lock to be held when called */
 int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
 {
 	DECLARE_WAITQUEUE(wait, current);
-- 
1.8.3.1

