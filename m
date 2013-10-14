Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix minor coding style issue in set_connectable()
Date: Mon, 14 Oct 2013 16:38:45 -0700
Message-Id: <1381793925-14134-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is a minor coding style violation and so just fix it. No actual
logic has changed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cba15da..9048653 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1297,14 +1297,13 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
 	    cp->val != test_bit(HCI_PSCAN, &hdev->flags)) {
-
 		if (cp->val) {
 			scan = SCAN_PAGE;
 		} else {
 			scan = 0;
 
 			if (test_bit(HCI_ISCAN, &hdev->flags) &&
-					hdev->discov_timeout > 0)
+			    hdev->discov_timeout > 0)
 				cancel_delayed_work(&hdev->discov_off);
 		}
 
-- 
1.8.3.1

