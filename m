Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Convert power off mechanism to use delayed_work
Date: Mon,  7 Nov 2011 22:16:04 +0200
Message-Id: <1320696964-3582-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320696964-3582-1-git-send-email-johan.hedberg@gmail.com>
References: <1320696964-3582-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The power off code doesn't need to use its own custom timer since the
delayed_work API provides the exact same functionality.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    3 +-
 net/bluetooth/hci_core.c         |   39 ++++++++++++-------------------------
 net/bluetooth/mgmt.c             |    8 ++++--
 3 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c233bce..bca53aa 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -193,8 +193,7 @@ struct hci_dev {
 	struct workqueue_struct	*workqueue;
 
 	struct work_struct	power_on;
-	struct work_struct	power_off;
-	struct timer_list	off_timer;
+	struct delayed_work	power_off;
 
 	__u16			discov_timeout;
 	struct delayed_work	discov_off;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2da3f90..e4ddf36 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -600,6 +600,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		hdev->discov_timeout = 0;
 	}
 
+	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
+		cancel_delayed_work_sync(&hdev->power_off);
+
 	hci_dev_lock_bh(hdev);
 	inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
@@ -819,7 +822,8 @@ int hci_get_dev_list(void __user *arg)
 
 	read_lock_bh(&hci_dev_list_lock);
 	list_for_each_entry(hdev, &hci_dev_list, list) {
-		hci_del_off_timer(hdev);
+		if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
+			cancel_delayed_work_sync(&hdev->power_off);
 
 		if (!test_bit(HCI_MGMT, &hdev->flags))
 			set_bit(HCI_PAIRABLE, &hdev->flags);
@@ -854,7 +858,8 @@ int hci_get_dev_info(void __user *arg)
 	if (!hdev)
 		return -ENODEV;
 
-	hci_del_off_timer(hdev);
+	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
+		cancel_delayed_work_sync(&hdev->power_off);
 
 	if (!test_bit(HCI_MGMT, &hdev->flags))
 		set_bit(HCI_PAIRABLE, &hdev->flags);
@@ -938,8 +943,8 @@ static void hci_power_on(struct work_struct *work)
 		return;
 
 	if (test_bit(HCI_AUTO_OFF, &hdev->flags))
-		mod_timer(&hdev->off_timer,
-				jiffies + msecs_to_jiffies(AUTO_OFF_TIMEOUT));
+		queue_delayed_work(hdev->workqueue, &hdev->power_off,
+					msecs_to_jiffies(AUTO_OFF_TIMEOUT));
 
 	if (test_and_clear_bit(HCI_SETUP, &hdev->flags))
 		mgmt_index_added(hdev->id);
@@ -947,30 +952,14 @@ static void hci_power_on(struct work_struct *work)
 
 static void hci_power_off(struct work_struct *work)
 {
-	struct hci_dev *hdev = container_of(work, struct hci_dev, power_off);
-
-	BT_DBG("%s", hdev->name);
-
-	hci_dev_close(hdev->id);
-}
-
-static void hci_auto_off(unsigned long data)
-{
-	struct hci_dev *hdev = (struct hci_dev *) data;
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+							power_off.work);
 
 	BT_DBG("%s", hdev->name);
 
 	clear_bit(HCI_AUTO_OFF, &hdev->flags);
 
-	queue_work(hdev->workqueue, &hdev->power_off);
-}
-
-void hci_del_off_timer(struct hci_dev *hdev)
-{
-	BT_DBG("%s", hdev->name);
-
-	clear_bit(HCI_AUTO_OFF, &hdev->flags);
-	del_timer(&hdev->off_timer);
+	hci_dev_close(hdev->id);
 }
 
 static void hci_discov_off(struct work_struct *work)
@@ -1505,8 +1494,7 @@ int hci_register_dev(struct hci_dev *hdev)
 						(unsigned long) hdev);
 
 	INIT_WORK(&hdev->power_on, hci_power_on);
-	INIT_WORK(&hdev->power_off, hci_power_off);
-	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
+	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 
@@ -1583,7 +1571,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_del_sysfs(hdev);
 
-	hci_del_off_timer(hdev);
 	del_timer(&hdev->adv_timer);
 
 	destroy_workqueue(hdev->workqueue);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0cb023e..6f9e3cd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -150,7 +150,8 @@ static int read_index_list(struct sock *sk)
 
 	i = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		hci_del_off_timer(d);
+		if (test_and_clear_bit(HCI_AUTO_OFF, &d->flags))
+			cancel_delayed_work_sync(&d->power_off);
 
 		if (test_bit(HCI_SETUP, &d->flags))
 			continue;
@@ -180,7 +181,8 @@ static int read_controller_info(struct sock *sk, u16 index)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_READ_INFO, ENODEV);
 
-	hci_del_off_timer(hdev);
+	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
+		cancel_delayed_work_sync(&hdev->power_off);
 
 	hci_dev_lock_bh(hdev);
 
@@ -337,7 +339,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (cp->val)
 		queue_work(hdev->workqueue, &hdev->power_on);
 	else
-		queue_work(hdev->workqueue, &hdev->power_off);
+		queue_work(hdev->workqueue, &hdev->power_off.work);
 
 	err = 0;
 
-- 
1.7.7.1

