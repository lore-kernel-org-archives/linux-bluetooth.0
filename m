Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 17/20] Bluetooth: Add support for using the crypto subsystem
Date: Tue, 23 Nov 2010 12:06:33 -0300
Message-Id: <1290524796-32246-18-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow using the crypto subsystem for encrypting data. As SMP
(Security Manager Protocol) is implemented almost entirely on the host
side and the crypto module already implements the needed methods
(AES-128), it makes sense to use it.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   10 ++++++++++
 net/bluetooth/smp.c              |    1 -
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e2d857a..ee5efa8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -135,6 +135,8 @@ struct hci_dev {
 	__u32			req_status;
 	__u32			req_result;
 
+	struct crypto_blkcipher	*tfm;
+
 	struct inquiry_cache	inq_cache;
 	struct hci_conn_hash	conn_hash;
 	struct list_head	blacklist;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5750b80..0e98ffb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -41,6 +41,7 @@
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/rfkill.h>
+#include <linux/crypto.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
@@ -947,6 +948,13 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!hdev->workqueue)
 		goto nomem;
 
+	hdev->tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(hdev->tfm)) {
+		BT_ERR("Failed to load transform for ecb(aes): %ld",
+							PTR_ERR(hdev->tfm));
+		goto nomem;
+	}
+
 	hci_register_sysfs(hdev);
 
 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
@@ -987,6 +995,8 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	for (i = 0; i < NUM_REASSEMBLY; i++)
 		kfree_skb(hdev->reassembly[i]);
 
+	crypto_free_blkcipher(hdev->tfm);
+
 	hci_notify(hdev, HCI_DEV_UNREG);
 
 	if (hdev->rfkill) {
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 7997978..8e8be47 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -227,7 +227,6 @@ static void smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb
 	BT_DBG("");
 
 	if (conn->hcon->out) {
-
 		struct smp_cmd_pairing_random random;
 
 		BT_DBG("master");
-- 
1.7.3.2

