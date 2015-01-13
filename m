Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Move Delete Stored Link Key to 4th phase of initialization
Date: Mon, 12 Jan 2015 22:47:22 -0800
Message-Id: <1421131642-7284-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This moves the execution of Delete Stored Link Key command to the
hci_init4_req phase. No actual code has been changed. The command
is just executed at a later stage of the initialization.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 96572a48948e..c04197347c90 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -739,29 +739,6 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_READ_STORED_LINK_KEY, sizeof(cp), &cp);
 	}
 
-	/* Some Broadcom based Bluetooth controllers do not support the
-	 * Delete Stored Link Key command. They are clearly indicating its
-	 * absence in the bit mask of supported commands.
-	 *
-	 * Check the supported commands and only if the the command is marked
-	 * as supported send it. If not supported assume that the controller
-	 * does not have actual support for stored link keys which makes this
-	 * command redundant anyway.
-	 *
-	 * Some controllers indicate that they support handling deleting
-	 * stored link keys, but they don't. The quirk lets a driver
-	 * just disable this command.
-	 */
-	if (hdev->commands[6] & 0x80 &&
-	    !test_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks)) {
-		struct hci_cp_delete_stored_link_key cp;
-
-		bacpy(&cp.bdaddr, BDADDR_ANY);
-		cp.delete_all = 0x01;
-		hci_req_add(req, HCI_OP_DELETE_STORED_LINK_KEY,
-			    sizeof(cp), &cp);
-	}
-
 	if (hdev->commands[5] & 0x10)
 		hci_setup_link_policy(req);
 
@@ -853,6 +830,29 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
 
+	/* Some Broadcom based Bluetooth controllers do not support the
+	 * Delete Stored Link Key command. They are clearly indicating its
+	 * absence in the bit mask of supported commands.
+	 *
+	 * Check the supported commands and only if the the command is marked
+	 * as supported send it. If not supported assume that the controller
+	 * does not have actual support for stored link keys which makes this
+	 * command redundant anyway.
+	 *
+	 * Some controllers indicate that they support handling deleting
+	 * stored link keys, but they don't. The quirk lets a driver
+	 * just disable this command.
+	 */
+	if (hdev->commands[6] & 0x80 &&
+	    !test_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks)) {
+		struct hci_cp_delete_stored_link_key cp;
+
+		bacpy(&cp.bdaddr, BDADDR_ANY);
+		cp.delete_all = 0x01;
+		hci_req_add(req, HCI_OP_DELETE_STORED_LINK_KEY,
+			    sizeof(cp), &cp);
+	}
+
 	/* Set event mask page 2 if the HCI command for it is supported */
 	if (hdev->commands[22] & 0x04)
 		hci_set_event_mask_page_2(req);
-- 
2.1.0

