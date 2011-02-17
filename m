Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFCv2 2/4] Bluetooth: LE advertising info caching
Date: Thu, 17 Feb 2011 10:39:54 -0300
Message-Id: <4d5d2587.8f7edc0a.5af6.27da@mx.google.com>
In-Reply-To: <n>
References: <n>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch implements a fixed-size circular list to store sensitive
information (bdaddr and bdaddr_type so far) gathered from LE
advertising report events.

The fixed-size circular list has max size equal to 64. Once the buffer
reaches its max size, new advertising entries will replace old ones.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |   17 +++++++++
 net/bluetooth/hci_core.c         |   75 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |    5 +--
 3 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5114122..5992148 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -82,6 +82,18 @@ struct link_key {
 	u8 pin_len;
 };
 
+struct adv_entry {
+	struct list_head list;
+	bdaddr_t bdaddr;
+	u8 bdaddr_type;
+};
+
+#define ADV_LIST_MAX_SIZE 64
+struct adv_list {
+	struct list_head list;
+	size_t size;
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -171,6 +183,8 @@ struct hci_dev {
 
 	struct list_head	link_keys;
 
+	struct adv_list		adv_entries;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
@@ -504,6 +518,9 @@ int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 						u8 *key, u8 type, u8 pin_len);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
+struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_add_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type);
+
 void hci_del_off_timer(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 013baf9..0d0598b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1067,6 +1067,78 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static inline void hci_adv_entries_init(struct hci_dev *hdev)
+{
+	hdev->adv_entries.size = 0;
+	INIT_LIST_HEAD(&hdev->adv_entries.list);
+}
+
+static int hci_adv_entries_clear(struct hci_dev *hdev)
+{
+	struct list_head *p, *n;
+
+	list_for_each_safe(p, n, &hdev->adv_entries.list) {
+		struct adv_entry *entry;
+
+		entry = list_entry(p, struct adv_entry, list);
+
+		list_del(p);
+		kfree(entry);
+	}
+
+	hdev->adv_entries.size = 0;
+	return 0;
+
+}
+
+struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct list_head *p;
+
+	list_for_each(p, &hdev->adv_entries.list) {
+		struct adv_entry *k;
+
+		k = list_entry(p, struct adv_entry, list);
+
+		if (bacmp(bdaddr, &k->bdaddr) == 0)
+			return k;
+	}
+
+	return NULL;
+}
+
+int hci_add_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
+{
+	struct adv_entry *entry;
+
+	entry = hci_find_adv_entry(hdev, bdaddr);
+	/* Only new entries should be added to adv_entries. So, if
+	 * bdaddr was found, don't add it. */
+	if (entry)
+		return 0;
+
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	BT_DBG(": %s type %d", batostr(bdaddr), bdaddr_type);
+
+	bacpy(&entry->bdaddr, bdaddr);
+	entry->bdaddr_type = bdaddr_type;
+
+	if (hdev->adv_entries.size < ADV_LIST_MAX_SIZE) {
+		hdev->adv_entries.size += 1;
+	} else {
+		struct list_head *head = &hdev->adv_entries.list;
+		struct list_head *tail = head->prev;
+		list_del(tail);
+	}
+
+	list_add(&entry->list, &hdev->adv_entries.list);
+
+	return 0;
+}
+
 static struct crypto_blkcipher *alloc_cypher(void)
 {
 #ifndef CONFIG_BT_SMP
@@ -1137,6 +1209,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->link_keys);
 
+	hci_adv_entries_init(hdev);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
@@ -1224,6 +1298,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_blacklist_clear(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
+	hci_adv_entries_clear(hdev);
 	hci_dev_unlock_bh(hdev);
 
 	__hci_dev_put(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c8d888..3111648 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2507,12 +2507,11 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 	num_reports = skb->data[0];
 
 	ev = (void *) &skb->data[1];
-
-	BT_DBG("adv from: %s", batostr(&ev->bdaddr));
+	hci_add_adv_entry(hdev, &ev->bdaddr, ev->bdaddr_type);
 
 	for (i = 1; i < num_reports; i++) {
 		ev = (void *) (ev->data + ev->length + 1);
-		BT_DBG("adv from: %s", batostr(&ev->bdaddr));
+		hci_add_adv_entry(hdev, &ev->bdaddr, ev->bdaddr_type);
 	}
 }
 
-- 
1.7.1

