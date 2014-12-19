Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Support static address when BR/EDR has been disabled
Date: Fri, 19 Dec 2014 23:05:35 +0100
Message-Id: <1419026735-24536-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Every BR/EDR/LE dual-mode controller requires to have a public address
and so far that has become the identity address and own address. The
only way to change that behavior was with a force_static_address
debugfs option.

However the host can actually disable the BR/EDR part of a dual-mode
controller and turn into a single mode LE controller. In that case
it makes perfect sense for a host to use a chosen static address
instead of the public address.

So if the host disables BR/EDR and configures a static address, then
that static address is used as identity address and own address. If
the host does not configure a static address, then the public address
is used as before.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c    | 8 +++++++-
 net/bluetooth/hci_request.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9790a0108e69..91dca121dbb6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3852,12 +3852,18 @@ static void le_scan_disable_work(struct work_struct *work)
  *
  * For debugging purposes it is possible to force controllers with a
  * public address to use the static random address instead.
+ *
+ * In case BR/EDR has been disabled on a dual-mode controller and
+ * userspace has configured a static address, then that address
+ * becomes the identity address instead of the public BR/EDR address.
  */
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type)
 {
 	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
-	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
+	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
+	    (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
+	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
 		bacpy(bdaddr, &hdev->static_addr);
 		*bdaddr_type = ADDR_LE_DEV_RANDOM;
 	} else {
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 5e64ea70a106..324c6418b17c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -378,9 +378,15 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	 * address use the static address as random address (but skip
 	 * the HCI command if the current random address is already the
 	 * static one.
+	 *
+	 * In case BR/EDR has been disabled on a dual-mode controller
+	 * and a static address has been configured, then use that
+	 * address instead of the public BR/EDR address.
 	 */
 	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
-	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
+	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
+	    (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
+	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
 		*own_addr_type = ADDR_LE_DEV_RANDOM;
 		if (bacmp(&hdev->static_addr, &hdev->random_addr))
 			hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
-- 
2.1.0

