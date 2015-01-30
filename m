Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2] Bluetooth: Add support for QCA ROME chipset family
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c91d59687e224bb582d1be6fd0b29adf@nalasexr02e.na.qualcomm.com>
Date: Thu, 29 Jan 2015 21:41:22 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <20F1EBA1-1051-42DD-B400-F5F04711EFAE@holtmann.org>
References: <c91d59687e224bb582d1be6fd0b29adf@nalasexr02e.na.qualcomm.com>
To: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

> This patch supports ROME Bluetooth family from Qualcomm Atheros,
> e.g. QCA61x4 or QCA6574.
> 
> New chipset have similar firmware downloading sequences to previous
> chipset from Atheros, however, it doesn't support vid/pid switching
> after downloading the patch so that firmware needs to be handled by
> btusb module directly.
> 
> ROME chipset can be differentiated from previous version by reading
> ROM version.
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 16 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cf3 ProdID=e300 Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Signed-off-by: Ben Kim <ytkim@qca.qualcomm.com>
> ---
> drivers/bluetooth/btusb.c | 251 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 251 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3aa4b3c..15b68b1 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -52,6 +52,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_SWAVE		0x1000
> #define BTUSB_INTEL_NEW		0x2000
> #define BTUSB_AMP		0x4000
> +#define BTUSB_QCA_ROME		0x8000
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -208,6 +209,9 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ USB_DEVICE(0x0489, 0xe036), .driver_info = BTUSB_ATH3012 },
> 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
> 
> +	/* QCA ROME chipset */
> +	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME},
> +
> 	/* Broadcom BCM2035 */
> 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
> 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
> @@ -2585,6 +2589,248 @@ static int btusb_set_bdaddr_ath3012(struct hci_dev *hdev,
> 	return 0;
> }
> 
> +#define QCA_DFU_PACKET_LEN	4096
> +
> +#define QCA_GET_TARGET_VERSION	0x09
> +#define QCA_CHECK_STATUS	0x05
> +#define QCA_DFU_DOWNLOAD	0x01
> +
> +#define QCA_PATCH_UPDATE	0xA0
> +#define QCA_SYSCFG_UPDATE	0x60
> +#define QCA_PATCH_SYSCFG_UPDATE	(QCA_PATCH_UPDATE | QCA_SYSCFG_UPDATE)

no longer needed. Remove this one.

