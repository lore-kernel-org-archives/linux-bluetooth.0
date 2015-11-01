Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Make LE only events conditional on supported commands
Date: Sun,  1 Nov 2015 09:39:50 +0100
Message-Id: <1446367191-67668-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For the LE only controllers, there are events that should not be enabled
if the corresponding command is not supported.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index db423657935a..ece86ed1249b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -534,13 +534,20 @@ static void hci_setup_event_mask(struct hci_request *req)
 	} else {
 		/* Use a different default for LE-only devices */
 		memset(events, 0, sizeof(events));
-		events[0] |= 0x10; /* Disconnection Complete */
-		events[1] |= 0x08; /* Read Remote Version Information Complete */
 		events[1] |= 0x20; /* Command Complete */
 		events[1] |= 0x40; /* Command Status */
 		events[1] |= 0x80; /* Hardware Error */
-		events[2] |= 0x04; /* Number of Completed Packets */
-		events[3] |= 0x02; /* Data Buffer Overflow */
+
+		if (hdev->commands[0] & 0x20) {
+			events[0] |= 0x10; /* Disconnection Complete */
+			events[2] |= 0x04; /* Number of Completed Packets */
+			events[3] |= 0x02; /* Data Buffer Overflow */
+		}
+
+		if (hdev->commands[2] & 0x80)
+			events[1] |= 0x08; /* Read Remote Version Information
+					    * Complete
+					    */
 
 		if (hdev->le_features[0] & HCI_LE_ENCRYPTION) {
 			events[0] |= 0x80; /* Encryption Change */
-- 
2.4.3

