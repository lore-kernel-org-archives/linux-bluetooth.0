Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: don.fry@intel.com, marcel@holtmann.org, johan.hedberg@intel.com
Subject: [PATCH] Bluetooth: Add Intel Bluetooth Bootloader driver
Date: Fri, 23 Aug 2013 09:21:28 -0700
Message-ID: <1979791.SXvDHP8xUh@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds Intel Bluetooth Bootloader driver for Intel BT device.

It downloads the full FW image file from firmware/intel to the device.
Once downloading is done successfully, the device reset and bootup as
Bluetooth class device.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
Tested-by: Don Fry <don.fry@intel.com>
---
 drivers/bluetooth/Kconfig    |   13 ++
 drivers/bluetooth/Makefile   |    1 +
 drivers/bluetooth/intel_bl.c |  370 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 384 insertions(+)
 create mode 100644 drivers/bluetooth/intel_bl.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index fdfd61a..060dd10 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -242,4 +242,17 @@ config BT_WILINK
 
 	  Say Y here to compile support for Texas Instrument's WiLink7 driver
 	  into the kernel or say M to compile it as module.
+
+config BT_INTEL_BL
+	tristate "Intel firmware download driver"
+	depends on USB
+	select FW_LOADER
+	help
+	  Intel Bluetooth firmware download driver.
+	  This driver loads the full firmware into the Intel Bluetooth
+	  chipset.
+
+	  Say Y here to compile support for "Intel firmware download driver"
+	  into the kernel or say M to compile it as module.
+
 endmenu
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 4afae20..edfcdb5 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_BT_ATH3K)		+= ath3k.o
 obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
 obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
 obj-$(CONFIG_BT_WILINK)		+= btwilink.o
+obj-$(CONFIG_BT_INTEL_BL)	+= intel_bl.o
 
 btmrvl-y			:= btmrvl_main.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
