Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: Intel: Introduce btvnd_intel library
Date: Thu, 26 Mar 2015 17:37:43 +0100
Message-Id: <1427387863-2629-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Most Intel Bluetooth controllers use a same set of vendor HCI commands
and procedures regardless of the transport layer (USB, UART, etc).
In order to prevent code duplication, this patch adds common library
for Intel bluetooth drivers.
This is essentially a move of btusb Intel code to btvnd_intel.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/Kconfig       |  10 +
 drivers/bluetooth/Makefile      |   2 +
 drivers/bluetooth/btusb.c       | 638 ++++++----------------------------------
 drivers/bluetooth/btvnd_intel.c | 510 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btvnd_intel.h |  65 ++++
 5 files changed, 675 insertions(+), 550 deletions(-)
 create mode 100644 drivers/bluetooth/btvnd_intel.c
 create mode 100644 drivers/bluetooth/btvnd_intel.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 364f080..2147fe5 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -5,6 +5,7 @@ menu "Bluetooth device drivers"
 config BT_HCIBTUSB
 	tristate "HCI USB driver"
 	depends on USB
+	select BT_VND_INTEL
 	help
 	  Bluetooth HCI USB driver.
 	  This driver is required if you want to use Bluetooth devices with
@@ -244,4 +245,13 @@ config BT_WILINK
 	  Say Y here to compile support for Texas Instrument's WiLink7 driver
 	  into the kernel or say M to compile it as module (btwilink).
 
+config BT_VND_INTEL
+	tristate "Intel HCI vendor support"
+	help
+	  This provides a set of vendor specific HCI operations for Intel based
+	  Bluetooth drivers.
+
+	  Say Y here to compile HCI vendor support for Intel Bluetooth drivers
+	  into the kernel or say M to compile it as module.
+
 endmenu
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 9fe8a87..73aa801 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -20,6 +20,8 @@ obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
 obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
 obj-$(CONFIG_BT_WILINK)		+= btwilink.o
 
+obj-$(CONFIG_BT_VND_INTEL)	+= btvnd_intel.o
+
 btmrvl-y			:= btmrvl_main.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8bfc4c2..f08b3a8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -28,6 +28,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "btvnd_intel.h"
+
 #define VERSION "0.7"
 
 static bool disable_scofix;
@@ -1318,41 +1320,8 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 	return ret;
 }
 
-struct intel_version {
-	u8 status;
-	u8 hw_platform;
-	u8 hw_variant;
-	u8 hw_revision;
-	u8 fw_variant;
-	u8 fw_revision;
-	u8 fw_build_num;
-	u8 fw_build_ww;
-	u8 fw_build_yy;
-	u8 fw_patch_num;
-} __packed;
-
-struct intel_boot_params {
-	__u8     status;
-	__u8     otp_format;
-	__u8     otp_content;
-	__u8     otp_patch;
-	__le16   dev_revid;
-	__u8     secure_boot;
-	__u8     key_from_hdr;
-	__u8     key_type;
-	__u8     otp_lock;
-	__u8     api_lock;
-	__u8     debug_lock;
-	bdaddr_t otp_bdaddr;
-	__u8     min_fw_build_nn;
-	__u8     min_fw_build_cw;
-	__u8     min_fw_build_yy;
-	__u8     limited_cce;
-	__u8     unlocked_state;
-} __packed;
-
 static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
-						       struct intel_version *ver)
+						       struct btvnd_intel_version *ver)
 {
 	const struct firmware *fw;
 	char fwname[64];
@@ -1392,178 +1361,12 @@ static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
 	return fw;
 }
 
