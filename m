Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC v2 3/6] Bluetooth: Protect adv_entries with a RW semaphore
Date: Fri, 11 Mar 2011 10:32:54 -0300
Message-Id: <1299850377-3734-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1299850377-3734-1-git-send-email-andre.guedes@openbossa.org>
References: <1299850377-3734-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a RW semaphore to protect concurrent operations on
adv_entries list.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 970711d..bf7b5df 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -178,6 +178,7 @@ struct hci_dev {
 	struct list_head	link_keys;
 
 	struct list_head	adv_entries;
+	struct rw_semaphore	adv_entries_rwsem;
 
 	struct hci_dev_stats	stat;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cbff329..71f8788 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -44,6 +44,7 @@
 #include <linux/timer.h>
 #include <linux/crypto.h>
 #include <net/sock.h>
+#include <linux/rwsem.h>
 
 #include <asm/system.h>
 #include <linux/uaccess.h>
@@ -1084,6 +1085,8 @@ static int hci_adv_entries_clear(struct hci_dev *hdev)
 {
 	struct list_head *p, *n;
 
+	down_write(&hdev->adv_entries_rwsem);
+
 	list_for_each_safe(p, n, &hdev->adv_entries) {
 		struct adv_entry *entry;
 
@@ -1093,23 +1096,31 @@ static int hci_adv_entries_clear(struct hci_dev *hdev)
 		kfree(entry);
 	}
 
+	up_write(&hdev->adv_entries_rwsem);
+
 	return 0;
 }
 
 struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct list_head *p;
+	struct adv_entry *res = NULL;
+
+	down_read(&hdev->adv_entries_rwsem);
 
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
+	up_read(&hdev->adv_entries_rwsem);
+	return res;
 }
 
 static inline int is_connectable_adv(u8 evt_type)
@@ -1141,7 +1152,9 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	bacpy(&entry->bdaddr, &ev->bdaddr);
 	entry->bdaddr_type = ev->bdaddr_type;
 
+	down_write(&hdev->adv_entries_rwsem);
 	list_add(&entry->list, &hdev->adv_entries);
+	up_write(&hdev->adv_entries_rwsem);
 
 	return 0;
 }
@@ -1219,6 +1232,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->link_keys);
 
 	INIT_LIST_HEAD(&hdev->adv_entries);
+	init_rwsem(&hdev->adv_entries_rwsem);
 
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
-- 
1.7.1

