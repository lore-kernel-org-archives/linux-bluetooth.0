Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] Bluetooth: Enable Secure Connection during power on if configured
Date: Thu,  9 Jan 2014 12:56:29 -0800
Message-Id: <1389300990-20255-9-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If support for Secure Connection has been configured, then make sure
to send the appropiate HCI command to enable it when powering on the
controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 52e398f37129..b3b619a448b5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1363,6 +1363,14 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 	/* Check for Synchronization Train support */
 	if (lmp_sync_train_capable(hdev))
 		hci_req_add(req, HCI_OP_READ_SYNC_TRAIN_PARAMS, 0, NULL);
+
+	/* Enable Secure Connections if supported and configured */
+	if (lmp_sc_capable(hdev) &&
+	    test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
+		u8 support = 0x01;
+		hci_req_add(req, HCI_OP_WRITE_SC_SUPPORT,
+			    sizeof(support), &support);
+	}
 }
 
 static int __hci_init(struct hci_dev *hdev)
-- 
1.8.4.2

