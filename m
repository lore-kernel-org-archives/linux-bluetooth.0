Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add quirk for disabling Delete Stored Link Key command
Date: Fri,  3 Jan 2014 03:02:35 -0800
Message-Id: <1388746956-9944-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some controller pretend they support the Delete Stored Link Key command,
but in reality they really don't support it.

  < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
      bdaddr 00:00:00:00:00:00 all 1
  > HCI Event: Command Complete (0x0e) plen 4
      Delete Stored Link Key (0x03|0x0012) ncmd 1
      status 0x11 deleted 0
      Error: Unsupported Feature or Parameter Value

Not correctly supporting this command causes the controller setup to
fail and will make a device not work. However sending the command for
controller that handle stored link keys is important. This quirk
allows a driver to disable the command if it knows that this command
handling is broken.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 3 ++-
 net/bluetooth/hci_core.c    | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5dc3d9072650..66c1cd87bfe7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -83,7 +83,8 @@
 enum {
 	HCI_QUIRK_RESET_ON_CLOSE,
 	HCI_QUIRK_RAW_DEVICE,
-	HCI_QUIRK_FIXUP_BUFFER_SIZE
+	HCI_QUIRK_FIXUP_BUFFER_SIZE,
+	HCI_QUIRK_BROKEN_STORED_LINK_KEY,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b23d40385f18..5e8663c194c1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1304,8 +1304,13 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 	 * as supported send it. If not supported assume that the controller
 	 * does not have actual support for stored link keys which makes this
 	 * command redundant anyway.
+	 *
+	 * Some controllers indicate that they support handling deleting
+	 * stored link keys, but they don't. The quirk lets a driver
+	 * just disable this command.
 	 */
-	if (hdev->commands[6] & 0x80) {
+	if (hdev->commands[6] & 0x80 &&
+	    !test_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks)) {
 		struct hci_cp_delete_stored_link_key cp;
 
 		bacpy(&cp.bdaddr, BDADDR_ANY);
-- 
1.8.4.2

