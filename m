Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] Bluetooth: Fix removing any IRKs when unpairing devices
Date: Tue, 18 Feb 2014 17:14:35 +0200
Message-Id: <1392736479-8808-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
References: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When mgmt_unpair_device is called we should also remove any associated
IRKs. This patch adds a hci_remove_irk convenience function and ensures
that it's called when mgmt_unpair_device is called.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 15 +++++++++++++++
 net/bluetooth/mgmt.c             |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 964a7888ad0c..ac468de11cb7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -801,6 +801,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type);
 int hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type,
 		u8 val[16], bdaddr_t *rpa);
+void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type);
 void hci_smp_irks_clear(struct hci_dev *hdev);
 
 void hci_remote_oob_data_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 69b7145bfce2..cdba4709f012 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2823,6 +2823,21 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 	return removed ? 0 : -ENOENT;
 }
 
+void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
+{
+	struct smp_irk *k, *tmp;
+
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
+		if (bacmp(bdaddr, &k->bdaddr) || k->addr_type != addr_type)
+			continue;
+
+		BT_DBG("%s removing %pMR", hdev->name, bdaddr);
+
+		list_del(&k->list);
+		kfree(k);
+	}
+}
+
 /* HCI command timer function */
 static void hci_cmd_timeout(unsigned long arg)
 {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fbb76a0de580..90aac905a98b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2328,6 +2328,8 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		else
 			addr_type = ADDR_LE_DEV_RANDOM;
 
+		hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
+
 		err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
 	}
 
-- 
1.8.5.3

