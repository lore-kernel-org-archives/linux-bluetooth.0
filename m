Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove no longer needed mgmt_new_settings() function
Date: Sun,  6 Oct 2013 04:11:12 -0700
Message-Id: <1381057872-35309-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The mgmt_new_settings() function was only needed to handle the
error case when re-enabling advertising failed. Since that is
now handled internally inside the management core, this function
is not needed anymore. So just remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 -
 net/bluetooth/mgmt.c             | 9 ++-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 869f6ad..30e0fbb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1094,7 +1094,6 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_index_added(struct hci_dev *hdev);
 int mgmt_index_removed(struct hci_dev *hdev);
-int mgmt_new_settings(struct hci_dev *hdev);
 int mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
 int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 381faf6..dd48e2a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -890,11 +890,6 @@ static int new_settings(struct hci_dev *hdev, struct sock *skip)
 	return mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), skip);
 }
 
-int mgmt_new_settings(struct hci_dev *hdev)
-{
-	return new_settings(hdev, NULL);
-}
-
 struct cmd_lookup {
 	struct sock *sk;
 	struct hci_dev *hdev;
@@ -4668,7 +4663,7 @@ static void adv_enable_complete(struct hci_dev *hdev, u8 status)
 	/* Clear the advertising mgmt setting if we failed to re-enable it */
 	if (status) {
 		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
-		mgmt_new_settings(hdev);
+		new_settings(hdev, NULL);
 	}
 }
 
@@ -4690,6 +4685,6 @@ void mgmt_reenable_advertising(struct hci_dev *hdev)
 	 */
 	if (hci_req_run(&req, adv_enable_complete) < 0) {
 		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
-		mgmt_new_settings(hdev);
+		new_settings(hdev, NULL);
 	}
 }
-- 
1.8.3.1

