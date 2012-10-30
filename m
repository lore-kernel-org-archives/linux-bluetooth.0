Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Notify about device registration before power on
Date: Tue, 30 Oct 2012 01:35:40 -0700
Message-Id: <1351586140-30708-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is important that the monitor interface gets notified about
a new device before its power on procedure has been started.

For some reason that is no longer working as expected and the power
on procedure runs first. It is safe to just notify about device
registration and trigger the power on procedure afterwards.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a0ce70..a0a2f97 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1754,11 +1754,11 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (hdev->dev_type != HCI_AMP)
 		set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
 
-	schedule_work(&hdev->power_on);
-
 	hci_notify(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
 
+	schedule_work(&hdev->power_on);
+
 	return id;
 
 err_wqueue:
-- 
1.7.11.7

