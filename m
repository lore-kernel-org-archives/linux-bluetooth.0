Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix wrong New Settings event when closing HCI User Channel
Date: Sun,  4 Sep 2016 05:13:46 +0200
Message-Id: <1472958826-43347-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When closing HCI User Channel, the New Settings event was send out to
inform about changed settings. However such event is wrong since the
exclusive HCI User Channel access is active until the Index Added event
has been sent.

@ USER Close: test
@ MGMT Event: New Settings (0x0006) plen 4
        Current settings: 0x00000ad0
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
= Close Index: 00:14:EF:22:04:12
@ MGMT Event: Index Added (0x0004) plen 0

Calling __mgmt_power_off from hci_dev_do_close requires an extra check
for an active HCI User Channel.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ddf8432fe8fb..3ac89e9ace71 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1562,6 +1562,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 	auto_off = hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF);
 
 	if (!auto_off && hdev->dev_type == HCI_PRIMARY &&
+	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 	    hci_dev_test_flag(hdev, HCI_MGMT))
 		__mgmt_power_off(hdev);
 
-- 
2.7.4

