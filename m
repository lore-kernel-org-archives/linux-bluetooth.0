Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/12 v3] Bluetooth: Add initial hooks for HCI transaction support
Date: Fri, 15 Feb 2013 11:51:49 +0200
Message-Id: <1360921920-14080-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the initial context variables and functions for HCI
transaction support. HCI transactions are essentially just groups of HCI
commands with an optional callback for notifying the completion of the
transaction.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   17 +++++++++++++++++
 net/bluetooth/hci_core.c         |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 90cf75a..0e53032 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -134,6 +134,15 @@ struct amp_assoc {
 	__u8	data[HCI_MAX_AMP_ASSOC_SIZE];
 };
 
+struct hci_dev;
+
+struct hci_transaction {
+	struct list_head	list;
+	struct sk_buff_head	cmd_q;
+	void			(*complete)(struct hci_dev *hdev,
+					    __u16 last_cmd, int hci_err);
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -240,6 +249,11 @@ struct hci_dev {
 	struct sk_buff_head	raw_q;
 	struct sk_buff_head	cmd_q;
 
+	struct mutex		transaction_lock;
+	struct hci_transaction	*build_transaction;
+	struct hci_transaction	*current_transaction;
+	struct list_head	transaction_q;
+
 	struct sk_buff		*sent_cmd;
 	struct sk_buff		*reassembly[NUM_REASSEMBLY];
 
@@ -1041,6 +1055,9 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
+#define hci_transaction_lock(d)		mutex_lock(&d->transaction_lock)
+#define hci_transaction_unlock(d)	mutex_unlock(&d->transaction_lock)
+
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 22e77a7..05e2e8b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -689,6 +689,36 @@ unlock:
 	return err;
 }
 
+static void __transaction_free(struct hci_transaction *transaction)
+{
+	skb_queue_purge(&transaction->cmd_q);
+	kfree(transaction);
+}
+
+static void hci_transaction_cleanup(struct hci_dev *hdev)
+{
+	struct hci_transaction *transact, *tmp;
+
+	hci_transaction_lock(hdev);
+
+	if (hdev->build_transaction) {
+		__transaction_free(hdev->build_transaction);
+		hdev->build_transaction = NULL;
+	}
+
+	if (hdev->current_transaction) {
+		__transaction_free(hdev->current_transaction);
+		hdev->current_transaction = NULL;
+	}
+
+	list_for_each_entry_safe(transact, tmp, &hdev->transaction_q, list) {
+		list_del(&transact->list);
+		__transaction_free(transact);
+	}
+
+	hci_transaction_unlock(hdev);
+}
+
 /* ---- HCI ioctl helpers ---- */
 
 int hci_dev_open(__u16 dev)
@@ -759,6 +789,7 @@ int hci_dev_open(__u16 dev)
 		flush_work(&hdev->cmd_work);
 		flush_work(&hdev->rx_work);
 
+		hci_transaction_cleanup(hdev);
 		skb_queue_purge(&hdev->cmd_q);
 		skb_queue_purge(&hdev->rx_q);
 
@@ -823,6 +854,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		hdev->flush(hdev);
 
 	/* Reset device */
+	hci_transaction_cleanup(hdev);
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
 	if (!test_bit(HCI_RAW, &hdev->flags) &&
@@ -838,6 +870,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
 	skb_queue_purge(&hdev->cmd_q);
+	hci_transaction_cleanup(hdev);
 	skb_queue_purge(&hdev->raw_q);
 
 	/* Drop last sent command */
@@ -908,6 +941,7 @@ int hci_dev_reset(__u16 dev)
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
 	skb_queue_purge(&hdev->cmd_q);
+	hci_transaction_cleanup(hdev);
 
 	hci_dev_lock(hdev);
 	inquiry_cache_flush(hdev);
@@ -1710,6 +1744,7 @@ struct hci_dev *hci_alloc_dev(void)
 
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
+	mutex_init(&hdev->transaction_lock);
 
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->blacklist);
@@ -1718,6 +1753,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->long_term_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
+	INIT_LIST_HEAD(&hdev->transaction_q);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
-- 
1.7.10.4

