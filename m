Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [bluetooth-next v4 04/16] Bluetooth: Add support for using the crypto subsystem
Date: Thu,  9 Jun 2011 18:50:43 -0300
Message-Id: <1307656255-8659-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307656255-8659-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307656255-8659-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow using the crypto subsystem for encrypting data. As SMP
(Security Manager Protocol) is implemented almost entirely on the host
side and the crypto module already implements the needed methods
(AES-128), it makes sense to use it.

There's now a new module option to enable/disable SMP support.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/Kconfig            |    8 ++++++++
 net/bluetooth/hci_core.c         |   22 ++++++++++++++++++++++
 net/bluetooth/smp.c              |   22 ++++++++++++++++++----
 4 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 836d3e8..7837f32 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -177,6 +177,8 @@ struct hci_dev {
 
 	__u16			init_last_cmd;
 
+	struct crypto_blkcipher	*tfm;
+
 	struct inquiry_cache	inq_cache;
 	struct hci_conn_hash	conn_hash;
 	struct list_head	blacklist;
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 6ae5ec5..f495dea 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -22,6 +22,7 @@ menuconfig BT
 	     BNEP Module (Bluetooth Network Encapsulation Protocol)
 	     CMTP Module (CAPI Message Transport Protocol)
 	     HIDP Module (Human Interface Device Protocol)
+	     SMP Module (Security Manager Protocol)
 
 	  Say Y here to compile Bluetooth support into the kernel or say M to
 	  compile it as module (bluetooth).
@@ -36,11 +37,18 @@ if BT != n
 config BT_L2CAP
 	bool "L2CAP protocol support"
 	select CRC16
+	select CRYPTO
+	select CRYPTO_BLKCIPHER
+	select CRYPTO_AES
+	select CRYPTO_ECB
 	help
 	  L2CAP (Logical Link Control and Adaptation Protocol) provides
 	  connection oriented and connection-less data transport.  L2CAP
 	  support is required for most Bluetooth applications.
 
+	  Also included is support for SMP (Security Manager Protocol) which
+	  is the security layer on top of LE (Low Energy) links.
+
 config BT_SCO
 	bool "SCO links support"
 	help
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e14e8a1..f62ca19 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -42,6 +42,7 @@
 #include <linux/notifier.h>
 #include <linux/rfkill.h>
 #include <linux/timer.h>
+#include <linux/crypto.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
@@ -59,6 +60,8 @@ static void hci_tx_task(unsigned long arg);
 
 static DEFINE_RWLOCK(hci_task_lock);
 
+static int enable_smp;
+
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
 DEFINE_RWLOCK(hci_dev_list_lock);
@@ -1274,6 +1277,14 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	return 0;
 }
 
+static struct crypto_blkcipher *alloc_cypher(void)
+{
+	if (enable_smp)
+		return crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+
+	return ERR_PTR(-ENOTSUPP);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1358,6 +1369,11 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!hdev->workqueue)
 		goto nomem;
 
+	hdev->tfm = alloc_cypher();
+	if (IS_ERR(hdev->tfm))
+		BT_INFO("Failed to load transform for ecb(aes): %ld",
+							PTR_ERR(hdev->tfm));
+
 	hci_register_sysfs(hdev);
 
 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
@@ -1406,6 +1422,9 @@ int hci_unregister_dev(struct hci_dev *hdev)
 					!test_bit(HCI_SETUP, &hdev->flags))
 		mgmt_index_removed(hdev->id);
 
+	if (!IS_ERR(hdev->tfm))
+		crypto_free_blkcipher(hdev->tfm);
+
 	hci_notify(hdev, HCI_DEV_UNREG);
 
 	if (hdev->rfkill) {
@@ -2242,3 +2261,6 @@ static void hci_cmd_task(unsigned long arg)
 		}
 	}
 }
+
+module_param(enable_smp, bool, 0644);
+MODULE_PARM_DESC(enable_smp, "Enable SMP support (LE only)");
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2240e96..aa20bee 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -154,9 +154,13 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 {
+	struct hci_conn *hcon = conn->hcon;
 	__u8 authreq;
 
-	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, conn->hcon, sec_level);
+	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
+
+	if (IS_ERR(hcon->hdev->tfm))
+		return 1;
 
 	switch (sec_level) {
 	case BT_SECURITY_MEDIUM:
@@ -174,7 +178,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		return 1;
 	}
 
-	if (conn->hcon->link_mode & HCI_LM_MASTER) {
+	if (hcon->link_mode & HCI_LM_MASTER) {
 		struct smp_cmd_pairing cp;
 		cp.io_capability = 0x00;
 		cp.oob_flag = 0x00;
@@ -198,6 +202,12 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
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
@@ -233,11 +243,15 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
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
1.7.5.4