diff --git a/drivers/bluetooth/intel_bl.c b/drivers/bluetooth/intel_bl.c
new file mode 100644
index 0000000..4c8296b
--- /dev/null
+++ b/drivers/bluetooth/intel_bl.c
@@ -0,0 +1,387 @@
+/*
+ *
+ *  Intel Bluetooth BootLoader driver
+ *
+ *  Copyright (C) 2012  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/usb.h>
+#include <linux/firmware.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#define VERSION		"1.0"
+
+static struct usb_driver intel_bl_driver;
+
+static const struct usb_device_id intel_bl_table[] = {
+	/* Intel Bluetooth USB BootLoader(RAM module) */
+	{ USB_DEVICE(0x8087, 0x0A5A) },
+
+	{ }	/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(usb, intel_bl_table);
+
+#define MAX_DATA_SIZE	260
+
+#define CMD_TIMEOUT		msecs_to_jiffies(2000)	/* 2 seconds */
+
+struct intel_version {
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
+struct intel_bl_data {
+	struct usb_device	*udev;
+
+	u8			evt_buff[MAX_DATA_SIZE];
+	int			evt_len;
+
+	struct work_struct	work;
+	atomic_t		shutdown;
+};
+
+static int intel_bl_send_cmd_sync(struct intel_bl_data *data,
+				  const u8 *cmd_buff, int cmd_len, u32 timeout)
+{
+	u8 *buff;
+	int err;
+
+	BT_DBG("send cmd len %d", cmd_len);
+
+	buff = kmalloc(cmd_len, GFP_KERNEL);
+	if (!buff)
+		return -ENOMEM;
+
+	memcpy(buff, cmd_buff, cmd_len);
+
+	err = usb_control_msg(data->udev, usb_sndctrlpipe(data->udev, 0x00),
+			      0, USB_TYPE_CLASS, 0, 0,
+			      buff, cmd_len, USB_CTRL_SET_TIMEOUT);
+	if (err < 0) {
+		BT_ERR("failed to send control message (%d)", err);
+		goto exit_error;
+	}
+
+	err = usb_interrupt_msg(data->udev, usb_rcvintpipe(data->udev, 0x81),
+				data->evt_buff, MAX_DATA_SIZE, &data->evt_len,
+				5000);
+	if (err < 0) {
+		BT_ERR("failed to receive interrupt message (%d)", err);
+		goto exit_error;
+	}
+
+	BT_DBG("received event(%d): %02x %02x %02x %02x %02x %02x",
+	       data->evt_len, data->evt_buff[0], data->evt_buff[1],
+	       data->evt_buff[2], data->evt_buff[3], data->evt_buff[4],
+	       data->evt_buff[5]);
+
+exit_error:
+	kfree(buff);
+
+	return err;
+}
+
+static const struct firmware *intel_bl_get_fw(struct intel_bl_data *data,
+					      struct intel_version *ver)
+{
+	const struct firmware *fw;
+	char fwname[64];
+	int err;
+
+	snprintf(fwname, sizeof(fwname),
+		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
+		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
+		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
+		 ver->fw_build_ww, ver->fw_build_yy);
+
+	BT_INFO("Intel Bluetooth firmware file: %s", fwname);
+
+	err = request_firmware(&fw, fwname, &data->udev->dev);
+	if (err < 0) {
+		BT_ERR("failed to open the Intel firmware file (%d)", err);
+		return NULL;
+	}
+
+	return fw;
+}
+
+static int intel_bl_downloading(struct intel_bl_data *data,
+				const struct firmware *fw,
+				const u8 **fw_ptr)
+{
+	struct hci_command_hdr *cmd;
+	const u8 *cmd_ptr;
+	struct hci_event_hdr *evt = NULL;
+	const u8 *evt_ptr = NULL;
+	int err;
+
+	int remain = fw->size - (*fw_ptr - fw->data);
+
+	if (atomic_read(&data->shutdown)) {
+		BT_ERR("firmware download aborted.");
+		return -EFAULT;
+	}
+
+	BT_DBG("downloading fw data: remain %d", remain);
+
+
+	if (remain <= HCI_COMMAND_HDR_SIZE || *fw_ptr[0] != 0x01) {
+		BT_ERR("fw file is corrupted: invalid cmd read");
+		return -EINVAL;
+	}
+	(*fw_ptr)++;
+	remain--;
+
+	cmd = (struct hci_command_hdr *)(*fw_ptr);
+	cmd_ptr = *fw_ptr;
+
+	/* push HCI command header */
+	*fw_ptr += sizeof(*cmd);
+	remain -= sizeof(*cmd);
+
+	if (remain < cmd->plen) {
+		BT_ERR("fw file is corrupted. invalid cmd len");
+		return -EFAULT;
+	}
+
+	/* push HCI command parameter */
+	*fw_ptr += cmd->plen;
+	remain -= cmd->plen;
+
+	/* read event */
+	if (remain <= HCI_EVENT_HDR_SIZE || *fw_ptr[0] != 0x02) {
+		BT_ERR("fw file is corrupted: invalid evt read");
+		return -EINVAL;
+	}
+
+	(*fw_ptr)++;
+	remain--;
+
+	evt = (struct hci_event_hdr *)(*fw_ptr);
+	evt_ptr = *fw_ptr;
+
+	/* push HCI event header */
+	*fw_ptr += sizeof(*evt);
+	remain -= sizeof(*evt);
+
+	if (remain < evt->plen) {
+		BT_ERR("fw file is corrupted: invalid evt len");
+		return -EFAULT;
+	}
+
+	*fw_ptr += evt->plen;
+	remain -= evt->plen;
+
+	err = intel_bl_send_cmd_sync(data, cmd_ptr, cmd->plen + 3, CMD_TIMEOUT);
+	if (err) {
+		BT_ERR("failed to send patch command %d", err);
+		return -EFAULT;
+	}
+
+	if (evt->plen + 2 != data->evt_len) {
+		BT_ERR("mismatch event length");
+		return -EFAULT;
+	}
+
+	if (memcmp(data->evt_buff, evt_ptr, evt->plen + 2)) {
+		BT_ERR("mismatch event parameter");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static void intel_bl_setup(struct work_struct *work)
+{
+	struct intel_bl_data *data =
+		container_of(work, struct intel_bl_data, work);
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	struct intel_version *ver;
+	int err;
+
+	const u8 get_version[] = { 0x05, 0xFC, 0x00 };
+	const u8 mfg_enable[] = { 0x11, 0xFC, 0x02, 0x01, 0x00 };
+	const u8 mfg_reset_deactivate[] = { 0x11, 0xFC, 0x02, 0x00, 0x01 };
+	const u8 mfg_reset_activate[] = { 0x11, 0xFC, 0x02, 0x00, 0x02 };
+
+	BT_DBG("start Intel fw setup: data %p", data);
+
+	/* get version */
+	err = intel_bl_send_cmd_sync(data, get_version, 3, CMD_TIMEOUT);
+	if (err < 0) {
+		BT_ERR("failed to send get_version command (%d)", err);
+		return;
+	}
+
+	BT_DBG("received get_version event");
+	if (data->evt_len != 15) {
+		BT_ERR("received invalid get_version event: (%d)",
+		       data->evt_len);
+		return;
+	}
+
+	ver = (struct intel_version *)&data->evt_buff[5];
+	if (ver->status) {
+		BT_ERR("get_version event failed (%02x)", ver->status);
+		return;
+	}
+
+	BT_DBG("Intel fw version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
+	       ver->hw_platform, ver->hw_variant, ver->hw_revision,
+	       ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
+	       ver->fw_build_ww, ver->fw_build_yy, ver->fw_patch_num);
+
+	if (ver->fw_patch_num) {
+		BT_INFO("fw is already loaded. skip the downloading");
+		return;
+	}
+
+	fw = intel_bl_get_fw(data, ver);
+	if (!fw)
+		return;
+
+	fw_ptr = fw->data;
+
+	/* make sure the first byte is FF */
+	if (fw->data[0] != 0xFF) {
+		BT_ERR("invalid fw image file: %02x", fw->data[0]);
+		release_firmware(fw);
+		return;
+	}
+	fw_ptr++;
+
+	/* enter mfg mode */
+	err = intel_bl_send_cmd_sync(data, mfg_enable, 5, CMD_TIMEOUT);
+	if (err < 0) {
+		BT_ERR("failed to enable mfg mode (%d)", err);
+		release_firmware(fw);
+		return;
+	}
+
+	while (fw->size > fw_ptr - fw->data) {
+		err = intel_bl_downloading(data, fw, &fw_ptr);
+		if (err < 0) {
+			release_firmware(fw);
+			goto exit_mfg_deactivate;
+		}
+	}
+
+	release_firmware(fw);
+
+	/* patching success */
+	err = intel_bl_send_cmd_sync(data, mfg_reset_activate, 5, CMD_TIMEOUT);
+	if (err < 0) {
+		BT_ERR("failed to disable mfg mode: (%d)", err);
+		return;
+	}
+
+	BT_INFO("Intel fw downloading is completed");
+
+	return;
+
+exit_mfg_deactivate:
+	err = intel_bl_send_cmd_sync(data, mfg_reset_deactivate, 5,
+				     CMD_TIMEOUT);
+	if (err < 0) {
+		BT_ERR("failed to disable mfg mode(deactivate fw): (%d)", err);
+		return;
+	}
+
+	BT_INFO("device is reset without enabling fw");
+	return;
+
+}
+
+static int intel_bl_probe(struct usb_interface *intf,
+			  const struct usb_device_id *id)
+{
+	struct intel_bl_data *data;
+	int err;
+
+	BT_DBG("intf %p id %p", intf, id);
+
+	/* interface numbers are hardcoded in the spec */
+	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
+		return -ENODEV;
+
+	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->udev = interface_to_usbdev(intf);
+
+	usb_set_intfdata(intf, data);
+
+	/* There is a bug in the bootloader that interrupt interface is only
+	 * enabled after receiving  SetInterface(0, AltSetting=0).
+	 */
+	err = usb_set_interface(data->udev, 0, 0);
+	if (err < 0) {
+		BT_ERR("failed to set interface 0, alt 0 %d", err);
+		return err;
+	}
+
+	INIT_WORK(&data->work, intel_bl_setup);
+
+	/* use workqueue to have a small delay */
+	schedule_work(&data->work);
+
+	return 0;
+}
+
+static void intel_bl_disconnect(struct usb_interface *intf)
+{
+	struct intel_bl_data *data = usb_get_intfdata(intf);
+
+	BT_DBG("intf %p", intf);
+
+	atomic_inc(&data->shutdown);
+	cancel_work_sync(&data->work);
+
+	BT_DBG("intel_bl_disconnect");
+
+	usb_set_intfdata(intf, NULL);
+}
+
+static struct usb_driver intel_bl_driver = {
+	.name		= "intel_bl",
+	.probe		= intel_bl_probe,
+	.disconnect	= intel_bl_disconnect,
+	.id_table	= intel_bl_table,
+	.disable_hub_initiated_lpm = 1,
+};
+
+module_usb_driver(intel_bl_driver);
+
+MODULE_AUTHOR("Tedd Ho-Jeong An <tedd.an@intel.com>");
+MODULE_DESCRIPTION("Intel Bluetooth USB Bootloader driver ver " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
-- 
1.7.9.5


-- 
Regards
Tedd Ho-Jeong An
Intel Corporation
