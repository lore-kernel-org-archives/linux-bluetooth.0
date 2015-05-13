Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btrtl: Create separate module for Realtek BT driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1431100652-3658-1-git-send-email-carlo@caione.org>
Date: Wed, 13 May 2015 22:56:49 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, larry.finger@lwfinger.net,
	champion_chen@realsil.com.cn, drake@endlessm.com,
	Carlo Caione <carlo@endlessm.com>
Message-Id: <86BBEE97-B28B-429A-8D13-AE41D7BC37A0@holtmann.org>
References: <1431100652-3658-1-git-send-email-carlo@caione.org>
To: Carlo Caione <carlo@caione.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Carlo,

> As already done for btintel and btbcm export setup as separate function
> in a vendor-specific module to hold all the Realtek specific commands.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
> drivers/bluetooth/Kconfig  |  14 ++
> drivers/bluetooth/Makefile |   1 +
> drivers/bluetooth/btrtl.c  | 398 +++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btrtl.h  |  60 +++++++
> drivers/bluetooth/btusb.c  | 375 +-----------------------------------------
> 5 files changed, 476 insertions(+), 372 deletions(-)
> create mode 100644 drivers/bluetooth/btrtl.c
> create mode 100644 drivers/bluetooth/btrtl.h
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index ed5c273..553965b 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -5,6 +5,9 @@ menu "Bluetooth device drivers"
> config BT_INTEL
> 	tristate
> 
> +config BT_RTL
> +	tristate
> +

please sort this one after the BT_BCM one. No need to try to squeeze it in between. Also if the request_firmware is done from this module, you need the select FW_LOADER same as done with BT_BCM.

> config BT_BCM
> 	tristate
> 	select FW_LOADER
> @@ -32,6 +35,17 @@ config BT_HCIBTUSB_BCM
> 
> 	  Say Y here to compile support for Broadcom protocol.
> 
> +config BT_HCIBTUSB_RTL
> +	bool "Realtek protocol support"
> +	depends on BT_HCIBTUSB
> +	select BT_RTL
> +	default y
> +	help
> +	  The Realtek protocol support enables firmware and patch ram

I would say “firmware and configuration” here instead of patch ram. The patch ram stuff is more like a Broadcom term anyway.

> +	  download support for Realket Bluetooth controllers.

Lets keep spelling this Realtek please.

