Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 6/6] Bluetooth: Add a timer to clear the advertising cache
Date: Fri,  4 Mar 2011 17:35:13 -0300
Message-Id: <1299270913-8436-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1299270913-8436-1-git-send-email-andre.guedes@openbossa.org>
References: <1299270913-8436-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a timer to clear adv_entries list after three minutes.

After some amount of time, the advertising entries cached during the
last LE scan should be considered expired and they should be removed
from the adv_entries list.

It was chosen a three minutes timeout as an initial attempt. This value
might change in future.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |    9 +++++++++
 net/bluetooth/hci_event.c        |    6 +++++-
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3ead365..790f839 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -179,6 +179,7 @@ struct hci_dev {
 
 	struct list_head	adv_entries;
 	struct rw_semaphore	adv_entries_rwsem;
+	struct timer_list	adv_timer;
 
 	struct hci_dev_stats	stat;
 
@@ -517,6 +518,7 @@ int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 						u8 *key, u8 type, u8 pin_len);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
+#define ADV_CLEAR_TIMEOUT (3*60*HZ) /* Three minutes */
 int hci_adv_entries_clear(struct hci_dev *hdev);
 struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_add_adv_entry(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8f9b3a5..ea8b0c2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1081,6 +1081,13 @@ static void hci_cmd_timer(unsigned long arg)
 	tasklet_schedule(&hdev->cmd_task);
 }
 
+static void hci_adv_clear(unsigned long arg)
+{
+	struct hci_dev *hdev = (void *) arg;
+
+	hci_adv_entries_clear(hdev);
+}
+
 int hci_adv_entries_clear(struct hci_dev *hdev)
 {
 	struct list_head *p, *n;
@@ -1233,6 +1240,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->adv_entries);
 	init_rwsem(&hdev->adv_entries_rwsem);
+	setup_timer(&hdev->adv_timer, hci_adv_clear, (unsigned long) hdev);
 
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
@@ -1314,6 +1322,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_unregister_sysfs(hdev);
 
 	hci_del_off_timer(hdev);
+	del_timer(&hdev->adv_timer);
 
 	destroy_workqueue(hdev->workqueue);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a07ed86..a1fe9cc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -858,8 +858,12 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		return;
 
 	param_scan_enable = *((__u8 *) sent);
-	if (param_scan_enable == 0x01)
+	if (param_scan_enable == 0x01) {
+		del_timer(&hdev->adv_timer);
 		hci_adv_entries_clear(hdev);
+	} else if (param_scan_enable == 0x00) {
+		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
+	}
 }
 
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
-- 
1.7.1

