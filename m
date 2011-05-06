Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 03/12] Bluetooth: Protect 'adv_entries' with a RW lock
Date: Fri,  6 May 2011 14:05:12 -0300
Message-Id: <1304701521-26459-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a RW lock to protect concurrent operations on
adv_entries list.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 65135f8..2ceeadf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -188,6 +188,7 @@ struct hci_dev {
 	struct list_head	remote_oob_data;
 
 	struct list_head	adv_entries;
+	rwlock_t		adv_entries_lock;
 
 	struct hci_dev_stats	stat;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0ba3c39..89d7cc8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1208,6 +1208,8 @@ int hci_adv_entries_clear(struct hci_dev *hdev)
 {
 	struct list_head *p, *n;
 
+	write_lock_bh(&hdev->adv_entries_lock);
+
 	list_for_each_safe(p, n, &hdev->adv_entries) {
 		struct adv_entry *entry;
 
@@ -1217,6 +1219,8 @@ int hci_adv_entries_clear(struct hci_dev *hdev)
 		kfree(entry);
 	}
 
+	write_unlock_bh(&hdev->adv_entries_lock);
+
 	BT_DBG("%s adv cache cleared", hdev->name);
 
 	return 0;
@@ -1225,17 +1229,23 @@ int hci_adv_entries_clear(struct hci_dev *hdev)
 struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct list_head *p;
+	struct adv_entry *res = NULL;
+
+	read_lock_bh(&hdev->adv_entries_lock);
 
 	list_for_each(p, &hdev->adv_entries) {
 		struct adv_entry *entry;
 
 		entry = list_entry(p, struct adv_entry, list);
 
-		if (bacmp(bdaddr, &entry->bdaddr) == 0)
-			return entry;
+		if (bacmp(bdaddr, &entry->bdaddr) == 0) {
+			res = entry;
+			goto out;
+		}
 	}
-
-	return NULL;
+out:
+	read_unlock_bh(&hdev->adv_entries_lock);
+	return res;
 }
 
 static inline int is_connectable_adv(u8 evt_type)
@@ -1267,7 +1277,9 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	bacpy(&entry->bdaddr, &ev->bdaddr);
 	entry->bdaddr_type = ev->bdaddr_type;
 
+	write_lock(&hdev->adv_entries_lock);
 	list_add(&entry->list, &hdev->adv_entries);
+	write_unlock(&hdev->adv_entries_lock);
 
 	BT_DBG("%s adv entry added: address %s type %u", hdev->name,
 				batostr(&entry->bdaddr), entry->bdaddr_type);
@@ -1342,6 +1354,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 
 	INIT_LIST_HEAD(&hdev->adv_entries);
+	rwlock_init(&hdev->adv_entries_lock);
 
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
-- 
1.7.1