-static int btusb_setup_intel_patching(struct hci_dev *hdev,
-				      const struct firmware *fw,
-				      const u8 **fw_ptr, int *disable_patch)
-{
-	struct sk_buff *skb;
-	struct hci_command_hdr *cmd;
-	const u8 *cmd_param;
-	struct hci_event_hdr *evt = NULL;
-	const u8 *evt_param = NULL;
-	int remain = fw->size - (*fw_ptr - fw->data);
-
-	/* The first byte indicates the types of the patch command or event.
-	 * 0x01 means HCI command and 0x02 is HCI event. If the first bytes
-	 * in the current firmware buffer doesn't start with 0x01 or
-	 * the size of remain buffer is smaller than HCI command header,
-	 * the firmware file is corrupted and it should stop the patching
-	 * process.
-	 */
-	if (remain > HCI_COMMAND_HDR_SIZE && *fw_ptr[0] != 0x01) {
-		BT_ERR("%s Intel fw corrupted: invalid cmd read", hdev->name);
-		return -EINVAL;
-	}
-	(*fw_ptr)++;
-	remain--;
-
-	cmd = (struct hci_command_hdr *)(*fw_ptr);
-	*fw_ptr += sizeof(*cmd);
-	remain -= sizeof(*cmd);
-
-	/* Ensure that the remain firmware data is long enough than the length
-	 * of command parameter. If not, the firmware file is corrupted.
-	 */
-	if (remain < cmd->plen) {
-		BT_ERR("%s Intel fw corrupted: invalid cmd len", hdev->name);
-		return -EFAULT;
-	}
-
-	/* If there is a command that loads a patch in the firmware
-	 * file, then enable the patch upon success, otherwise just
-	 * disable the manufacturer mode, for example patch activation
-	 * is not required when the default firmware patch file is used
-	 * because there are no patch data to load.
-	 */
-	if (*disable_patch && le16_to_cpu(cmd->opcode) == 0xfc8e)
-		*disable_patch = 0;
-
-	cmd_param = *fw_ptr;
-	*fw_ptr += cmd->plen;
-	remain -= cmd->plen;
-
-	/* This reads the expected events when the above command is sent to the
-	 * device. Some vendor commands expects more than one events, for
-	 * example command status event followed by vendor specific event.
-	 * For this case, it only keeps the last expected event. so the command
-	 * can be sent with __hci_cmd_sync_ev() which returns the sk_buff of
-	 * last expected event.
-	 */
-	while (remain > HCI_EVENT_HDR_SIZE && *fw_ptr[0] == 0x02) {
-		(*fw_ptr)++;
-		remain--;
-
-		evt = (struct hci_event_hdr *)(*fw_ptr);
-		*fw_ptr += sizeof(*evt);
-		remain -= sizeof(*evt);
-
-		if (remain < evt->plen) {
-			BT_ERR("%s Intel fw corrupted: invalid evt len",
-			       hdev->name);
-			return -EFAULT;
-		}
-
-		evt_param = *fw_ptr;
-		*fw_ptr += evt->plen;
-		remain -= evt->plen;
-	}
-
-	/* Every HCI commands in the firmware file has its correspond event.
-	 * If event is not found or remain is smaller than zero, the firmware
-	 * file is corrupted.
-	 */
-	if (!evt || !evt_param || remain < 0) {
-		BT_ERR("%s Intel fw corrupted: invalid evt read", hdev->name);
-		return -EFAULT;
-	}
-
-	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cmd->opcode), cmd->plen,
-				cmd_param, evt->evt, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s sending Intel patch command (0x%4.4x) failed (%ld)",
-		       hdev->name, cmd->opcode, PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	/* It ensures that the returned event matches the event data read from
-	 * the firmware file. At fist, it checks the length and then
-	 * the contents of the event.
-	 */
-	if (skb->len != evt->plen) {
-		BT_ERR("%s mismatch event length (opcode 0x%4.4x)", hdev->name,
-		       le16_to_cpu(cmd->opcode));
-		kfree_skb(skb);
-		return -EFAULT;
-	}
-
-	if (memcmp(skb->data, evt_param, evt->plen)) {
-		BT_ERR("%s mismatch event parameter (opcode 0x%4.4x)",
-		       hdev->name, le16_to_cpu(cmd->opcode));
-		kfree_skb(skb);
-		return -EFAULT;
-	}
-	kfree_skb(skb);
-
-	return 0;
-}
-
-#define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
-
-static int btusb_check_bdaddr_intel(struct hci_dev *hdev)
-{
-	struct sk_buff *skb;
-	struct hci_rp_read_bd_addr *rp;
-
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s reading Intel device address failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->len != sizeof(*rp)) {
-		BT_ERR("%s Intel device address length mismatch", hdev->name);
-		kfree_skb(skb);
-		return -EIO;
-	}
-
-	rp = (struct hci_rp_read_bd_addr *)skb->data;
-	if (rp->status) {
-		BT_ERR("%s Intel device address result failed (%02x)",
-		       hdev->name, rp->status);
-		kfree_skb(skb);
-		return -bt_to_errno(rp->status);
-	}
-
-	/* For some Intel based controllers, the default Bluetooth device
-	 * address 00:03:19:9E:8B:00 can be found. These controllers are
-	 * fully operational, but have the danger of duplicate addresses
-	 * and that in turn can cause problems with Bluetooth operation.
-	 */
-	if (!bacmp(&rp->bdaddr, BDADDR_INTEL)) {
-		BT_ERR("%s found Intel default device address (%pMR)",
-		       hdev->name, &rp->bdaddr);
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-	}
-
-	kfree_skb(skb);
-
-	return 0;
-}
-
 static int btusb_setup_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	const struct firmware *fw;
-	const u8 *fw_ptr;
-	int disable_patch;
-	struct intel_version *ver;
-
-	const u8 mfg_enable[] = { 0x01, 0x00 };
-	const u8 mfg_disable[] = { 0x00, 0x00 };
-	const u8 mfg_reset_deactivate[] = { 0x00, 0x01 };
-	const u8 mfg_reset_activate[] = { 0x00, 0x02 };
+	struct btvnd_intel_version ver;
+	int err;
 
 	BT_DBG("%s", hdev->name);
 
