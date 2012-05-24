Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH] Bluetooth: Use lmp_ssp_capable() macro
Date: Thu, 24 May 2012 03:36:37 -0300
Message-Id: <1337841397-24085-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Make the check more user friendly.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/hci_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5e24a57..80f209b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -557,7 +557,7 @@ static void hci_setup(struct hci_dev *hdev)
 	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
 		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
-	if (hdev->features[6] & LMP_SIMPLE_PAIR) {
+	if (lmp_ssp_capable(hdev)) {
 		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
 			u8 mode = 0x01;
 			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE,
-- 
1.7.10.1

