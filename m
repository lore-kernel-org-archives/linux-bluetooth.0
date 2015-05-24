Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 14/16] Bluetooth: mgmt: multi adv for clear_adv_instances()
Date: Mon, 25 May 2015 00:39:12 +0200
Message-Id: <1432507154-22925-15-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
References: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The clean_adv_instance() function could not clean up multiple
advertising instances previously. It is being changed to provide both, a
means to clean up a single instance and cleaning up all instances at
once.

An additional instance parameter is being introduced to achieve this.
Passing in 0x00 to this parameter signifies that all instances should be
cleaned up. This semantics has been chosen similarly to the semantics of
the instance parameter in the remove_advertising() function.

This change still relies on the fact that we only allow a single
advertising instance. When we allow for more than one instance then
advertising should only be disabled when the last instance was cleaned
up, in all other cases the next active advertising instance should be
advertised instead. A corresponding TODO has been inserted into the
code.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6eba4d8..39e6b772 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1463,18 +1463,30 @@ static void advertising_removed(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_ADVERTISING_REMOVED, hdev, &ev, sizeof(ev), sk);
 }
 
-static void clear_adv_instance(struct hci_dev *hdev)
+static void clear_adv_instance(struct hci_dev *hdev, u8 instance)
 {
+	struct adv_info *adv_instance;
+	int err;
 	struct hci_request req;
 
+	/* A value of 0 indicates that all instances should be cleared. */
+	if (instance == 0x00) {
+		list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
+			advertising_removed(NULL, hdev, adv_instance->instance);
+		}
+		hci_adv_instances_clear(hdev);
+	} else {
+		err = hci_remove_adv_instance(hdev, instance);
+		if (!err)
+			advertising_removed(NULL, hdev, instance);
+	}
+
 	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
 		return;
 
-	if (hdev->adv_instance.timeout)
-		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
-
-	memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
-	advertising_removed(NULL, hdev, 1);
+	/* TODO: Only switch off advertising if the instance list is empty
+	 * else switch to the next remaining adv instance.
+	 */
 	hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
 
 	if (!hdev_is_powered(hdev) ||
@@ -1501,8 +1513,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
-	if (hdev->adv_instance.timeout)
-		clear_adv_instance(hdev);
+	clear_adv_instance(hdev, 0x00);
 
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 		disable_advertising(&req);
@@ -6956,7 +6967,7 @@ static void adv_timeout_expired(struct work_struct *work)
 
 	adv_instance->timeout = 0;
 	hci_dev_lock(hdev);
-	clear_adv_instance(hdev);
+	clear_adv_instance(hdev, adv_instance->instance);
 	hci_dev_unlock(hdev);
 }
 
-- 
1.9.1