@@ -1589,42 +1392,24 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * The returned information are hardware variant and revision plus
 	 * firmware variant, revision and build number.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s reading Intel fw version command failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->len != sizeof(*ver)) {
-		BT_ERR("%s Intel version event length mismatch", hdev->name);
-		kfree_skb(skb);
-		return -EIO;
-	}
-
-	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
-		BT_ERR("%s Intel fw version event failed (%02x)", hdev->name,
-		       ver->status);
-		kfree_skb(skb);
-		return -bt_to_errno(ver->status);
-	}
+	err = btvnd_intel_get_version(hdev, &ver);
+	if (err)
+		return err;
 
 	BT_INFO("%s: read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
-		hdev->name, ver->hw_platform, ver->hw_variant,
-		ver->hw_revision, ver->fw_variant,  ver->fw_revision,
-		ver->fw_build_num, ver->fw_build_ww, ver->fw_build_yy,
-		ver->fw_patch_num);
+		hdev->name, ver.hw_platform, ver.hw_variant,
+		ver.hw_revision, ver.fw_variant,  ver.fw_revision,
+		ver.fw_build_num, ver.fw_build_ww, ver.fw_build_yy,
+		ver.fw_patch_num);
 
 	/* fw_patch_num indicates the version of patch the device currently
 	 * have. If there is no patch data in the device, it is always 0x00.
 	 * So, if it is other than 0x00, no need to patch the deivce again.
 	 */
-	if (ver->fw_patch_num) {
+	if (ver.fw_patch_num) {
 		BT_INFO("%s: Intel device is already patched. patch num: %02x",
-			hdev->name, ver->fw_patch_num);
-		kfree_skb(skb);
-		btusb_check_bdaddr_intel(hdev);
+			hdev->name, ver.fw_patch_num);
+		btvnd_intel_check_bdaddr(hdev);
 		return 0;
 	}
 
@@ -1634,13 +1419,12 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * If no patch file is found, allow the device to operate without
 	 * a patch.
 	 */
-	fw = btusb_setup_intel_get_fw(hdev, ver);
+	fw = btusb_setup_intel_get_fw(hdev, &ver);
 	if (!fw) {
 		kfree_skb(skb);
-		btusb_check_bdaddr_intel(hdev);
+		btvnd_intel_check_bdaddr(hdev);
 		return 0;
 	}
-	fw_ptr = fw->data;
 
 	/* This Intel specific command enables the manufacturer mode of the
 	 * controller.
@@ -1648,93 +1432,62 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * Only while this mode is enabled, the driver can download the
 	 * firmware patch data and configuration parameters.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_enable, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s entering Intel manufacturer mode failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		release_firmware(fw);
-		return PTR_ERR(skb);
-	}
-
-	if (skb->data[0]) {
-		u8 evt_status = skb->data[0];
-
-		BT_ERR("%s enable Intel manufacturer mode event failed (%02x)",
-		       hdev->name, evt_status);
-		kfree_skb(skb);
-		release_firmware(fw);
-		return -bt_to_errno(evt_status);
+	err = btvnd_intel_mfg(hdev, INTEL_MFG_ENABLE);
+	if (err) {
+		BT_ERR("%s entering Intel manufacturer mode failed (%d)",
+		       hdev->name, err);
+		return err;
 	}
-	kfree_skb(skb);
 
-	disable_patch = 1;
 
-	/* The firmware data file consists of list of Intel specific HCI
-	 * commands and its expected events. The first byte indicates the
-	 * type of the message, either HCI command or HCI event.
-	 *
-	 * It reads the command and its expected event from the firmware file,
-	 * and send to the controller. Once __hci_cmd_sync_ev() returns,
-	 * the returned event is compared with the event read from the firmware
-	 * file and it will continue until all the messages are downloaded to
-	 * the controller.
-	 *
-	 * Once the firmware patching is completed successfully,
+	/* Once the firmware patching is completed successfully (return 0),
 	 * the manufacturer mode is disabled with reset and activating the
 	 * downloaded patch.
 	 *
-	 * If the firmware patching fails, the manufacturer mode is
-	 * disabled with reset and deactivating the patch.
+	 * If the firmware patching fails (return < 0), the manufacturer mode
+	 * is disabled with reset and deactivating the patch.
 	 *
-	 * If the default patch file is used, no reset is done when disabling
-	 * the manufacturer.
+	 * If the default patch file is used (return > 0), no reset is done
+	 * when disabling the manufacturer.
 	 */
-	while (fw->size > fw_ptr - fw->data) {
-		int ret;
-
-		ret = btusb_setup_intel_patching(hdev, fw, &fw_ptr,
-						 &disable_patch);
-		if (ret < 0)
-			goto exit_mfg_deactivate;
-	}
+	err = btvnd_intel_patch_bseq(hdev, fw);
+	if (err < 0)
+		goto exit_mfg_deactivate;
+	else if (err > 0)
+		goto exit_mfg_disable;
 
 	release_firmware(fw);
 
-	if (disable_patch)
-		goto exit_mfg_disable;
-
 	/* Patching completed successfully and disable the manufacturer mode
 	 * with reset and activate the downloaded firmware patches.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_reset_activate),
-			     mfg_reset_activate, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
+	err = btvnd_intel_mfg(hdev, INTEL_MFG_RESET_ACTIVATE);
+	if (err) {
+		BT_ERR("%s exiting Intel manufacturer mode failed (%d)",
+		       hdev->name, err);
+		return err;
 	}
-	kfree_skb(skb);
 
 	BT_INFO("%s: Intel Bluetooth firmware patch completed and activated",
 		hdev->name);
 
-	btusb_check_bdaddr_intel(hdev);
+	btvnd_intel_check_bdaddr(hdev);
 	return 0;
 
 exit_mfg_disable:
+	release_firmware(fw);
+
 	/* Disable the manufacturer mode without reset */
