Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek 8723/8761 support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404205896-25742-1-git-send-email-drake@endlessm.com>
Date: Tue, 1 Jul 2014 11:26:38 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
Message-Id: <BABA9B45-3DA7-40E4-9850-56CE967013BD@holtmann.org>
References: <1404205896-25742-1-git-send-email-drake@endlessm.com>
To: Daniel Drake <drake@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> Realtek ship a variety of bluetooth USB devices that identify
> themselves with standard USB Bluetooth device class values, but
> require a special driver to actually work. Without that driver,
> you never get any scan results.
> 
> More recently however, Realtek appear to have wisened up and simply
> posted a firmware update that makes these devices comply with
> normal btusb protocols. The firmware needs to be uploaded on each boot.
> 
> Based on Realtek code from https://github.com/lwfinger/rtl8723au_bt
> ('new' branch).
> 
> This enables bluetooth support in the Gigabyte Brix GB-BXBT-2807 which
> has this RTL8723BE USB device:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 2.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3410 Rev= 2.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> There is no change to the USB descriptor after firmware update,
> however the version read by HCI_OP_READ_LOCAL_VERSION changes from
> 0x8723 to 0x3083.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
> drivers/bluetooth/btusb.c | 427 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 427 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 6250fc2..7f4503f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1382,6 +1382,430 @@ exit_mfg_deactivate:
> 	return 0;
> }
> 
> +#define RTL_FRAG_LEN 252
> +
> +struct rtk_download_cmd {
> +	uint8_t index;
> +	uint8_t data[RTL_FRAG_LEN];
> +} __packed;
> +
> +struct rtk_download_response {
> +	uint8_t status;
> +	uint8_t index;
> +} __packed;
> +
> +struct rtk_eversion_evt {
> +	uint8_t status;
> +	uint8_t version;
> +} __packed;
> +
> +struct rtk_epatch_header {
> +	uint8_t signature[8];
> +	uint32_t fm_version;
> +	uint16_t num_patches;
> +} __packed;
> +
> +static const uint8_t RTK_EPATCH_SIGNATURE[] = {
> +	0x52, 0x65, 0x61, 0x6C, 0x74, 0x65, 0x63, 0x68
> +};
> +
> +#define ROM_LMP_8723a	0x1200
> +#define ROM_LMP_8723b	0x8723
> +#define ROM_LMP_8821a	0x8821
> +#define ROM_LMP_8761a	0x8761
> +
> +static const uint16_t project_id[] = {
> +	ROM_LMP_8723a,
> +	ROM_LMP_8723b,
> +	ROM_LMP_8821a,
> +	ROM_LMP_8761a
> +};
> +
> +enum rtk_variant {
> +	RTL8723A,
> +	RTL8723B,
> +	RTL8761AU,
> +	RTL8761AW_8192EU,
> +	RTL8761AU_8192EE,
> +	RTL8761AU_8812AE,
> +	RTL8821A,
> +	RTK_UNKNOWN,

I don't think you will need the RTK_UNKNOWN.

> +};
> +
> +static const struct {
> +	uint16_t lmp_sub;
> +	const char *fw_name;
> +	const char *config_name;
> +} rtk_fw_info[] = {
> +	[RTL8723A] = { ROM_LMP_8723a, "rtl8723a_fw", "rtl8723a_config" },
> +	[RTL8723B] = { ROM_LMP_8723b, "rtl8723b_fw", "rtl8723b_config" },
> +	[RTL8761AU] = { ROM_LMP_8761a, "rtl8761au_fw", "rtl8761a_config" },
> +	[RTL8761AW_8192EU] = { ROM_LMP_8761a, "rtl8761aw8192eu_fw", "rtl8761a_config" },
> +	[RTL8761AU_8192EE] = { ROM_LMP_8761a, "rtl8761au8192ee_fw", "rtl8761a_config" },
> +	[RTL8761AU_8812AE] = { ROM_LMP_8761a, "rtl8761au8812ae_fw", "rtl8761a_config" },
> +	[RTL8821A] = { ROM_LMP_8821a, "rtl8821a_fw", "rtl8821a_config" },
> +};
> +
> +static const struct usb_device_id rtk_device_table[] = {
> +	{ USB_DEVICE(0x0bda, 0xa761), .driver_info = RTL8761AU },
> +	{ USB_DEVICE(0x0bda, 0x8760), .driver_info = RTL8761AU_8192EE },
> +	{ USB_DEVICE(0x0bda, 0xb761), .driver_info = RTL8761AU_8192EE },
> +	{ USB_DEVICE(0x0bda, 0x8761), .driver_info = RTL8761AU_8192EE },
> +	{ USB_DEVICE(0x0bda, 0x8a60), .driver_info = RTL8761AU_8812AE },
> +	{ USB_DEVICE(0x0bda, 0x818b), .driver_info = RTL8761AW_8192EU },
> +	{ USB_DEVICE(0x0bda, 0x0821), .driver_info = RTL8821A },
> +	{ USB_DEVICE(0x0bda, 0x8821), .driver_info = RTL8821A },
> +	{ USB_DEVICE(0x0bda, 0x8723), .driver_info = RTL8723A },
> +	{ USB_DEVICE(0x0bda, 0xb720), .driver_info = RTL8723B },
> +	{ USB_DEVICE(0x0bda, 0xb72a), .driver_info = RTL8723B },
> +	{ USB_DEVICE(0x0bda, 0xb728), .driver_info = RTL8723B },
> +	{ USB_DEVICE(0x0bda, 0xb723), .driver_info = RTL8723B },
> +	{ USB_DEVICE(0x13d3, 0x3410), .driver_info = RTL8723B },
> +	{ }	/* Terminating entry */
> +};
> +
> +static enum rtk_variant rtk_get_variant(struct hci_dev *hdev)
> +{
> +	struct btusb_data *data = dev_get_drvdata(&hdev->dev);
> +	const struct usb_device_id *match;
> +
> +	match = usb_match_id(data->intf, rtk_device_table);
> +	if (match)
> +		return match->driver_info;
> +
> +	return RTK_UNKNOWN;
> +}