> +
> +	  Say Y here to compile support for Realtek protocol.
> +
> config BT_HCIBTSDIO
> 	tristate "HCI SDIO driver"
> 	depends on MMC
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index dd0d9c4..f40e194 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
> obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
> obj-$(CONFIG_BT_WILINK)		+= btwilink.o
> obj-$(CONFIG_BT_BCM)		+= btbcm.o
> +obj-$(CONFIG_BT_RTL)		+= btrtl.o
> 
> btmrvl-y			:= btmrvl_main.o
> btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> new file mode 100644
> index 0000000..b5a04bb
> --- /dev/null
> +++ b/drivers/bluetooth/btrtl.c
> @@ -0,0 +1,398 @@
> +/*
> + *  Bluetooth support for Realtek devices
> + *
> + *  Copyright (C) 2015 Endless Mobile, Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/firmware.h>
> +#include <asm/unaligned.h>
> +#include <linux/usb.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "btrtl.h"
> +
> +#define VERSION "0.1"
> +
> +static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
> +{
> +	struct rtl_rom_version_evt *rom_version;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +	/* Read RTL ROM version command */
> +	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: Read ROM version failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->len != sizeof(*rom_version)) {
> +		BT_ERR("%s: RTL version event length mismatch", hdev->name);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	rom_version = (struct rtl_rom_version_evt *)skb->data;
> +	BT_INFO("%s: rom_version status=%x version=%x",
> +		hdev->name, rom_version->status, rom_version->version);
> +
> +	ret = rom_version->status;
> +	if (ret == 0)
> +		*version = rom_version->version;

since the status check is actually done by the core, no need to repeat it here. See patches from Fred.

> +
> +	kfree_skb(skb);
> +	return ret;
> +}
> +
> +static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
> +				   const struct firmware *fw,
> +				   unsigned char **_buf)
> +{
> +	const u8 extension_sig[] = { 0x51, 0x04, 0xfd, 0x77 };
> +	struct rtl_epatch_header *epatch_info;
> +	unsigned char *buf;
> +	int i, ret, len;
> +	size_t min_size;
> +	u8 opcode, length, data, rom_version = 0;
> +	int project_id = -1;
> +	const unsigned char *fwptr, *chip_id_base;
> +	const unsigned char *patch_length_base, *patch_offset_base;
> +	u32 patch_offset = 0;
> +	u16 patch_length, num_patches;
> +	const u16 project_id_to_lmp_subver[] = {
> +		RTL_ROM_LMP_8723A,
> +		RTL_ROM_LMP_8723B,
> +		RTL_ROM_LMP_8821A,
> +		RTL_ROM_LMP_8761A
> +	};
> +
> +	ret = rtl_read_rom_version(hdev, &rom_version);
> +	if (ret)
> +		return -bt_to_errno(ret);

And with that in mind, this returns already the errno value and not the HCI status value. No need to try and convert this twice.

> +
> +	min_size = sizeof(struct rtl_epatch_header) + sizeof(extension_sig) + 3;
> +	if (fw->size < min_size)
> +		return -EINVAL;
> +
> +	fwptr = fw->data + fw->size - sizeof(extension_sig);
> +	if (memcmp(fwptr, extension_sig, sizeof(extension_sig)) != 0) {
> +		BT_ERR("%s: extension section signature mismatch", hdev->name);
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
> +			BT_ERR("%s: found instruction with length 0",
> +			       hdev->name);
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
> +		BT_ERR("%s: failed to find version instruction", hdev->name);
> +		return -EINVAL;
> +	}
> +
> +	if (project_id >= ARRAY_SIZE(project_id_to_lmp_subver)) {
> +		BT_ERR("%s: unknown project id %d", hdev->name, project_id);
> +		return -EINVAL;
> +	}
> +
> +	if (lmp_subver != project_id_to_lmp_subver[project_id]) {
> +		BT_ERR("%s: firmware is for %x but this is a %x", hdev->name,
> +		       project_id_to_lmp_subver[project_id], lmp_subver);
> +		return -EINVAL;
> +	}
> +
> +	epatch_info = (struct rtl_epatch_header *)fw->data;
> +	if (memcmp(epatch_info->signature, RTL_EPATCH_SIGNATURE, 8) != 0) {
> +		BT_ERR("%s: bad EPATCH signature", hdev->name);
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
> +		BT_ERR("%s: didn't find patch for chip id %d",
> +		       hdev->name, rom_version);
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
> +			BT_ERR("%s: download fw command failed (%ld)",
> +			       hdev->name, PTR_ERR(skb));
> +			ret = -PTR_ERR(skb);
> +			goto out;
> +		}
> +
> +		if (skb->len != sizeof(*dl_resp)) {
> +			BT_ERR("%s: download fw event length mismatch",
> +			       hdev->name);
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
> +	const struct firmware *fw;
> +	int ret;
> +
> +	BT_INFO("%s: rtl: loading rtl_bt/rtl8723a_fw.bin", hdev->name);
> +	ret = request_firmware(&fw, "rtl_bt/rtl8723a_fw.bin", &hdev->dev);
> +	if (ret < 0) {
> +		BT_ERR("%s: Failed to load rtl_bt/rtl8723a_fw.bin", hdev->name);
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
> +		BT_ERR("%s: unexpected EPATCH signature!", hdev->name);
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
> +	unsigned char *fw_data = NULL;
> +	const struct firmware *fw;
> +	int ret;
> +
> +	BT_INFO("%s: rtl: loading %s", hdev->name, fw_name);
> +	ret = request_firmware(&fw, fw_name, &hdev->dev);
> +	if (ret < 0) {
> +		BT_ERR("%s: Failed to load %s", hdev->name, fw_name);
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
> +/*
> + * This is taken from btusb.c. Probably it should be moved in an header file to
> + * be included by modules that need it.
> + */

It should not be. Have a copy here. Just label it properly with btrtl instead of btusb. The btusb_ prefix has no place in this module.

> +static struct sk_buff *btusb_read_local_version(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return skb;
> +	}
> +
> +	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
> +		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
> +		       hdev->name);
> +		kfree_skb(skb);
> +		return ERR_PTR(-EIO);
> +	}
> +
> +	return skb;
> +}
> +
> +int btusb_setup_realtek(struct hci_dev *hdev)
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
> +EXPORT_SYMBOL_GPL(btusb_setup_realtek);

btrtl_setup is the correct name here. Please have exported modules done properly.

> +
> +MODULE_AUTHOR("Carlo Caione <carlo@endlessm.com>");
> +MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);