-	skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_disable), mfg_disable,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
+	err = btvnd_intel_mfg(hdev, INTEL_MFG_DISABLE);
+	if (err) {
+		BT_ERR("%s exiting Intel manufacturer mode failed (%d)",
+		       hdev->name, err);
+		return err;
 	}
-	kfree_skb(skb);
 
 	BT_INFO("%s: Intel Bluetooth firmware patch completed", hdev->name);
 
-	btusb_check_bdaddr_intel(hdev);
+	btvnd_intel_check_bdaddr(hdev);
 	return 0;
 
 exit_mfg_deactivate:
@@ -1743,19 +1496,17 @@ exit_mfg_deactivate:
 	/* Patching failed. Disable the manufacturer mode with reset and
 	 * deactivate the downloaded firmware patches.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_reset_deactivate),
-			     mfg_reset_deactivate, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
+	err = btvnd_intel_mfg(hdev, INTEL_MFG_RESET_DEACTIVATE);
+	if (err) {
+		BT_ERR("%s exiting Intel manufacturer mode failed (%d)",
+		       hdev->name, err);
+		return err;
 	}
-	kfree_skb(skb);
 
 	BT_INFO("%s: Intel Bluetooth firmware patch completed and deactivated",
 		hdev->name);
 
-	btusb_check_bdaddr_intel(hdev);
+	btvnd_intel_check_bdaddr(hdev);
 	return 0;
 }
 
@@ -1901,61 +1652,12 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
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
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct sk_buff *skb;
-	struct intel_version *ver;
-	struct intel_boot_params *params;
+	struct btvnd_intel_version ver;
+	struct btvnd_intel_boot_params params;
 	const struct firmware *fw;
-	const u8 *fw_ptr;
 	char fwname[64];
 	ktime_t calltime, delta, rettime;
 	unsigned long long duration;
@@ -1969,35 +1671,16 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
 	 */
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
+	err = btvnd_intel_get_version(hdev, &ver);
+	if (err)
 		return err;
-	}
 
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
 	 */
-	if (ver->hw_platform != 0x37) {
+	if (ver.hw_platform != 0x37) {
 		BT_ERR("%s: Unsupported Intel hardware platform (%u)",
-		       hdev->name, ver->hw_platform);
-		kfree_skb(skb);
+		       hdev->name, ver.hw_platform);
 		return -EINVAL;
 	}
 
@@ -2006,14 +1689,13 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * put in place to ensure correct forward compatibility options
 	 * when newer hardware variants come along.
 	 */
-	if (ver->hw_variant != 0x0b) {
+	if (ver.hw_variant != 0x0b) {
 		BT_ERR("%s: Unsupported Intel hardware variant (%u)",
-		       hdev->name, ver->hw_variant);
-		kfree_skb(skb);
+		       hdev->name, ver.hw_variant);
 		return -EINVAL;
 	}
 
-	btusb_intel_version_info(hdev, ver);
+	btvnd_intel_version_info(hdev, &ver);
 
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
@@ -2028,75 +1710,52 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * It is not possible to use the Secure Boot Parameters in this
 	 * case since that command is only available in bootloader mode.
 	 */
-	if (ver->fw_variant == 0x23) {
-		kfree_skb(skb);
+	if (ver.fw_variant == 0x23) {
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
-		btusb_check_bdaddr_intel(hdev);
+		btvnd_intel_check_bdaddr(hdev);
 		return 0;
 	}
 
 	/* If the device is not in bootloader mode, then the only possible
 	 * choice is to return an error and abort the device initialization.
 	 */
-	if (ver->fw_variant != 0x06) {
+	if (ver.fw_variant != 0x06) {
 		BT_ERR("%s: Unsupported Intel firmware variant (%u)",
-		       hdev->name, ver->fw_variant);
-		kfree_skb(skb);
+		       hdev->name, ver.fw_variant);
 		return -ENODEV;
 	}
 
-	kfree_skb(skb);
-
 	/* Read the secure boot parameters to identify the operating
 	 * details of the bootloader.
 	 */
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
+	err = btvnd_intel_get_boot_params(hdev, &params);
+	if (err)
 		return err;
-	}
 
 	BT_INFO("%s: Device revision is %u", hdev->name,
-		le16_to_cpu(params->dev_revid));
+		le16_to_cpu(params.dev_revid));
 
 	BT_INFO("%s: Secure boot is %s", hdev->name,
-		params->secure_boot ? "enabled" : "disabled");
+		params.secure_boot ? "enabled" : "disabled");
 
 	BT_INFO("%s: Minimum firmware build %u week %u %u", hdev->name,
-		params->min_fw_build_nn, params->min_fw_build_cw,
-		2000 + params->min_fw_build_yy);
+		params.min_fw_build_nn, params.min_fw_build_cw,
+		2000 + params.min_fw_build_yy);
 
 	/* It is required that every single firmware fragment is acknowledged
 	 * with a command complete event. If the boot parameters indicate
 	 * that this bootloader does not send them, then abort the setup.
 	 */
