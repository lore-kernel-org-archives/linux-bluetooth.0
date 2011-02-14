Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 4/5] Bluetooth: limit size of advertising reports cache
Date: Mon, 14 Feb 2011 18:59:59 -0300
Message-Id: <4d59a605.859ddc0a.46cb.514e@mx.google.com>
In-Reply-To: <n>
References: <n>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch limits to 64 the size of the list used to store the
advertising reports.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    8 +++++++-
 net/bluetooth/hci_core.c         |   29 ++++++++++++++++++++++-------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 48059a2..5992148 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -88,6 +88,12 @@ struct adv_entry {
 	u8 bdaddr_type;
 };
 
+#define ADV_LIST_MAX_SIZE 64
+struct adv_list {
+	struct list_head list;
+	size_t size;
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -177,7 +183,7 @@ struct hci_dev {
 
 	struct list_head	link_keys;
 
-	struct list_head	adv_list;
+	struct adv_list		adv_entries;
 
 	struct hci_dev_stats	stat;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b573832..e749c90 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1067,11 +1067,17 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int hci_adv_list_clear(struct hci_dev *hdev)
+static inline void hci_adv_entries_init(struct hci_dev *hdev)
+{
+	hdev->adv_entries.size = 0;
+	INIT_LIST_HEAD(&hdev->adv_entries.list);
+}
+
+static int hci_adv_entries_clear(struct hci_dev *hdev)
 {
 	struct list_head *p, *n;
 
-	list_for_each_safe(p, n, &hdev->adv_list) {
+	list_for_each_safe(p, n, &hdev->adv_entries.list) {
 		struct adv_entry *entry;
 
 		entry = list_entry(p, struct adv_entry, list);
@@ -1080,6 +1086,7 @@ static int hci_adv_list_clear(struct hci_dev *hdev)
 		kfree(entry);
 	}
 
+	hdev->adv_entries.size = 0;
 	return 0;
 
 }
@@ -1088,7 +1095,7 @@ struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct list_head *p;
 
-	list_for_each(p, &hdev->adv_list) {
+	list_for_each(p, &hdev->adv_entries.list) {
 		struct adv_entry *k;
 
 		k = list_entry(p, struct adv_entry, list);
@@ -1105,7 +1112,7 @@ int hci_add_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 	struct adv_entry *entry;
 
 	entry = hci_find_adv_entry(hdev, bdaddr);
-	/* Only new entries should be added to adv_list. So, if
+	/* Only new entries should be added to adv_entries. So, if
 	 * bdaddr was found, don't add it. */
 	if (entry)
 		return 0;
@@ -1117,7 +1124,15 @@ int hci_add_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 	bacpy(&entry->bdaddr, bdaddr);
 	entry->bdaddr_type = bdaddr_type;
 
-	list_add(&entry->list, &hdev->adv_list);
+	if (hdev->adv_entries.size < ADV_LIST_MAX_SIZE) {
+		hdev->adv_entries.size += 1;
+	} else {
+		struct list_head *head = &hdev->adv_entries.list;
+		struct list_head *tail = head->prev;
+		list_del(tail);
+	}
+
+	list_add(&entry->list, &hdev->adv_entries.list);
 
 	return 0;
 }
@@ -1192,7 +1207,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->link_keys);
 
-	INIT_LIST_HEAD(&hdev->adv_list);
+	hci_adv_entries_init(hdev);
 
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
@@ -1279,7 +1294,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_blacklist_clear(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
-	hci_adv_list_clear(hdev);
+	hci_adv_entries_clear(hdev);
 	hci_dev_unlock_bh(hdev);
 
 	__hci_dev_put(hdev);
-- 
1.7.1

