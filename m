Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 1/5] Bluetooth: hci_intel: Use shorter timeout for HCI commands
Date: Fri, 27 Nov 2015 19:55:59 +0100
Message-Id: <1448650563-9075-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Use the standard HCI_CMD_TIMEOUT(1s) for HCI command instead of
HCI_INIT_TIMEOUT(10s) which is not justified in these cases.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 69760e2..3c28c4a 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -502,7 +502,7 @@ static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	/* Device will not accept speed change if Intel version has not been
 	 * previously requested.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
@@ -590,7 +590,7 @@ static int intel_setup(struct hci_uart *hu)
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
@@ -671,7 +671,7 @@ static int intel_setup(struct hci_uart *hu)
 	/* Read the secure boot parameters to identify the operating
 	 * details of the bootloader.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc0d, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc0d, 0, NULL, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reading Intel boot parameters failed (%ld)",
 			   PTR_ERR(skb));
@@ -881,7 +881,7 @@ done:
 	set_bit(STATE_BOOTING, &intel->flags);
 
 	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
-			     HCI_INIT_TIMEOUT);
+			     HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-- 
1.9.1
