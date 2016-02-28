Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Add diag and address support for Intel/AG6xx
Date: Sun, 28 Feb 2016 21:25:19 +0100
Message-Id: <1456691119-64405-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The AG6xx devices behave similar to Wilkens Peak and Stone Peak and with
that it is needed to check for Intel default address. In addition it is
possible to enable vendor events and diag support.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ag6xx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ag6xx.c b/drivers/bluetooth/hci_ag6xx.c
index ea65c2d089ed..6923d17a022f 100644
--- a/drivers/bluetooth/hci_ag6xx.c
+++ b/drivers/bluetooth/hci_ag6xx.c
@@ -174,6 +174,9 @@ static int ag6xx_setup(struct hci_uart *hu)
 	bool patched = false;
 	int err;
 
+	hu->hdev->set_diag = btintel_set_diag;
+	hu->hdev->set_bdaddr = btintel_set_bdaddr;
+
 	err = btintel_enter_mfg(hdev);
 	if (err)
 		return err;
@@ -298,8 +301,16 @@ patch:
 complete:
 	/* Exit manufacturing mode and reset */
 	err = btintel_exit_mfg(hdev, true, patched);
+	if (err)
+		return err;
 
-	return err;
+	/* Set the event mask for Intel specific vendor events. This enables
+	 * a few extra events that are useful during general operation.
+	 */
+	btintel_set_event_mask_mfg(hdev, false);
+
+	btintel_check_bdaddr(hdev);
+	return 0;
 }
 
 static const struct hci_uart_proto ag6xx_proto = {
-- 
2.5.0

