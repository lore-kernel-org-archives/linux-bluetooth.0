Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Enable basics for LE Data Length Extension feature
Date: Sat, 20 Dec 2014 16:28:39 +0100
Message-Id: <1419089320-14498-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller supports the new LE Data Length Extension feature
from Bluetooth 4.2 specification, enable the new events and read the
values for default and maxmimum data length supported by the controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2db071b2f0f4..01e35ef6d201 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -805,6 +805,12 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 						 * Parameter Request
 						 */
 
+		/* If the controller supports the Data Length Extension
+		 * feature, enable the corresponding event.
+		 */
+		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT)
+			events[0] |= 0x40;	/* LE Data Length Change */
+
 		/* If the controller supports Extended Scanner Filter
 		 * Policies, enable the correspondig event.
 		 */
@@ -835,6 +841,14 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 			hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 		}
 
+		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
+			/* Read LE Maximum Data Length */
+			hci_req_add(req, HCI_OP_LE_READ_MAX_DATA_LEN, 0, NULL);
+
+			/* Read LE Suggested Default Data Length */
+			hci_req_add(req, HCI_OP_LE_READ_DEF_DATA_LEN, 0, NULL);
+		}
+
 		hci_set_le_support(req);
 	}
 
-- 
2.1.0

