Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Replace hci_notify with hci_sock_dev_event
Date: Sun, 25 Oct 2015 23:29:22 +0100
Message-Id: <1445812162-53215-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no point in wrapping hci_sock_dev_event around hci_notify. It
is an empty wrapper which adds no value. So remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3604e0194f87..83a6aacfab31 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -65,13 +65,6 @@ static DEFINE_IDA(hci_index_ida);
 #define hci_req_lock(d)		mutex_lock(&d->req_lock)
 #define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
 
-/* ---- HCI notifications ---- */
-
-static void hci_notify(struct hci_dev *hdev, int event)
-{
-	hci_sock_dev_event(hdev, event);
-}
-
 /* ---- HCI debugfs entries ---- */
 
 static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
@@ -1455,7 +1448,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	}
 
 	set_bit(HCI_RUNNING, &hdev->flags);
-	hci_notify(hdev, HCI_DEV_OPEN);
+	hci_sock_dev_event(hdev, HCI_DEV_OPEN);
 
 	atomic_set(&hdev->cmd_cnt, 1);
 	set_bit(HCI_INIT, &hdev->flags);
@@ -1524,7 +1517,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		hci_dev_hold(hdev);
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		set_bit(HCI_UP, &hdev->flags);
-		hci_notify(hdev, HCI_DEV_UP);
+		hci_sock_dev_event(hdev, HCI_DEV_UP);
 		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
 		    !hci_dev_test_flag(hdev, HCI_CONFIG) &&
 		    !hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
@@ -1552,7 +1545,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		}
 
 		clear_bit(HCI_RUNNING, &hdev->flags);
-		hci_notify(hdev, HCI_DEV_CLOSE);
+		hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
 
 		hdev->close(hdev);
 		hdev->flags &= BIT(HCI_RAW);
@@ -1708,7 +1701,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	smp_unregister(hdev);
 
-	hci_notify(hdev, HCI_DEV_DOWN);
+	hci_sock_dev_event(hdev, HCI_DEV_DOWN);
 
 	if (hdev->flush)
 		hdev->flush(hdev);
@@ -1739,7 +1732,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 	}
 
 	clear_bit(HCI_RUNNING, &hdev->flags);
-	hci_notify(hdev, HCI_DEV_CLOSE);
+	hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
 
 	/* After this point our queues are empty
 	 * and no tasks are scheduled. */
@@ -3414,7 +3407,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
 
-	hci_notify(hdev, HCI_DEV_REG);
+	hci_sock_dev_event(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
 
 	queue_work(hdev->req_workqueue, &hdev->power_on);
@@ -3462,7 +3455,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	 * pending list */
 	BUG_ON(!list_empty(&hdev->mgmt_pending));
 
-	hci_notify(hdev, HCI_DEV_UNREG);
+	hci_sock_dev_event(hdev, HCI_DEV_UNREG);
 
 	if (hdev->rfkill) {
 		rfkill_unregister(hdev->rfkill);
@@ -3499,7 +3492,7 @@ EXPORT_SYMBOL(hci_unregister_dev);
 /* Suspend HCI device */
 int hci_suspend_dev(struct hci_dev *hdev)
 {
-	hci_notify(hdev, HCI_DEV_SUSPEND);
+	hci_sock_dev_event(hdev, HCI_DEV_SUSPEND);
 	return 0;
 }
 EXPORT_SYMBOL(hci_suspend_dev);
@@ -3507,7 +3500,7 @@ EXPORT_SYMBOL(hci_suspend_dev);
 /* Resume HCI device */
 int hci_resume_dev(struct hci_dev *hdev)
 {
-	hci_notify(hdev, HCI_DEV_RESUME);
+	hci_sock_dev_event(hdev, HCI_DEV_RESUME);
 	return 0;
 }
 EXPORT_SYMBOL(hci_resume_dev);
-- 
2.4.3

