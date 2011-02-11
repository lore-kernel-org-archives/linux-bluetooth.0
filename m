Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [bluetooth-next -v2 14/24] Bluetooth: Add support for using the crypto subsystem
Date: Thu, 10 Feb 2011 22:38:59 -0300
Message-Id: <1297388349-14878-15-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297388349-14878-14-git-send-email-vinicius.gomes@openbossa.org>
References: <1297388349-14878-1-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-2-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-3-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-4-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-5-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-6-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-7-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-8-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-9-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-10-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-11-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-12-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-13-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-14-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow using the crypto subsystem for encrypting data. As SMP
(Security Manager Protocol) is implemented almost entirely on the host
side and the crypto module already implements the needed methods
(AES-128), it makes sense to use it.

This patch also adds a new Kconfig option to toggle the SMP support.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/Kconfig            |   12 ++++++++++++
 net/bluetooth/hci_core.c         |   17 +++++++++++++++++
 net/bluetooth/smp.c              |   17 +++++++++++++++--
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d30b93c..4bfe38d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -161,6 +161,8 @@ struct hci_dev {
 
 	__u16			init_last_cmd;
 
+	struct crypto_blkcipher	*tfm;
+
 	struct inquiry_cache	inq_cache;
 	struct hci_conn_hash	conn_hash;
 	struct list_head	blacklist;
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index e45eae6..b08293b 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -43,6 +43,18 @@ config BT_L2CAP
 	  Say Y here to compile L2CAP support into the kernel or say M to
 	  compile it as module (l2cap).
 
+config BT_SMP
+	bool "Security Manager Protocol support"
+	depends on BT_L2CAP
+	select CRYPTO_BLKCIPHER
+	select CRYPTO_AES
+	help
+	  The Security Manager Protocol (SMP) is used for pairing and
+	  transport specific key distribution. The SMP is used on Low
+	  Energy devices to handle encrypted connections.
+
+	  Say Y here to compile SMP support into the kernel.
+
 config BT_SCO
 	tristate "SCO links support"
 	depends on BT
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 173bebd..c81dc17 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -41,6 +41,7 @@
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/rfkill.h>
+#include <linux/crypto.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
@@ -1066,6 +1067,14 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static struct crypto_blkcipher *alloc_cypher(void)
+{
+#ifndef CONFIG_BT_SMP
+	return ERR_PTR(-ENOTSUPP);
+#endif
+	return crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1142,6 +1151,11 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!hdev->workqueue)
 		goto nomem;
 
+	hdev->tfm = alloc_cypher();
+	if (IS_ERR(hdev->tfm))
+		BT_INFO("Failed to load transform for ecb(aes): %ld",
+							PTR_ERR(hdev->tfm));
+
 	hci_register_sysfs(hdev);
 
 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
@@ -1190,6 +1204,9 @@ int hci_unregister_dev(struct hci_dev *hdev)
 					!test_bit(HCI_SETUP, &hdev->flags))
 		mgmt_index_removed(hdev->id);
 
+	if (!IS_ERR(hdev->tfm))
+		crypto_free_blkcipher(hdev->tfm);
+
 	hci_notify(hdev, HCI_DEV_UNREG);
 
 	if (hdev->rfkill) {
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 479ff6b..80a3c7e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -279,6 +279,9 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 
 	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, conn->hcon, sec_level);
 
+	if (IS_ERR(conn->hcon->hdev->tfm))
+		return PTR_ERR(conn->hcon->hdev->tfm);
+
 	switch (sec_level) {
 	case BT_SECURITY_MEDIUM:
 		/* Encrypted, no MITM protection */
@@ -319,6 +322,12 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 	__u8 reason;
 	int err = 0;
 
+	if (IS_ERR(conn->hcon->hdev->tfm)) {
+		err = PTR_ERR(conn->hcon->hdev->tfm);
+		reason = SMP_PAIRING_NOTSUPP;
+		goto done;
+	}
+
 	skb_pull(skb, sizeof(code));
 
 	switch (code) {
@@ -354,11 +363,15 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 		BT_DBG("Unknown command code 0x%2.2x", code);
 
 		reason = SMP_CMD_NOTSUPP;
-		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
-								&reason);
 		err = -EOPNOTSUPP;
+		goto done;
 	}
 
+done:
+	if (reason)
+		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
+								&reason);
+
 	kfree_skb(skb);
 	return err;
 }
-- 
1.7.4

