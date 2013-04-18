Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@intel.com, don.fry@intel.com, tedd.an@intel.com, gustavo@padovan.org
Subject: [PATCH v5] Bluetooth: Add support for Intel Bluetooth device [8087:07dc]
Date: Thu, 18 Apr 2013 11:27:39 -0700
Message-ID: <1657315.CFhxFClec5@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds support for Intel Bluetooth device by adding
btusb_setup_intel() routine that update the device with ROM patch.

T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=07dc Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
v5 changes
 - revised the return case of btusb_setup_intel()
 - updated with proper error code in btusb_setup_intel_patching()
 - removed the unnecessary condition after patching in btusb_setup_intel()
 - removed extra fw_ptr var
 - minor format changes and typo

 drivers/bluetooth/btusb.c |  359 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 359 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3d684d2..2531145 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -23,6 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/firmware.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -47,6 +48,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BROKEN_ISOC	0x20
 #define BTUSB_WRONG_SCO_MTU	0x40
 #define BTUSB_ATH3012		0x80
+#define BTUSB_INTEL		0x100
 
 static struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -207,6 +209,9 @@ static struct usb_device_id blacklist_table[] = {
 	/* Frontline ComProbe Bluetooth Sniffer */
 	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = BTUSB_SNIFFER },
 
+	/* Intel Bluetooth device */
+	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
+
 	{ }	/* Terminating entry */
 };
 
@@ -943,6 +948,357 @@ static int btusb_setup_bcm92035(struct hci_dev *hdev)
 	return 0;
 }
 
