Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <54DD4502.6000304@lwfinger.net>
Date: Thu, 12 Feb 2015 18:27:46 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Daniel Drake <drake@endlessm.com>, marcel@holtmann.org,
 gustavo@padovan.org, johan.hedberg@gmail.com
CC: linux-bluetooth@vger.kernel.org, champion_chen@realsil.com.cn
Subject: Re: [PATCH v4] Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A
 support
References: <1423786087-7354-1-git-send-email-drake@endlessm.com>
In-Reply-To: <1423786087-7354-1-git-send-email-drake@endlessm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 02/12/2015 06:08 PM, Daniel Drake wrote:
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
> This has also been tested on RTL8723AE and RTL8821AE. Support for
> RTL8761A has also been added, but that is untested.
>
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>   drivers/bluetooth/btusb.c | 395 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 395 insertions(+)
>
> Depends on:
>   Bluetooth: btusb: Add helper for READ_LOCAL_VERSION command
>
> v4:
>   - Simplify ID matching: match just the Realtek vendor, and the non-Realtek
>     device IDs. Specific chip detection is then done with READ_LOCAL_VERSION.
>   - Endianness fixes
>   - Addressed other review comments
>
> v3:
>   - Removed support for devices where we don't have firmware
>   - Divide 8723A/8723B codepaths based on driver_info constant
>   - Added more device IDs from latest Realtek code
>   - Addressed minor review comments
>   - Rename RTK --> RTL
>
> v2:
>   - share main blacklist table with other devices
>   - epatch table parsing endian/alignment fixes
>   - BT_INFO message to inform user
>   - added missing kmalloc error check
>   - fixed skb leak
>   - style fixes
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 10062b9..0b2af42 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -24,6 +24,7 @@
>   #include <linux/module.h>
>   #include <linux/usb.h>
>   #include <linux/firmware.h>
> +#include <asm/unaligned.h>
>
>   #include <net/bluetooth/bluetooth.h>
>   #include <net/bluetooth/hci_core.h>
> @@ -52,6 +53,7 @@ static struct usb_driver btusb_driver;
>   #define BTUSB_SWAVE		0x1000
>   #define BTUSB_INTEL_NEW		0x2000
>   #define BTUSB_AMP		0x4000
> +#define BTUSB_REALTEK		0x8000
>
>   static const struct usb_device_id btusb_table[] = {
>   	/* Generic Bluetooth USB device */
> @@ -280,6 +282,28 @@ static const struct usb_device_id blacklist_table[] = {
>   	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
>   	  .driver_info = BTUSB_IGNORE },
>
> +	/* Realtek Bluetooth devices */
> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
> +	  .driver_info = BTUSB_REALTEK },
> +
> +	/* Additional Realtek 8723AE Bluetooth devices */
> +	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
> +	{ USB_DEVICE(0x13d3, 0x3394), .driver_info = BTUSB_REALTEK },
> +
> +	/* Additional Realtek 8723BE Bluetooth devices */
> +	{ USB_DEVICE(0x0489, 0xe085), .driver_info = BTUSB_REALTEK },
> +	{ USB_DEVICE(0x0489, 0xe08b), .driver_info = BTUSB_REALTEK },
> +	{ USB_DEVICE(0x13d3, 0x3410), .driver_info = BTUSB_REALTEK },
> +	{ USB_DEVICE(0x13d3, 0x3416), .driver_info = BTUSB_REALTEK },
> +	{ USB_DEVICE(0x13d3, 0x3459), .driver_info = BTUSB_REALTEK },
> +
> +	/* Additional Realtek 8821AE Bluetooth devices */
> +	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
> +	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },
> +	{ USB_DEVICE(0x13d3, 0x3458), .driver_info = BTUSB_REALTEK },
> +	{ USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
> +	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
> +
>   	{ }	/* Terminating entry */
>   };
>
> @@ -1336,6 +1360,374 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>   	return ret;
>   }
>
> +#define RTL_FRAG_LEN 252
> +
> +struct rtl_download_cmd {
> +	__u8 index;
> +	__u8 data[RTL_FRAG_LEN];
> +} __packed;
> +
> +struct rtl_download_response {
> +	__u8 status;
> +	__u8 index;
> +} __packed;
> +
> +struct rtl_rom_version_evt {
> +	__u8 status;
> +	__u8 version;
> +} __packed;
> +
> +struct rtl_epatch_header {
> +	__u8 signature[8];
> +	__le32 fw_version;
> +	__le16 num_patches;
> +} __packed;
> +
> +#define RTL_EPATCH_SIGNATURE	"Realtech"

