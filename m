Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 13/20] Bluetooth: mgmt: multi adv for clear_adv_instances()
Date: Sat, 13 Jun 2015 05:41:06 +0200
Message-Id: <1434166873-21595-14-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
References: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The clear_adv_instance() function could not clean up multiple
advertising instances previously. It is being changed to provide both, a
means to clean up a single instance and cleaning up all instances at
once.

An additional instance parameter is being introduced to achieve this.
Passing in 0x00 to this parameter signifies that all instances should be
cleaned up. This semantics has been chosen similarly to the semantics of
the instance parameter in the remove_advertising() function.

When removing a single instance the method also ensures that another
instance will be scheduled if available. When the currently advertising
method is being removed, it will be canceled immediately.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 80 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a85b80f..cbcc8d9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1538,27 +1538,57 @@ static void cancel_adv_timeout(struct hci_dev *hdev)
 	}
 }
 
-static void clear_adv_instance(struct hci_dev *hdev)
+static void clear_adv_instance(struct hci_dev *hdev, struct hci_request *req,
+			       u8 instance, bool force)
 {
-	struct hci_request req;
+	struct adv_info *adv_instance, *next_instance = NULL;
+	int err;
 
-	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
-		return;
+	/* An instance value of 0 indicates that all instances
+	 * should be removed and advertising should be disabled.
+	 */
+	if (!instance || hdev->cur_adv_instance == instance)
+		cancel_adv_timeout(hdev);
 
-	if (hdev->adv_instance_timeout)
-		cancel_delayed_work(&hdev->adv_instance_expire);
+	/* Get the next instance to advertise BEFORE we remove
+	 * the current one. This can be the same instance again
+	 * if there is only one instance.
+	 */
+	if (instance && hdev->cur_adv_instance == instance)
+		next_instance = hci_get_next_instance(hdev, instance);
 
-	memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
-	advertising_removed(NULL, hdev, 1);
-	hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
+	if (instance == 0x00) {
+		list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
+			advertising_removed(NULL, hdev, adv_instance->instance);
+		}
+		hci_adv_instances_clear(hdev);
+	} else {
+		adv_instance = hci_find_adv_instance(hdev, instance);
 
-	if (!hdev_is_powered(hdev) ||
+		if (force || (adv_instance && adv_instance->timeout &&
+			      !adv_instance->remaining_time)) {
+			/* Don't advertise a removed instance. */
+			if (next_instance &&
+			    next_instance->instance == instance)
+				next_instance = NULL;
+
+			err = hci_remove_adv_instance(hdev, instance);
+			if (!err)
+				advertising_removed(NULL, hdev, instance);
+		}
+	}
+
+	if (list_empty(&hdev->adv_instances)) {
+		hdev->cur_adv_instance = 0x00;
+		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
+	}
+
+	if (!req || !hdev_is_powered(hdev) ||
 	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return;
 
-	hci_req_init(&req, hdev);
-	disable_advertising(&req);
-	hci_req_run(&req, NULL);
+	if (next_instance)
+		schedule_adv_instance(req, next_instance->instance, false);
 }
 
 static int clean_up_hci_state(struct hci_dev *hdev)
@@ -1576,8 +1606,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
-	if (hdev->adv_instance_timeout)
-		clear_adv_instance(hdev);
+	clear_adv_instance(hdev, NULL, 0x00, true);
 
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 		disable_advertising(&req);
@@ -2532,6 +2561,9 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	val = !!cp->val;
 	enabled = lmp_host_le_capable(hdev);
 
+	if (!val)
+		clear_adv_instance(hdev, NULL, 0x00, true);
+
 	if (!hdev_is_powered(hdev) || val == enabled) {
 		bool changed = false;
 
@@ -7018,10 +7050,26 @@ unlock:
 
 void mgmt_adv_timeout_expired(struct hci_dev *hdev)
 {
+	u8 instance;
+	struct hci_request req;
+
 	hdev->adv_instance_timeout = 0;
 
+	instance = get_current_adv_instance(hdev);
+	if (instance == 0x00)
+		return;
+
 	hci_dev_lock(hdev);
-	clear_adv_instance(hdev);
+	hci_req_init(&req, hdev);
+
+	clear_adv_instance(hdev, &req, instance, false);
+
+	if (list_empty(&hdev->adv_instances))
+		disable_advertising(&req);
+
+	if (!skb_queue_empty(&req.cmd_q))
+		hci_req_run(&req, NULL);
+
 	hci_dev_unlock(hdev);
 }
 
-- 
1.9.1