+struct intel_version {
+	u8	status;
+	u8	hw_platform;
+	u8	hw_variant;
+	u8	hw_revision;
+	u8	fw_variant;
+	u8	fw_revision;
+	u8	fw_build_num;
+	u8	fw_build_ww;
+	u8	fw_build_yy;
+	u8	fw_patch_num;
+} __packed;
+
+static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
+						struct intel_version *ver)
+{
+	const struct firmware *fw;
+	char fwname[64];
+	int ret;
+
+	snprintf(fwname, sizeof(fwname),
+		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
+		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
+		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
+		 ver->fw_build_ww, ver->fw_build_yy);
+
+	ret = request_firmware(&fw, fwname, &hdev->dev);
+	if (ret < 0) {
+		if (ret == -EINVAL) {
+			BT_ERR("%s Intel firmware file request failed (%d)",
+			       hdev->name, ret);
+			return NULL;
+		}
+
+		BT_ERR("%s failed to open Intel firmware file: %s(%d)",
+		       hdev->name, fwname, ret);
+
+		snprintf(fwname, sizeof(fwname), "intel/ibt-default-%x.%x.bseq",
+			 ver->hw_platform, ver->hw_variant);
+		if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
+			BT_ERR("%s failed to open default Intel fw file: %s",
+			       hdev->name, fwname);
+			return NULL;
+		}
+	}
+
+	BT_INFO("%s: Intel Bluetooth firmware file: %s", hdev->name, fwname);
+
+	return fw;
+}
+
+static int btusb_setup_intel_patching(struct hci_dev *hdev,
+				      const struct firmware *fw,
+				      const u8 **fw_ptr,
+				      int *disable_patch)
+{
+	struct sk_buff *skb;
+	struct hci_command_hdr *cmd;
+	const u8 *cmd_param;
+	struct hci_event_hdr *evt = NULL;
+	const u8 *evt_param = NULL;
+	int remain = fw->size - (*fw_ptr - fw->data);
+
+	/* Read command */
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
+	/* checking the length */
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
+	if (*disable_patch && cmd->opcode == 0xfc8e)
+		*disable_patch = 0;
+
+	cmd_param = *fw_ptr;
+	*fw_ptr += cmd->plen;
+	remain -= cmd->plen;
+
+	/* Read event */
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
+	if (!evt || !evt_param || remain < 0) {
+		BT_ERR("%s Intel fw corrupted: invalid evt read", hdev->name);
+		return -EFAULT;
+	}
+
+	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cmd->opcode),
+				cmd->plen, (void *)cmd_param, evt->evt,
+				HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s sending Intel patch command failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return -PTR_ERR(skb);
+	}
+
+	/* Checking the returned event */
+	if (skb->len != evt->plen) {
+		BT_ERR("%s mismatch event length", hdev->name);
+		kfree_skb(skb);
+		return -EFAULT;
+	}
+
+	if (memcmp(skb->data, evt_param, evt->plen)) {
+		BT_ERR("%s mismatch event parameter", hdev->name);
+		kfree_skb(skb);
+		return -EFAULT;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int btusb_setup_intel(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	int disable_patch;
+	struct intel_version *ver;
+
+	u8 mfg_enable[] = { 0x01, 0x00 };
+	u8 mfg_disable[] = { 0x00, 0x00 };
+	u8 mfg_reset_deactivate[] = { 0x00, 0x01 };
+	u8 mfg_reset_activate[] = { 0x00, 0x02 };
+
+	BT_DBG("%s", hdev->name);
+
+	/* The controller has a bug with the first HCI command sent to it
+	 * returning number of completed commands as zero. This would stall the
+	 * command processing in the Bluetooth core
+	 *
+	 * As a workaround, send HCI Reset command first which will reset the
+	 * number of completed commands and allow normal command processing
+	 * from now on
+	 */
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s sending initial HCI reset command failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return -PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	/* Read Intel specific controller version first to allow selection of
+	 * which firmware file to load.
+	 *
+	 * The returned information are hardware variant and revision plus
+	 * firmware variant, revision and build number.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s reading Intel fw version command failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return -PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		BT_ERR("%s Intel version event length mismatch", hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	ver = (struct intel_version *)skb->data;
+	if (ver->status) {
+		BT_ERR("%s Intel fw version event failed (%02x)", hdev->name,
+		       ver->status);
+		kfree_skb(skb);
+		return -bt_to_errno(ver->status);
+	}
+
+	BT_INFO("%s: read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
+		hdev->name, ver->hw_platform, ver->hw_variant,
+		ver->hw_revision, ver->fw_variant,  ver->fw_revision,
+		ver->fw_build_num, ver->fw_build_ww, ver->fw_build_yy,
+		ver->fw_patch_num);
+
+	/* is the device already patched */
+	if (ver->fw_patch_num) {
+		BT_INFO("%s: Intel device is already patched. patch num: %02x",
+			hdev->name, ver->fw_patch_num);
+		kfree_skb(skb);
+		return 0;
+	}
+
+	/* Opens the firmware patch file based on the firmware version read
+	 * from the controller. If it fails to open the matching firmware
+	 * patch file, it tries to open the default firmware patch file.
+	 * If no patch file is found, allow the device to operate without
+	 * a patch.
+	 */
+	fw = btusb_setup_intel_get_fw(hdev, ver);
+	if (!fw) {
+		kfree_skb(skb);
+		return 0;
+	}
+	fw_ptr = fw->data;
+
+	/* This Intel specific command enables the manufacturer mode of the
+	 * controller.
+	 *
+	 * Only while this mode is enabled, the driver can download the
+	 * firmware patch data and configuration parameters.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_enable, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s entering Intel manufacturer mode failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		release_firmware(fw);
+		return -PTR_ERR(skb);
+	}
+
+	if (skb->data[0]) {
+		u8 evt_status = skb->data[0];
+		BT_ERR("%s enable Intel manufacturer mode event failed (%02x)",
+		       hdev->name, evt_status);
+		kfree_skb(skb);
+		release_firmware(fw);
+		return -bt_to_errno(evt_status);
+	}
+	kfree_skb(skb);
+
+	disable_patch = 1;
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
+	 *
+	 * Once the firmware patching is completed successfully,
+	 * the manufacturer mode is disabled with reset and activating the
+	 * downloaded patch.
+	 *
+	 * If the firmware patching fails, the manufacturer mode is
+	 * disabled with reset and deactivating the patch.
+	 *
+	 * If the default patch file is used, no reset is done when disabling
+	 * the manufacturer.
+	 */
+	while (1) {
+		int ret;
+
+		ret = btusb_setup_intel_patching(hdev, fw, &fw_ptr,
+						 &disable_patch);
+		if (ret < 0)
+			goto exit_mfg_deactivate;
+
+		/* Checking if EOF */
+		if (fw->size == fw_ptr - fw->data) {
+			if (disable_patch)
+				goto exit_mfg_disable;
+			else
+				goto exit_mfg_activate;
+		}
+	}
+
+exit_mfg_activate:
+	release_firmware(fw);
+
+	/* Reset is done when disabling the manufacturer mode and activate
+	 * the downloaded firmware patches
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_reset_activate,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return -PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	BT_INFO("%s: Intel Bluetooth firmware patch completed and activated",
+		hdev->name);
+
+	return 0;
+
+exit_mfg_deactivate:
+	release_firmware(fw);
+
+	/* Reset is done when disabling the manufacturer mode and deactivate
+	 * the downloaded firmware patches.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_reset_deactivate,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return -PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	BT_INFO("%s: Intel Bluetooth firmware patch completed and deactivated",
+		hdev->name);
+
+	return 0;
+
+exit_mfg_disable:
+	release_firmware(fw);
+
+	/* No reset is done when disabling the manufacturer mode */
+	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_disable,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return -PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	BT_INFO("%s: Intel Bluetooth firmware patch completed", hdev->name);
+
+	return 0;
+}
+
 static int btusb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
@@ -1048,6 +1404,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_BCM92035)
 		hdev->setup = btusb_setup_bcm92035;
 
+	if (id->driver_info & BTUSB_INTEL)
+		hdev->setup = btusb_setup_intel;
+
 	/* Interface numbers are hardcoded in the specification */
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
 
-- 
1.7.9.5