-	if (params->limited_cce != 0x00) {
+	if (params.limited_cce != 0x00) {
 		BT_ERR("%s: Unsupported Intel firmware loading method (%u)",
-		       hdev->name, params->limited_cce);
-		kfree_skb(skb);
+		       hdev->name, params.limited_cce);
 		return -EINVAL;
 	}
 
 	/* If the OTP has no valid Bluetooth device address, then there will
 	 * also be no valid address for the operational firmware.
 	 */
-	if (!bacmp(&params->otp_bdaddr, BDADDR_ANY)) {
+	if (!bacmp(&params.otp_bdaddr, BDADDR_ANY)) {
 		BT_INFO("%s: No device address configured", hdev->name);
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
 	}
@@ -2108,79 +1767,22 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * iBT 3.0 (LnP/SfP) which is identified by the value 11 (0x0b).
 	 */
 	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.sfi",
-		 le16_to_cpu(params->dev_revid));
+		 le16_to_cpu(params.dev_revid));
 
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err < 0) {
 		BT_ERR("%s: Failed to load Intel firmware file (%d)",
 		       hdev->name, err);
-		kfree_skb(skb);
 		return err;
 	}
 
 	BT_INFO("%s: Found device firmware: %s", hdev->name, fwname);
 
-	kfree_skb(skb);
-
-	if (fw->size < 644) {
-		BT_ERR("%s: Invalid size of firmware file (%zu)",
-		       hdev->name, fw->size);
-		err = -EBADF;
-		goto done;
-	}
-
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
-	/* Start the firmware download transaction with the Init fragment
-	 * represented by the 128 bytes of CSS header.
-	 */
-	err = btusb_intel_secure_send(hdev, 0x00, 128, fw->data);
-	if (err < 0) {
-		BT_ERR("%s: Failed to send firmware header (%d)",
-		       hdev->name, err);
+	err = btvnd_intel_patch_sfi(hdev, fw);
+	if (err)
 		goto done;
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
 
 	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
 
@@ -2224,22 +1826,11 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	BT_INFO("%s: Firmware loaded in %llu usecs", hdev->name, duration);
 
-done:
-	release_firmware(fw);
-
-	if (err < 0)
-		return err;
-
 	calltime = ktime_get();
 
 	set_bit(BTUSB_BOOTING, &data->flags);
 
-	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	kfree_skb(skb);
+	btvnd_intel_reset(hdev);
 
 	/* The bootloader will not indicate when the device is ready. This
 	 * is done by the operational firmware sending bootup notification.
@@ -2256,14 +1847,18 @@ done:
 
 	if (err == 1) {
 		BT_ERR("%s: Device boot interrupted", hdev->name);
-		return -EINTR;
+		err = -EINTR;
+		goto done;
 	}
 
 	if (err) {
 		BT_ERR("%s: Device boot timeout", hdev->name);
-		return -ETIMEDOUT;
+		err = -ETIMEDOUT;
 	}
 
+done:
+	release_firmware(fw);
+
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
 	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
@@ -2272,64 +1867,7 @@ done:
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
-	return 0;
-}
-
-static void btusb_hw_error_intel(struct hci_dev *hdev, u8 code)
-{
-	struct sk_buff *skb;
-	u8 type = 0x00;
-
-	BT_ERR("%s: Hardware error 0x%2.2x", hdev->name, code);
-
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s: Reset after hardware error failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return;
-	}
-	kfree_skb(skb);
-
-	skb = __hci_cmd_sync(hdev, 0xfc22, 1, &type, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s: Retrieving Intel exception info failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return;
-	}
-
-	if (skb->len != 13) {
-		BT_ERR("%s: Exception info size mismatch", hdev->name);
-		kfree_skb(skb);
-		return;
-	}
-
-	if (skb->data[0] != 0x00) {
-		BT_ERR("%s: Exception info command failure (%02x)",
-		       hdev->name, skb->data[0]);
-		kfree_skb(skb);
-		return;
-	}
-
-	BT_ERR("%s: Exception info %s", hdev->name, (char *)(skb->data + 1));
-
-	kfree_skb(skb);
-}
-
-static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
-{
-	struct sk_buff *skb;
-	long ret;
-
-	skb = __hci_cmd_sync(hdev, 0xfc31, 6, bdaddr, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		BT_ERR("%s: changing Intel device address failed (%ld)",
-		       hdev->name, ret);
-		return ret;
-	}
-	kfree_skb(skb);
-
-	return 0;
+	return err;
 }
 
 static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
@@ -2709,15 +2247,15 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
-		hdev->set_bdaddr = btusb_set_bdaddr_intel;
+		hdev->set_bdaddr = btvnd_intel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btusb_setup_intel_new;
-		hdev->hw_error = btusb_hw_error_intel;
-		hdev->set_bdaddr = btusb_set_bdaddr_intel;
+		hdev->hw_error = btvnd_intel_hw_error;
+		hdev->set_bdaddr = btvnd_intel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
diff --git a/drivers/bluetooth/btvnd_intel.c b/drivers/bluetooth/btvnd_intel.c
new file mode 100644
index 0000000..b8320c5
--- /dev/null
+++ b/drivers/bluetooth/btvnd_intel.c
@@ -0,0 +1,510 @@
+/*
+ *  Intel Bluetooth vendor functions
+ *
+ *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2015, Intel Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+#include <linux/firmware.h>
+#include <linux/module.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btvnd_intel.h"
+
+static int btvnd_intel_secure_send(struct hci_dev *hdev, u8 fragment_type,
+				   u32 plen, const void *param)
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
+int btvnd_intel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc31, 6, bdaddr, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: changing Intel device address failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btvnd_intel_set_bdaddr);
+
+int btvnd_intel_get_version(struct hci_dev *hdev,
+			    struct btvnd_intel_version *ver)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s reading Intel fw version command failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		BT_ERR("%s Intel version event length mismatch", hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	memcpy(ver, skb->data, sizeof(*ver));
+
+	kfree_skb(skb);
+
+	if (ver->status) {
+		BT_ERR("%s Intel fw version event failed (%02x)", hdev->name,
+		       ver->status);
+		return -bt_to_errno(ver->status);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btvnd_intel_get_version);
+
+void btvnd_intel_version_info(struct hci_dev *hdev,
+			      struct btvnd_intel_version *ver)
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
+EXPORT_SYMBOL_GPL(btvnd_intel_version_info);
+
+int btvnd_intel_get_boot_params(struct hci_dev *hdev,
+				struct btvnd_intel_boot_params *params)
+{
+	struct sk_buff *skb;
+
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
+	memcpy(params, skb->data, sizeof(*params));
+
+	kfree_skb(skb);
+
+	if (params->status) {
+		BT_ERR("%s: Intel boot parameters command failure (%02x)",
+		       hdev->name, params->status);
+		return -bt_to_errno(params->status);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btvnd_intel_get_boot_params);
+
+int btvnd_intel_patch_sfi(struct hci_dev *hdev, const struct firmware *fw)
+{
+	const u8 *fw_ptr;
+	int err;
+
+	if (fw->size < 644) {
+		BT_ERR("%s: Invalid size of firmware file (%zu)",
+		       hdev->name, fw->size);
+		return -EBADF;
+	}
+
+	/* Start the firmware download transaction with the Init fragment
+	 * represented by the 128 bytes of CSS header.
+	 */
+	err = btvnd_intel_secure_send(hdev, 0x00, 128, fw->data);
+	if (err < 0) {
+		BT_ERR("%s: Failed to send firmware header (%d)",
+		       hdev->name, err);
+		return err;
+	}
+
+	/* Send the 256 bytes of public key information from the firmware
+	 * as the PKey fragment.
+	 */
+	err = btvnd_intel_secure_send(hdev, 0x03, 256, fw->data + 128);
+	if (err < 0) {
+		BT_ERR("%s: Failed to send firmware public key (%d)",
+		       hdev->name, err);
+		return err;
+	}
+
+	/* Send the 256 bytes of signature information from the firmware
+	 * as the Sign fragment.
+	 */
+	err = btvnd_intel_secure_send(hdev, 0x02, 256, fw->data + 388);
+	if (err < 0) {
+		BT_ERR("%s: Failed to send firmware signature (%d)",
+		       hdev->name, err);
+		return err;
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
+		err = btvnd_intel_secure_send(hdev, 0x01, cmd_len, fw_ptr);
+		if (err < 0) {
+			BT_ERR("%s: Failed to send firmware data (%d)",
+			       hdev->name, err);
+			return err;
+		}
+
+		fw_ptr += cmd_len;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btvnd_intel_patch_sfi);
+
+int btvnd_intel_reset(struct hci_dev *hdev)
+{
+	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
+					  0x00, 0x08, 0x04, 0x00 };
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btvnd_intel_reset);
+
+#define BDADDR_INTEL (&(bdaddr_t) { {0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00} })
+int btvnd_intel_check_bdaddr(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct hci_rp_read_bd_addr *rp;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s reading Intel device address failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*rp)) {
+		BT_ERR("%s Intel device address length mismatch", hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	rp = (struct hci_rp_read_bd_addr *)skb->data;
+	if (rp->status) {
+		BT_ERR("%s Intel device address result failed (%02x)",
+		       hdev->name, rp->status);
+		kfree_skb(skb);
+		return -bt_to_errno(rp->status);
+	}
+
+	/* For some Intel based controllers, the default Bluetooth device
+	 * address 00:03:19:9E:8B:00 can be found. These controllers are
+	 * fully operational, but have the danger of duplicate addresses
+	 * and that in turn can cause problems with Bluetooth operation.
+	 */
+	if (!bacmp(&rp->bdaddr, BDADDR_INTEL)) {
+		BT_ERR("%s found Intel default device address (%pMR)",
+		       hdev->name, &rp->bdaddr);
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btvnd_intel_check_bdaddr);
+
+void btvnd_intel_hw_error(struct hci_dev *hdev, u8 code)
+{
+	struct sk_buff *skb;
+	u8 type = 0x00;
+
+	BT_ERR("%s: Hardware error 0x%2.2x", hdev->name, code);
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Reset after hardware error failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return;
+	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc22, 1, &type, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Retrieving Intel exception info failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return;
+	}
+
+	if (skb->len != 13) {
+		BT_ERR("%s: Exception info size mismatch", hdev->name);
+		kfree_skb(skb);
+		return;
+	}
+
+	if (skb->data[0] != 0x00) {
+		BT_ERR("%s: Exception info command failure (%02x)",
+		       hdev->name, skb->data[0]);
+		kfree_skb(skb);
+		return;
+	}
+
+	BT_ERR("%s: Exception info %s", hdev->name, (char *)(skb->data + 1));
+
+	kfree_skb(skb);
+}
+EXPORT_SYMBOL_GPL(btvnd_intel_hw_error);
+
+int btvnd_intel_mfg(struct hci_dev *hdev, int state)
+{
+	struct sk_buff *skb = NULL;
+	const u8 enable[] = { 0x01, 0x00 };
+	const u8 disable[] = { 0x00, 0x00 };
+	const u8 reset_deactivate[] = { 0x00, 0x01 };
+	const u8 reset_activate[] = { 0x00, 0x02 };
+
+	switch (state) {
+	case INTEL_MFG_ENABLE:
+		skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(enable),
+				     enable, HCI_INIT_TIMEOUT);
+		break;
+	case INTEL_MFG_DISABLE:
+		skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(disable),
+				     disable, HCI_INIT_TIMEOUT);
+		break;
+	case INTEL_MFG_RESET_ACTIVATE:
+		skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(reset_activate),
+				     reset_activate, HCI_INIT_TIMEOUT);
+		break;
+	case INTEL_MFG_RESET_DEACTIVATE:
+		skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(reset_deactivate),
+				     reset_deactivate, HCI_INIT_TIMEOUT);
+		break;
+	}
+
+	if (IS_ERR(skb)) {
+		BT_ERR("%s Changing Intel manufacturer mode failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->data[0]) {
+		u8 evt_status = skb->data[0];
+
+		BT_ERR("%s Intel manufacturer mode event failed (%02x)",
+		       hdev->name, evt_status);
+		kfree_skb(skb);
+		return -bt_to_errno(evt_status);
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btvnd_intel_mfg);
+
+static int __btvnd_intel_patch_bseq(struct hci_dev *hdev,
+				    const struct firmware *fw,
+				    const u8 **fw_ptr, int *disable_patch)
+{
+	struct sk_buff *skb;
+	struct hci_command_hdr *cmd;
+	const u8 *cmd_param;
+	struct hci_event_hdr *evt = NULL;
+	const u8 *evt_param = NULL;
+	int remain = fw->size - (*fw_ptr - fw->data);
+
+	/* The first byte indicates the types of the patch command or event.
+	 * 0x01 means HCI command and 0x02 is HCI event. If the first bytes
+	 * in the current firmware buffer doesn't start with 0x01 or
+	 * the size of remain buffer is smaller than HCI command header,
+	 * the firmware file is corrupted and it should stop the patching
+	 * process.
+	 */
+	if (remain > HCI_COMMAND_HDR_SIZE && *fw_ptr[0] != 0x01) {
+		BT_ERR("%s Intel fw corrupted: invalid cmd read", hdev->name);
+		return -EINVAL;
+	}
+	(*fw_ptr)++;
+	remain--;
+
+	cmd = (struct hci_command_hdr *)(*fw_ptr);
+	*fw_ptr += sizeof(*cmd);
+	remain -= sizeof(*cmd);
+
+	/* Ensure that the remain firmware data is long enough than the length
+	 * of command parameter. If not, the firmware file is corrupted.
+	 */
+	if (remain < cmd->plen) {
+		BT_ERR("%s Intel fw corrupted: invalid cmd len", hdev->name);
+		return -EFAULT;
+	}
+
+	/* If there is a command that loads a patch in the firmware
+	 * file, then enable the patch upon success, otherwise just
+	 * disable the manufacturer mode, for example patch activation
+	 * is not required when the default firmware patch file is used
+	 * because there are no patch data to load.
+	 */
+	if (*disable_patch && le16_to_cpu(cmd->opcode) == 0xfc8e)
+		*disable_patch = 0;
+
+	cmd_param = *fw_ptr;
+	*fw_ptr += cmd->plen;
+	remain -= cmd->plen;
+
+	/* This reads the expected events when the above command is sent to the
+	 * device. Some vendor commands expects more than one events, for
+	 * example command status event followed by vendor specific event.
+	 * For this case, it only keeps the last expected event. so the command
+	 * can be sent with __hci_cmd_sync_ev() which returns the sk_buff of
+	 * last expected event.
+	 */
+	while (remain > HCI_EVENT_HDR_SIZE && *fw_ptr[0] == 0x02) {
+		(*fw_ptr)++;
+		remain--;
+
+		evt = (struct hci_event_hdr *)(*fw_ptr);
+		*fw_ptr += sizeof(*evt);
+		remain -= sizeof(*evt);
+
+		if (remain < evt->plen) {
+			BT_ERR("%s Intel fw corrupted: invalid evt len",
+			       hdev->name);
+			return -EFAULT;
+		}
+
+		evt_param = *fw_ptr;
+		*fw_ptr += evt->plen;
+		remain -= evt->plen;
+	}
+
+	/* Every HCI commands in the firmware file has its correspond event.
+	 * If event is not found or remain is smaller than zero, the firmware
+	 * file is corrupted.
+	 */
+	if (!evt || !evt_param || remain < 0) {
+		BT_ERR("%s Intel fw corrupted: invalid evt read", hdev->name);
+		return -EFAULT;
+	}
+
+	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cmd->opcode), cmd->plen,
+				cmd_param, evt->evt, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s sending Intel patch command (0x%4.4x) failed (%ld)",
+		       hdev->name, cmd->opcode, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	/* It ensures that the returned event matches the event data read from
+	 * the firmware file. At fist, it checks the length and then
+	 * the contents of the event.
+	 */
+	if (skb->len != evt->plen) {
+		BT_ERR("%s mismatch event length (opcode 0x%4.4x)", hdev->name,
+		       le16_to_cpu(cmd->opcode));
+		kfree_skb(skb);
+		return -EFAULT;
+	}
+
+	if (memcmp(skb->data, evt_param, evt->plen)) {
+		BT_ERR("%s mismatch event parameter (opcode 0x%4.4x)",
+		       hdev->name, le16_to_cpu(cmd->opcode));
+		kfree_skb(skb);
+		return -EFAULT;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
+int btvnd_intel_patch_bseq(struct hci_dev *hdev, const struct firmware *fw)
+{
+	const u8 *fw_ptr = fw->data;
+	int disable_patch = 1;
+
+	/* The firmware data file consists of list of Intel specific HCI
+	 * commands and its expected events. The first byte indicates the
+	 * type of the message, either HCI command or HCI event.
+	 *
+	 * It reads the command and its expected event from the firmware file,
+	 * and send to the controller. Once __hci_cmd_sync_ev() returns,
+	 * the returned event is compared with the event read from the firmware
+	 * file and it will continue until all the messages are downloaded to
+	 * the controller.
+	 */
+
+	while (fw->size > fw_ptr - fw->data) {
+		int ret;
+
+		ret = __btvnd_intel_patch_bseq(hdev, fw, &fw_ptr,
+					       &disable_patch);
+		if (ret < 0)
+			return ret;
+	}
+
+	return disable_patch;
+}
+EXPORT_SYMBOL_GPL(btvnd_intel_patch_bseq);
+
+MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
+MODULE_DESCRIPTION("Intel Bluetooth vendor functions");
+MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btvnd_intel.h b/drivers/bluetooth/btvnd_intel.h
new file mode 100644
index 0000000..56c6d6c
--- /dev/null
+++ b/drivers/bluetooth/btvnd_intel.h
@@ -0,0 +1,65 @@
+/*
+ *  Intel Bluetooth vendor functions
+ *
+ *  Copyright (C) 2015, Intel Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+struct btvnd_intel_version {
+	u8 status;
+	u8 hw_platform;
+	u8 hw_variant;
+	u8 hw_revision;
+	u8 fw_variant;
+	u8 fw_revision;
+	u8 fw_build_num;
+	u8 fw_build_ww;
+	u8 fw_build_yy;
+	u8 fw_patch_num;
+} __packed;
+
+struct btvnd_intel_boot_params {
+	__u8     status;
+	__u8     otp_format;
+	__u8     otp_content;
+	__u8     otp_patch;
+	__le16   dev_revid;
+	__u8     secure_boot;
+	__u8     key_from_hdr;
+	__u8     key_type;
+	__u8     otp_lock;
+	__u8     api_lock;
+	__u8     debug_lock;
+	bdaddr_t otp_bdaddr;
+	__u8     min_fw_build_nn;
+	__u8     min_fw_build_cw;
+	__u8     min_fw_build_yy;
+	__u8     limited_cce;
+	__u8     unlocked_state;
+} __packed;
+
+enum {
+	INTEL_MFG_ENABLE,
+	INTEL_MFG_DISABLE,
+	INTEL_MFG_RESET_ACTIVATE,
+	INTEL_MFG_RESET_DEACTIVATE,
+};
+
+int btvnd_intel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+int btvnd_intel_get_version(struct hci_dev *hdev,
+			    struct btvnd_intel_version *ver);
+void btvnd_intel_version_info(struct hci_dev *hdev,
+			      struct btvnd_intel_version *ver);
+int btvnd_intel_get_boot_params(struct hci_dev *hdev,
+				struct btvnd_intel_boot_params *params);
+int btvnd_intel_patch_sfi(struct hci_dev *hdev, const struct firmware *fw);
+int btvnd_intel_reset(struct hci_dev *hdev);
+int btvnd_intel_check_bdaddr(struct hci_dev *hdev);
+void btvnd_intel_hw_error(struct hci_dev *hdev, u8 code);
+
+int btvnd_intel_mfg(struct hci_dev *hdev, int state);
+int btvnd_intel_patch_bseq(struct hci_dev *hdev, const struct firmware *fw);
-- 
1.9.1
