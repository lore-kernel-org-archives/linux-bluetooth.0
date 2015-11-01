Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Check for supported white list before issuing commands
Date: Sun,  1 Nov 2015 09:39:48 +0100
Message-Id: <1446367191-67668-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The white list commands might not be implemented if the controller does
not actually support the white list. So check the supported commands
first before issuing these commands. Not supporting the white list is
the same as supporting a white list with zero size.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 83a6aacfab31..62edbf1b114e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -508,12 +508,6 @@ static void le_setup(struct hci_request *req)
 	/* Read LE Supported States */
 	hci_req_add(req, HCI_OP_LE_READ_SUPPORTED_STATES, 0, NULL);
 
-	/* Read LE White List Size */
-	hci_req_add(req, HCI_OP_LE_READ_WHITE_LIST_SIZE, 0, NULL);
-
-	/* Clear LE White List */
-	hci_req_add(req, HCI_OP_LE_CLEAR_WHITE_LIST, 0, NULL);
-
 	/* LE-only controllers have LE implicitly enabled */
 	if (!lmp_bredr_capable(hdev))
 		hci_dev_set_flag(hdev, HCI_LE_ENABLED);
@@ -832,6 +826,17 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 			hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 		}
 
+		if (hdev->commands[26] & 0x40) {
+			/* Read LE White List Size */
+			hci_req_add(req, HCI_OP_LE_READ_WHITE_LIST_SIZE,
+				    0, NULL);
+		}
+
+		if (hdev->commands[26] & 0x80) {
+			/* Clear LE White List */
+			hci_req_add(req, HCI_OP_LE_CLEAR_WHITE_LIST, 0, NULL);
+		}
+
 		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
 			/* Read LE Maximum Data Length */
 			hci_req_add(req, HCI_OP_LE_READ_MAX_DATA_LEN, 0, NULL);
-- 
2.4.3

