Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't announce raw-only devices over management interface
Date: Wed,  2 Jul 2014 16:43:29 +0200
Message-Id: <1404312209-42720-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the HCI_QUIRK_RAW_DEVICE is set, then the controller existence
should not be announced over the management interface.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 21a4c8dfb874..9e983b242057 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2275,6 +2275,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		hci_notify(hdev, HCI_DEV_UP);
 		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
 		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
+		    !test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks) &&
 		    hdev->dev_type == HCI_BREDR) {
 			hci_dev_lock(hdev);
 			mgmt_powered(hdev, 1);
-- 
1.9.3

