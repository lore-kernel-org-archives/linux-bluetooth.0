Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 2/5] Bluetooth: Implement advertising reports cache
Date: Mon, 14 Feb 2011 18:59:57 -0300
Message-Id: <4d59a601.859ddc0a.46cb.5148@mx.google.com>
In-Reply-To: <n>
References: <n>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch implements a list to store the advertising reports and bdaddr
types from LE devices.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |   11 +++++++
 net/bluetooth/hci_core.c         |   58 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |    2 +
 3 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5114122..48059a2 100644
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
 
+	struct list_head	adv_list;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
@@ -504,6 +512,9 @@ int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 						u8 *key, u8 type, u8 pin_len);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
+struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_add_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type);
+
 void hci_del_off_timer(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c81dc17..b573832 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1067,6 +1067,61 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int hci_adv_list_clear(struct hci_dev *hdev)
+{
+	struct list_head *p, *n;
+
+	list_for_each_safe(p, n, &hdev->adv_list) {
+		struct adv_entry *entry;
+
+		entry = list_entry(p, struct adv_entry, list);
+
+		list_del(p);
+		kfree(entry);
+	}
+
+	return 0;
+
+}
+
+struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct list_head *p;
+
+	list_for_each(p, &hdev->adv_list) {
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
+	/* Only new entries should be added to adv_list. So, if
+	 * bdaddr was found, don't add it. */
+	if (entry)
+		return 0;
+
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	bacpy(&entry->bdaddr, bdaddr);
+	entry->bdaddr_type = bdaddr_type;
+
+	list_add(&entry->list, &hdev->adv_list);
+
+	return 0;
+}
+
 static struct crypto_blkcipher *alloc_cypher(void)
 {
 #ifndef CONFIG_BT_SMP
@@ -1137,6 +1192,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->link_keys);
 
+	INIT_LIST_HEAD(&hdev->adv_list);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
@@ -1222,6 +1279,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_blacklist_clear(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
+	hci_adv_list_clear(hdev);
 	hci_dev_unlock_bh(hdev);
 
 	__hci_dev_put(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 987f5de..0cbc1cf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2507,12 +2507,14 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 	num_reports = (u8) skb->data[0];
 
 	ev = (struct hci_ev_le_advertising_info *) (skb->data + 1);
+	hci_add_adv_entry(hdev, &ev->bdaddr, ev->bdaddr_type);
 
 	BT_DBG("adv from: %s", batostr(&ev->bdaddr));
 
 	for (i = 1; i < num_reports; i++) {
 		ev = (struct hci_ev_le_advertising_info *)
 					(ev->data + ev->length + 1);
+		hci_add_adv_entry(hdev, &ev->bdaddr, ev->bdaddr_type);
 		BT_DBG("adv from: %s", batostr(&ev->bdaddr));
 	}
 }
-- 
1.7.1

