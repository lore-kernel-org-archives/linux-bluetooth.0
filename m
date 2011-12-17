Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 04/22] Bluetooth: Use delayed work for advertisiment cache timeout
Date: Sat, 17 Dec 2011 19:29:24 -0200
Message-Id: <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

As HCI rx path is now done in process context it makes sense to do all the
timer in process context as well.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |   10 +++++-----
 net/bluetooth/hci_event.c        |    6 ++++--
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d915908..14b200b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -226,7 +226,7 @@ struct hci_dev {
 	struct list_head	remote_oob_data;
 
 	struct list_head	adv_entries;
-	struct timer_list	adv_timer;
+	struct delayed_work	adv_work;
 
 	struct hci_dev_stats	stat;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 279074c..1605fe7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1341,9 +1341,10 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return mgmt_device_unblocked(hdev, bdaddr);
 }
 
-static void hci_clear_adv_cache(unsigned long arg)
+static void hci_clear_adv_cache(struct work_struct *work)
 {
-	struct hci_dev *hdev = (void *) arg;
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+							adv_work.work);
 
 	hci_dev_lock(hdev);
 
@@ -1489,9 +1490,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 
 	INIT_LIST_HEAD(&hdev->adv_entries);
-	setup_timer(&hdev->adv_timer, hci_clear_adv_cache,
-						(unsigned long) hdev);
 
+	INIT_DELAYED_WORK(&hdev->adv_work, hci_clear_adv_cache);
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 
@@ -1577,7 +1577,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_del_sysfs(hdev);
 
-	del_timer(&hdev->adv_timer);
+	cancel_delayed_work_sync(&hdev->adv_work);
 
 	destroy_workqueue(hdev->workqueue);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 35cb56e..0a9501f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1017,7 +1017,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	if (cp->enable == 0x01) {
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
-		del_timer(&hdev->adv_timer);
+		cancel_delayed_work_sync(&hdev->adv_work);
 
 		hci_dev_lock(hdev);
 		hci_adv_entries_clear(hdev);
@@ -1025,7 +1025,9 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	} else if (cp->enable == 0x00) {
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
-		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
+		cancel_delayed_work_sync(&hdev->adv_work);
+		queue_delayed_work(hdev->workqueue, &hdev->adv_work,
+						 jiffies + ADV_CLEAR_TIMEOUT);
 	}
 }
 
-- 
1.7.6.4

