Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 13/17] Bluetooth: mgmt: multi adv for set_advertising_complete()
Date: Thu, 30 Apr 2015 17:33:16 +0200
Message-Id: <1430408000-17785-14-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
References: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The set_advertising_complete() method relied on the now obsolete
hci_dev->adv_instance structure. We replace this reference by an
equivalent access to the newly introduced dynamic advertising instance
list.

This solution still relies on the fact that we only allow a single
advertising instance for now. It needs to be further refactored once we
allow more than one advertising instance. A corresponding TODO has been
inserted in the code to make this clear.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 04d1c5a..92560ae 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4673,6 +4673,7 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 {
 	struct cmd_lookup match = { NULL, hdev };
 	struct hci_request req;
+	struct adv_info *adv_instance;
 
 	hci_dev_lock(hdev);
 
@@ -4698,14 +4699,26 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 		sock_put(match.sk);
 
 	/* If "Set Advertising" was just disabled and instance advertising was
-	 * set up earlier, then enable the advertising instance.
+	 * set up earlier, then re-enable multi-instance advertising.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) ||
+	    &hdev->adv_instance_cnt == 0)
 		goto unlock;
 
-	hci_req_init(&req, hdev);
+	/* We advertise multiple instances in a round robin fashion starting
+	 * with the first instance in the list.
+	 */
+	/* TODO: Make sure the other instances are actually being advertised
+	 * once we set HCI_MAX_ADV_INSTANCES > 1.
+	 */
+	adv_instance = list_first_entry(&hdev->adv_instances, struct adv_info,
+					list);
+	if (!adv_instance)
+		goto unlock;
 
+	hci_req_init(&req, hdev);
+	hdev->cur_adv_instance = adv_instance->instance;
 	update_adv_data(&req);
 	enable_advertising(&req);
 
-- 
1.9.1

