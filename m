Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] Bluetooth: Remove return values from functions that don't need them
Date: Tue, 18 Feb 2014 17:14:32 +0200
Message-Id: <1392736479-8808-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
References: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are many functions that never fail but still declare an integer
return value for no reason. This patch converts these functions to use a
void return value to avoid any confusion of whether they can fail or not.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 10 +++++-----
 net/bluetooth/hci_core.c         | 26 +++++++++-----------------
 net/bluetooth/mgmt.c             |  2 +-
 3 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ab94abdeb3c1..964a7888ad0c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -768,7 +768,7 @@ int hci_inquiry(void __user *arg);
 
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
 					 bdaddr_t *bdaddr, u8 type);
-int hci_blacklist_clear(struct hci_dev *hdev);
+void hci_blacklist_clear(struct hci_dev *hdev);
 int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
@@ -779,9 +779,9 @@ void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear(struct hci_dev *hdev);
 
-int hci_uuids_clear(struct hci_dev *hdev);
+void hci_uuids_clear(struct hci_dev *hdev);
 
-int hci_link_keys_clear(struct hci_dev *hdev);
+void hci_link_keys_clear(struct hci_dev *hdev);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		     bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
@@ -793,7 +793,7 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type, bool master);
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type);
-int hci_smp_ltks_clear(struct hci_dev *hdev);
+void hci_smp_ltks_clear(struct hci_dev *hdev);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa);
@@ -803,7 +803,7 @@ int hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type,
 		u8 val[16], bdaddr_t *rpa);
 void hci_smp_irks_clear(struct hci_dev *hdev);
 
-int hci_remote_oob_data_clear(struct hci_dev *hdev);
+void hci_remote_oob_data_clear(struct hci_dev *hdev);
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr);
 int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 957c8f4cc4c7..fd5bb4086613 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2506,7 +2506,7 @@ static void hci_discov_off(struct work_struct *work)
 	mgmt_discoverable_timeout(hdev);
 }
 
-int hci_uuids_clear(struct hci_dev *hdev)
+void hci_uuids_clear(struct hci_dev *hdev)
 {
 	struct bt_uuid *uuid, *tmp;
 
@@ -2514,11 +2514,9 @@ int hci_uuids_clear(struct hci_dev *hdev)
 		list_del(&uuid->list);
 		kfree(uuid);
 	}
-
-	return 0;
 }
 
-int hci_link_keys_clear(struct hci_dev *hdev)
+void hci_link_keys_clear(struct hci_dev *hdev)
 {
 	struct list_head *p, *n;
 
@@ -2530,11 +2528,9 @@ int hci_link_keys_clear(struct hci_dev *hdev)
 		list_del(p);
 		kfree(key);
 	}
-
-	return 0;
 }
 
-int hci_smp_ltks_clear(struct hci_dev *hdev)
+void hci_smp_ltks_clear(struct hci_dev *hdev)
 {
 	struct smp_ltk *k, *tmp;
 
@@ -2542,8 +2538,6 @@ int hci_smp_ltks_clear(struct hci_dev *hdev)
 		list_del(&k->list);
 		kfree(k);
 	}
-
-	return 0;
 }
 
 void hci_smp_irks_clear(struct hci_dev *hdev)
@@ -2873,7 +2867,7 @@ int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return 0;
 }
 
-int hci_remote_oob_data_clear(struct hci_dev *hdev)
+void hci_remote_oob_data_clear(struct hci_dev *hdev)
 {
 	struct oob_data *data, *n;
 
@@ -2881,8 +2875,6 @@ int hci_remote_oob_data_clear(struct hci_dev *hdev)
 		list_del(&data->list);
 		kfree(data);
 	}
-
-	return 0;
 }
 
 int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
@@ -2951,7 +2943,7 @@ struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
 	return NULL;
 }
 
-int hci_blacklist_clear(struct hci_dev *hdev)
+void hci_blacklist_clear(struct hci_dev *hdev)
 {
 	struct list_head *p, *n;
 
@@ -2961,8 +2953,6 @@ int hci_blacklist_clear(struct hci_dev *hdev)
 		list_del(p);
 		kfree(b);
 	}
-
-	return 0;
 }
 
 int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
@@ -2991,8 +2981,10 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	struct bdaddr_list *entry;
 
-	if (!bacmp(bdaddr, BDADDR_ANY))
-		return hci_blacklist_clear(hdev);
+	if (!bacmp(bdaddr, BDADDR_ANY)) {
+		hci_blacklist_clear(hdev);
+		return 0;
+	}
 
 	entry = hci_blacklist_lookup(hdev, bdaddr, type);
 	if (!entry)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 473f8687b28b..fbb76a0de580 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2073,7 +2073,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (memcmp(cp->uuid, bt_uuid_any, 16) == 0) {
-		err = hci_uuids_clear(hdev);
+		hci_uuids_clear(hdev);
 
 		if (enable_service_cache(hdev)) {
 			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID,
-- 
1.8.5.3

