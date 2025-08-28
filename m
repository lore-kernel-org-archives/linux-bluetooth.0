Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743E29CB32;
	Thu, 28 Aug 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365570; cv=none; b=N+vHf/qyAiUXJz2I+9iQeIpBFOYPIs3fmT8JmB1N4Mvlys9GEB05VrmwtQMw4QghyAhScPFK1c92knArE4XjrGcjvWvllKr4EYyM7/vPcyagcCJIedG6A3p4PsmJiuwMdUk6C6l5W7AyHXYh/eyR4QLlRBT+LdQxQQOsGFRVfn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365570; c=relaxed/simple;
	bh=2HaGrPmoLI7inHCVASWwOwFOmxQv1pRPfcAkwl9TS0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9g0j9nNtDy0L01iyXSByNrC19O2pn0OdQj7B6pz7c0f14meD6aoTDpqrDJLIv4vZJ1L1WNtjRtwHaT1X2/2vAoYg6MJBwgw7W4P1gnv/AosLixMrgJ63AoedXVcrZ2CV9bhzxJSgTI1kEIqI4N9ytRa7iASzL0DCI+Jxg5/2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af7e7.dynamic.kabel-deutschland.de [95.90.247.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B400C60213AFC;
	Thu, 28 Aug 2025 09:18:50 +0200 (CEST)
Message-ID: <a54d3bdf-757f-481a-b8db-d3f0b5389809@molgen.mpg.de>
Date: Thu, 28 Aug 2025 09:18:49 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] Bluetooth: btrtl: Firmware format v3 support
To: Hilda Wu <hildawu@realtek.com>, Alex Lu <alex_lu@realsil.com.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 max.chou@realtek.com
References: <20250828060427.1794237-1-hildawu@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250828060427.1794237-1-hildawu@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hilda, dear Alex,


Thank you for the patch. Some minor comments. For the summary/title 
please make it a statement: Add firmware format v3 support


Am 28.08.25 um 08:04 schrieb Hilda Wu:
> From: Alex Lu <alex_lu@realsil.com.cn>
> 
> Realtek changed the format of the firmware file as v3. The driver

Where is format v3 documented? What’s the difference to v2?

> should implement the patch to extract the firmware data from the
> firmware file. The future chips must apply this patch for firmware loading.
> This patch is compatible with the both previous format, v2 and v3 as well.

Maybe:

The new implementation supports both formats: v2 and v3.

> Expected output:
> Bluetooth: btrtl_read_chip_id() hci0: RTL: chip_id status=0x00 id=0x37
> Bluetooth: btrtl_initialize() hci0: RTL: examining hci_ver=0e hci_rev=000di
> lmp_ver=0e lmp_subver=8922

Please do not wrap lines of pasted logs. Is `rtl_bt/rtl8922du_fw.bin` in 
v3 format? Where is the file?

> Bluetooth: rtl_read_rom_version() hci0: RTL: rom_version status=0 version=0
> Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl8922du_fw.bin
> Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl8922du_config.bin
> Bluetooth: rtlbt_parse_firmware_v3() hci0: RTL: key id 0
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f000:00), chip id 55,
> cut 0x01, len 0000849d
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image version: b70c202e

Could the image version be listed on the line above to improve 
readibility of the logs?

> Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rtl_bt/rtl8922du_c
> onfig_f000.bin
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f001:00), chip id 55,
> cut 0x01, len 0001b4b5
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image version: b70c202e
> Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rtl_bt/rtl8922du_c
> onfig_f001.bin
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f002:00), chip id 55,
> cut 0x01, len 00013865
> Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image version: 2481a639
> Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rtl_bt/rtl8922du_
> config_f002.bin
> Bluetooth: rtlbt_parse_firmware_v3() hci0: RTL: image payload total len:
> 0x000371b7
> Bluetooth: rtl_finalize_download() hci0: RTL: Watchdog reset status 00
> Bluetooth: rtl_finalize_download() hci0: RTL: fw version 0x2481a639

What user space tools exist to analyze v3 firmware files?

> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> Change in V4:
> - Modify access to skb->data and add descriptions
> - Fix hidden issues
> 
> Change in V3:
> - Fixed cocci warning
> 
> Change in V2:
> - Fill in the missing symbols
> - Fix build warnings
> ---
> ---
>   drivers/bluetooth/btrtl.c | 693 +++++++++++++++++++++++++++++++++++++-
>   drivers/bluetooth/btrtl.h |  99 ++++++
>   drivers/bluetooth/btusb.c |   3 +
>   3 files changed, 787 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 6abd962502e3..dbf087a8cc97 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -22,6 +22,12 @@
>   #define RTL_CHIP_8723CS_XX	5
>   #define RTL_EPATCH_SIGNATURE	"Realtech"
>   #define RTL_EPATCH_SIGNATURE_V2	"RTBTCore"
> +#define RTL_EPATCH_SIGNATURE_V3	"BTNIC003"
> +#define RTL_PATCH_V3_1			0x01

What does the _1 refer to?