Can we just put this into blacklist_table and not create our own ones. What is good enough for the others should be good enough for this driver as well. There is really no point in just another table that you go through for every single matching interface.

> +
> +static int rtk_read_eversion(struct hci_dev *hdev)
> +{
> +	struct rtk_eversion_evt *eversion;
> +	struct sk_buff *skb;
> +
> +	/* Read RTK ROM version command */
> +	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("Read ROM version failed (%ld)", PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->len != sizeof(*eversion)) {
> +		BT_ERR("RTK version event length mismatch");
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	eversion = (struct rtk_eversion_evt *) skb->data;
> +	BT_DBG("eversion status=%x version=%x",
> +	       eversion->status, eversion->version);
> +	if (eversion->status)
> +		return 0;
> +	else

Replace the else here with an empty line and adjust the indentation of the next line.

> +		return eversion->version;
> +}
> +
> +/* RTL8723A has a simple fw patch format */
> +static int rtk_load_firmware_8723a(const struct firmware *epatch_fw,
> +				   const struct firmware *config_fw,
> +				   unsigned char **_buf)
> +{
> +	unsigned char *buf;
> +	int len;
> +
> +	if (epatch_fw->size < 8)
> +		return -EINVAL;
> +
> +	/* This might look odd, but it's how the Realtek driver does it:
> +	 * Make sure we don't match the regular epatch signature. Maybe that
> +	 * signature is only for the newer devices. */
> +	if (memcmp(epatch_fw->data, RTK_EPATCH_SIGNATURE, 8) == 0) {
> +		BT_ERR("8723a has EPATCH signature!");
> +		return -EINVAL;
> +	}
> +
> +	len = epatch_fw->size;
> +	if (config_fw)
> +		len += config_fw->size;
> +
> +	buf = kzalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	BT_DBG("8723a direct firmware copy\n");
> +	memcpy(buf, epatch_fw->data, epatch_fw->size);
> +	if (config_fw)
> +		memcpy(buf + epatch_fw->size, config_fw->data, config_fw->size);
> +
> +	*_buf = buf;
> +	return len;
> +}
> +
> +/* RTL8723B and newer have a patch format which requires some parsing */
> +static int rtk_load_firmware_8723b(enum rtk_variant variant, uint8_t eversion,
> +				   const struct firmware *epatch_fw,
> +				   const struct firmware *config_fw,
> +				   unsigned char **_buf)
> +{
> +	const uint8_t extension_sig[] = { 0x51, 0x04, 0xfd, 0x77 };
> +	struct rtk_epatch_header *epatch_info;
> +	u16 lmp_version = rtk_fw_info[variant].lmp_sub;
> +	unsigned char *buf;
> +	int i, len;
> +	size_t min_size;
> +	uint8_t opcode, length, data;
> +	unsigned char *tmp;
> +	const unsigned char *fwptr;
> +	bool patch_found = false;
> +	uint16_t *chip_id, *patch_length;
> +	uint32_t *patch_offset;
> +
> +	BT_DBG("lmp_version=%x eversion=%x", lmp_version, eversion);
> +
> +	min_size = sizeof(struct rtk_epatch_header) + sizeof(extension_sig) + 3;
> +	if (epatch_fw->size < min_size)
> +		return -EINVAL;
> +
> +	fwptr = epatch_fw->data + epatch_fw->size - sizeof(extension_sig);
> +	if (memcmp(fwptr, extension_sig, sizeof(extension_sig)) != 0) {
> +		BT_ERR("extension section signature mismatch");
> +		return -EINVAL;
> +	}
> +
> +	/* At this point the vendor driver has some confusing and dangerous
> +	 * (probably broken) code that parses instructions backwards in a
> +	 * loop starting from the end of the file.
> +	 * In current firmware, the loop never executes because the instruction
> +	 * needed is right at the end of the file.
> +	 * For now, check for the same end-of-file data that the vendor driver
> +	 * picks up with current firmware.
> +	 */
> +	opcode = *--fwptr;
> +	length = *--fwptr;
> +	data = *--fwptr;
> +	BT_DBG("final instr op=%x len=%x data=%x", opcode, length, data);
> +	if (opcode != 0 || length != 1) {
> +		BT_ERR("failed to find version instruction");
> +		return -EINVAL;
> +	}
> +
> +	if (lmp_version != project_id[data]) {
> +		BT_ERR("firmware is for %x but this is a %x",
> +		       project_id[data], lmp_version);
> +		return -EINVAL;
> +	}
> +
> +	epatch_info = (struct rtk_epatch_header *) epatch_fw->data;
> +	if (memcmp(epatch_info->signature, RTK_EPATCH_SIGNATURE, 8) != 0) {
> +		BT_ERR("bad EPATCH signature");
> +		return -EINVAL;
> +	}
> +
> +	BT_DBG("fm_version=%x, num_patches=%d",
> +	       epatch_info->fm_version, epatch_info->num_patches);
> +
> +	/* After the rtk_epatch_header there is a funky patch metadata section.
> +	 * Assuming 2 patches, the layout is:
> +	 * ChipID1 ChipID2 PatchLength1 PatchLength2 PatchOffset1 PatchOffset2
> +	 *
> +	 * Find the right patch for this chip. */
> +	min_size += 8 * epatch_info->num_patches;
> +	if (epatch_fw->size < min_size)
> +		return -EINVAL;
> +
> +	chip_id = (uint16_t *)(epatch_fw->data +
> +			       sizeof(struct rtk_epatch_header));
> +	patch_length = (uint16_t *)((unsigned char *) chip_id +
> +				    (sizeof(uint16_t)
> +				     * epatch_info->num_patches));
> +	patch_offset = (uint32_t *)((unsigned char *) patch_length +
> +				    (sizeof(uint16_t)
> +				     * epatch_info->num_patches));

Using the unaligned helpers is not an option?

> +	for (i = 0; i < epatch_info->num_patches; i++) {
> +		if (chip_id[i] == eversion + 1) {
> +			patch_found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!patch_found) {
> +		BT_ERR("didn't find patch for chip id %d", eversion);
> +		return -EINVAL;
> +	}
> +
> +	BT_DBG("chipID=%d length=%x offset=%x index %d",
> +	       chip_id[i], patch_length[i], patch_offset[i], i);
> +
> +	min_size = patch_offset[i] + patch_length[i];
> +	if (epatch_fw->size < min_size)
> +		return -EINVAL;
> +
> +	len = patch_length[i];
> +	if (config_fw)
> +		len += config_fw->size;
> +
> +	buf = kzalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	memcpy(buf, epatch_fw->data + patch_offset[i], patch_length[i]);
> +	tmp = buf + patch_length[i];
> +	memcpy(tmp - 4, &epatch_info->fm_version, 4);
> +	if (config_fw)
> +		memcpy(tmp, config_fw->data, config_fw->size);
> +
> +	*_buf = buf;
> +	return len;
> +}
> +
> +static int rtk_load_firmware(struct hci_dev *hdev, unsigned char **buf,
> +			     enum rtk_variant variant, uint8_t eversion)
> +{
> +	struct btusb_data *data = dev_get_drvdata(&hdev->dev);
> +	struct usb_device *udev = interface_to_usbdev(data->intf);
> +	char fw_name[32];
> +	const struct firmware *epatch_fw, *config_fw;
> +	int ret;
> +
> +	snprintf(fw_name, sizeof(fw_name), "rtl_bt/%s.bin",
> +			 rtk_fw_info[variant].config_name);

Do you really want to name the directory rtl_bt and not rtk or realtek or something more that makes actually sense. I have no idea where rtl comes from.

And the indentation is wrong here.


> +	ret = request_firmware(&config_fw, fw_name, &udev->dev);
> +	if (ret < 0) {
> +		BT_DBG("optional config blob %s not found", fw_name);
> +		config_fw = NULL;
> +	}
> +
> +	snprintf(fw_name, sizeof(fw_name), "rtl_bt/%s.bin",
> +			 rtk_fw_info[variant].fw_name);

See above.

> +	ret = request_firmware(&epatch_fw, fw_name, &udev->dev);
> +	if (ret < 0) {
> +		BT_ERR("fw blob %s not found", fw_name);
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (rtk_fw_info[variant].lmp_sub == ROM_LMP_8723a)
> +		ret = rtk_load_firmware_8723a(epatch_fw, config_fw, buf);
> +	else
> +		ret = rtk_load_firmware_8723b(variant, eversion, epatch_fw,
> +					      config_fw, buf);
> +
> +out:
> +	BT_DBG("return %d", ret);
> +	release_firmware(config_fw);
> +	release_firmware(epatch_fw);
> +	return ret;
> +}
> +
> +static bool rtk_fw_upload_needed(struct hci_dev *hdev, enum rtk_variant variant)
> +{
> +	struct hci_rp_read_local_version *resp;
> +	u16 lmp_version = rtk_fw_info[variant].lmp_sub;
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("rtk fw version read command failed (%ld)",
> +		       PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->len != sizeof(*resp)) {
> +		BT_ERR("rtk version event length mismatch");
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	resp = (struct hci_rp_read_local_version *) skb->data;
> +	if (resp->status) {
> +		BT_ERR("rtk fw version event failed (%02x)", resp->status);
> +		kfree_skb(skb);
> +		return bt_to_errno(resp->status);
> +	}
> +
> +	BT_DBG("rtk fw: lmp_subver=%x vs %x", resp->lmp_subver, lmp_version);

For the Broadcom devices we are using BT_INFO to allow users to see if something happened. Might want to do the same.

> +
> +	/* Firmware upload is only needed when the running version matches the
> +	 * one listed in the driver. If versions differ, we assume that no
> +	 * firmware update is necessary. */
> +	return resp->lmp_subver == lmp_version;
> +}
> +
> +static int btusb_setup_rtk(struct hci_dev *hdev)
> +{
> +	struct rtk_download_cmd *dl_cmd;
> +	unsigned char *fw_blob, *pcur;
> +	int frag_num, frag_len;
> +	int fw_len, i, eversion;
> +	enum rtk_variant variant = rtk_get_variant(hdev);
> +	int ret = -EIO;
> +
> +	BT_DBG("variant %d", variant);
> +	if (variant == RTK_UNKNOWN) {
> +		BT_ERR("unrecognised rtk device");
> +		return -EIO;
> +	}

Scrap this part. As I said, this should not even happen since you will only assign the setup handler to known devices.

> +
> +	if (!rtk_fw_upload_needed(hdev, variant))
> +		return 0;
> +
> +	eversion = rtk_read_eversion(hdev);
> +	if (eversion < 0)
> +		return eversion;
> +
> +	fw_len = rtk_load_firmware(hdev, &fw_blob, variant, eversion);
> +	if (fw_len < 0)
> +		return fw_len;

No. This function returns either 0 or an error. Don't confuse the Bluetooth core with some random number.

> +
> +	frag_num = fw_len / RTL_FRAG_LEN + 1;
> +	frag_len = RTL_FRAG_LEN;
> +	dl_cmd = kmalloc(sizeof(struct rtk_download_cmd), GFP_KERNEL);

No need to check that allocation of dl_cmd actually succeeded?

> +	pcur = fw_blob;
> +
> +	for (i = 0; i < frag_num; i++) {
> +		struct rtk_download_response *dl_resp;
> +		struct sk_buff *skb;
> +
> +		BT_DBG("download fw (%d/%d)", i, frag_num);
> +		dl_cmd->index = i;
> +		if (i == (frag_num - 1)) {
> +			dl_cmd->index |= 0x80; /* data end */
> +			frag_len = fw_len % RTL_FRAG_LEN;
> +		}
> +		memcpy(dl_cmd->data, pcur, frag_len);
> +
> +		/* Send download command */
> +		skb = __hci_cmd_sync(hdev, 0xfc20, frag_len + 1, dl_cmd,
> +				     HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			BT_ERR("download fw command failed (%ld)",
> +			       PTR_ERR(skb));
> +			goto out;
> +		}
> +
> +		if (skb->len != sizeof(*dl_resp)) {
> +			BT_ERR("download fw event length mismatch");
> +			kfree_skb(skb);
> +			goto out;
> +		}
> +
> +		dl_resp = (struct rtk_download_response *) skb->data;
> +		if (dl_resp->status != 0) {
> +			kfree_skb(skb);
> +			goto out;
> +		}
> +
> +		kfree_skb(skb);
> +		pcur += RTL_FRAG_LEN;
> +	}
> +
> +	ret = 0;
> +
> +out:
> +	kfree(fw_blob);
> +	kfree(dl_cmd);
> +	return ret;
> +}
> +
> static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
> {
> 	struct btusb_data *data = hci_get_drvdata(hdev);
> @@ -1641,6 +2065,9 @@ static int btusb_probe(struct usb_interface *intf,
> 	if (id->driver_info & BTUSB_INTEL)
> 		hdev->setup = btusb_setup_intel;
> 
> +	if (rtk_get_variant(hdev) != RTK_UNKNOWN)
> +		hdev->setup = btusb_setup_rtk;
> +

As commented above. Just use driver_info here.

> 	/* Interface numbers are hardcoded in the specification */
> 	data->isoc = usb_ifnum_to_if(data->udev, 1);

Regards

Marcel