> +#define QCA_DFU_TIMEOUT		3000
> +
> +struct qca_version {
> +	__le32	rom_version;
> +	__le32	patch_version;
> +	__le32	ram_version;
> +	__le32	ref_clock;
> +	__u8	reserved[4];
> +} __packed;
> +
> +struct qca_rampatch_version {
> +	__le16	rom_version;
> +	__le16	patch_version;
> +} __packed;
> +
> +struct qca_device_info {
> +	__le32	rom_version;
> +	__u8	rampatch_hdr;	/* length of header in rampatch */
> +	__u8	nvm_hdr;	/* length of header in NVM */
> +	__u8	ver_offset;	/* offset of version structure in rampatch */
> +};
> +
> +static const struct qca_device_info qca_devices_table[] = {
> +	{ 0x00000100, 20, 4, 10 }, /* Rome 1.0 */
> +	{ 0x00000101, 20, 4, 10 }, /* Rome 1.1 */
> +	{ 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
> +	{ 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
> +	{ 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
> +};
> +
> +static const struct qca_device_info *btusb_qca_find_device(struct qca_version *ver)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
> +		if (ver->rom_version == qca_devices_table[i].rom_version)
> +			return &qca_devices_table[i];
> +	}
> +
> +	return NULL;
> +}

I think this one can be just put directly into btusb_setup_qca. You only have single user of it. Avoids have to jump around and figure out what is going on.

> +
> +static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
> +				     void *data, u16 size)
> +{
> +	u8 *buf;
> +	int pipe, ret;
> +
> +	buf = kmalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	/* To access OTP(one time programing) memory area at early stage,
> +	 * use USB endpoint instead of VS HCI command because HCI path may 
> +	 * not be ready to access OTP area.
> +	 */
> +	pipe = usb_rcvctrlpipe(udev, 0);
> +	ret = usb_control_msg(udev, pipe, request, USB_TYPE_VENDOR | USB_DIR_IN,
> +			      0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
> +
> +	memcpy(data, buf, size);
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
> +static int btusb_setup_qca_download_fw(struct usb_device *udev,
> +				       const struct firmware *firmware,
> +				       size_t hdr_size)
> +{
> +	u8 *buf;
> +	size_t count, size, sent = 0;
> +	int pipe, len, err;
> +
> +	buf = kmalloc(QCA_DFU_PACKET_LEN, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	count = firmware->size;
> +
> +	size = min_t(size_t, count, hdr_size);
> +	memcpy(buf, firmware->data, size);
> +
> +	/* Patch header goes down through control path */
> +	pipe = usb_sndctrlpipe(udev, 0);
> +	err = usb_control_msg(udev, pipe, QCA_DFU_DOWNLOAD, USB_TYPE_VENDOR,
> +			      0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
> +	if (err < 0)
> +		goto done;

Put the error message here and make it clear that the header fails.

> +
> +	sent += size;
> +	count -= size;
> +
> +	while (count) {
> +		size = min_t(size_t, count, QCA_DFU_PACKET_LEN);
> +
> +		memcpy(buf, firmware->data + sent, size);
> +
> +		/* Patch body goes down through bulk channel */
> +		pipe = usb_sndbulkpipe(udev, 0x02);
> +		err = usb_bulk_msg(udev, pipe, buf, size, &len,
> +				   QCA_DFU_TIMEOUT);
> +		if (err < 0)
> +			break;

This should include the error message that the body failed.

> +
> +		if (size != len) {
> +			err = -EILSEQ;
> +			break;
> +		}
> +
> +		sent  += size;
> +		count -= size;
> +	}
> +
> +done:
> +	if (err)
> +		BT_ERR("firmware download failed at %zd of %zd (%d)",
> +		       sent, firmware->size, err);

Actually I think you want the error message where it happens. This location is not a good idea. See both comments above.

> +
> +	kfree(buf);
> +	return err;
> +}
> +
> +static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
> +					 struct qca_version *ver,
> +					 const struct qca_device_info *info)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	struct qca_rampatch_version *rver;
> +	const struct firmware *fw;
> +	char fwname[64];
> +	int err;
> +
> +	snprintf(fwname, sizeof(fwname), "qca/rampatch_tlv_usb_%08x.bin",
> +		 ver->rom_version);

Honestly, qca/rampatch_%08x.bin should be plenty. I still have no idea what value tlv adds and why we need the statement in there that is is for USB? Do you use different files for UART version?

And btw. le32_to_cpu(ver->rom_version) since otherwise this does not do the right thing on big endian machines.

> +
> +	err = request_firmware(&fw, fwname, &hdev->dev);
> +	if (err) {
> +		BT_ERR("%s: failed to request rampatch file: %s (%d)",
> +		       hdev->name, fwname, err);
> +		return err;
> +	}
> +
> +	BT_INFO("%s: using rampatch file: %s", hdev->name, fwname);
> +	rver = (struct qca_rampatch_version *)(fw->data + info->ver_offset);
> +	BT_INFO("%s: QCA: patch rome 0x%x build 0x%x, firmware rome 0x%x "
> +		"build 0x%x", hdev->name, le16_to_cpu(rver->rom_version),
> +		le16_to_cpu(rver->patch_version), le32_to_cpu(ver->rom_version), 
> +		le32_to_cpu(ver->patch_version));
> +
> +	if (rver->rom_version != ver->rom_version ||
> +		rver->patch_version <= ver->patch_version) {

Indentation is still wrong.

> +		BT_ERR("rampatch file version did not match with firmware");
> +		return -EINVAL;

You are leaking the firmware data here.

> +	}
> +
> +	err = btusb_setup_qca_download_fw(data->udev, fw, info->rampatch_hdr);
> +
> +	release_firmware(fw);
> +
> +	return err;
> +}
> +
> +static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
> +				    struct qca_version *ver,
> +				    const struct qca_device_info *info)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	const struct firmware *fw;
> +	char fwname[64];
> +	int err;
> +
> +	snprintf(fwname, sizeof(fwname), "qca/nvm_tlv_usb_%08x.bin",
> +		 ver->rom_version);

Same applies from comment above. Including the endian bug.

> +
> +	err = request_firmware(&fw, fwname, &hdev->dev);
> +	if (err) {
> +		BT_ERR("%s: failed to request NVM file: %s (%d)",
> +		       hdev->name, fwname, err);
> +		return err;
> +	}
> +
> +	BT_INFO("%s: using NVM file: %s", hdev->name, fwname);
> +
> +	err = btusb_setup_qca_download_fw(data->udev, fw, info->nvm_hdr);
> +
> +	release_firmware(fw);
> +
> +	return err;
> +}
> +
> +static int btusb_setup_qca(struct hci_dev *hdev)
> +{
> +	struct btusb_data *data;
> +	struct qca_version ver;
> +	u8 status;
> +	const struct qca_device_info *info;
> +	int err;
> +
> +	data = hci_get_drvdata(hdev);

	struct btusb_data *data = hci_get_drvdata(hdev);

That should be always first in the function.

> +
> +	err = btusb_qca_send_vendor_req(data->udev, QCA_GET_TARGET_VERSION,
> +					&ver, sizeof(ver));
> +	if (err < 0)
> +		goto done;

		return err;

> +
> +	info = btusb_qca_find_device(&ver);
> +	if (!info) {
> +		err = -ENODEV;
> +		goto done;

		return -ENODEV;

> +	}

Replace the call to btusb_qca_find_device with a direct coding of that lookup here.

> +
> +	err = btusb_qca_send_vendor_req(data->udev, QCA_CHECK_STATUS,
> +					&status, sizeof(status));
> +	if (err < 0)
> +		goto done;

		return err;

> +
> +	if (status != QCA_PATCH_UPDATE) {

	if (status & QCA_PATCH_UPDATE) {
	}

Otherwise you have to explain how that thing works. Since I do not understand it.

> +		err = btusb_setup_qca_load_rampatch(hdev, &ver, info);
> +		if (err < 0)
> +			goto done;

			return err;

> +	}
> +
> +	if (status != QCA_SYSCFG_UPDATE) {

Same as above.

> +		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
> +		if (err < 0)
> +			goto done;

		return err;

> +	}
> +
> +done:
> +	return err;

	return 0;

> +}
> +
> static int btusb_probe(struct usb_interface *intf,
> 		       const struct usb_device_id *id)
> {
> @@ -2736,6 +2982,11 @@ static int btusb_probe(struct usb_interface *intf,
> 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> 	}
> 
> +	if (id->driver_info & BTUSB_QCA_ROME) {
> +		hdev->setup = btusb_setup_qca;
> +		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
> +	}
> +
> 	if (id->driver_info & BTUSB_AMP) {
> 		/* AMP controllers do not support SCO packets */
> 		data->isoc = NULL;
> -- 
> 1.9.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

