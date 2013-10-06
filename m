Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use explicit check for BR/EDR device type
Date: Sun,  6 Oct 2013 01:16:22 -0700
Message-Id: <1381047382-37225-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The BR/EDR and LE setup procedures apply only to BR/EDR device types
and so check for that explicitly. Checking that it is not an AMP
controller is dangerous in case there will be ever a third device
type.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 86c022c..03a8b93 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2360,7 +2360,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	set_bit(HCI_SETUP, &hdev->dev_flags);
 
-	if (hdev->dev_type != HCI_AMP) {
+	if (hdev->dev_type == HCI_BREDR) {
 		set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
 		/* Assume BR/EDR support until proven otherwise (such as
 		 * through reading supported features during init.
-- 
1.8.3.1

