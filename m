Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 2/6] Bluetooth: LE advertising info caching
Date: Fri,  4 Mar 2011 17:35:09 -0300
Message-Id: <1299270913-8436-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1299270913-8436-1-git-send-email-andre.guedes@openbossa.org>
References: <1299270913-8436-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a list of 'advertising entry' to the struct hci_dev.

The advertising entry (struct adv_entry) stores sensitive information
(bdaddr and bdaddr_type so far) gathered from LE advertising report
events.

A double-linked list (list_head adv_entries) is used to store those
advertising entries. Only advertising entries from connectables devices
are inserted into the list.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |   12 ++++++
 net/bluetooth/hci_core.c         |   69 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |    5 +--
 3 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c59e857..970711d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -82,6 +82,12 @@ struct link_key {
 	u8 pin_len;
 };
 
+struct adv_entry {
+	struct list_head list;
+	bdaddr_t bdaddr;
+	u8 bdaddr_type;
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -171,6 +177,8 @@ struct hci_dev {
 
 	struct list_head	link_keys;
 
+	struct list_head	adv_entries;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
@@ -508,6 +516,10 @@ int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 						u8 *key, u8 type, u8 pin_len);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
+struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_add_adv_entry(struct hci_dev *hdev,
+					struct hci_ev_le_advertising_info *ev);
+
 void hci_del_off_timer(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ff67843..cbff329 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1080,6 +1080,72 @@ static void hci_cmd_timer(unsigned long arg)
 	tasklet_schedule(&hdev->cmd_task);
 }
 
+static int hci_adv_entries_clear(struct hci_dev *hdev)
+{
+	struct list_head *p, *n;
+
+	list_for_each_safe(p, n, &hdev->adv_entries) {
+		struct adv_entry *entry;
+
+		entry = list_entry(p, struct adv_entry, list);
+
+		list_del(p);
+		kfree(entry);
+	}
+
+	return 0;
+}
+
+struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct list_head *p;
+
+	list_for_each(p, &hdev->adv_entries) {
+		struct adv_entry *entry;
+
+		entry = list_entry(p, struct adv_entry, list);
+
+		if (bacmp(bdaddr, &entry->bdaddr) == 0)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static inline int is_connectable_adv(u8 evt_type)
+{
+	if (evt_type == ADV_IND || evt_type == ADV_DIRECT_IND)
+		return 1;
+
+	return 0;
+}
+
+int hci_add_adv_entry(struct hci_dev *hdev,
+					struct hci_ev_le_advertising_info *ev)
+{
+	struct adv_entry *entry;
+
+	if (!is_connectable_adv(ev->evt_type))
+		return -EINVAL;
+
+	entry = hci_find_adv_entry(hdev, &ev->bdaddr);
+	/* Only new entries should be added to adv_entries. So, if
+	 * bdaddr was found, don't add it. */
+	if (entry)
+		return 0;
+
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	bacpy(&entry->bdaddr, &ev->bdaddr);
+	entry->bdaddr_type = ev->bdaddr_type;
+
+	list_add(&entry->list, &hdev->adv_entries);
+
+	return 0;
+}
+
 static struct crypto_blkcipher *alloc_cypher(void)
 {
 	if (enable_smp)
@@ -1152,6 +1218,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->link_keys);
 
+	INIT_LIST_HEAD(&hdev->adv_entries);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
@@ -1239,6 +1307,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_blacklist_clear(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
+	hci_adv_entries_clear(hdev);
 	hci_dev_unlock_bh(hdev);
 
 	__hci_dev_put(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8acc4a5..825de59 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2565,12 +2565,11 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 	num_reports = skb->data[0];
 
 	ev = (void *) &skb->data[1];
-
-	BT_DBG("adv from: %s", batostr(&ev->bdaddr));
+	hci_add_adv_entry(hdev, ev);
 
 	for (i = 1; i < num_reports; i++) {
 		ev = (void *) (ev->data + ev->length + 1);
-		BT_DBG("adv from: %s", batostr(&ev->bdaddr));
+		hci_add_adv_entry(hdev, ev);
 	}
 }
 
-- 
1.7.1

