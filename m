Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Bluetooth: Initialize the SMP workqueue
Date: Thu, 25 Aug 2011 19:23:04 -0300
Message-Id: <1314310984-5697-1-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1313798415-8555-3-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798415-8555-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

The SMP workqueue is initialized unconditionally because it needs
to be done during module initialization. And during this time we
can't be sure that LE support is available.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 09ca51e..b721f16 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4290,6 +4290,10 @@ int __init l2cap_init(void)
 	if (err < 0)
 		return err;
 
+	err = smp_crypto_init();
+	if (err < 0)
+		BT_DBG("SMP Initialization falied");
+
 	err = hci_register_proto(&l2cap_hci_proto);
 	if (err < 0) {
 		BT_ERR("L2CAP protocol registration failed");
@@ -4307,6 +4311,7 @@ int __init l2cap_init(void)
 	return 0;
 
 error:
+	smp_crypto_exit();
 	l2cap_cleanup_sockets();
 	return err;
 }
@@ -4315,6 +4320,8 @@ void l2cap_exit(void)
 {
 	debugfs_remove(l2cap_debugfs);
 
+	smp_crypto_exit();
+
 	if (hci_unregister_proto(&l2cap_hci_proto) < 0)
 		BT_ERR("L2CAP protocol unregistration failed");
 
-- 
1.7.6

