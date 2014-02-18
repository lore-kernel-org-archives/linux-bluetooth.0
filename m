Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] Bluetooth: Add basic IRK management support
Date: Tue, 18 Feb 2014 10:19:33 +0200
Message-Id: <1392711577-31431-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
References: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the initial IRK storage and management functions to the
HCI core. This includes storing a list of IRKs per HCI device and the
ability to add, remove and lookup entries in that list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 16 +++++++++
 net/bluetooth/hci_core.c         | 70 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b344890b18f5..eac422337582 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -103,6 +103,14 @@ struct smp_ltk {
 	u8 val[16];
 };
 
+struct smp_irk {
+	struct list_head list;
+	bdaddr_t rpa;
+	bdaddr_t bdaddr;
+	u8 addr_type;
+	u8 val[16];
+};
+
 struct link_key {
 	struct list_head list;
 	bdaddr_t bdaddr;
@@ -269,6 +277,7 @@ struct hci_dev {
 	struct list_head	uuids;
 	struct list_head	link_keys;
 	struct list_head	long_term_keys;
+	struct list_head	identity_resolving_keys;
 	struct list_head	remote_oob_data;
 	struct list_head	le_conn_params;
 
@@ -787,6 +796,13 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_smp_ltks_clear(struct hci_dev *hdev);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
+struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa);
+struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				     u8 addr_type);
+int hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type,
+		u8 val[16], bdaddr_t *rpa);
+void hci_smp_irks_clear(struct hci_dev *hdev);
+
 int hci_remote_oob_data_clear(struct hci_dev *hdev);
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cd1cd7da3235..2e1819bed2b4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -35,6 +35,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "smp.h"
+
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
@@ -2544,6 +2546,16 @@ int hci_smp_ltks_clear(struct hci_dev *hdev)
 	return 0;
 }
 
+void hci_smp_irks_clear(struct hci_dev *hdev)
+{
+	struct smp_irk *k, *tmp;
+
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
+		list_del(&k->list);
+		kfree(k);
+	}
+}
+
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct link_key *k;
@@ -2632,6 +2644,39 @@ struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return NULL;
 }
 
+struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
+{
+	struct smp_irk *irk;
+
+	list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
+		if (!bacmp(&irk->rpa, rpa))
+			return irk;
+	}
+
+	list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
+		if (smp_irk_matches(hdev->tfm_aes, irk->val, rpa)) {
+			bacpy(&irk->rpa, rpa);
+			return irk;
+		}
+	}
+
+	return NULL;
+}
+
+struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				     u8 addr_type)
+{
+	struct smp_irk *irk;
+
+	list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
+		if (addr_type == irk->addr_type &&
+		    bacmp(bdaddr, &irk->bdaddr) == 0)
+			return irk;
+	}
+
+	return NULL;
+}
+
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		     bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len)
 {
@@ -2726,6 +2771,29 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 	return 0;
 }
 
+int hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type,
+		u8 val[16], bdaddr_t *rpa)
+{
+	struct smp_irk *irk;
+
+	irk = hci_find_irk_by_addr(hdev, bdaddr, addr_type);
+	if (!irk) {
+		irk = kzalloc(sizeof(*irk), GFP_KERNEL);
+		if (!irk)
+			return -ENOMEM;
+
+		bacpy(&irk->bdaddr, bdaddr);
+		irk->addr_type = addr_type;
+
+		list_add(&irk->list, &hdev->identity_resolving_keys);
+	}
+
+	memcpy(irk->val, val, 16);
+	bacpy(&irk->rpa, rpa);
+
+	return 0;
+}
+
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct link_key *key;
@@ -3120,6 +3188,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->uuids);
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
+	INIT_LIST_HEAD(&hdev->identity_resolving_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 	INIT_LIST_HEAD(&hdev->le_conn_params);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
@@ -3318,6 +3387,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
+	hci_smp_irks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
 	hci_conn_params_clear(hdev);
 	hci_dev_unlock(hdev);
-- 
1.8.5.3