Typo here. It should be Realtek.

> +#define RTL_ROM_LMP_3499	0x3499
> +#define RTL_ROM_LMP_8723A	0x1200
> +#define RTL_ROM_LMP_8723B	0x8723
> +#define RTL_ROM_LMP_8821A	0x8821
> +#define RTL_ROM_LMP_8761A	0x8761

I just got a report for an lmp_subversion of 0x4ce1 on an RTL8723BE. The above 
list and the table below may need expanding. We are still testing.

> +
> +static int rtl_read_rom_version(struct hci_dev *hdev)
> +{
> +	struct rtl_rom_version_evt *rom_version;
> +	struct sk_buff *skb;
> +	int r;
> +
> +	/* Read RTL ROM version command */
> +	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("Read ROM version failed (%ld)", PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->len != sizeof(*rom_version)) {
> +		BT_ERR("RTL version event length mismatch");
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	rom_version = (struct rtl_rom_version_evt *)skb->data;
> +	BT_DBG("rom_version status=%x version=%x",
> +	       rom_version->status, rom_version->version);
> +	if (!rom_version->status)
> +		r = rom_version->version;
> +	else
> +		r = bt_to_errno(rom_version->status);
> +
> +	kfree_skb(skb);
> +	return r;
> +}
> +
> +static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
> +				   const struct firmware *fw,
> +				   unsigned char **_buf)
> +{
> +	const uint8_t extension_sig[] = { 0x51, 0x04, 0xfd, 0x77 };
> +	struct rtl_epatch_header *epatch_info;
> +	unsigned char *buf;
> +	int i, len, rom_version;
> +	size_t min_size;
> +	uint8_t opcode, length, data;
> +	int project_id = -1;
> +	const unsigned char *fwptr, *chip_id_base;
> +	const unsigned char *patch_length_base, *patch_offset_base;
> +	u32 patch_offset = 0;
> +	u16 patch_length, num_patches;
> +	const uint16_t project_id_to_lmp_subver[] = {
> +		RTL_ROM_LMP_8723A,
> +		RTL_ROM_LMP_8723B,
> +		RTL_ROM_LMP_8821A,
> +		RTL_ROM_LMP_8761A
> +	};
> +
> +	rom_version = rtl_read_rom_version(hdev);
> +	if (rom_version < 0)
> +		return rom_version;
> +
> +	BT_DBG("lmp_subver=%x rom_version=%x", lmp_subver, rom_version);
> +
> +	min_size = sizeof(struct rtl_epatch_header) + sizeof(extension_sig) + 3;
> +	if (fw->size < min_size)
> +		return -EINVAL;
> +
> +	fwptr = fw->data + fw->size - sizeof(extension_sig);
> +	if (memcmp(fwptr, extension_sig, sizeof(extension_sig)) != 0) {
> +		BT_ERR("extension section signature mismatch");
> +		return -EINVAL;
> +	}
> +
> +	/* Loop from the end of the firmware parsing instructions, until
> +	 * we find an instruction that identifies the "project ID" for the
> +	 * hardware supported by this firwmare file.
> +	 * Once we have that, we double-check that that project_id is suitable
> +	 * for the hardware we are working with.
> +	 */
> +	while (fwptr >= fw->data + (sizeof(struct rtl_epatch_header) + 3)) {
> +		opcode = *--fwptr;
> +		length = *--fwptr;
> +		data = *--fwptr;
> +
> +		BT_DBG("check op=%x len=%x data=%x", opcode, length, data);
> +
> +		if (opcode == 0xff) /* EOF */
> +			break;
> +
> +		if (length == 0) {
> +			BT_ERR("found instruction with length 0");
> +			return -EINVAL;
> +		}
> +
> +		if (opcode == 0 && length == 1) {
> +			project_id = data;
> +			break;
> +		}
> +
> +		fwptr -= length;
> +	}
> +
> +	if (project_id < 0) {
> +		BT_ERR("failed to find version instruction");
> +		return -EINVAL;
> +	}
> +
> +	if (project_id > ARRAY_SIZE(project_id_to_lmp_subver)) {
> +		BT_ERR("unknown project id %d", project_id);
> +		return -EINVAL;
> +	}
> +
> +	if (lmp_subver != project_id_to_lmp_subver[project_id]) {
> +		BT_ERR("firmware is for %x but this is a %x",
> +		       project_id_to_lmp_subver[project_id], lmp_subver);
> +		return -EINVAL;
> +	}
> +
> +	epatch_info = (struct rtl_epatch_header *)fw->data;
> +	if (memcmp(epatch_info->signature, RTL_EPATCH_SIGNATURE, 8) != 0) {
> +		BT_ERR("bad EPATCH signature");
> +		return -EINVAL;
> +	}
> +
> +	num_patches = le16_to_cpu(epatch_info->num_patches);
> +	BT_DBG("fw_version=%x, num_patches=%d",
> +	       le32_to_cpu(epatch_info->fw_version), num_patches);
> +
> +	/* After the rtl_epatch_header there is a funky patch metadata section.
> +	 * Assuming 2 patches, the layout is:
> +	 * ChipID1 ChipID2 PatchLength1 PatchLength2 PatchOffset1 PatchOffset2
> +	 *
> +	 * Find the right patch for this chip.
> +	 */
> +	min_size += 8 * num_patches;
> +	if (fw->size < min_size)
> +		return -EINVAL;
> +
> +	chip_id_base = fw->data + sizeof(struct rtl_epatch_header);
> +	patch_length_base = chip_id_base + (sizeof(u16) * num_patches);
> +	patch_offset_base = patch_length_base + (sizeof(u16) * num_patches);
> +	for (i = 0; i < num_patches; i++) {
> +		u16 chip_id = get_unaligned_le16(chip_id_base +
> +						 (i * sizeof(u16)));
> +		if (chip_id == rom_version + 1) {
> +			patch_length = get_unaligned_le16(patch_length_base +
> +							  (i * sizeof(u16)));
> +			patch_offset = get_unaligned_le32(patch_offset_base +
> +							  (i * sizeof(u32)));
> +			break;
> +		}
> +	}
> +
> +	if (!patch_offset) {
> +		BT_ERR("didn't find patch for chip id %d", rom_version);
> +		return -EINVAL;
> +	}
> +
> +	BT_DBG("length=%x offset=%x index %d", patch_length, patch_offset, i);
> +	min_size = patch_offset + patch_length;
> +	if (fw->size < min_size)
> +		return -EINVAL;
> +
> +	/* Copy the firmware into a new buffer and write the version at
> +	 * the end.
> +	 */
> +	len = patch_length;
> +	buf = kmemdup(fw->data + patch_offset, patch_length, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	memcpy(buf + patch_length - 4, &epatch_info->fw_version, 4);
> +
> +	*_buf = buf;
> +	return len;
> +}
> +
> +static int rtl_download_firmware(struct hci_dev *hdev,
> +				 const unsigned char *data, int fw_len)
> +{
> +	struct rtl_download_cmd *dl_cmd;
> +	int frag_num = fw_len / RTL_FRAG_LEN + 1;
> +	int frag_len = RTL_FRAG_LEN;
> +	int ret = 0;
> +	int i;
> +
> +	dl_cmd = kmalloc(sizeof(struct rtl_download_cmd), GFP_KERNEL);
> +	if (!dl_cmd)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < frag_num; i++) {
> +		struct rtl_download_response *dl_resp;
> +		struct sk_buff *skb;
> +
> +		BT_DBG("download fw (%d/%d)", i, frag_num);
> +
> +		dl_cmd->index = i;
> +		if (i == (frag_num - 1)) {
> +			dl_cmd->index |= 0x80; /* data end */
> +			frag_len = fw_len % RTL_FRAG_LEN;
> +		}
> +		memcpy(dl_cmd->data, data, frag_len);
> +
> +		/* Send download command */
> +		skb = __hci_cmd_sync(hdev, 0xfc20, frag_len + 1, dl_cmd,
> +				     HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			BT_ERR("download fw command failed (%ld)",
> +			       PTR_ERR(skb));
> +			ret = -PTR_ERR(skb);
> +			goto out;
> +		}
> +
> +		if (skb->len != sizeof(*dl_resp)) {
> +			BT_ERR("download fw event length mismatch");
> +			kfree_skb(skb);
> +			ret = -EIO;
> +			goto out;
> +		}
> +
> +		dl_resp = (struct rtl_download_response *)skb->data;
> +		if (dl_resp->status != 0) {
> +			kfree_skb(skb);
> +			ret = bt_to_errno(dl_resp->status);
> +			goto out;
> +		}
> +
> +		kfree_skb(skb);
> +		data += RTL_FRAG_LEN;
> +	}
> +
> +out:
> +	kfree(dl_cmd);
> +	return ret;
> +}
> +
> +static int btusb_setup_rtl8723a(struct hci_dev *hdev)
> +{
> +	struct btusb_data *data = dev_get_drvdata(&hdev->dev);
> +	struct usb_device *udev = interface_to_usbdev(data->intf);
> +	const struct firmware *fw;
> +	int ret;
> +
> +	ret = request_firmware(&fw, "rtl_bt/rtl8723a_fw.bin", &udev->dev);
> +	if (ret < 0) {
> +		BT_ERR("Failed to load rtl_bt/rtl8723a_fw.bin");
> +		return ret;
> +	}
> +
> +	if (fw->size < 8) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Check that the firmware doesn't have the epatch signature
> +	 * (which is only for RTL8723B and newer).
> +	 */
> +	if (!memcmp(fw->data, RTL_EPATCH_SIGNATURE, 8)) {
> +		BT_ERR("RTL8723A: unexpected EPATCH signature!");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = rtl_download_firmware(hdev, fw->data, fw->size);
> +
> +out:
> +	release_firmware(fw);
> +	return ret;
> +}
> +
> +static int btusb_setup_rtl8723b(struct hci_dev *hdev, u16 lmp_subver,
> +				const char *fw_name)
> +{
> +	struct btusb_data *data = dev_get_drvdata(&hdev->dev);
> +	struct usb_device *udev = interface_to_usbdev(data->intf);
> +	unsigned char *fw_data;
> +	const struct firmware *fw;
> +	int ret;
> +
> +	ret = request_firmware(&fw, fw_name, &udev->dev);
> +	if (ret < 0) {
> +		BT_ERR("Failed to load %s", fw_name);
> +		return ret;
> +	}
> +
> +	ret = rtl8723b_parse_firmware(hdev, lmp_subver, fw, &fw_data);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = rtl_download_firmware(hdev, fw_data, ret);
> +	kfree(fw_data);
> +	if (ret < 0)
> +		goto out;
> +
> +out:
> +	release_firmware(fw);
> +	return ret;
> +}
> +
> +static int btusb_setup_realtek(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	struct hci_rp_read_local_version *resp;
> +	u16 lmp_subver;
> +
> +	skb = btusb_read_local_version(hdev);
> +	if (IS_ERR(skb))
> +		return -PTR_ERR(skb);
> +
> +	resp = (struct hci_rp_read_local_version *)skb->data;
> +	BT_INFO("%s: rtl: examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x "
> +		"lmp_subver=%04x", hdev->name, resp->hci_ver, resp->hci_rev,
> +		resp->lmp_ver, resp->lmp_subver);
> +
> +	lmp_subver = le16_to_cpu(resp->lmp_subver);
> +	kfree_skb(skb);
> +
> +	/* Match a set of subver values that correspond to stock firmware,
> +	 * which is not compatible with standard btusb.
> +	 * If matched, upload an alternative firmware that does conform to
> +	 * standard btusb. Once that firmware is uploaded, the subver changes
> +	 * to a different value.
> +	 */
> +	switch (lmp_subver) {
> +	case RTL_ROM_LMP_8723A:
> +	case RTL_ROM_LMP_3499:
> +		return btusb_setup_rtl8723a(hdev);
> +	case RTL_ROM_LMP_8723B:
> +		return btusb_setup_rtl8723b(hdev, lmp_subver,
> +					    "rtl_bt/rtl8723b_fw.bin");
> +	case RTL_ROM_LMP_8821A:
> +		return btusb_setup_rtl8723b(hdev, lmp_subver,
> +					    "rtl_bt/rtl8821a_fw.bin");
> +	case RTL_ROM_LMP_8761A:
> +		return btusb_setup_rtl8723b(hdev, lmp_subver,
> +					    "rtl_bt/rtl8761a_fw.bin");
> +	default:
> +		BT_INFO("rtl: assuming no firmware upload needed.");
> +		return 0;
> +	}
> +}
> +
>   struct intel_version {
>   	u8 status;
>   	u8 hw_platform;
> @@ -2733,6 +3125,9 @@ static int btusb_probe(struct usb_interface *intf,
>   		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>   	}
>
> +	if (id->driver_info & BTUSB_REALTEK)
> +		hdev->setup = btusb_setup_realtek;
> +
>   	if (id->driver_info & BTUSB_AMP) {
>   		/* AMP controllers do not support SCO packets */
>   		data->isoc = NULL;
>

I will test on my devices and let you know of any needed changes.

Larry
