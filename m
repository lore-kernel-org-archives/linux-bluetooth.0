Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Fix two coding style issues
Date: Thu, 16 Apr 2015 23:15:50 +0200
Message-Id: <1429218950-21313-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ERROR: spaces required around that '<' (ctx:WxV)
+		if (err <0)
 		        ^

ERROR: code indent should use tabs where possible
+^I^I^I^I        sizeof(ver));$

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 84f998532117..920f6fbd28ac 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -916,7 +916,7 @@ static int btusb_open(struct hci_dev *hdev)
 	 */
 	if (data->setup_on_usb) {
 		err = data->setup_on_usb(hdev);
-		if (err <0)
+		if (err < 0)
 			return err;
 	}
 
@@ -2973,7 +2973,7 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	int i, err;
 
 	err = btusb_qca_send_vendor_req(hdev, QCA_GET_TARGET_VERSION, &ver,
-				        sizeof(ver));
+					sizeof(ver));
 	if (err < 0)
 		return err;
 
-- 
2.1.0

