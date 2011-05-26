Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH v3 2/9] Bluetooth: LE advertising cache
Date: Thu, 26 May 2011 16:23:50 -0300
Message-Id: <1306437837-18263-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1306437837-18263-1-git-send-email-andre.guedes@openbossa.org>
References: <1306437837-18263-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the LE advertising cache. It stores sensitive
information (bdaddr and bdaddr_type so far) gathered from LE
advertising report events.

Only advertising entries from connectables devices are added to the
cache.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |   13 ++++++++
 net/bluetooth/hci_core.c         |   64 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6c994c0..10dfb85 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -89,6 +89,12 @@ struct oob_data {
 	u8 randomizer[16];
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
@@ -181,6 +187,8 @@ struct hci_dev {
 
 	struct list_head	remote_oob_data;
 
+	struct list_head	adv_entries;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
@@ -527,6 +535,11 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 								u8 *randomizer);
 int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
+int hci_adv_entries_clear(struct hci_dev *hdev);
+struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_add_adv_entry(struct hci_dev *hdev,
+					struct hci_ev_le_advertising_info *ev);
+
 void hci_del_off_timer(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b6bda3f..dd27f97 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1204,6 +1204,67 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 	return 0;
 }
 
+int hci_adv_entries_clear(struct hci_dev *hdev)
+{
+	struct adv_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &hdev->adv_entries, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
+	BT_DBG("%s adv cache cleared", hdev->name);
+
+	return 0;
+}
+
+struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct adv_entry *entry;
+
+	list_for_each_entry(entry, &hdev->adv_entries, list)
+		if (bacmp(bdaddr, &entry->bdaddr) == 0)
+			return entry;
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
+	/* Only new entries should be added to adv_entries. So, if
+	 * bdaddr was found, don't add it. */
+	if (hci_find_adv_entry(hdev, &ev->bdaddr))
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
+	BT_DBG("%s adv entry added: address %s type %u", hdev->name,
+				batostr(&entry->bdaddr), entry->bdaddr_type);
+
+	return 0;
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1270,6 +1331,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 
+	INIT_LIST_HEAD(&hdev->adv_entries);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
@@ -1350,6 +1413,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
+	hci_adv_entries_clear(hdev);
 	hci_dev_unlock_bh(hdev);
 
 	__hci_dev_put(hdev);
-- 
1.7.4.1