> +#define RTL_PATCH_V3_PATCH_IMAGE	0x02
> +#define IMAGE_ID_F000		0xf000
> +#define IMAGE_ID_F001		0xf001
> +#define IMAGE_ID_F002		0xf002
>   #define RTL_ROM_LMP_8703B	0x8703
>   #define RTL_ROM_LMP_8723A	0x1200
>   #define RTL_ROM_LMP_8723B	0x8723
> @@ -72,6 +78,7 @@ enum btrtl_chip_id {
>   	CHIP_ID_8851B = 36,
>   	CHIP_ID_8922A = 44,
>   	CHIP_ID_8852BT = 47,
> +	CHIP_ID_8922D = 55,

Should this be a separate patch?

>   };
>   
>   struct id_table {
> @@ -98,8 +105,11 @@ struct btrtl_device_info {
>   	int cfg_len;
>   	bool drop_fw;
>   	int project_id;
> +	u32 opcode;
> +	u8 fw_type;
>   	u8 key_id;
>   	struct list_head patch_subsecs;
> +	struct list_head patch_images;
>   };
>   
>   static const struct id_table ic_id_table[] = {
> @@ -328,6 +338,15 @@ static const struct id_table ic_id_table[] = {
>   	  .fw_name  = "rtl_bt/rtl8852btu_fw",
>   	  .cfg_name = "rtl_bt/rtl8852btu_config",
>   	  .hw_info  = "rtl8852btu" },
> +
> +	/* 8922DU */
> +	{ IC_INFO(RTL_ROM_LMP_8922A, 0xd, 0xe, HCI_USB),
> +	  .config_needed = false,
> +	  .has_rom_version = true,
> +	  .has_msft_ext = true,
> +	  .fw_name  = "rtl_bt/rtl8922du_fw",
> +	  .cfg_name = "rtl_bt/rtl8922du_config",
> +	  .hw_info  = "rtl8922du" },
>   	};

Ditto. (Also, it’s not mentioned in the commit message at all.)

>   static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
> @@ -361,6 +380,34 @@ static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
>   	return &ic_id_table[i];
>   }
>   
> +static int btrtl_read_chip_id(struct hci_dev *hdev, u8 *chip_id)
> +{
> +	struct rtl_rp_read_chip_id *rp;
> +	struct sk_buff *skb;
> +	int ret = 0;
> +
> +	/* Read RTL chip id command */
> +	skb = __hci_cmd_sync(hdev, 0xfc6f, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	rp = skb_pull_data(skb, sizeof(*rp));
> +	if (!rp) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	rtl_dev_info(hdev, "chip_id status=0x%02x id=0x%02x",
> +		     rp->status, rp->chip_id);
> +
> +	if (chip_id)
> +		*chip_id = rp->chip_id;
> +
> +out:
> +	kfree_skb(skb);
> +	return ret;
> +}
> +
>   static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
>   {
>   	struct sk_buff *skb;
> @@ -439,6 +486,26 @@ static int btrtl_vendor_read_reg16(struct hci_dev *hdev,
>   	return 0;
>   }
>   
> +static int btrtl_vendor_write_mem(struct hci_dev *hdev, u32 addr, u32 val)

What is addr?

> +{
> +	struct rtl_vendor_write_cmd cp;
> +	struct sk_buff *skb;
> +	int err = 0;
> +
> +	cp.type = 0x21;

Define a macro for 0x21?

> +	cp.addr = cpu_to_le32(addr);
> +	cp.val = cpu_to_le32(val);
> +	skb = __hci_cmd_sync(hdev, 0xfc62, sizeof(cp), &cp, HCI_INIT_TIMEOUT);

Define macro for 0xfc62?

> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "RTL: Write mem32 failed (%d)", err);
> +		return err;
> +	}
> +
> +	kfree_skb(skb);
> +	return 0;
> +}
> +
>   static void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len)
>   {
>   	void *data = iov->data;
> @@ -452,6 +519,30 @@ static void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len)
>   	return data;
>   }
>   
> +static void btrtl_insert_ordered_patch_image(struct rtl_section_patch_image *image,
> +					     struct btrtl_device_info *btrtl_dev)
> +{
> +	struct list_head *pos;
> +	struct list_head *next;
> +	struct rtl_section_patch_image *node;
> +
> +	list_for_each_safe(pos, next, &btrtl_dev->patch_images) {
> +		node = list_entry(pos, struct rtl_section_patch_image, list);
> +
> +		if (node->image_id > image->image_id) {
> +			__list_add(&image->list, pos->prev, pos);
> +			return;
> +		}
> +
> +		if (node->image_id == image->image_id &&
> +		    node->index > image->index) {
> +			__list_add(&image->list, pos->prev, pos);
> +			return;
> +		}
> +	}
> +	__list_add(&image->list, pos->prev, pos);
> +}
> +
>   static void btrtl_insert_ordered_subsec(struct rtl_subsection *node,
>   					struct btrtl_device_info *btrtl_dev)
>   {
> @@ -629,6 +720,295 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
>   		return -EPERM;
>   
>   	*_buf = ptr;
> +	btrtl_dev->fw_type = FW_TYPE_V2;
> +	return len;
> +}
> +
> +static int rtlbt_parse_config(struct hci_dev *hdev,
> +			      struct rtl_section_patch_image *patch_image,
> +			      struct btrtl_device_info *btrtl_dev)
> +{
> +	const struct id_table *ic_info = NULL;
> +	const struct firmware *fw;
> +	char tmp_name[32];
> +	char filename[64];
> +	u8 *cfg_buf;
> +	char *str;
> +	char *p;
> +	int len;

size_t

> +	int ret;
> +
> +	if (btrtl_dev && btrtl_dev->ic_info)
> +		ic_info = btrtl_dev->ic_info;
> +
> +	if (!ic_info)
> +		return -EINVAL;
> +
> +	str = ic_info->cfg_name;
> +	if (btrtl_dev->fw_type == FW_TYPE_V3_1) {
> +		if (!patch_image->image_id && !patch_image->index) {
> +			snprintf(filename, sizeof(filename), "%s.bin", str);
> +			goto load_fw;
> +		}
> +		goto done;
> +	}
> +
> +	len = strlen(str);
> +	if (len > sizeof(tmp_name) - 1)
> +		len = sizeof(tmp_name) - 1;
> +	memcpy(tmp_name, str, len);
> +	tmp_name[len] = '\0';
> +
> +	str = tmp_name;
> +	p = strsep(&str, ".");
> +
> +	ret = snprintf(filename, sizeof(filename), "%s", p);
> +	if (patch_image->config_rule && patch_image->need_config) {
> +		switch (patch_image->image_id) {
> +		case IMAGE_ID_F000:
> +		case IMAGE_ID_F001:
> +		case IMAGE_ID_F002:
> +			ret += snprintf(filename + ret, sizeof(filename) - ret,
> +					"_%04x", patch_image->image_id);
> +			break;
> +		default:
> +			goto done;
> +		}
> +	} else {
> +		goto done;
> +	}
> +
> +	if (str)
> +		snprintf(filename + ret, sizeof(filename) - ret, ".%s", str);
> +	else
> +		snprintf(filename + ret, sizeof(filename) - ret, ".bin");

No idea, if the compiler generates different code, but I’d use the 
ternary operator:

     snprintf(filename + ret, sizeof(filename) - ret, ".%s", str ? str : 
".bin");

> +load_fw:
> +	rtl_dev_info(hdev, "config file: %s", filename);
> +	ret = request_firmware(&fw, filename, &hdev->dev);
> +	if (ret < 0) {
> +		rtl_dev_err(hdev, "request_firmware [%s] error", filename);

Please improve the error message, so the user knows, what going on. File 
not found? Something else?

> +		if (btrtl_dev->fw_type == FW_TYPE_V3_2) {
> +			len = 4;
> +			cfg_buf = kvmalloc(len, GFP_KERNEL);
> +			if (!cfg_buf)
> +				return -ENOMEM;
> +
> +			memset(cfg_buf, 0xff, len);
> +			patch_image->cfg_buf = cfg_buf;
> +			patch_image->cfg_len = len;
> +			return 0;
> +		}
> +		goto err_req_fw;
> +	}
> +	cfg_buf = kvmalloc(fw->size, GFP_KERNEL);
> +	if (!cfg_buf) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	memcpy(cfg_buf, fw->data, fw->size);
> +	len = fw->size;
> +	release_firmware(fw);
> +
> +	patch_image->cfg_buf = cfg_buf;
> +	patch_image->cfg_len = len;
> +done:
> +	return 0;
> +err:
> +	release_firmware(fw);
> +err_req_fw:
> +	return ret;
> +}
> +
> +static int rtlbt_parse_section_v3(struct hci_dev *hdev,
> +				  struct btrtl_device_info *btrtl_dev,
> +				  u32 opcode, u8 *data, u32 len)
> +{
> +	struct rtl_section_patch_image *patch_image;
> +	struct rtl_patch_image_hdr *hdr;
> +	u16 image_id;
> +	u16 chip_id;
> +	u32 patch_image_len;

Would `size_t` work?

> +	u8 *ptr;
> +	int ret = 0;
> +	u8 i;

No need to limit the length of counting variables. `size_t` or `unsigned 
int`.

> +	struct rtl_iovec iov = {
> +		.data = data,
> +		.len  = len,
> +	};
> +
> +	hdr = rtl_iov_pull_data(&iov, sizeof(*hdr));
> +	if (!hdr)
> +		return -EINVAL;
> +
> +	if (btrtl_dev->opcode && btrtl_dev->opcode != opcode) {
> +		rtl_dev_err(hdev, "invalid opcode 0x%02x", opcode);
> +		return -EINVAL;
> +	}
> +
> +	if (!btrtl_dev->opcode) {
> +		btrtl_dev->opcode = opcode;
> +		switch (btrtl_dev->opcode) {
> +		case RTL_PATCH_V3_1:
> +			btrtl_dev->fw_type = FW_TYPE_V3_1;
> +			break;
> +		case RTL_PATCH_V3_PATCH_IMAGE:
> +			btrtl_dev->fw_type = FW_TYPE_V3_2;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	patch_image_len = (u32)le64_to_cpu(hdr->patch_image_len);
> +	chip_id = le16_to_cpu(hdr->chip_id);
> +	image_id = le16_to_cpu(hdr->image_id);
> +	rtl_dev_info(hdev, "image (%04x:%02x), chip id %u, cut 0x%02x, len %08x"
> +		     , image_id, hdr->index, chip_id, hdr->ic_cut,
> +		     patch_image_len);
> +
> +	if (btrtl_dev->key_id && btrtl_dev->key_id != hdr->key_id) {
> +		rtl_dev_err(hdev, "invalid key_id (%u, %u)", hdr->key_id,
> +			    btrtl_dev->key_id);
> +		return -EINVAL;
> +	}
> +
> +	if (hdr->ic_cut != btrtl_dev->rom_version + 1) {
> +		rtl_dev_info(hdev, "unused ic_cut (%u, %u)", hdr->ic_cut,
> +			    btrtl_dev->rom_version + 1);
> +		return -EINVAL;
> +	}
> +
> +	if (btrtl_dev->fw_type == FW_TYPE_V3_1 && !btrtl_dev->project_id)
> +		btrtl_dev->project_id = chip_id;
> +
> +	if (btrtl_dev->fw_type == FW_TYPE_V3_2 &&
> +	    chip_id != btrtl_dev->project_id) {
> +		rtl_dev_err(hdev, "invalid chip_id (%u, %d)", chip_id,
> +			    btrtl_dev->project_id);
> +		return -EINVAL;
> +	}
> +
> +	ptr = rtl_iov_pull_data(&iov, patch_image_len);
> +	if (!ptr)
> +		return -ENODATA;
> +
> +	patch_image = kzalloc(sizeof(*patch_image), GFP_KERNEL);
> +	if (!patch_image)
> +		return -ENOMEM;
> +	patch_image->index = hdr->index;
> +	patch_image->image_id = image_id;
> +	patch_image->config_rule = hdr->config_rule;
> +	patch_image->need_config = hdr->need_config;
> +
> +	for (i = 0; i < DL_FIX_ADDR_MAX; i++) {
> +		patch_image->fix[i].addr =
> +			(u32)le64_to_cpu(hdr->addr_fix[i * 2]);
> +		patch_image->fix[i].value =
> +			(u32)le64_to_cpu(hdr->addr_fix[i * 2 + 1]);
> +	}
> +
> +	patch_image->image_len = patch_image_len;
> +	patch_image->image_data = kvmalloc(patch_image_len, GFP_KERNEL);
> +	if (!patch_image->image_data) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	memcpy(patch_image->image_data, ptr, patch_image_len);
> +	patch_image->image_ver =
> +		get_unaligned_le32(ptr + patch_image->image_len - 4);
> +	rtl_dev_info(hdev, "image version: %08x", patch_image->image_ver);
> +
> +	rtlbt_parse_config(hdev, patch_image, btrtl_dev);
> +
> +	ret = patch_image->image_len;
> +
> +	btrtl_insert_ordered_patch_image(patch_image, btrtl_dev);
> +
> +	return ret;
> +err:
> +	kfree(patch_image);
> +	return ret;
> +}

I am stopping my review here for now, and will look at the next iteration.


Kind regards,

Paul


> +
> +static int rtlbt_parse_firmware_v3(struct hci_dev *hdev,
> +				   struct btrtl_device_info *btrtl_dev)
> +{
> +	struct rtl_epatch_header_v3 *hdr;
> +	int rc;
> +	u32 num_sections;
> +	struct rtl_section_v3 *section;
> +	u32 section_len;
> +	u32 opcode;
> +	int len = 0;
> +	int i;
> +	u8 *ptr;
> +	struct rtl_iovec iov = {
> +		.data = btrtl_dev->fw_data,
> +		.len  = btrtl_dev->fw_len,
> +	};
> +	struct rtl_vendor_cmd cmd_data = { {0x10, 0xa4, 0xad, 0x00, 0xb0} };
> +	u8 reg_val[2];
> +
> +	if (btrtl_dev->project_id >= CHIP_ID_8922D) {
> +		/* A0010DA4 */
> +		cmd_data.param[2] = 0x0d;
> +		cmd_data.param[3] = 0x01;
> +		cmd_data.param[4] = 0xa0;
> +	}
> +
> +	rc = btrtl_vendor_read_reg16(hdev, &cmd_data, reg_val);
> +	if (rc < 0)
> +		return -EIO;
> +
> +	rtl_dev_info(hdev, "key id %u", reg_val[0]);
> +
> +	btrtl_dev->key_id = reg_val[0];
> +
> +	hdr = rtl_iov_pull_data(&iov, sizeof(*hdr));
> +	if (!hdr)
> +		return -EINVAL;
> +	num_sections = le32_to_cpu(hdr->num_sections);
> +
> +	rtl_dev_dbg(hdev, "timpstamp %08x-%08x", *((u32 *)hdr->timestamp),
> +		    *((u32 *)(hdr->timestamp + 4)));
> +
> +	for (i = 0; i < num_sections; i++) {
> +		section = rtl_iov_pull_data(&iov, sizeof(*section));
> +		if (!section)
> +			break;
> +
> +		section_len = (u32)le64_to_cpu(section->len);
> +		opcode = le32_to_cpu(section->opcode);
> +
> +		rtl_dev_dbg(hdev, "opcode 0x%04x", section->opcode);
> +
> +		ptr = rtl_iov_pull_data(&iov, section_len);
> +		if (!ptr)
> +			break;
> +
> +		rc = 0;
> +		switch (opcode) {
> +		case RTL_PATCH_V3_1:
> +		case RTL_PATCH_V3_PATCH_IMAGE:
> +			rc = rtlbt_parse_section_v3(hdev, btrtl_dev, opcode,
> +						    ptr, section_len);
> +			break;
> +		default:
> +			rtl_dev_warn(hdev, "Unknown opcode %08x", opcode);
> +			break;
> +		}
> +		if (rc < 0) {
> +			rtl_dev_err(hdev, "Parse section (%u) err (%d)",
> +				    opcode, rc);
> +			continue;
> +		}
> +		len += rc;
> +	}
> +
> +	rtl_dev_info(hdev, "image payload total len: 0x%08x", len);
> +	if (!len)
> +		return -ENODATA;
> +
>   	return len;
>   }
>   
> @@ -673,6 +1053,9 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>   	if (btrtl_dev->fw_len <= 8)
>   		return -EINVAL;
>   
> +	if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE_V3, 8))
> +		return rtlbt_parse_firmware_v3(hdev, btrtl_dev);
> +
>   	if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8))
>   		min_size = sizeof(struct rtl_epatch_header) +
>   				sizeof(extension_sig) + 3;
> @@ -808,10 +1191,11 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>   	memcpy(buf + patch_length - 4, &epatch_info->fw_version, 4);
>   
>   	*_buf = buf;
> +	btrtl_dev->fw_type = FW_TYPE_V1;
>   	return len;
>   }
>   
> -static int rtl_download_firmware(struct hci_dev *hdev,
> +static int rtl_download_firmware(struct hci_dev *hdev, u8 fw_type,
>   				 const unsigned char *data, int fw_len)
>   {
>   	struct rtl_download_cmd *dl_cmd;
> @@ -822,6 +1206,13 @@ static int rtl_download_firmware(struct hci_dev *hdev,
>   	int j = 0;
>   	struct sk_buff *skb;
>   	struct hci_rp_read_local_version *rp;
> +	u8 dl_rp_len = sizeof(struct rtl_download_response);
> +
> +	if (is_v3_fw(fw_type)) {
> +		j = 1;
> +		if (fw_type == FW_TYPE_V3_2)
> +			dl_rp_len++;
> +	}
>   
>   	dl_cmd = kmalloc(sizeof(*dl_cmd), GFP_KERNEL);
>   	if (!dl_cmd)
> @@ -835,7 +1226,8 @@ static int rtl_download_firmware(struct hci_dev *hdev,
>   			j = 1;
>   
>   		if (i == (frag_num - 1)) {
> -			dl_cmd->index |= 0x80; /* data end */
> +			if (!is_v3_fw(fw_type))
> +				dl_cmd->index |= 0x80; /* data end */
>   			frag_len = fw_len % RTL_FRAG_LEN;
>   		}
>   		rtl_dev_dbg(hdev, "download fw (%d/%d). index = %d", i,
> @@ -852,7 +1244,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
>   			goto out;
>   		}
>   
> -		if (skb->len != sizeof(struct rtl_download_response)) {
> +		if (skb->len != dl_rp_len) {
>   			rtl_dev_err(hdev, "download fw event length mismatch");
>   			kfree_skb(skb);
>   			ret = -EIO;
> @@ -863,6 +1255,9 @@ static int rtl_download_firmware(struct hci_dev *hdev,
>   		data += RTL_FRAG_LEN;
>   	}
>   
> +	if (is_v3_fw(fw_type))
> +		goto out;
> +
>   	skb = btrtl_read_local_version(hdev);
>   	if (IS_ERR(skb)) {
>   		ret = PTR_ERR(skb);
> @@ -880,6 +1275,237 @@ static int rtl_download_firmware(struct hci_dev *hdev,
>   	return ret;
>   }
>   
> +static int rtl_check_download_state(struct hci_dev *hdev,
> +				    struct btrtl_device_info *btrtl_dev)
> +{
> +	struct sk_buff *skb;
> +	int ret = 0;
> +	u8 *state;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfdcf, 0, NULL, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		rtl_dev_err(hdev, "write tb error %lu", PTR_ERR(skb));
> +		return -EIO;
> +	}
> +
> +	/* Other driver might be downloading the combined firmware. */
> +	state = skb_pull_data(skb, sizeof(*state));
> +	if (state && *state == 0x03) {
> +		btrealtek_set_flag(hdev, REALTEK_DOWNLOADING);
> +		ret = btrealtek_wait_on_flag_timeout(hdev, REALTEK_DOWNLOADING,
> +						     TASK_INTERRUPTIBLE,
> +						     msecs_to_jiffies(5000));
> +		if (ret == -EINTR) {
> +			bt_dev_err(hdev, "Firmware loading interrupted");
> +			goto out;
> +		}
> +
> +		if (ret) {
> +			bt_dev_err(hdev, "Firmware loading timeout");
> +			ret = -ETIMEDOUT;
> +		} else {
> +			ret = -EALREADY;
> +		}
> +
> +	}
> +
> +out:
> +	kfree_skb(skb);
> +	return ret;
> +}
> +
> +static int rtl_finalize_download(struct hci_dev *hdev,
> +				 struct btrtl_device_info *btrtl_dev)
> +{
> +	struct hci_rp_read_local_version *rp_ver;
> +	u8 params[2] = { 0x03, 0xb2 };
> +	struct sk_buff *skb;
> +	int ret = 0;
> +	u16 opcode;
> +	u32 len;
> +	u8 *p;
> +
> +	opcode = 0xfc8e;
> +	len = 2;
> +	if (btrtl_dev->opcode == RTL_PATCH_V3_1) {
> +		opcode = 0xfc20;
> +		params[0] = 0x80;
> +		len = 1;
> +	}
> +	skb = __hci_cmd_sync(hdev, opcode, len, params, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		rtl_dev_err(hdev, "Watchdog reset err (%ld)", PTR_ERR(skb));
> +		return -EIO;
> +	}
> +	p = skb_pull_data(skb, 1);
> +	if (!p) {
> +		ret = -ENODATA;
> +		goto out;
> +	}
> +	rtl_dev_info(hdev, "Watchdog reset status %02x", *p);
> +	kfree_skb(skb);
> +
> +	skb = btrtl_read_local_version(hdev);
> +	if (IS_ERR(skb)) {
> +		ret = PTR_ERR(skb);
> +		rtl_dev_err(hdev, "read local version failed (%d)", ret);
> +		return ret;
> +	}
> +
> +	rp_ver = skb_pull_data(skb, sizeof(*rp_ver));
> +	if (rp_ver)
> +		rtl_dev_info(hdev, "fw version 0x%04x%04x",
> +			     __le16_to_cpu(rp_ver->hci_rev),
> +			     __le16_to_cpu(rp_ver->lmp_subver));
> +out:
> +	kfree_skb(skb);
> +	return ret;
> +}
> +
> +static int rtl_security_check(struct hci_dev *hdev,
> +			      struct btrtl_device_info *btrtl_dev)
> +{
> +	struct rtl_section_patch_image *tmp = NULL;
> +	struct rtl_section_patch_image *image = NULL;
> +	u32 val;
> +	int ret;
> +
> +	list_for_each_entry_reverse(tmp, &btrtl_dev->patch_images, list) {
> +		/* Check security hdr */
> +		if (!tmp->fix[DL_FIX_SEC_HDR_ADDR].value ||
> +		    !tmp->fix[DL_FIX_SEC_HDR_ADDR].addr ||
> +		    tmp->fix[DL_FIX_SEC_HDR_ADDR].addr == 0xffffffff)
> +			continue;
> +		rtl_dev_info(hdev, "addr 0x%08x, value 0x%08x",
> +			     tmp->fix[DL_FIX_SEC_HDR_ADDR].addr,
> +			     tmp->fix[DL_FIX_SEC_HDR_ADDR].value);
> +		image = tmp;
> +		break;
> +	}
> +
> +	if (!image)
> +		return 0;
> +
> +	rtl_dev_info(hdev, "sec image (%04x:%02x)", image->image_id,
> +		     image->index);
> +	val = image->fix[DL_FIX_PATCH_ADDR].value + image->image_len -
> +					image->fix[DL_FIX_SEC_HDR_ADDR].value;
> +	ret = btrtl_vendor_write_mem(hdev, image->fix[DL_FIX_PATCH_ADDR].addr,
> +				     val);
> +	if (ret) {
> +		rtl_dev_err(hdev, "write sec reg failed (%d)", ret);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int rtl_download_firmware_v3(struct hci_dev *hdev,
> +				    struct btrtl_device_info *btrtl_dev)
> +{
> +	struct rtl_section_patch_image *image, *tmp;
> +	struct rtl_rp_dl_v3 *rp;
> +	struct sk_buff *skb;
> +	u8 *fw_data;
> +	int fw_len;
> +	int ret = 0;
> +	u8 i;
> +
> +	if (btrtl_dev->fw_type == FW_TYPE_V3_2) {
> +		ret = rtl_check_download_state(hdev, btrtl_dev);
> +		if (ret) {
> +			if (ret == -EALREADY)
> +				return 0;
> +			return ret;
> +		}
> +	}
> +
> +	list_for_each_entry_safe(image, tmp, &btrtl_dev->patch_images, list) {
> +		rtl_dev_dbg(hdev, "image (%04x:%02x)", image->image_id,
> +			    image->index);
> +
> +		for (i = DL_FIX_CI_ID; i < DL_FIX_ADDR_MAX; i++) {
> +			if (!image->fix[i].addr ||
> +			    image->fix[i].addr == 0xffffffff) {
> +				rtl_dev_dbg(hdev, "no need to write addr %08x",
> +					    image->fix[i].addr);
> +				continue;
> +			}
> +			rtl_dev_dbg(hdev, "write addr and val, 0x%08x, 0x%08x",
> +				    image->fix[i].addr, image->fix[i].value);
> +			if (btrtl_vendor_write_mem(hdev, image->fix[i].addr,
> +						   image->fix[i].value)) {
> +				rtl_dev_err(hdev, "write reg failed");
> +				ret = -EIO;
> +				goto done;
> +			}
> +		}
> +
> +		fw_len = image->image_len + image->cfg_len;
> +		fw_data = kvmalloc(fw_len, GFP_KERNEL);
> +		if (!fw_data) {
> +			rtl_dev_err(hdev, "Couldn't alloc buf for image data");
> +			ret = -ENOMEM;
> +			goto done;
> +		}
> +		memcpy(fw_data, image->image_data, image->image_len);
> +		if (image->cfg_len > 0)
> +			memcpy(fw_data + image->image_len, image->cfg_buf,
> +			       image->cfg_len);
> +
> +		rtl_dev_dbg(hdev, "patch image (%04x:%02x). len: %d",
> +			    image->image_id, image->index, fw_len);
> +		rtl_dev_dbg(hdev, "fw_data %p, image buf %p, len %u", fw_data,
> +			    image->image_data, image->image_len);
> +
> +		ret = rtl_download_firmware(hdev, btrtl_dev->fw_type, fw_data,
> +					    fw_len);
> +		kvfree(fw_data);
> +		if (ret < 0) {
> +			rtl_dev_err(hdev, "download firmware failed (%d)", ret);
> +			goto done;
> +		}
> +
> +		if (image->list.next != &btrtl_dev->patch_images &&
> +		    image->image_id == tmp->image_id)
> +			continue;
> +
> +		if (btrtl_dev->fw_type == FW_TYPE_V3_1)
> +			continue;
> +
> +		i = 0x80;
> +		skb = __hci_cmd_sync(hdev, 0xfc20, 1, &i, HCI_CMD_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			ret = -EIO;
> +			rtl_dev_err(hdev, "Failed to issue last cmd fc20, %ld",
> +				    PTR_ERR(skb));
> +			goto done;
> +		}
> +		ret = 2;
> +		rp = skb_pull_data(skb, sizeof(*rp));
> +		if (rp)
> +			ret = rp->err;
> +		kfree_skb(skb);
> +		if (ret == 2) {
> +			/* Verification failure */
> +			ret = -EFAULT;
> +			goto done;
> +		}
> +	}
> +
> +	if (btrtl_dev->fw_type == FW_TYPE_V3_1) {
> +		ret = rtl_security_check(hdev, btrtl_dev);
> +		if (ret) {
> +			rtl_dev_err(hdev, "Security check failed (%d)", ret);
> +			goto done;
> +		}
> +	}
> +
> +	ret = rtl_finalize_download(hdev, btrtl_dev);
> +
> +done:
> +	return ret;
> +}
> +
>   static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **buff)
>   {
>   	const struct firmware *fw;
> @@ -913,7 +1539,7 @@ static int btrtl_setup_rtl8723a(struct hci_dev *hdev,
>   		return -EINVAL;
>   	}
>   
> -	return rtl_download_firmware(hdev, btrtl_dev->fw_data,
> +	return rtl_download_firmware(hdev, FW_TYPE_V0, btrtl_dev->fw_data,
>   				     btrtl_dev->fw_len);
>   }
>   
> @@ -928,7 +1554,7 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
>   	if (ret < 0)
>   		goto out;
>   
> -	if (btrtl_dev->cfg_len > 0) {
> +	if (!is_v3_fw(btrtl_dev->fw_type) && btrtl_dev->cfg_len > 0) {
>   		tbuff = kvzalloc(ret + btrtl_dev->cfg_len, GFP_KERNEL);
>   		if (!tbuff) {
>   			ret = -ENOMEM;
> @@ -944,9 +1570,14 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
>   		fw_data = tbuff;
>   	}
>   
> +	if (is_v3_fw(btrtl_dev->fw_type)) {
> +		ret = rtl_download_firmware_v3(hdev, btrtl_dev);
> +		goto out;
> +	}
> +
>   	rtl_dev_info(hdev, "cfg_sz %d, total sz %d", btrtl_dev->cfg_len, ret);
>   
> -	ret = rtl_download_firmware(hdev, fw_data, ret);
> +	ret = rtl_download_firmware(hdev, btrtl_dev->fw_type, fw_data, ret);
>   
>   out:
>   	kvfree(fw_data);
> @@ -1042,6 +1673,7 @@ static int rtl_read_chip_type(struct hci_dev *hdev, u8 *type)
>   void btrtl_free(struct btrtl_device_info *btrtl_dev)
>   {
>   	struct rtl_subsection *entry, *tmp;
> +	struct rtl_section_patch_image *image, *next;
>   
>   	kvfree(btrtl_dev->fw_data);
>   	kvfree(btrtl_dev->cfg_data);
> @@ -1051,6 +1683,13 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev)
>   		kfree(entry);
>   	}
>   
> +	list_for_each_entry_safe(image, next, &btrtl_dev->patch_images, list) {
> +		list_del(&image->list);
> +		kvfree(image->image_data);
> +		kvfree(image->cfg_buf);
> +		kfree(image);
> +	}
> +
>   	kfree(btrtl_dev);
>   }
>   EXPORT_SYMBOL_GPL(btrtl_free);
> @@ -1058,7 +1697,7 @@ EXPORT_SYMBOL_GPL(btrtl_free);
>   struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>   					   const char *postfix)
>   {
> -	struct btrealtek_data *coredump_info = hci_get_priv(hdev);
> +	struct btrealtek_data *btrtl_data = hci_get_priv(hdev);
>   	struct btrtl_device_info *btrtl_dev;
>   	struct sk_buff *skb;
>   	struct hci_rp_read_local_version *resp;
> @@ -1069,6 +1708,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>   	u8 hci_ver, lmp_ver, chip_type = 0;
>   	int ret;
>   	u8 reg_val[2];
> +	u8 chip_id = 0;
>   
>   	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
>   	if (!btrtl_dev) {
> @@ -1077,8 +1717,15 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>   	}
>   
>   	INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
> +	INIT_LIST_HEAD(&btrtl_dev->patch_images);
>   
>   check_version:
> +	ret = btrtl_read_chip_id(hdev, &chip_id);
> +	if (!ret && chip_id >= CHIP_ID_8922D) {
> +		btrtl_dev->project_id = chip_id;
> +		goto read_local_ver;
> +	}
> +
>   	ret = btrtl_vendor_read_reg16(hdev, RTL_CHIP_SUBVER, reg_val);
>   	if (ret < 0)
>   		goto err_free;
> @@ -1101,6 +1748,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>   		}
>   	}
>   
> +read_local_ver:
>   	skb = btrtl_read_local_version(hdev);
>   	if (IS_ERR(skb)) {
>   		ret = PTR_ERR(skb);
> @@ -1228,7 +1876,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>   		hci_set_msft_opcode(hdev, 0xFCF0);
>   
>   	if (btrtl_dev->ic_info)
> -		coredump_info->rtl_dump.controller = btrtl_dev->ic_info->hw_info;
> +		btrtl_data->rtl_dump.controller = btrtl_dev->ic_info->hw_info;
>   
>   	return btrtl_dev;
>   
> @@ -1301,6 +1949,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
>   	case CHIP_ID_8851B:
>   	case CHIP_ID_8922A:
>   	case CHIP_ID_8852BT:
> +	case CHIP_ID_8922D:
>   		hci_set_quirk(hdev, HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED);
>   
>   		/* RTL8852C needs to transmit mSBC data continuously without
> @@ -1387,6 +2036,34 @@ int btrtl_shutdown_realtek(struct hci_dev *hdev)
>   }
>   EXPORT_SYMBOL_GPL(btrtl_shutdown_realtek);
>   
> +int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
> +	struct hci_event_hdr *hdr;
> +	u8 *p;
> +
> +	if (!clone)
> +		goto out;
> +
> +	hdr = skb_pull_data(clone, sizeof(*hdr));
> +	if (!hdr || hdr->evt != HCI_VENDOR_PKT)
> +		goto out;
> +
> +	p = skb_pull_data(clone, 1);
> +	if (!p)
> +		goto out;
> +	switch (*p) {
> +	case 0x77:
> +		if (btrealtek_test_and_clear_flag(hdev, REALTEK_DOWNLOADING))
> +			btrealtek_wake_up_flag(hdev, REALTEK_DOWNLOADING);
> +		break;
> +	}
> +out:
> +	consume_skb(clone);
> +	return hci_recv_frame(hdev, skb);
> +}
> +EXPORT_SYMBOL_GPL(btrtl_recv_event);
> +
>   static unsigned int btrtl_convert_baudrate(u32 device_baudrate)
>   {
>   	switch (device_baudrate) {
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index a2d9d34f9fb0..e642a9da586c 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -12,6 +12,19 @@
>   #define rtl_dev_info(dev, fmt, ...) bt_dev_info(dev, "RTL: " fmt, ##__VA_ARGS__)
>   #define rtl_dev_dbg(dev, fmt, ...) bt_dev_dbg(dev, "RTL: " fmt, ##__VA_ARGS__)
>   
> +#define FW_TYPE_V0		0
> +#define FW_TYPE_V1		1
> +#define FW_TYPE_V2		2
> +#define FW_TYPE_V3_1		3
> +#define FW_TYPE_V3_2		4
> +#define is_v3_fw(type)	(type == FW_TYPE_V3_1 || type == FW_TYPE_V3_2)
> +
> +#define DL_FIX_CI_ID		0
> +#define DL_FIX_CI_ADDR		1
> +#define DL_FIX_PATCH_ADDR	2
> +#define DL_FIX_SEC_HDR_ADDR	3
> +#define DL_FIX_ADDR_MAX		4
> +
>   struct btrtl_device_info;
>   
>   struct rtl_chip_type_evt {
> @@ -103,8 +116,79 @@ struct rtl_vendor_cmd {
>   	__u8 param[5];
>   } __packed;
>   
> +struct rtl_vendor_write_cmd {
> +	u8 type;
> +	__le32 addr;
> +	__le32 val;
> +} __packed;
> +
> +struct rtl_rp_read_chip_id {
> +	__u8 status;
> +	__u8 chip_id;
> +} __packed;
> +
> +struct rtl_rp_dl_v3 {
> +	__u8 status;
> +	__u8 index;
> +	__u8 err;
> +} __packed;
> +
> +struct rtl_epatch_header_v3 {
> +	__u8 signature[8];
> +	__u8 timestamp[8];
> +	__le32 ver_rsvd;
> +	__le32 num_sections;
> +} __packed;
> +
> +struct rtl_section_v3 {
> +	__le32 opcode;
> +	__le64 len;
> +	u8 data[];
> +} __packed;
> +
> +struct rtl_addr_fix {
> +	u32 addr;
> +	u32 value;
> +};
> +
> +struct rtl_section_patch_image {
> +	u16 image_id;
> +	u8 index;
> +	u8 config_rule;
> +	u8 need_config;
> +
> +	struct rtl_addr_fix fix[DL_FIX_ADDR_MAX];
> +
> +	u32 image_len;
> +	u8 *image_data;
> +	u32 image_ver;
> +
> +	u8  *cfg_buf;
> +	u16 cfg_len;
> +
> +	struct list_head list;
> +};
> +
> +struct rtl_patch_image_hdr {
> +	__le16 chip_id;
> +	u8 ic_cut;
> +	u8 key_id;
> +	u8 enable_ota;
> +	__le16 image_id;
> +	u8 config_rule;
> +	u8 need_config;
> +	u8 rsv[950];
> +
> +	__le64 addr_fix[DL_FIX_ADDR_MAX * 2];
> +	u8 index;
> +
> +	__le64 patch_image_len;
> +	__u8 data[];
> +} __packed;
> +
>   enum {
>   	REALTEK_ALT6_CONTINUOUS_TX_CHIP,
> +	REALTEK_DOWNLOADING,
>   
>   	__REALTEK_NUM_FLAGS,
>   };
> @@ -130,7 +214,16 @@ struct btrealtek_data {
>   #define btrealtek_get_flag(hdev)					\
>   	(((struct btrealtek_data *)hci_get_priv(hdev))->flags)
>   
> +#define btrealtek_wake_up_flag(hdev, nr)				\
> +	do {								\
> +		struct btrealtek_data *rtl = hci_get_priv((hdev));	\
> +		wake_up_bit(rtl->flags, (nr));				\
> +	} while (0)
>   #define btrealtek_test_flag(hdev, nr)	test_bit((nr), btrealtek_get_flag(hdev))
> +#define btrealtek_test_and_clear_flag(hdev, nr)				\
> +		test_and_clear_bit((nr), btrealtek_get_flag(hdev))
> +#define btrealtek_wait_on_flag_timeout(hdev, nr, m, to)			\
> +		wait_on_bit_timeout(btrealtek_get_flag(hdev), (nr), m, to)
>   
>   #if IS_ENABLED(CONFIG_BT_RTL)
>   
> @@ -148,6 +241,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>   			    unsigned int *controller_baudrate,
>   			    u32 *device_baudrate, bool *flow_control);
>   void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name);
> +int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb);
>   
>   #else
>   
> @@ -157,6 +251,11 @@ static inline struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>   	return ERR_PTR(-EOPNOTSUPP);
>   }
>   
> +static inline int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline void btrtl_free(struct btrtl_device_info *btrtl_dev)
>   {
>   }
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3595a8bad6bd..511e191edca9 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2685,6 +2685,9 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
>   		return 0;
>   	}
>   
> +	if (skb->data[0] == HCI_VENDOR_PKT)
> +		return btrtl_recv_event(hdev, skb);
> +
>   	return hci_recv_frame(hdev, skb);
>   }
>   

