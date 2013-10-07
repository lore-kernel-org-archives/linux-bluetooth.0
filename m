Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Power off AMP controllers after setup phase
Date: Mon,  7 Oct 2013 00:26:05 -0700
Message-Id: <1381130767-42488-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Even AMP controllers should be powered off after the setup phase. It
is not a good idea to keep AMP controllers powered on all the time
if they are not in use.

Power on of the AMP controller can either be done manually via
command line commands or directly via A2MP. Especially since there
is an indication in A2MP for powered down controllers that can
be activated.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d9626aa..2ee5a8e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2356,9 +2356,9 @@ int hci_register_dev(struct hci_dev *hdev)
 		set_bit(HCI_RFKILLED, &hdev->dev_flags);
 
 	set_bit(HCI_SETUP, &hdev->dev_flags);
+	set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
 
 	if (hdev->dev_type == HCI_BREDR) {
-		set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
 		/* Assume BR/EDR support until proven otherwise (such as
 		 * through reading supported features during init.
 		 */
-- 
1.8.3.1

