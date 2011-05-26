Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH v3 5/9] Bluetooth: Advertising entries lifetime
Date: Thu, 26 May 2011 16:23:53 -0300
Message-Id: <1306437837-18263-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1306437837-18263-1-git-send-email-andre.guedes@openbossa.org>
References: <1306437837-18263-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a timer to clear 'adv_entries' after three minutes.

After some amount of time, the advertising entries cached during
the last LE scan should be considered expired and they should be
removed from the advertising cache.

It was chosen a three minutes timeout as an initial attempt. This
value might change in future.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   14 ++++++++++++++
 net/bluetooth/hci_event.c        |    6 +++++-
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 10dfb85..af4b0ed 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -188,6 +188,7 @@ struct hci_dev {
 	struct list_head	remote_oob_data;
 
 	struct list_head	adv_entries;
+	struct timer_list	adv_timer;
 
 	struct hci_dev_stats	stat;
 
@@ -535,6 +536,7 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 								u8 *randomizer);
 int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
+#define ADV_CLEAR_TIMEOUT (3*60*HZ) /* Three minutes */
 int hci_adv_entries_clear(struct hci_dev *hdev);
 struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_add_adv_entry(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dd27f97..5040c3f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1204,6 +1204,17 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 	return 0;
 }
 
+static void hci_clear_adv_cache(unsigned long arg)
+{
+	struct hci_dev *hdev = (void *) arg;
+
+	hci_dev_lock(hdev);
+
+	hci_adv_entries_clear(hdev);
+
+	hci_dev_unlock(hdev);
+}
+
 int hci_adv_entries_clear(struct hci_dev *hdev)
 {
 	struct adv_entry *entry, *tmp;
@@ -1332,6 +1343,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 
 	INIT_LIST_HEAD(&hdev->adv_entries);
+	setup_timer(&hdev->adv_timer, hci_clear_adv_cache,
+						(unsigned long) hdev);
 
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
@@ -1405,6 +1418,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_unregister_sysfs(hdev);
 
 	hci_del_off_timer(hdev);
+	del_timer(&hdev->adv_timer);
 
 	destroy_workqueue(hdev->workqueue);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 556c38a..df51f93 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -856,8 +856,12 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (cp->enable == 0x01)
+	if (cp->enable == 0x01) {
+		del_timer(&hdev->adv_timer);
 		hci_adv_entries_clear(hdev);
+	} else if (cp->enable == 0x00) {
+		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
+	}
 
 	hci_dev_unlock(hdev);
 }
-- 
1.7.4.1

