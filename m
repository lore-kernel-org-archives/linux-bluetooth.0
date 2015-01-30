Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
Subject: [PATCH] Bluetooth: Add support for QCA ROME chipset family
Date: Fri, 30 Jan 2015 00:35:00 +0000
Message-ID: <27c299b26b2c489aa7d8ad1114a10a2e@nalasexr02e.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch supports ROME Bluetooth family from Qualcomm Atheros,
e.g. QCA61x4 or QCA6574.

New chipset have similar firmware downloading sequences to previous
chipset from Atheros, however, it doesn't support vid/pid switching
after downloading the patch so that firmware needs to be handled by
btusb module directly.

ROME chipset can be differentiated from previous version by reading
ROM version.

Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 266 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -52,6 +52,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_SWAVE		0x1000
 #define BTUSB_INTEL_NEW		0x2000
 #define BTUSB_AMP		0x4000
+#define BTUSB_QCA_ROME		0x8000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -208,6 +209,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe036), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
+	/* QCA ROME chipset */
+	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME},
+
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
@@ -2585,6 +2589,249 @@ static int btusb_set_bdaddr_ath3012(struct hci_dev *hdev,
 	return 0;
 }
 
+#define QCA_DFU_PACKET_LEN	4096
+
+#define QCA_GET_TARGET_VERSION	0x09
+#define QCA_CHECK_STATUS	0x05
+#define QCA_DFU_DOWNLOAD	0x01
+
+#define QCA_PATCH_UPDATE	0xA0
+#define QCA_SYSCFG_UPDATE	0x60
+#define QCA_PATCH_SYSCFG_UPDATE	(QCA_PATCH_UPDATE | QCA_SYSCFG_UPDATE)
+#define QCA_DFU_TIMEOUT		3000
+
+struct qca_version {
+	u32	rom_version;
+	u32	patch_version;
+	u32	ram_version;
+	u32	ref_clock;
+	u8	reserved[4];
+} __packed;
+
+struct qca_rampatch_version {
+	u16	rom_version;
+	u16	patch_version;
+} __packed;
+
+struct qca_device_info {
+	u32	rom_version;
+	u8	rampatch_hdr;	/* length of header in rampatch */
+	u8	nvm_hdr;	/* length of header in NVM */
+	u8	ver_offset;	/* offset of version structure in rampatch */
+};
+
+static const struct qca_device_info qca_devices_table[] = {
+	{ 0x00000100, 20, 4, 10 }, /* Rome 1.0 */
+	{ 0x00000101, 20, 4, 10 }, /* Rome 1.1 */
+	{ 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
+	{ 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
+	{ 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
+};
+
+static const struct qca_device_info *btusb_qca_find_device(struct qca_version *ver)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++)
+		if (ver->rom_version == qca_devices_table[i].rom_version)
+			return &qca_devices_table[i];
+
+	return NULL;
+}
+
+static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
+				     void *data, u16 size)
+{
+	u8 *buf;
+	int pipe, ret;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pipe = usb_rcvctrlpipe(udev, 0);
+	ret = usb_control_msg(udev, pipe, request, USB_TYPE_VENDOR | USB_DIR_IN,
+			      0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
+
+	memcpy(data, buf, size);
+	kfree(buf);
+
+	return ret;
+}
+
+static int btusb_setup_qca_download_fw(struct usb_device *udev,
+				       const struct firmware *firmware,
+				       size_t hdr_size)
+{
+	u8 *buf;
+	size_t count, size, sent = 0;
+	int pipe, len, err = 0;
+
+	buf = kmalloc(QCA_DFU_PACKET_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	count = firmware->size;
+
+	size = min_t(size_t, count, hdr_size);
+	memcpy(buf, firmware->data, size);
+
+	pipe = usb_sndctrlpipe(udev, 0);
+	err = usb_control_msg(udev, pipe, QCA_DFU_DOWNLOAD, USB_TYPE_VENDOR,
+			      0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
+	if (err < 0)
+		goto done;
+
+	sent += size;
+	count -= size;
+
+	while (count) {
+		size = min_t(size_t, count, QCA_DFU_PACKET_LEN);
+
+		memcpy(buf, firmware->data + sent, size);
+
+		pipe = usb_sndbulkpipe(udev, 0x02);
+		err = usb_bulk_msg(udev, pipe, buf, size, &len,
+				   QCA_DFU_TIMEOUT);
+		if (err)
+			goto done;
+
+		if (size != len) {
+			err = -EIO;
+			goto done;
+		}
+
+		sent  += size;
+		count -= size;
+	}
+
+done:
+	if (err)
+		BT_ERR("firmware download failed at %zd of %zd (%d)",
+		       sent, firmware->size, err);
+
+	kfree(buf);
+	return err;
+}
+
+static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
+					 struct qca_version *ver,
+					 const struct qca_device_info *info)
+{
+	struct btusb_data *data;
+	struct qca_rampatch_version *rver;
+	const struct firmware *fw;
+	char fwname[64];
+	int err;
+
+	snprintf(fwname, sizeof(fwname), "qca/rampatch_tlv_usb_%08x.tlv",
+		 ver->rom_version);
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err) {
+		BT_ERR("%s: failed to request rampatch file: %s (%d)",
+		       hdev->name, fwname, err);
+		return err;
+	}
+
+	BT_INFO("%s: using rampatch file: %s", hdev->name, fwname);
+	rver = (struct qca_rampatch_version *) &fw->data[info->ver_offset];
+	BT_INFO("%s: QCA: patch rome 0x%x build 0x%x, firmware rome 0x%x "
+		"build 0x%x", hdev->name, rver->rom_version,
+		rver->patch_version, ver->rom_version, ver->patch_version);
+
+	if (rver->rom_version != ver->rom_version ||
+				rver->patch_version <= ver->patch_version) {
+		BT_ERR("rampatch file version did not match with firmware");
+		return -EINVAL;
+	}
+
+	data = hci_get_drvdata(hdev);
+
+	err = btusb_setup_qca_download_fw(data->udev, fw, info->rampatch_hdr);
+
+	release_firmware(fw);
+
+	return err;
+}
+
+static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
+				    struct qca_version *ver,
+				    const struct qca_device_info *info)
+{
+	struct btusb_data *data;
+	const struct firmware *fw;
+	char fwname[64];
+	int err;
+
+	snprintf(fwname, sizeof(fwname), "qca/nvm_tlv_usb_%08x.bin",
+		 ver->rom_version);
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err) {
+		BT_ERR("%s: failed to request NVM file: %s (%d)",
+		       hdev->name, fwname, err);
+		return err;
+	}
+
+	BT_INFO("%s: using NVM file: %s", hdev->name, fwname);
+
+	data = hci_get_drvdata(hdev);
+
+	err = btusb_setup_qca_download_fw(data->udev, fw, info->nvm_hdr);
+
+	release_firmware(fw);
+
+	return err;
+}
+
+static int btusb_setup_qca(struct hci_dev *hdev)
+{
+	struct btusb_data *data;
+	struct qca_version ver;
+	u8 status;
+	const struct qca_device_info *info;
+	int err;
+
+	data = hci_get_drvdata(hdev);
+
+	err = btusb_qca_send_vendor_req(data->udev, QCA_GET_TARGET_VERSION,
+					&ver, sizeof(ver));
+	if (err < 0)
+		goto done;
+
+	info = btusb_qca_find_device(&ver);
+	if (!info) {
+		err = -ENODEV;
+		goto done;
+	}
+
+	err = btusb_qca_send_vendor_req(data->udev, QCA_CHECK_STATUS,
+					&status, sizeof(status));
+	if (err < 0)
+		goto done;
+
+	if ((status != QCA_PATCH_UPDATE) || (status != QCA_PATCH_SYSCFG_UPDATE)) {
+		err = btusb_setup_qca_load_rampatch(hdev, &ver, info);
+		if (err < 0)
+			goto done;
+	}
+
+	err = btusb_qca_send_vendor_req(data->udev, QCA_CHECK_STATUS,
+					&status, sizeof(status));
+	if (err < 0)
+		goto done;
+
+	if ((status != QCA_SYSCFG_UPDATE) || (status != QCA_PATCH_SYSCFG_UPDATE)) {
+		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
+		if (err < 0)
+			goto done;
+	}
+
+done:
+	return err;
+}
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -2619,6 +2866,20 @@ static int btusb_probe(struct usb_interface *intf,
 			return -ENODEV;
 	}
 
+	if (id->driver_info & BTUSB_QCA_ROME) {
+		struct usb_device *udev = interface_to_usbdev(intf);
+		struct qca_version ver;
+
+		err = btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION,
+						&ver, sizeof(ver));
+		if (err < 0)
+			return err;
+
+		if (!btusb_qca_find_device(&ver)) {
+			return -ENODEV;
+		}
+	}
+
 	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -2736,6 +2997,11 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
+	if (id->driver_info & BTUSB_QCA_ROME) {
+		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+		hdev->setup = btusb_setup_qca;
+	}
+
 	if (id->driver_info & BTUSB_AMP) {
 		/* AMP controllers do not support SCO packets */
 		data->isoc = NULL;
-- 
1.9.1
