Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove locking in hci_user_passkey_request_evt
Date: Mon, 23 Jul 2012 18:19:04 -0300
Message-Id: <1343078344-22759-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes hdev locking in hci_user_passkey_request_evt
since it is not needed. mgmt_user_passkey_request simply calls
mgmt_event which does not require hdev locking at all.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 41ff978..a6c509d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3252,12 +3252,8 @@ static void hci_user_passkey_request_evt(struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
-	hci_dev_lock(hdev);
-
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_user_passkey_request(hdev, &ev->bdaddr, ACL_LINK, 0);
-
-	hci_dev_unlock(hdev);
 }
 
 static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
-- 
1.7.11.2

