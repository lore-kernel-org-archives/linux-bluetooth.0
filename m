Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Move Intel firmware download into common module
Date: Sun,  5 Apr 2015 06:35:27 -0700
Message-Id: <1428240927-31803-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel firmware download code for the new generation of devices can
be shared between USB and UART devices. And so move it into the generic
module for Intel Bluetooth support.

This also adds turns the support for the new Intel controllers into an
optional feature. It can be enabled/disabled if needed. For backwards
compatibility with older kernel configurations, the new option defaults
to yes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig   |  12 ++
 drivers/bluetooth/btintel.c | 382 +++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |   7 +
 drivers/bluetooth/btusb.c   | 388 +++-----------------------------------------
 4 files changed, 421 insertions(+), 368 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 6141e40ee1cd..f4d5714668e4 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -4,6 +4,7 @@ menu "Bluetooth device drivers"
 
 config BT_INTEL
 	tristate
+	select FW_LOADER
 
 config BT_BCM
 	tristate
@@ -21,6 +22,17 @@ config BT_HCIBTUSB
 	  Say Y here to compile support for Bluetooth USB devices into the
 	  kernel or say M to compile it as module (btusb).
 
+config BT_HCIBTUSB_INTEL
+	bool "Intel protocol support"
+	depends on BT_HCIBTUSB
+	select BT_INTEL
+	default y
+	help
+	  The Intel protocol support enables firmware download and
+	  configuration for Intel Bluetooth controllers.
+
+	  Say Y here to compile support for Intel protocol.
+
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index aa56dcf6adcc..7c92e55b8683 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/firmware.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -136,7 +137,388 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 }
 EXPORT_SYMBOL_GPL(btintel_hw_error);
 
