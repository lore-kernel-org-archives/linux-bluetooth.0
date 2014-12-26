Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Remove BlueFritz! specific check from initialization
Date: Fri, 26 Dec 2014 04:42:34 +0100
Message-Id: <1419565354-49553-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The AVM BlueFritz! USB controllers had a special handling in the
Bluetooth core when it comes to reading the supported commands.

Both drivers now set the HCI_QUIRK_BROKEN_LOCAL_COMMANDS and with
that it is no longer needed to look for vendor specific details.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 47f0311d1006..5ef5221c1813 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -623,10 +623,16 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 	if (lmp_le_capable(hdev))
 		le_setup(req);
 
-	/* AVM Berlin (31), aka "BlueFRITZ!", doesn't support the read
-	 * local supported commands HCI command.
+	/* All Bluetooth 1.2 and later controllers should support the
+	 * HCI command for reading the local supported commands.
+	 *
+	 * Unfortunately some controllers indicate Bluetooth 1.2 support,
+	 * but do not have support for this command. If that is the case,
+	 * the driver can quirk the behavior and skip reading the local
+	 * supported commands.
 	 */
-	if (hdev->manufacturer != 31 && hdev->hci_ver > BLUETOOTH_VER_1_1)
+	if (hdev->hci_ver > BLUETOOTH_VER_1_1 &&
+	    !test_bit(HCI_QUIRK_BROKEN_LOCAL_COMMANDS, &hdev->quirks))
 		hci_req_add(req, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
 	if (lmp_ssp_capable(hdev)) {
-- 
2.1.0

