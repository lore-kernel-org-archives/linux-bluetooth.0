Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 5/5] Bluetooth: Remove advertising cache
Date: Wed,  4 Apr 2012 17:16:10 -0300
Message-Id: <1333570570-1288-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1333570570-1288-1-git-send-email-andre.guedes@openbossa.org>
References: <1333570570-1288-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

User-space pass the remote device address type to kernel through
struct sockaddr_l2 what makes the advertising useless. This patch
removes all advertising cache code.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    9 -----
 net/bluetooth/hci_core.c         |   75 --------------------------------------
 net/bluetooth/hci_event.c        |    7 ----
 3 files changed, 91 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9083a95..b79099a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -255,9 +255,6 @@ struct hci_dev {
 
 	struct list_head	remote_oob_data;
 
-	struct list_head	adv_entries;
-	struct delayed_work	adv_work;
-
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
@@ -691,12 +688,6 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 								u8 *randomizer);
 int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
-#define ADV_CLEAR_TIMEOUT (3*60*HZ) /* Three minutes */
-int hci_adv_entries_clear(struct hci_dev *hdev);
-struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
-int hci_add_adv_entry(struct hci_dev *hdev,
-					struct hci_ev_le_advertising_info *ev);
-
 void hci_del_off_timer(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 286f3fc..6111de9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1547,75 +1547,6 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return mgmt_device_unblocked(hdev, bdaddr, type);
 }
 
-static void hci_clear_adv_cache(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    adv_work.work);
-
-	hci_dev_lock(hdev);
-
-	hci_adv_entries_clear(hdev);
-
-	hci_dev_unlock(hdev);
-}
-
-int hci_adv_entries_clear(struct hci_dev *hdev)
-{
-	struct adv_entry *entry, *tmp;
-
-	list_for_each_entry_safe(entry, tmp, &hdev->adv_entries, list) {
-		list_del(&entry->list);
-		kfree(entry);
-	}
-
-	BT_DBG("%s adv cache cleared", hdev->name);
-
-	return 0;
-}
-
-struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
-{
-	struct adv_entry *entry;
-
-	list_for_each_entry(entry, &hdev->adv_entries, list)
-		if (bacmp(bdaddr, &entry->bdaddr) == 0)
-			return entry;
-
-	return NULL;
-}
-
-static inline int is_connectable_adv(u8 evt_type)
-{
-	if (evt_type == ADV_IND || evt_type == ADV_DIRECT_IND)
-		return 1;
-
-	return 0;
-}
-
-int hci_add_adv_entry(struct hci_dev *hdev,
-					struct hci_ev_le_advertising_info *ev) { struct adv_entry *entry; if (!is_connectable_adv(ev->evt_type))
-		return -EINVAL;
-
-	/* Only new entries should be added to adv_entries. So, if
-	 * bdaddr was found, don't add it. */
-	if (hci_find_adv_entry(hdev, &ev->bdaddr))
-		return 0;
-
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
-	bacpy(&entry->bdaddr, &ev->bdaddr);
-	entry->bdaddr_type = ev->bdaddr_type;
-
-	list_add(&entry->list, &hdev->adv_entries);
-
-	BT_DBG("%s adv entry added: address %s type %u", hdev->name,
-				batostr(&entry->bdaddr), entry->bdaddr_type);
-
-	return 0;
-}
-
 static void le_scan_param_req(struct hci_dev *hdev, unsigned long opt)
 {
 	struct le_scan_params *param =  (struct le_scan_params *) opt;
@@ -1809,9 +1740,6 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 
-	INIT_LIST_HEAD(&hdev->adv_entries);
-
-	INIT_DELAYED_WORK(&hdev->adv_work, hci_clear_adv_cache);
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 
@@ -1905,8 +1833,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_del_sysfs(hdev);
 
-	cancel_delayed_work_sync(&hdev->adv_work);
-
 	destroy_workqueue(hdev->workqueue);
 
 	hci_dev_lock(hdev);
@@ -1915,7 +1841,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
-	hci_adv_entries_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7325300..f78524f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1101,10 +1101,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
-		cancel_delayed_work_sync(&hdev->adv_work);
-
 		hci_dev_lock(hdev);
-		hci_adv_entries_clear(hdev);
 		hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 		hci_dev_unlock(hdev);
 		break;
@@ -1119,8 +1116,6 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
-		schedule_delayed_work(&hdev->adv_work, ADV_CLEAR_TIMEOUT);
-
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
 				hdev->discovery.state == DISCOVERY_FINDING) {
 			mgmt_interleaved_discovery(hdev);
@@ -3349,8 +3344,6 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 	while (num_reports--) {
 		struct hci_ev_le_advertising_info *ev = ptr;
 
-		hci_add_adv_entry(hdev, ev);
-
 		rssi = ev->data[ev->length];
 		mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
 				  NULL, rssi, 0, 1, ev->data, ev->length);
-- 
1.7.9.4