I think you mean Realtek and not Intel ;)

> +MODULE_VERSION(VERSION);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> new file mode 100644
> index 0000000..bb6a192
> --- /dev/null
> +++ b/drivers/bluetooth/btrtl.h
> @@ -0,0 +1,60 @@
> +/*
> + *  Bluetooth support for Realtek devices
> + *
> + *  Copyright (C) 2015 Endless Mobile, Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
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
> +#define RTL_ROM_LMP_3499	0x3499
> +#define RTL_ROM_LMP_8723A	0x1200
> +#define RTL_ROM_LMP_8723B	0x8723
> +#define RTL_ROM_LMP_8821A	0x8821
> +#define RTL_ROM_LMP_8761A	0x8761

These belong in the btrtl.c file and not in the header. They are not used from anywhere else.

> +
> +
> +#if IS_ENABLED(CONFIG_BT_RTL)
> +
> +int btusb_setup_realtek(struct hci_dev *hdev);
> +
> +#else
> +
> +static inline int btusb_setup_realtek(struct hci_dev *hdev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +#endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d21f3b4..f696f7a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -31,6 +31,7 @@
> 
> #include "btintel.h"
> #include "btbcm.h"
> +#include "btrtl.h"
> 
> #define VERSION "0.8"
> 
> @@ -1369,378 +1370,6 @@ static int btusb_setup_csr(struct hci_dev *hdev)
> 	return ret;
> }
> 
> -#define RTL_FRAG_LEN 252
> -
> -struct rtl_download_cmd {
> -	__u8 index;
> -	__u8 data[RTL_FRAG_LEN];
> -} __packed;
> -
> -struct rtl_download_response {
> -	__u8 status;
> -	__u8 index;
> -} __packed;
> -
> -struct rtl_rom_version_evt {
> -	__u8 status;
> -	__u8 version;
> -} __packed;
> -
> -struct rtl_epatch_header {
> -	__u8 signature[8];
> -	__le32 fw_version;
> -	__le16 num_patches;
> -} __packed;
> -
> -#define RTL_EPATCH_SIGNATURE	"Realtech"
> -#define RTL_ROM_LMP_3499	0x3499
> -#define RTL_ROM_LMP_8723A	0x1200
> -#define RTL_ROM_LMP_8723B	0x8723
> -#define RTL_ROM_LMP_8821A	0x8821
> -#define RTL_ROM_LMP_8761A	0x8761
> -
> -static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
> -{
> -	struct rtl_rom_version_evt *rom_version;
> -	struct sk_buff *skb;
> -	int ret;
> -
> -	/* Read RTL ROM version command */
> -	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
> -	if (IS_ERR(skb)) {
> -		BT_ERR("%s: Read ROM version failed (%ld)",
> -		       hdev->name, PTR_ERR(skb));
> -		return PTR_ERR(skb);
> -	}
> -
> -	if (skb->len != sizeof(*rom_version)) {
> -		BT_ERR("%s: RTL version event length mismatch", hdev->name);
> -		kfree_skb(skb);
> -		return -EIO;
> -	}
> -
> -	rom_version = (struct rtl_rom_version_evt *)skb->data;
> -	BT_INFO("%s: rom_version status=%x version=%x",
> -		hdev->name, rom_version->status, rom_version->version);
> -
> -	ret = rom_version->status;
> -	if (ret == 0)
> -		*version = rom_version->version;
> -
> -	kfree_skb(skb);
> -	return ret;
> -}
> -
> -static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
> -				   const struct firmware *fw,
> -				   unsigned char **_buf)
> -{
> -	const u8 extension_sig[] = { 0x51, 0x04, 0xfd, 0x77 };
> -	struct rtl_epatch_header *epatch_info;
> -	unsigned char *buf;
> -	int i, ret, len;
> -	size_t min_size;
> -	u8 opcode, length, data, rom_version = 0;
> -	int project_id = -1;
> -	const unsigned char *fwptr, *chip_id_base;
> -	const unsigned char *patch_length_base, *patch_offset_base;
> -	u32 patch_offset = 0;
> -	u16 patch_length, num_patches;
> -	const u16 project_id_to_lmp_subver[] = {
> -		RTL_ROM_LMP_8723A,
> -		RTL_ROM_LMP_8723B,
> -		RTL_ROM_LMP_8821A,
> -		RTL_ROM_LMP_8761A
> -	};
> -
> -	ret = rtl_read_rom_version(hdev, &rom_version);
> -	if (ret)
> -		return -bt_to_errno(ret);
> -
> -	min_size = sizeof(struct rtl_epatch_header) + sizeof(extension_sig) + 3;
> -	if (fw->size < min_size)
> -		return -EINVAL;
> -
> -	fwptr = fw->data + fw->size - sizeof(extension_sig);
> -	if (memcmp(fwptr, extension_sig, sizeof(extension_sig)) != 0) {
> -		BT_ERR("%s: extension section signature mismatch", hdev->name);
> -		return -EINVAL;
> -	}
> -
> -	/* Loop from the end of the firmware parsing instructions, until
> -	 * we find an instruction that identifies the "project ID" for the
> -	 * hardware supported by this firwmare file.
> -	 * Once we have that, we double-check that that project_id is suitable
> -	 * for the hardware we are working with.
> -	 */
> -	while (fwptr >= fw->data + (sizeof(struct rtl_epatch_header) + 3)) {
> -		opcode = *--fwptr;
> -		length = *--fwptr;
> -		data = *--fwptr;
> -
> -		BT_DBG("check op=%x len=%x data=%x", opcode, length, data);
> -
> -		if (opcode == 0xff) /* EOF */
> -			break;
> -
> -		if (length == 0) {
> -			BT_ERR("%s: found instruction with length 0",
> -			       hdev->name);
> -			return -EINVAL;
> -		}
> -
> -		if (opcode == 0 && length == 1) {
> -			project_id = data;
> -			break;
> -		}
> -
> -		fwptr -= length;
> -	}
> -
> -	if (project_id < 0) {
> -		BT_ERR("%s: failed to find version instruction", hdev->name);
> -		return -EINVAL;
> -	}
> -
> -	if (project_id >= ARRAY_SIZE(project_id_to_lmp_subver)) {
> -		BT_ERR("%s: unknown project id %d", hdev->name, project_id);
> -		return -EINVAL;
> -	}
> -
> -	if (lmp_subver != project_id_to_lmp_subver[project_id]) {
> -		BT_ERR("%s: firmware is for %x but this is a %x", hdev->name,
> -		       project_id_to_lmp_subver[project_id], lmp_subver);
> -		return -EINVAL;
> -	}
> -
> -	epatch_info = (struct rtl_epatch_header *)fw->data;
> -	if (memcmp(epatch_info->signature, RTL_EPATCH_SIGNATURE, 8) != 0) {
> -		BT_ERR("%s: bad EPATCH signature", hdev->name);
> -		return -EINVAL;
> -	}
> -
> -	num_patches = le16_to_cpu(epatch_info->num_patches);
> -	BT_DBG("fw_version=%x, num_patches=%d",
> -	       le32_to_cpu(epatch_info->fw_version), num_patches);
> -
> -	/* After the rtl_epatch_header there is a funky patch metadata section.
> -	 * Assuming 2 patches, the layout is:
> -	 * ChipID1 ChipID2 PatchLength1 PatchLength2 PatchOffset1 PatchOffset2
> -	 *
> -	 * Find the right patch for this chip.
> -	 */
> -	min_size += 8 * num_patches;
> -	if (fw->size < min_size)
> -		return -EINVAL;
> -
> -	chip_id_base = fw->data + sizeof(struct rtl_epatch_header);
> -	patch_length_base = chip_id_base + (sizeof(u16) * num_patches);
> -	patch_offset_base = patch_length_base + (sizeof(u16) * num_patches);
> -	for (i = 0; i < num_patches; i++) {
> -		u16 chip_id = get_unaligned_le16(chip_id_base +
> -						 (i * sizeof(u16)));
> -		if (chip_id == rom_version + 1) {
> -			patch_length = get_unaligned_le16(patch_length_base +
> -							  (i * sizeof(u16)));
> -			patch_offset = get_unaligned_le32(patch_offset_base +
> -							  (i * sizeof(u32)));
> -			break;
> -		}
> -	}
> -
> -	if (!patch_offset) {
> -		BT_ERR("%s: didn't find patch for chip id %d",
> -		       hdev->name, rom_version);
> -		return -EINVAL;
> -	}
> -
> -	BT_DBG("length=%x offset=%x index %d", patch_length, patch_offset, i);
> -	min_size = patch_offset + patch_length;
> -	if (fw->size < min_size)
> -		return -EINVAL;
> -
> -	/* Copy the firmware into a new buffer and write the version at
> -	 * the end.
> -	 */
> -	len = patch_length;
> -	buf = kmemdup(fw->data + patch_offset, patch_length, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	memcpy(buf + patch_length - 4, &epatch_info->fw_version, 4);
> -
> -	*_buf = buf;
> -	return len;
> -}
> -
> -static int rtl_download_firmware(struct hci_dev *hdev,
> -				 const unsigned char *data, int fw_len)
> -{
> -	struct rtl_download_cmd *dl_cmd;
> -	int frag_num = fw_len / RTL_FRAG_LEN + 1;
> -	int frag_len = RTL_FRAG_LEN;
> -	int ret = 0;
> -	int i;
> -
> -	dl_cmd = kmalloc(sizeof(struct rtl_download_cmd), GFP_KERNEL);
> -	if (!dl_cmd)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < frag_num; i++) {
> -		struct rtl_download_response *dl_resp;
> -		struct sk_buff *skb;
> -
> -		BT_DBG("download fw (%d/%d)", i, frag_num);
> -
> -		dl_cmd->index = i;
> -		if (i == (frag_num - 1)) {
> -			dl_cmd->index |= 0x80; /* data end */
> -			frag_len = fw_len % RTL_FRAG_LEN;
> -		}
> -		memcpy(dl_cmd->data, data, frag_len);
> -
> -		/* Send download command */
> -		skb = __hci_cmd_sync(hdev, 0xfc20, frag_len + 1, dl_cmd,
> -				     HCI_INIT_TIMEOUT);
> -		if (IS_ERR(skb)) {
> -			BT_ERR("%s: download fw command failed (%ld)",
> -			       hdev->name, PTR_ERR(skb));
> -			ret = -PTR_ERR(skb);
> -			goto out;
> -		}
> -
> -		if (skb->len != sizeof(*dl_resp)) {
> -			BT_ERR("%s: download fw event length mismatch",
> -			       hdev->name);
> -			kfree_skb(skb);
> -			ret = -EIO;
> -			goto out;
> -		}
> -
> -		dl_resp = (struct rtl_download_response *)skb->data;
> -		if (dl_resp->status != 0) {
> -			kfree_skb(skb);
> -			ret = bt_to_errno(dl_resp->status);
> -			goto out;
> -		}
> -
> -		kfree_skb(skb);
> -		data += RTL_FRAG_LEN;
> -	}
> -
> -out:
> -	kfree(dl_cmd);
> -	return ret;
> -}
> -
> -static int btusb_setup_rtl8723a(struct hci_dev *hdev)
> -{
> -	struct btusb_data *data = dev_get_drvdata(&hdev->dev);
> -	struct usb_device *udev = interface_to_usbdev(data->intf);
> -	const struct firmware *fw;
> -	int ret;
> -
> -	BT_INFO("%s: rtl: loading rtl_bt/rtl8723a_fw.bin", hdev->name);
> -	ret = request_firmware(&fw, "rtl_bt/rtl8723a_fw.bin", &udev->dev);
> -	if (ret < 0) {
> -		BT_ERR("%s: Failed to load rtl_bt/rtl8723a_fw.bin", hdev->name);
> -		return ret;
> -	}
> -
> -	if (fw->size < 8) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	/* Check that the firmware doesn't have the epatch signature
> -	 * (which is only for RTL8723B and newer).
> -	 */
> -	if (!memcmp(fw->data, RTL_EPATCH_SIGNATURE, 8)) {
> -		BT_ERR("%s: unexpected EPATCH signature!", hdev->name);
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	ret = rtl_download_firmware(hdev, fw->data, fw->size);
> -
> -out:
> -	release_firmware(fw);
> -	return ret;
> -}
> -
> -static int btusb_setup_rtl8723b(struct hci_dev *hdev, u16 lmp_subver,
> -				const char *fw_name)
> -{
> -	struct btusb_data *data = dev_get_drvdata(&hdev->dev);
> -	struct usb_device *udev = interface_to_usbdev(data->intf);
> -	unsigned char *fw_data = NULL;
> -	const struct firmware *fw;
> -	int ret;
> -
> -	BT_INFO("%s: rtl: loading %s", hdev->name, fw_name);
> -	ret = request_firmware(&fw, fw_name, &udev->dev);
> -	if (ret < 0) {
> -		BT_ERR("%s: Failed to load %s", hdev->name, fw_name);
> -		return ret;
> -	}
> -
> -	ret = rtl8723b_parse_firmware(hdev, lmp_subver, fw, &fw_data);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = rtl_download_firmware(hdev, fw_data, ret);
> -	kfree(fw_data);
> -	if (ret < 0)
> -		goto out;
> -
> -out:
> -	release_firmware(fw);
> -	return ret;
> -}
> -
> -static int btusb_setup_realtek(struct hci_dev *hdev)
> -{
> -	struct sk_buff *skb;
> -	struct hci_rp_read_local_version *resp;
> -	u16 lmp_subver;
> -
> -	skb = btusb_read_local_version(hdev);
> -	if (IS_ERR(skb))
> -		return -PTR_ERR(skb);
> -
> -	resp = (struct hci_rp_read_local_version *)skb->data;
> -	BT_INFO("%s: rtl: examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x "
> -		"lmp_subver=%04x", hdev->name, resp->hci_ver, resp->hci_rev,
> -		resp->lmp_ver, resp->lmp_subver);
> -
> -	lmp_subver = le16_to_cpu(resp->lmp_subver);
> -	kfree_skb(skb);
> -
> -	/* Match a set of subver values that correspond to stock firmware,
> -	 * which is not compatible with standard btusb.
> -	 * If matched, upload an alternative firmware that does conform to
> -	 * standard btusb. Once that firmware is uploaded, the subver changes
> -	 * to a different value.
> -	 */
> -	switch (lmp_subver) {
> -	case RTL_ROM_LMP_8723A:
> -	case RTL_ROM_LMP_3499:
> -		return btusb_setup_rtl8723a(hdev);
> -	case RTL_ROM_LMP_8723B:
> -		return btusb_setup_rtl8723b(hdev, lmp_subver,
> -					    "rtl_bt/rtl8723b_fw.bin");
> -	case RTL_ROM_LMP_8821A:
> -		return btusb_setup_rtl8723b(hdev, lmp_subver,
> -					    "rtl_bt/rtl8821a_fw.bin");
> -	case RTL_ROM_LMP_8761A:
> -		return btusb_setup_rtl8723b(hdev, lmp_subver,
> -					    "rtl_bt/rtl8761a_fw.bin");
> -	default:
> -		BT_INFO("rtl: assuming no firmware upload needed.");
> -		return 0;
> -	}
> -}
> -
> static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
> 						       struct intel_version *ver)
> {
> @@ -3172,8 +2801,10 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
> 	}
> 
> +#ifdef CONFIG_BT_HCIBTUSB_RTL
> 	if (id->driver_info & BTUSB_REALTEK)
> 		hdev->setup = btusb_setup_realtek;
> +#endif
> 
> 	if (id->driver_info & BTUSB_AMP) {
> 		/* AMP controllers do not support SCO packets */

The rest seems to be fine and straight forward.

Regards

Marcel

