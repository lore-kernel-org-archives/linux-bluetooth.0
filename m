Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Add BCM20702 firmware upgrade support
Message-Id: <20140409043001.27305100A34@puck.mtv.corp.google.com>
Date: Tue,  8 Apr 2014 21:30:01 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After hardware reset, BCM20702 obtains its initial firmware from a PROM chip.
Once this initial firmware is running, the firmware can be further upgraded
over HCI interface with .hcd files provided by Broadcom. This is also known
as "patch RAM" support. This change implements that.

If the .hcd file is not found in /lib/firmware, BCM20702 continues to operate
with the initial firmware. Sample kernel log:
  hotplug: sys=firmware act=add fw=brcm/bcm20702-0a5c-22be.hcd dev=...
  Bluetooth: hci0: BCM20702: patch brcm/bcm20702-0a5c-22be.hcd not found
  Bluetooth: hci0: BCM20702: firmware hci_ver=06 hci_rev=1000 lmp_ver=06 lmp_subver=220e

If the .hcd file is found, btusb driver pushes it to BCM20702, and BCM20702
starts using the new firmware. Sample kernel log:
  hotplug: sys=firmware act=add fw=brcm/bcm20702-0a5c-22be.hcd dev=...
  Bluetooth: hci0: BCM20702: patching hci_ver=06 hci_rev=1000 lmp_ver=06 lmp_subver=220e
  Bluetooth: hci0: BCM20702: firmware hci_ver=06 hci_rev=1389 lmp_ver=06 lmp_subver=220e

Above, we can see that hci_rev goes from 1000 to 1389 as a result of the upgrade.

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 drivers/bluetooth/btusb.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f338b0c..59658a1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -49,6 +49,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_WRONG_SCO_MTU	0x40
 #define BTUSB_ATH3012		0x80
 #define BTUSB_INTEL		0x100
+#define BTUSB_BCM20702_PATCHRAM	0x200
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -103,6 +104,7 @@ static const struct usb_device_id btusb_table[] = {
 	/* Broadcom BCM20702A0 */
 	{ USB_DEVICE(0x0489, 0xe042) },
 	{ USB_DEVICE(0x04ca, 0x2003) },
+	{ USB_DEVICE(0x0a5c, 0x22be), .driver_info = BTUSB_BCM20702_PATCHRAM },
 	{ USB_DEVICE(0x0b05, 0x17b5) },
 	{ USB_DEVICE(0x0b05, 0x17cb) },
 	{ USB_DEVICE(0x413c, 0x8197) },
@@ -1380,6 +1382,156 @@ exit_mfg_deactivate:
 	return 0;
 }
 
+static int btusb_setup_bcm20702(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct usb_device *udev = data->udev;
+	char fw_name[64];
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	size_t fw_size;
+	const struct hci_command_hdr *cmd;
+	const u8 *cmd_param;
+	u16 opcode;
+	struct sk_buff *skb;
+	struct hci_rp_read_local_version *ver;
+	long ret;
+
+	snprintf(fw_name, sizeof(fw_name), "brcm/bcm20702-%04x-%04x.hcd",
+		 le16_to_cpu(udev->descriptor.idVendor),
+		 le16_to_cpu(udev->descriptor.idProduct));
+
+	ret = request_firmware(&fw, fw_name, &hdev->dev);
+	if (ret < 0) {
+		BT_INFO("%s: BCM20702: patch %s not found", hdev->name,
+			fw_name);
+		ret = 0;
+		goto get_fw_ver;
+	}
+
+	/* Reset */
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: HCI_OP_RESET failed (%ld)", hdev->name, ret);
+		goto reset_fw;
+	}
+	kfree_skb(skb);
+
+	/* Read Local Version Info */
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
+			hdev->name, ret);
+		goto reset_fw;
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
+			hdev->name);
+		kfree_skb(skb);
+		ret = -EIO;
+		goto reset_fw;
+	}
+
+	ver = (struct hci_rp_read_local_version *) skb->data;
+	BT_INFO("%s: BCM20702: patching hci_ver=%02x hci_rev=%04x lmp_ver=%02x "
+		"lmp_subver=%04x", hdev->name, ver->hci_ver, ver->hci_rev,
+		ver->lmp_ver, ver->lmp_subver);
+	kfree_skb(skb);
+
+	/* Start Download */
+	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: BCM20702: Download Minidrv command failed (%ld)",
+			hdev->name, ret);
+		goto reset_fw;
+	}
+	kfree_skb(skb);
+
+	/* 50 msec delay after Download Minidrv completes */
+	msleep(50);
+
+	fw_ptr = fw->data;
+	fw_size = fw->size;
+
+	while (fw_size >= sizeof(*cmd)) {
+		cmd = (struct hci_command_hdr *) fw_ptr;
+		fw_ptr += sizeof(*cmd);
+		fw_size -= sizeof(*cmd);
+
+		if (fw_size < cmd->plen) {
+			BT_ERR("%s: BCM20702: patch %s is corrupted",
+				hdev->name, fw_name);
+			ret = -EINVAL;
+			goto reset_fw;
+		}
+
+		cmd_param = fw_ptr;
+		fw_ptr += cmd->plen;
+		fw_size -= cmd->plen;
+
+		opcode = le16_to_cpu(cmd->opcode);
+
+		skb = __hci_cmd_sync(hdev, opcode, cmd->plen, cmd_param,
+				     HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			ret = PTR_ERR(skb);
+			BT_ERR("%s: BCM20702: patch command %04x failed (%ld)",
+				hdev->name, opcode, ret);
+			goto reset_fw;
+		}
+		kfree_skb(skb);
+	}
+
+	/* 250 msec delay after Launch Ram completes */
+	msleep(250);
+
+reset_fw:
+	/* Reset */
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: HCI_OP_RESET failed (%ld)", hdev->name, ret);
+		goto done;
+	}
+	kfree_skb(skb);
+
+get_fw_ver:
+	/* Read Local Version Info */
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
+			hdev->name, ret);
+		goto done;
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
+			hdev->name);
+		kfree_skb(skb);
+		ret = -EIO;
+		goto done;
+	}
+
+	ver = (struct hci_rp_read_local_version *) skb->data;
+	BT_INFO("%s: BCM20702: firmware hci_ver=%02x hci_rev=%04x lmp_ver=%02x "
+		"lmp_subver=%04x", hdev->name, ver->hci_ver, ver->hci_rev,
+		ver->lmp_ver, ver->lmp_subver);
+	kfree_skb(skb);
+
+done:
+	if (fw)
+		release_firmware(fw);
+
+	return ret;
+}
+
 static int btusb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
@@ -1485,6 +1637,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_BCM92035)
 		hdev->setup = btusb_setup_bcm92035;
 
+	if (id->driver_info & BTUSB_BCM20702_PATCHRAM)
+		hdev->setup = btusb_setup_bcm20702;
+
 	if (id->driver_info & BTUSB_INTEL) {
 		usb_enable_autosuspend(data->udev);
 		hdev->setup = btusb_setup_intel;
-- 
1.9.1.423.g4596e3a

