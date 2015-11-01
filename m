Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Build LE event mask based on supported commands
Date: Sun,  1 Nov 2015 09:39:51 +0100
Message-Id: <1446367191-67668-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LE event mask should be created based on the commands that are
actually supported by the controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ece86ed1249b..41a70138a770 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -788,7 +788,6 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 		u8 events[8];
 
 		memset(events, 0, sizeof(events));
-		events[0] = 0x0f;
 
 		if (hdev->le_features[0] & HCI_LE_ENCRYPTION)
 			events[0] |= 0x10;	/* LE Long Term Key Request */
@@ -815,6 +814,34 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 						 * Report
 						 */
 
+		/* If the controller supports the LE Set Scan Enable command,
+		 * enable the corresponding advertising report event.
+		 */
+		if (hdev->commands[26] & 0x08)
+			events[0] |= 0x02;	/* LE Advertising Report */
+
+		/* If the controller supports the LE Create Connection
+		 * command, enable the corresponding event.
+		 */
+		if (hdev->commands[26] & 0x10)
+			events[0] |= 0x01;	/* LE Connection Complete */
+
+		/* If the controller supports the LE Connection Update
+		 * command, enable the corresponding event.
+		 */
+		if (hdev->commands[27] & 0x04)
+			events[0] |= 0x04;	/* LE Connection Update
+						 * Complete
+						 */
+
+		/* If the controller supports the LE Read Remote Used Features
+		 * command, enable the corresponding event.
+		 */
+		if (hdev->commands[27] & 0x20)
+			events[0] |= 0x08;	/* LE Read Remote Used
+						 * Features Complete
+						 */
+
 		/* If the controller supports the LE Read Local P-256
 		 * Public Key command, enable the corresponding event.
 		 */
-- 
2.4.3

