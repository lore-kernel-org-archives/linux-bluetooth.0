Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Add clarifying comment to bt_sock_wait_state()
Date: Tue, 24 Sep 2013 17:02:36 +0300
Message-Id: <1380031363-1266-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The bt_sock_wait_state requires the sk lock to be held (through
lock_sock) so document it clearly in the code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
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
1.8.4.rc3

