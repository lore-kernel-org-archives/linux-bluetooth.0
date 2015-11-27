Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 2/5] Bluetooth: hci_intel: Split Intel setup procedure
Date: Fri, 27 Nov 2015 19:56:00 +0100
Message-Id: <1448650563-9075-2-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1448650563-9075-1-git-send-email-loic.poulain@intel.com>
References: <1448650563-9075-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

In order to prepare support for other Intel controller variants, split
the Intel setup procedure into a generic init and a LnP(iBT 3.0)
specific one. The generic part consists mostly of reading the Intel
version and calling the specific setup accordingly.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 154 +++++++++++++++++++++++-------------------
 1 file changed, 84 insertions(+), 70 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 3c28c4a..2dcf9b0 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -533,7 +533,7 @@ static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	return 0;
 }
 
-static int intel_setup(struct hci_uart *hu)
+static int intel_setup_lnp(struct hci_uart *hu, struct intel_version *ver)
 {
 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
 					  0x00, 0x08, 0x04, 0x00 };
@@ -542,7 +542,6 @@ static int intel_setup(struct hci_uart *hu)
 	struct intel_device *idev = NULL;
 	struct hci_dev *hdev = hu->hdev;
 	struct sk_buff *skb;
-	struct intel_version *ver;
 	struct intel_boot_params *params;
 	struct list_head *p;
 	const struct firmware *fw;
@@ -575,67 +574,6 @@ static int intel_setup(struct hci_uart *hu)
 	if (oper_speed && init_speed && oper_speed != init_speed)
 		speed_change = 1;
 
-	/* Check that the controller is ready */
-	err = intel_wait_booting(hu);
-
-	clear_bit(STATE_BOOTING, &intel->flags);
-
-	/* In case of timeout, try to continue anyway */
-	if (err && err != ETIMEDOUT)
-		return err;
-
-	set_bit(STATE_BOOTLOADER, &intel->flags);
-
-	/* Read the Intel version information to determine if the device
-	 * is in bootloader mode or if it already has operational firmware
-	 * loaded.
-	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
-			   PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->len != sizeof(*ver)) {
-		bt_dev_err(hdev, "Intel version event size mismatch");
-		kfree_skb(skb);
-		return -EILSEQ;
-	}
-
-	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
-		bt_dev_err(hdev, "Intel version command failure (%02x)",
-			   ver->status);
-		err = -bt_to_errno(ver->status);
-		kfree_skb(skb);
-		return err;
-	}
-
-	/* The hardware platform number has a fixed value of 0x37 and
-	 * for now only accept this single value.
-	 */
-	if (ver->hw_platform != 0x37) {
-		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
-			   ver->hw_platform);
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
-	/* At the moment only the hardware variant iBT 3.0 (LnP/SfP) is
-	 * supported by this firmware loading method. This check has been
-	 * put in place to ensure correct forward compatibility options
-	 * when newer hardware variants come along.
-	 */
-	if (ver->hw_variant != 0x0b) {
-		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
-			   ver->hw_variant);
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
-	btintel_version_info(hdev, ver);
-
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
 	 * the bootloader and the value 0x23 identifies the operational
@@ -650,8 +588,6 @@ static int intel_setup(struct hci_uart *hu)
 	 * case since that command is only available in bootloader mode.
 	 */
 	if (ver->fw_variant == 0x23) {
-		kfree_skb(skb);
-		clear_bit(STATE_BOOTLOADER, &intel->flags);
 		btintel_check_bdaddr(hdev);
 		return 0;
 	}
@@ -662,12 +598,9 @@ static int intel_setup(struct hci_uart *hu)
 	if (ver->fw_variant != 0x06) {
 		bt_dev_err(hdev, "Unsupported Intel firmware variant (%u)",
 			   ver->fw_variant);
-		kfree_skb(skb);
 		return -ENODEV;
 	}
 
-	kfree_skb(skb);
-
 	/* Read the secure boot parameters to identify the operating
 	 * details of the bootloader.
 	 */
@@ -951,11 +884,92 @@ no_lpm:
 			return err;
 	}
 
-	bt_dev_info(hdev, "Setup complete");
+	return 0;
+}
 
+static int intel_setup(struct hci_uart *hu)
+{
+	struct intel_data *intel = hu->priv;
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+	struct intel_version *ver;
+	int err;
+
+	bt_dev_dbg(hdev, "start intel_setup");
+
+	hu->hdev->set_diag = btintel_set_diag;
+	hu->hdev->set_bdaddr = btintel_set_bdaddr;
+
+	/* Check that the controller is ready */
+	err = intel_wait_booting(hu);
+
+	clear_bit(STATE_BOOTING, &intel->flags);
+
+	/* In case of timeout, try to continue anyway */
+	if (err && err != ETIMEDOUT)
+		return err;
+
+	set_bit(STATE_BOOTLOADER, &intel->flags);
+
+	/* Read the Intel version information to determine if the device
+	 * is in bootloader mode or if it already has operational firmware
+	 * loaded.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		bt_dev_err(hdev, "Intel version event size mismatch");
+		err = -EILSEQ;
+		goto done;
+	}
+
+	ver = (struct intel_version *)skb->data;
+	if (ver->status) {
+		bt_dev_err(hdev, "Intel version command failure (%02x)",
+			   ver->status);
+		err = -bt_to_errno(ver->status);
+		goto done;
+	}
+
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (ver->hw_platform != 0x37) {
+		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
+			   ver->hw_platform);
+		err = -EINVAL;
+		goto done;
+	}
+
+	btintel_version_info(hdev, ver);
+
+	/* At the moment only the hardware variant iBT 3.0 (LnP/SfP) is
+	 * supported by this firmware loading method. This check has been
+	 * put in place to ensure correct forward compatibility options
+	 * when newer hardware variants come along.
+	 */
+	switch (ver->hw_variant) {
+	case 0x0b:
+		err = intel_setup_lnp(hu, ver);
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
+			   ver->hw_variant);
+		err = -EINVAL;
+		break;
+	}
+
+done:
+	kfree_skb(skb);
 	clear_bit(STATE_BOOTLOADER, &intel->flags);
+	bt_dev_info(hdev, "Setup complete (%d)", err);
 
-	return 0;
+	return err;
 }
 
 static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.9.1
