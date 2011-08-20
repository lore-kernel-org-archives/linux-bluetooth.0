Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/4] Bluetooth: Add functions to initialize the SMP workqueue
Date: Fri, 19 Aug 2011 21:00:13 -0300
Message-Id: <1313798415-8555-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798415-8555-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798415-8555-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SMP crypto function crypto_blkcypher_setkey() may sleep, so we need
to move that part of the SMP procedure inside a workqueue.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/smp.h |    3 +++
 net/bluetooth/smp.c         |   24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index 46c4576..884ed41 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -120,4 +120,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
 int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
 
+int smp_crypto_init(void);
+void smp_crypto_exit(void);
+
 #endif /* __SMP_H */
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f911930..9edd317 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -20,6 +20,7 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#include <linux/errno.h>
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
@@ -30,6 +31,8 @@
 
 #define SMP_TIMEOUT 30000 /* 30 seconds */
 
+static struct workqueue_struct *crypto_wq;
+
 struct smp_chan {
 	u8		preq[7]; /* SMP Pairing Request */
 	u8		prsp[7]; /* SMP Pairing Response */
@@ -644,6 +647,9 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 	BT_DBG("conn %p force %d", conn, force);
 
+	if (!crypto_wq)
+		return -ENOTSUPP;
+
 	if (!test_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend))
 		return 0;
 
@@ -725,3 +731,21 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 	return 0;
 }
+
+int smp_crypto_init(void)
+{
+	crypto_wq = create_singlethread_workqueue("smp");
+	if (!crypto_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void smp_crypto_exit(void)
+{
+	if (!crypto_wq)
+		return;
+
+	flush_workqueue(crypto_wq);
+	destroy_workqueue(crypto_wq);
+}
-- 
1.7.6