+static void btintel_set_quirks(struct hci_dev *hdev)
+{
+	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+}
+
+static int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type,
+			       u32 plen, const void *param)
+{
+	while (plen > 0) {
+		struct sk_buff *skb;
+		u8 cmd_param[253], fragment_len = (plen > 252) ? 252 : plen;
+
+		cmd_param[0] = fragment_type;
+		memcpy(cmd_param + 1, param, fragment_len);
+
+		skb = __hci_cmd_sync(hdev, 0xfc09, fragment_len + 1,
+				     cmd_param, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
+
+		kfree_skb(skb);
+
+		plen -= fragment_len;
+		param += fragment_len;
+	}
+
+	return 0;
+}
+
+static void btintel_version_info(struct hci_dev *hdev,
+				 struct intel_version *ver)
+{
+	const char *variant;
+
+	switch (ver->fw_variant) {
+	case 0x06:
+		variant = "Bootloader";
+		break;
+	case 0x23:
+		variant = "Firmware";
+		break;
+	default:
+		return;
+	}
+
+	BT_INFO("%s: %s revision %u.%u build %u week %u %u", hdev->name,
+		variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
+		ver->fw_build_num, ver->fw_build_ww, 2000 + ver->fw_build_yy);
+}
+
+int btintel_setup(struct hci_dev *hdev, unsigned long *flags)
+{
+	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
+					  0x00, 0x08, 0x04, 0x00 };
+	struct sk_buff *skb;
+	struct intel_version *ver;
+	struct intel_boot_params *params;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	char fwname[64];
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	calltime = ktime_get();
+
+	/* Read the Intel version information to determine if the device
+	 * is in bootloader mode or if it already has operational firmware
+	 * loaded.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Reading Intel version information failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		BT_ERR("%s: Intel version event size mismatch", hdev->name);
+		kfree_skb(skb);
+		return -EILSEQ;
+	}
+
+	ver = (struct intel_version *)skb->data;
+	if (ver->status) {
+		BT_ERR("%s: Intel version command failure (%02x)",
+		       hdev->name, ver->status);
+		err = -bt_to_errno(ver->status);
+		kfree_skb(skb);
+		return err;
+	}
+
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (ver->hw_platform != 0x37) {
+		BT_ERR("%s: Unsupported Intel hardware platform (%u)",
+		       hdev->name, ver->hw_platform);
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	/* At the moment only the hardware variant iBT 3.0 (LnP/SfP) is
+	 * supported by this firmware loading method. This check has been
+	 * put in place to ensure correct forward compatibility options
+	 * when newer hardware variants come along.
+	 */
+	if (ver->hw_variant != 0x0b) {
+		BT_ERR("%s: Unsupported Intel hardware variant (%u)",
+		       hdev->name, ver->hw_variant);
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	btintel_version_info(hdev, ver);
+
+	/* The firmware variant determines if the device is in bootloader
+	 * mode or is running operational firmware. The value 0x06 identifies
+	 * the bootloader and the value 0x23 identifies the operational
+	 * firmware.
+	 *
+	 * When the operational firmware is already present, then only
+	 * the check for valid Bluetooth device address is needed. This
+	 * determines if the device will be added as configured or
+	 * unconfigured controller.
+	 *
+	 * It is not possible to use the Secure Boot Parameters in this
+	 * case since that command is only available in bootloader mode.
+	 */
+	if (ver->fw_variant == 0x23) {
+		kfree_skb(skb);
+		clear_bit(BTINTEL_BOOTLOADER, flags);
+		btintel_check_bdaddr(hdev);
+		btintel_set_quirks(hdev);
+		return 0;
+	}
+
+	/* If the device is not in bootloader mode, then the only possible
+	 * choice is to return an error and abort the device initialization.
+	 */
+	if (ver->fw_variant != 0x06) {
+		BT_ERR("%s: Unsupported Intel firmware variant (%u)",
+		       hdev->name, ver->fw_variant);
+		kfree_skb(skb);
+		return -ENODEV;
+	}
+
+	kfree_skb(skb);
+
+	/* Read the secure boot parameters to identify the operating
+	 * details of the bootloader.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc0d, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Reading Intel boot parameters failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*params)) {
+		BT_ERR("%s: Intel boot parameters size mismatch", hdev->name);
+		kfree_skb(skb);
+		return -EILSEQ;
+	}
+
+	params = (struct intel_boot_params *)skb->data;
+	if (params->status) {
+		BT_ERR("%s: Intel boot parameters command failure (%02x)",
+		       hdev->name, params->status);
+		err = -bt_to_errno(params->status);
+		kfree_skb(skb);
+		return err;
+	}
+
+	BT_INFO("%s: Device revision is %u", hdev->name,
+		le16_to_cpu(params->dev_revid));
+
+	BT_INFO("%s: Secure boot is %s", hdev->name,
+		params->secure_boot ? "enabled" : "disabled");
+
+	BT_INFO("%s: Minimum firmware build %u week %u %u", hdev->name,
+		params->min_fw_build_nn, params->min_fw_build_cw,
+		2000 + params->min_fw_build_yy);
+
+	/* It is required that every single firmware fragment is acknowledged
+	 * with a command complete event. If the boot parameters indicate
+	 * that this bootloader does not send them, then abort the setup.
+	 */
+	if (params->limited_cce != 0x00) {
+		BT_ERR("%s: Unsupported Intel firmware loading method (%u)",
+		       hdev->name, params->limited_cce);
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	/* If the OTP has no valid Bluetooth device address, then there will
+	 * also be no valid address for the operational firmware.
+	 */
+	if (!bacmp(&params->otp_bdaddr, BDADDR_ANY)) {
+		BT_INFO("%s: No device address configured", hdev->name);
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
+
+	/* With this Intel bootloader only the hardware variant and device
+	 * revision information are used to select the right firmware.
+	 *
+	 * Currently this bootloader support is limited to hardware variant
+	 * iBT 3.0 (LnP/SfP) which is identified by the value 11 (0x0b).
+	 */
+	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.sfi",
+		 le16_to_cpu(params->dev_revid));
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		BT_ERR("%s: Failed to load Intel firmware file (%d)",
+		       hdev->name, err);
+		kfree_skb(skb);
+		return err;
+	}
+
+	BT_INFO("%s: Found device firmware: %s", hdev->name, fwname);
+
+	kfree_skb(skb);
+
+	if (fw->size < 644) {
+		BT_ERR("%s: Invalid size of firmware file (%zu)",
+		       hdev->name, fw->size);
+		err = -EBADF;
+		goto done;
+	}
+
+	set_bit(BTINTEL_DOWNLOADING, flags);
+
+	/* Start the firmware download transaction with the Init fragment
+	 * represented by the 128 bytes of CSS header.
+	 */
+	err = btintel_secure_send(hdev, 0x00, 128, fw->data);
+	if (err < 0) {
+		BT_ERR("%s: Failed to send firmware header (%d)",
+		       hdev->name, err);
+		goto done;
+	}
+
+	/* Send the 256 bytes of public key information from the firmware
+	 * as the PKey fragment.
+	 */
+	err = btintel_secure_send(hdev, 0x03, 256, fw->data + 128);
+	if (err < 0) {
+		BT_ERR("%s: Failed to send firmware public key (%d)",
+		       hdev->name, err);
+		goto done;
+	}
+
+	/* Send the 256 bytes of signature information from the firmware
+	 * as the Sign fragment.
+	 */
+	err = btintel_secure_send(hdev, 0x02, 256, fw->data + 388);
+	if (err < 0) {
+		BT_ERR("%s: Failed to send firmware signature (%d)",
+		       hdev->name, err);
+		goto done;
+	}
+
+	fw_ptr = fw->data + 644;
+
+	while (fw_ptr - fw->data < fw->size) {
+		struct hci_command_hdr *cmd = (void *)fw_ptr;
+		u8 cmd_len;
+
+		cmd_len = sizeof(*cmd) + cmd->plen;
+
+		/* Send each command from the firmware data buffer as
+		 * a single Data fragment.
+		 */
+		err = btintel_secure_send(hdev, 0x01, cmd_len, fw_ptr);
+		if (err < 0) {
+			BT_ERR("%s: Failed to send firmware data (%d)",
+			       hdev->name, err);
+			goto done;
+		}
+
+		fw_ptr += cmd_len;
+	}
+
+	set_bit(BTINTEL_FIRMWARE_LOADED, flags);
+
+	BT_INFO("%s: Waiting for firmware download to complete", hdev->name);
+
+	/* Before switching the device into operational mode and with that
+	 * booting the loaded firmware, wait for the bootloader notification
+	 * that all fragments have been successfully received.
+	 *
+	 * When the event processing receives the notification, then the
+	 * downloading flag will be cleared.
+	 *
+	 * The firmware loading should not take longer than 5 seconds
+	 * and thus just timeout if that happens and fail the setup
+	 * of this device.
+	 */
+	err = wait_on_bit_timeout(flags, BTINTEL_DOWNLOADING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(5000));
+	if (err == 1) {
+		BT_ERR("%s: Firmware loading interrupted", hdev->name);
+		err = -EINTR;
+		goto done;
+	}
+
+	if (err) {
+		BT_ERR("%s: Firmware loading timeout", hdev->name);
+		err = -ETIMEDOUT;
+		goto done;
+	}
+
+	if (test_bit(BTINTEL_FIRMWARE_FAILED, flags)) {
+		BT_ERR("%s: Firmware loading failed", hdev->name);
+		err = -ENOEXEC;
+		goto done;
+	}
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+
+	BT_INFO("%s: Firmware loaded in %llu usecs", hdev->name, duration);
+
+done:
+	release_firmware(fw);
+
+	if (err < 0)
+		return err;
+
+	calltime = ktime_get();
+
+	set_bit(BTINTEL_BOOTING, flags);
+
+	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+
+	/* The bootloader will not indicate when the device is ready. This
+	 * is done by the operational firmware sending bootup notification.
+	 *
+	 * Booting into operational firmware should not take longer than
+	 * 1 second. However if that happens, then just fail the setup
+	 * since something went wrong.
+	 */
+	BT_INFO("%s: Waiting for device to boot", hdev->name);
+
+	err = wait_on_bit_timeout(flags, BTINTEL_BOOTING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(1000));
+
+	if (err == 1) {
+		BT_ERR("%s: Device boot interrupted", hdev->name);
+		return -EINTR;
+	}
+
+	if (err) {
+		BT_ERR("%s: Device boot timeout", hdev->name);
+		return -ETIMEDOUT;
+	}
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+
+	BT_INFO("%s: Device booted in %llu usecs", hdev->name, duration);
+
+	clear_bit(BTINTEL_BOOTLOADER, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_setup);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE("intel/ibt-11-0.sfi");
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 698e4270f88e..8068846c9d07 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -66,6 +66,8 @@ int btintel_check_bdaddr(struct hci_dev *hdev);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
+int btintel_setup(struct hci_dev *hdev, unsigned long *flags);
+
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -82,4 +84,9 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
 
+static inline int btintel_setup(struct hci_dev *hdev, unsigned long *flags)
+{
+	return 0;
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cdc4e324825f..c13d41808820 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1568,7 +1568,9 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 		BT_INFO("%s: Intel device is already patched. patch num: %02x",
 			hdev->name, ver->fw_patch_num);
 		kfree_skb(skb);
+#ifdef CONFIG_BT_HCIBTUSB_INTEL
 		btintel_check_bdaddr(hdev);
+#endif
 		return 0;
 	}
 
@@ -1581,7 +1583,9 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	fw = btusb_setup_intel_get_fw(hdev, ver);
 	if (!fw) {
 		kfree_skb(skb);
+#ifdef CONFIG_BT_HCIBTUSB_INTEL
 		btintel_check_bdaddr(hdev);
+#endif
 		return 0;
 	}
 	fw_ptr = fw->data;
@@ -1662,7 +1666,9 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	BT_INFO("%s: Intel Bluetooth firmware patch completed and activated",
 		hdev->name);
 
+#ifdef CONFIG_BT_HCIBTUSB_INTEL
 	btintel_check_bdaddr(hdev);
+#endif
 	return 0;
 
 exit_mfg_disable:
@@ -1678,7 +1684,9 @@ exit_mfg_disable:
 
 	BT_INFO("%s: Intel Bluetooth firmware patch completed", hdev->name);
 
+#ifdef CONFIG_BT_HCIBTUSB_INTEL
 	btintel_check_bdaddr(hdev);
+#endif
 	return 0;
 
 exit_mfg_deactivate:
@@ -1699,7 +1707,9 @@ exit_mfg_deactivate:
 	BT_INFO("%s: Intel Bluetooth firmware patch completed and deactivated",
 		hdev->name);
 
+#ifdef CONFIG_BT_HCIBTUSB_INTEL
 	btintel_check_bdaddr(hdev);
+#endif
 	return 0;
 }
 
@@ -1845,378 +1855,15 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
-static int btusb_intel_secure_send(struct hci_dev *hdev, u8 fragment_type,
-				   u32 plen, const void *param)
-{
-	while (plen > 0) {
-		struct sk_buff *skb;
-		u8 cmd_param[253], fragment_len = (plen > 252) ? 252 : plen;
-
-		cmd_param[0] = fragment_type;
-		memcpy(cmd_param + 1, param, fragment_len);
-
-		skb = __hci_cmd_sync(hdev, 0xfc09, fragment_len + 1,
-				     cmd_param, HCI_INIT_TIMEOUT);
-		if (IS_ERR(skb))
-			return PTR_ERR(skb);
-
-		kfree_skb(skb);
-
-		plen -= fragment_len;
-		param += fragment_len;
-	}
-
-	return 0;
-}
-
-static void btusb_intel_version_info(struct hci_dev *hdev,
-				     struct intel_version *ver)
-{
-	const char *variant;
-
-	switch (ver->fw_variant) {
-	case 0x06:
-		variant = "Bootloader";
-		break;
-	case 0x23:
-		variant = "Firmware";
-		break;
-	default:
-		return;
-	}
-
-	BT_INFO("%s: %s revision %u.%u build %u week %u %u", hdev->name,
-		variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
-		ver->fw_build_num, ver->fw_build_ww, 2000 + ver->fw_build_yy);
-}
-
 static int btusb_setup_intel_new(struct hci_dev *hdev)
 {
-	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
-					  0x00, 0x08, 0x04, 0x00 };
+#ifdef CONFIG_BT_HCIBTUSB_INTEL
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct sk_buff *skb;
-	struct intel_version *ver;
-	struct intel_boot_params *params;
-	const struct firmware *fw;
-	const u8 *fw_ptr;
-	char fwname[64];
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
-	int err;
-
-	BT_DBG("%s", hdev->name);
-
-	calltime = ktime_get();
-
-	/* Read the Intel version information to determine if the device
-	 * is in bootloader mode or if it already has operational firmware
-	 * loaded.
-	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s: Reading Intel version information failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->len != sizeof(*ver)) {
-		BT_ERR("%s: Intel version event size mismatch", hdev->name);
-		kfree_skb(skb);
-		return -EILSEQ;
-	}
-
-	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
-		BT_ERR("%s: Intel version command failure (%02x)",
-		       hdev->name, ver->status);
-		err = -bt_to_errno(ver->status);
-		kfree_skb(skb);
-		return err;
-	}
-
-	/* The hardware platform number has a fixed value of 0x37 and
-	 * for now only accept this single value.
-	 */
-	if (ver->hw_platform != 0x37) {
-		BT_ERR("%s: Unsupported Intel hardware platform (%u)",
-		       hdev->name, ver->hw_platform);
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
-		BT_ERR("%s: Unsupported Intel hardware variant (%u)",
-		       hdev->name, ver->hw_variant);
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
-	btusb_intel_version_info(hdev, ver);
-
-	/* The firmware variant determines if the device is in bootloader
-	 * mode or is running operational firmware. The value 0x06 identifies
-	 * the bootloader and the value 0x23 identifies the operational
-	 * firmware.
-	 *
-	 * When the operational firmware is already present, then only
-	 * the check for valid Bluetooth device address is needed. This
-	 * determines if the device will be added as configured or
-	 * unconfigured controller.
-	 *
-	 * It is not possible to use the Secure Boot Parameters in this
-	 * case since that command is only available in bootloader mode.
-	 */
-	if (ver->fw_variant == 0x23) {
-		kfree_skb(skb);
-		clear_bit(BTINTEL_BOOTLOADER, &data->flags);
-		btintel_check_bdaddr(hdev);
-		return 0;
-	}
-
-	/* If the device is not in bootloader mode, then the only possible
-	 * choice is to return an error and abort the device initialization.
-	 */
-	if (ver->fw_variant != 0x06) {
-		BT_ERR("%s: Unsupported Intel firmware variant (%u)",
-		       hdev->name, ver->fw_variant);
-		kfree_skb(skb);
-		return -ENODEV;
-	}
-
-	kfree_skb(skb);
-
-	/* Read the secure boot parameters to identify the operating
-	 * details of the bootloader.
-	 */
-	skb = __hci_cmd_sync(hdev, 0xfc0d, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s: Reading Intel boot parameters failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->len != sizeof(*params)) {
-		BT_ERR("%s: Intel boot parameters size mismatch", hdev->name);
-		kfree_skb(skb);
-		return -EILSEQ;
-	}
-
-	params = (struct intel_boot_params *)skb->data;
-	if (params->status) {
-		BT_ERR("%s: Intel boot parameters command failure (%02x)",
-		       hdev->name, params->status);
-		err = -bt_to_errno(params->status);
-		kfree_skb(skb);
-		return err;
-	}
-
-	BT_INFO("%s: Device revision is %u", hdev->name,
-		le16_to_cpu(params->dev_revid));
-
-	BT_INFO("%s: Secure boot is %s", hdev->name,
-		params->secure_boot ? "enabled" : "disabled");
-
-	BT_INFO("%s: Minimum firmware build %u week %u %u", hdev->name,
-		params->min_fw_build_nn, params->min_fw_build_cw,
-		2000 + params->min_fw_build_yy);
-
-	/* It is required that every single firmware fragment is acknowledged
-	 * with a command complete event. If the boot parameters indicate
-	 * that this bootloader does not send them, then abort the setup.
-	 */
-	if (params->limited_cce != 0x00) {
-		BT_ERR("%s: Unsupported Intel firmware loading method (%u)",
-		       hdev->name, params->limited_cce);
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
-	/* If the OTP has no valid Bluetooth device address, then there will
-	 * also be no valid address for the operational firmware.
-	 */
-	if (!bacmp(&params->otp_bdaddr, BDADDR_ANY)) {
-		BT_INFO("%s: No device address configured", hdev->name);
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-	}
-
-	/* With this Intel bootloader only the hardware variant and device
-	 * revision information are used to select the right firmware.
-	 *
-	 * Currently this bootloader support is limited to hardware variant
-	 * iBT 3.0 (LnP/SfP) which is identified by the value 11 (0x0b).
-	 */
-	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.sfi",
-		 le16_to_cpu(params->dev_revid));
-
-	err = request_firmware(&fw, fwname, &hdev->dev);
-	if (err < 0) {
-		BT_ERR("%s: Failed to load Intel firmware file (%d)",
-		       hdev->name, err);
-		kfree_skb(skb);
-		return err;
-	}
-
-	BT_INFO("%s: Found device firmware: %s", hdev->name, fwname);
-
-	kfree_skb(skb);
-
-	if (fw->size < 644) {
-		BT_ERR("%s: Invalid size of firmware file (%zu)",
-		       hdev->name, fw->size);
-		err = -EBADF;
-		goto done;
-	}
-
-	set_bit(BTINTEL_DOWNLOADING, &data->flags);
-
-	/* Start the firmware download transaction with the Init fragment
-	 * represented by the 128 bytes of CSS header.
-	 */
-	err = btusb_intel_secure_send(hdev, 0x00, 128, fw->data);
-	if (err < 0) {
-		BT_ERR("%s: Failed to send firmware header (%d)",
-		       hdev->name, err);
-		goto done;
-	}
-
-	/* Send the 256 bytes of public key information from the firmware
-	 * as the PKey fragment.
-	 */
-	err = btusb_intel_secure_send(hdev, 0x03, 256, fw->data + 128);
-	if (err < 0) {
-		BT_ERR("%s: Failed to send firmware public key (%d)",
-		       hdev->name, err);
-		goto done;
-	}
-
-	/* Send the 256 bytes of signature information from the firmware
-	 * as the Sign fragment.
-	 */
-	err = btusb_intel_secure_send(hdev, 0x02, 256, fw->data + 388);
-	if (err < 0) {
-		BT_ERR("%s: Failed to send firmware signature (%d)",
-		       hdev->name, err);
-		goto done;
-	}
-
-	fw_ptr = fw->data + 644;
-
-	while (fw_ptr - fw->data < fw->size) {
-		struct hci_command_hdr *cmd = (void *)fw_ptr;
-		u8 cmd_len;
-
-		cmd_len = sizeof(*cmd) + cmd->plen;
-
-		/* Send each command from the firmware data buffer as
-		 * a single Data fragment.
-		 */
-		err = btusb_intel_secure_send(hdev, 0x01, cmd_len, fw_ptr);
-		if (err < 0) {
-			BT_ERR("%s: Failed to send firmware data (%d)",
-			       hdev->name, err);
-			goto done;
-		}
-
-		fw_ptr += cmd_len;
-	}
-
-	set_bit(BTINTEL_FIRMWARE_LOADED, &data->flags);
-
-	BT_INFO("%s: Waiting for firmware download to complete", hdev->name);
-
-	/* Before switching the device into operational mode and with that
-	 * booting the loaded firmware, wait for the bootloader notification
-	 * that all fragments have been successfully received.
-	 *
-	 * When the event processing receives the notification, then the
-	 * BTUSB_DOWNLOADING flag will be cleared.
-	 *
-	 * The firmware loading should not take longer than 5 seconds
-	 * and thus just timeout if that happens and fail the setup
-	 * of this device.
-	 */
-	err = wait_on_bit_timeout(&data->flags, BTINTEL_DOWNLOADING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(5000));
-	if (err == 1) {
-		BT_ERR("%s: Firmware loading interrupted", hdev->name);
-		err = -EINTR;
-		goto done;
-	}
-
-	if (err) {
-		BT_ERR("%s: Firmware loading timeout", hdev->name);
-		err = -ETIMEDOUT;
-		goto done;
-	}
-
-	if (test_bit(BTINTEL_FIRMWARE_FAILED, &data->flags)) {
-		BT_ERR("%s: Firmware loading failed", hdev->name);
-		err = -ENOEXEC;
-		goto done;
-	}
-
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
-
-	BT_INFO("%s: Firmware loaded in %llu usecs", hdev->name, duration);
-
-done:
-	release_firmware(fw);
-
-	if (err < 0)
-		return err;
-
-	calltime = ktime_get();
-
-	set_bit(BTINTEL_BOOTING, &data->flags);
-
-	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	kfree_skb(skb);
-
-	/* The bootloader will not indicate when the device is ready. This
-	 * is done by the operational firmware sending bootup notification.
-	 *
-	 * Booting into operational firmware should not take longer than
-	 * 1 second. However if that happens, then just fail the setup
-	 * since something went wrong.
-	 */
-	BT_INFO("%s: Waiting for device to boot", hdev->name);
-
-	err = wait_on_bit_timeout(&data->flags, BTINTEL_BOOTING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(1000));
-
-	if (err == 1) {
-		BT_ERR("%s: Device boot interrupted", hdev->name);
-		return -EINTR;
-	}
-
-	if (err) {
-		BT_ERR("%s: Device boot timeout", hdev->name);
-		return -ETIMEDOUT;
-	}
-
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
-
-	BT_INFO("%s: Device booted in %llu usecs", hdev->name, duration);
-
-	clear_bit(BTINTEL_BOOTLOADER, &data->flags);
 
+	return btintel_setup(hdev, &data->flags);
+#else
 	return 0;
+#endif
 }
 
 static int btusb_shutdown_intel(struct hci_dev *hdev)
@@ -2669,7 +2316,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
 		hdev->shutdown = btusb_shutdown_intel;
+#ifdef CONFIG_BT_HCIBTUSB_INTEL
 		hdev->set_bdaddr = btintel_set_bdaddr;
+#endif
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	}
@@ -2677,9 +2326,12 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btusb_setup_intel_new;
+#ifdef CONFIG_BT_HCIBTUSB_INTEL
 		hdev->hw_error = btintel_hw_error;
 		hdev->set_bdaddr = btintel_set_bdaddr;
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+#else
+		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
+#endif
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.1.0

