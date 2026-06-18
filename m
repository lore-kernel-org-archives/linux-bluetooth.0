Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC6211466;
	Thu, 18 Jun 2026 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760663; cv=none; b=tQ76rlKEre4Qn8+W/Ur9Dwy0bRCSyijnKv+cBzjmGuB4YvGyDnmWQcvH1AfhufDycb9rANRQgsxBEUqDQ+Fgn+REXBZ5VKKnQsmlUgswn6y+vrRFMDzg92rUuglbGcVxJY+Dsslk3SlEi+6eTOlPOWybtAkXO2g2VBfqvLEoN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760663; c=relaxed/simple;
	bh=JVBLQr9mcav3HSmTSUUc4Wm/KXUCctZBLoTt2hfSDAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHeskESekqAT24PAquFQ++cT2WpRxEv70lwSuFiQSFk0w2AZ1n9lOYdHXeCbZfoz27sebC4km1YNYpPhEqZ5A2OHp+1pMbMDPIjGrC545oyz6XCHVjnWbU5x4TliOzngBOzGXC3O5Y33GnNBYmUIS8QXxvxvHIyFZ26xoh52X0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af119.dynamic.kabel-deutschland.de [95.90.241.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 01ECC4C1A4F360;
	Thu, 18 Jun 2026 07:30:22 +0200 (CEST)
Message-ID: <36ecf0bd-8d3f-482d-891d-c07b4c81a145@molgen.mpg.de>
Date: Thu, 18 Jun 2026 07:30:22 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btmtk: Add MT7928 support
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Will Lee <will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>,
 Steve Lee <steve.lee@mediatek.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20260617235145.2582862-1-chris.lu@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260617235145.2582862-1-chris.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 18.06.26 um 01:51 schrieb Chris Lu:
> Add support for MT7928 (internal device ID is MT7935) which
> requires additional firmware (CBMCU firmware) loading before
> Bluetooth firmware.
> 
> CBMCU is a new component on MT7928 to handle common part shared
> across the combo chip (Wi-Fi/Bluetooth's subsystem), providing
> a better user experience through improved coordination between
> subsystems.
> 
> Implement two-phase CBMCU firmware download: Phase 1 loads
> section with type 0x5 containing global descriptor,
> section maps and signature data; Phase 2 loads remaining
> firmware sections. Add retry mechanism for concurrent download
> protection.
> 
> After CBMCU firmware loads successfully, the driver continues
> to load corresponding BT firmware based on device ID through
> fallthrough to case 0x7922/0x7925.
> 
> The firmware required for MT7928 will be scheduled for upload
> to linux-firmware at a later stage.

Should you resend please re-flow for 72 characters per line to use less 
lines.

Also, please mention the document name, revision and file name, where 
the CBMCU format is described.

> MT7928 bringup kernel log:
> [90.209995] usb 1-3: New USB device found, idVendor=0e8d,
>              idProduct=7935, bcdDevice= 1.00
> [90.210027] usb 1-3: New USB device strings: Mfr=5,
>              Product=6, SerialNumber=7
> [90.210046] usb 1-3: Product: Wireless_Device
> [90.210060] usb 1-3: Manufacturer: MediaTek Inc.
> [90.210075] usb 1-3: SerialNumber: 000000000
> [90.223089] Bluetooth: hci1: CBMCU Version: 0x00000000,
>              Build Time: 20260601T161751+0800
> [90.664706] Bluetooth: hci1: CBMCU firmware download completed
> [90.685424] Bluetooth: hci1: HW/SW Version: 0x00000000,
>              Build Time: 20260527000816
> [93.771612] Bluetooth: hci1: Device setup in 3467323 usecs

Wow, over three seconds is too long. Can you please check how to bring 
this below one second.

> [93.771657] Bluetooth: hci1: HCI Enhanced Setup Synchronous
>              Connection command is advertised, but not supported.
> [93.890840] Bluetooth: hci1: AOSP extensions version v2.00
> [93.890887] Bluetooth: hci1: AOSP quality report is supported
> [93.893444] Bluetooth: MGMT ver 1.23

Please do not wrap pasted logs. `scripts/checkpatch.pl` should not complain:

```
# Check if the commit log is in a possible stack dump
                 if ($in_commit_log && !$commit_log_possible_stack_dump &&
                     ($line =~ /^\s*(?:WARNING:|BUG:)/ ||
                      $line =~ /^\s*\[\s*\d+\.\d{6,6}\s*\]/ ||
                                         # timestamp
                      $line =~ /^\s*\[\<[0-9a-fA-F]{8,}\>\]/) ||
                      $line =~ /^(?:\s+\w+:\s+[0-9a-fA-F]+){3,3}/ ||
                      $line =~ /^\s*\#\d+\s*\[[0-9a-fA-F]+\]\s*\w+ at 
[0-9a-fA-F]+/) {
                                         # stack dump address styles
                         $commit_log_possible_stack_dump = 1;
                 }
```

> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
> v1->v2: Update error message; Use macro instead of magic number.
> v2->v3: Update commit message.
> ---
>   drivers/bluetooth/btmtk.c | 348 +++++++++++++++++++++++++++++++++++++-
>   drivers/bluetooth/btmtk.h |   3 +
>   2 files changed, 350 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 02a96342e964..6bae0b0794dd 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -21,6 +21,8 @@
>   #define MTK_FW_ROM_PATCH_SEC_MAP_SIZE	64
>   #define MTK_SEC_MAP_COMMON_SIZE	12
>   #define MTK_SEC_MAP_NEED_SEND_SIZE	52
> +#define MTK_SEC_MAP_LENGTH_SIZE	4
> +#define MTK_SEC_CBMCU_DESC	0x5
>   
>   /* It is for mt79xx iso data transmission setting */
>   #define MTK_ISO_THRESHOLD	264
> @@ -120,6 +122,10 @@ void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
>   		snprintf(buf, size,
>   			 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
>   			 dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff) + 1);
> +	else if (dev_id == 0x7935)

I wonder if the marketing name should be added as a comment.

> +		snprintf(buf, size,
> +			 "mediatek/mt7928/BT_RAM_CODE_MT%04x_1_1_hdr.bin",
> +			 dev_id & 0xffff);

`dev_id` is u32, so the truncatation is unnecessary?

>   	else if (dev_id == 0x7961 && fw_flavor)
>   		snprintf(buf, size,
>   			 "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
> @@ -734,6 +740,7 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
>   			status = BTMTK_WMT_ON_UNDONE;
>   		break;
>   	case BTMTK_WMT_PATCH_DWNLD:
> +	case BTMTK_WMT_CBMCU_DWNLD:
>   		if (wmt_evt->whdr.flag == 2)
>   			status = BTMTK_WMT_PATCH_DONE;
>   		else if (wmt_evt->whdr.flag == 1)
> @@ -870,6 +877,334 @@ static u32 btmtk_usb_reset_done(struct hci_dev *hdev)
>   	return val & MTK_BT_RST_DONE;
>   }
>   
> +static int btmtk_cbmcu_patch_status(struct hci_dev *hdev,
> +				    wmt_cmd_sync_func_t wmt_cmd_sync,
> +				    u8 *patch_status)
> +{
> +	struct btmtk_hci_wmt_params wmt_params;
> +	int status, err, retry = 20;
> +
> +	do {
> +		wmt_params.op = BTMTK_WMT_CBMCU_DWNLD;
> +		wmt_params.flag = 0xF0;
> +		wmt_params.dlen = 0;
> +		wmt_params.data = NULL;
> +		wmt_params.status = &status;
> +
> +		err = wmt_cmd_sync(hdev, &wmt_params);
> +		if (err < 0) {
> +			bt_dev_err(hdev, "Failed to query CBMCU patch status (%d)", err);
> +			return err;
> +		}
> +
> +		*patch_status = (u8)status;
> +
> +		if (*patch_status == BTMTK_WMT_PATCH_PROGRESS) {
> +			msleep(100);
> +			retry--;
> +		} else {
> +			break;
> +		}
> +	} while (retry > 0);
> +
> +	return 0;
> +}
> +
> +static int btmtk_query_cbmcu_section(struct hci_dev *hdev,
> +				     wmt_cmd_sync_func_t wmt_cmd_sync,
> +				     u8 cbmcu_type,
> +				     const u8 *section_map,
> +				     u32 cert_len)
> +{
> +	struct btmtk_hci_wmt_params wmt_params;
> +	u8 cmd[64];
> +	int status, err;
> +
> +	cmd[0] = 0;
> +	cmd[1] = cbmcu_type;
> +
> +	if (cbmcu_type == 0)
> +		put_unaligned_le32(cert_len, &cmd[2]);
> +	else
> +		memcpy(&cmd[2], section_map, MTK_SEC_MAP_NEED_SEND_SIZE);
> +
> +	wmt_params.op = BTMTK_WMT_CBMCU_DWNLD;
> +	wmt_params.flag = 0;
> +	wmt_params.dlen = cbmcu_type ?
> +		MTK_SEC_MAP_NEED_SEND_SIZE + 2 :
> +		MTK_SEC_MAP_LENGTH_SIZE + 2;
> +	wmt_params.data = cmd;
> +	wmt_params.status = &status;
> +
> +	err = wmt_cmd_sync(hdev, &wmt_params);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to query CBMCU section (%d)", err);
> +		return err;
> +	}
> +
> +	/* Query should return UNDONE status for successful section query */
> +	if (status != BTMTK_WMT_PATCH_UNDONE) {
> +		bt_dev_err(hdev, "CBMCU section query status error (%d)", status);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int btmtk_download_cbmcu_section(struct hci_dev *hdev,
> +					wmt_cmd_sync_func_t wmt_cmd_sync,
> +					const u8 *fw_data,
> +					u32 dl_size)
> +{
> +	struct btmtk_hci_wmt_params wmt_params;
> +	u32 sent_len, total_size = dl_size;
> +	int err;
> +
> +	wmt_params.op = BTMTK_WMT_CBMCU_DWNLD;
> +	wmt_params.status = NULL;
> +
> +	while (dl_size > 0) {
> +		sent_len = min_t(u32, 250, dl_size);
> +
> +		if (dl_size == total_size)
> +			wmt_params.flag = 1;
> +		else if (dl_size == sent_len)
> +			wmt_params.flag = 3;
> +		else
> +			wmt_params.flag = 2;

This is not easy to read, as it’s not clear right away, what 1, 2 and 3 
mean. Maybe use enums?

> +
> +		wmt_params.dlen = sent_len;
> +		wmt_params.data = fw_data;
> +
> +		err = wmt_cmd_sync(hdev, &wmt_params);
> +		if (err < 0) {
> +			bt_dev_err(hdev, "Failed to send CBMCU section data (%d)", err);

Print the sent parameters? Or will `wmt_cmd_sync()` log something?

> +			return err;
> +		}
> +
> +		dl_size -= sent_len;
> +		fw_data += sent_len;
> +	}
> +
> +	return 0;
> +}
> +
> +static int btmtk_enable_cbmcu_patch(struct hci_dev *hdev,
> +				    wmt_cmd_sync_func_t wmt_cmd_sync)
> +{
> +	struct btmtk_hci_wmt_params wmt_params;
> +	int err;
> +
> +	wmt_params.op = BTMTK_WMT_CBMCU_DWNLD;
> +	wmt_params.flag = 0xF1;

Ditto.

> +	wmt_params.dlen = 0;
> +	wmt_params.data = NULL;
> +	wmt_params.status = NULL;
> +
> +	err = wmt_cmd_sync(hdev, &wmt_params);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to enable CBMCU patch (%d)", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int btmtk_load_cbmcu_firmware(struct hci_dev *hdev,
> +				     const char *fwname,
> +				     wmt_cmd_sync_func_t wmt_cmd_sync)
> +{
> +	struct btmtk_patch_header *hdr;
> +	struct btmtk_global_desc *globaldesc;
> +	struct btmtk_section_map *sectionmap;
> +	const struct firmware *fw;
> +	const u8 *fw_ptr;
> +	u8 *cert_buf = NULL;
> +	u32 section_num, section_offset, dl_size, cert_len;
> +	int i, err;
> +
> +	err = request_firmware(&fw, fwname, &hdev->dev);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to load CBMCU firmware file %s (%d)",
> +			   fwname, err);
> +		return err;
> +	}
> +
> +	if (fw->size < MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD_SIZE) {
> +		bt_dev_err(hdev, "CBMCU firmware too small (%zu bytes)", fw->size);

Please log `MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD_SIZE`.

> +		err = -EINVAL;
> +		goto err_release_fw;
> +	}
> +
> +	fw_ptr = fw->data;
> +	hdr = (struct btmtk_patch_header *)fw_ptr;
> +	globaldesc = (struct btmtk_global_desc *)(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE);
> +	section_num = le32_to_cpu(globaldesc->section_num);
> +
> +	if (fw->size < MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD_SIZE +
> +		       (size_t)MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_num) {
> +		bt_dev_err(hdev, "CBMCU firmware truncated: size=%zu, expected=%zu (section_num=%u)",
> +			   fw->size,
> +			   MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD_SIZE +
> +			   (size_t)MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_num,
> +			   section_num);
> +		err = -EINVAL;
> +		goto err_release_fw;
> +	}
> +
> +	bt_dev_info(hdev, "CBMCU Version: 0x%04x%04x, Build Time: %s",
> +		    le16_to_cpu(hdr->hwver), le16_to_cpu(hdr->swver), hdr->datetime);
> +
> +	/* Phase 1: Download section type MTK_SEC_CBMCU_DESC */
> +	for (i = 0; i < section_num; i++) {
> +		sectionmap = (struct btmtk_section_map *)
> +			(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE +
> +			 MTK_FW_ROM_PATCH_GD_SIZE +
> +			 MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
> +
> +		/* Only process MTK_SEC_CBMCU_DESC section in Phase 1 */
> +		if ((le32_to_cpu(sectionmap->sectype) & 0xFFFF) != MTK_SEC_CBMCU_DESC)
> +			continue;
> +
> +		section_offset = le32_to_cpu(sectionmap->secoffset);
> +		dl_size = le32_to_cpu(sectionmap->secsize);
> +
> +		if (dl_size == 0)
> +			continue;
> +
> +		if (section_offset > fw->size ||
> +		    dl_size > fw->size - section_offset) {
> +			bt_dev_err(hdev, "CBMCU Phase 1 section out of bounds");
> +			err = -EINVAL;
> +			goto err_release_fw;
> +		}
> +
> +		cert_len = MTK_FW_ROM_PATCH_GD_SIZE +
> +			   MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_num +
> +			   dl_size;
> +
> +		/* Query cbmcu section */
> +		err = btmtk_query_cbmcu_section(hdev, wmt_cmd_sync, 0, NULL,
> +						cert_len);
> +		if (err < 0)
> +			goto err_release_fw;
> +
> +		cert_buf = kmalloc(cert_len, GFP_KERNEL);
> +		if (!cert_buf) {
> +			err = -ENOMEM;
> +			goto err_release_fw;
> +		}
> +
> +		/* Copy Global Descriptor + All Section Maps */
> +		memcpy(cert_buf,
> +		       fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE,
> +		       MTK_FW_ROM_PATCH_GD_SIZE + MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_num);
> +
> +		/* Copy Phase 1 section data */
> +		memcpy(cert_buf + MTK_FW_ROM_PATCH_GD_SIZE +
> +		       MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_num,
> +		       fw_ptr + section_offset,
> +		       dl_size);
> +
> +		/* Download Phase 1 section */
> +		err = btmtk_download_cbmcu_section(hdev, wmt_cmd_sync,
> +						   cert_buf, cert_len);
> +		kfree(cert_buf);
> +		cert_buf = NULL;
> +
> +		if (err < 0) {
> +			bt_dev_err(hdev, "Failed to download CBMCU Phase 1 section (%d)", err);
> +			goto err_release_fw;
> +		}
> +
> +		break;
> +	}
> +
> +	/* Phase 2: Download other sections (type != MTK_SEC_CBMCU_DESC) */
> +	for (i = 0; i < section_num; i++) {
> +		sectionmap = (struct btmtk_section_map *)
> +			(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE +
> +			 MTK_FW_ROM_PATCH_GD_SIZE +
> +			 MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
> +
> +		/* Skip MTK_SEC_CBMCU_DESC section in Phase 2 */
> +		if ((le32_to_cpu(sectionmap->sectype) & 0xFFFF) == MTK_SEC_CBMCU_DESC)
> +			continue;
> +
> +		section_offset = le32_to_cpu(sectionmap->secoffset);
> +		dl_size = le32_to_cpu(sectionmap->bin_info_spec.dlsize);
> +
> +		if (dl_size == 0)
> +			continue;
> +
> +		if (section_offset > fw->size ||
> +		    dl_size > fw->size - section_offset) {
> +			bt_dev_err(hdev, "CBMCU Phase 2 section %d out of bounds", i);
> +			err = -EINVAL;
> +			goto err_release_fw;
> +		}
> +
> +		/* Query cbmcu section */
> +		err = btmtk_query_cbmcu_section(hdev, wmt_cmd_sync, 1,
> +						(u8 *)&sectionmap->bin_info_spec,
> +						0);
> +		if (err < 0)
> +			goto err_release_fw;
> +
> +		/* Download section data */
> +		err = btmtk_download_cbmcu_section(hdev, wmt_cmd_sync,
> +						   fw_ptr + section_offset,
> +						   dl_size);
> +		if (err < 0) {
> +			bt_dev_err(hdev, "Failed to download CBMCU section %d (%d)", i, err);
> +			goto err_release_fw;
> +		}
> +	}
> +
> +	/* Wait for firmware activation */
> +	usleep_range(100000, 120000);

Does the firmware really take this long? (Please report to the firmware 
engineers to optimize this. Optimized Linux takes less time. ;-)) Isn’t 
there a way to poll the readiness?

> +
> +	bt_dev_info(hdev, "CBMCU firmware download completed");

For me, Linux uploads firmware to the device (and the BT device would 
download it). But this is not a BT device message but the OS message? 
Feel free to ignore.

> +
> +err_release_fw:
> +	release_firmware(fw);
> +	return err;
> +}
> +
> +static int btmtk_setup_cbmcu_firmware(struct hci_dev *hdev,
> +				      wmt_cmd_sync_func_t wmt_cmd_sync,
> +				      u32 dev_id)
> +{
> +	char cbmcu_fwname[64];
> +	u8 patch_status;
> +	int err;
> +
> +	err = btmtk_cbmcu_patch_status(hdev, wmt_cmd_sync, &patch_status);
> +	if (err < 0)
> +		return err;
> +
> +	bt_dev_dbg(hdev, "CBMCU patch status: 0x%02x", patch_status);
> +
> +	if (patch_status != BTMTK_WMT_PATCH_UNDONE)
> +		return 0;
> +
> +	snprintf(cbmcu_fwname, sizeof(cbmcu_fwname),
> +		 "mediatek/mt7928/CBMCU_CODE_MT%04x_1_1.bin",
> +		 dev_id & 0xffff);
> +
> +	err = btmtk_load_cbmcu_firmware(hdev, cbmcu_fwname, wmt_cmd_sync);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to download CBMCU firmware (%d)", err);
> +		return err;
> +	}
> +
> +	err = btmtk_enable_cbmcu_patch(hdev, wmt_cmd_sync);
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}
> +
>   int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
>   {
>   	u32 val;
> @@ -894,7 +1229,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
>   		if (err < 0)
>   			return err;
>   		msleep(100);
> -	} else if (dev_id == 0x7925 || dev_id == 0x6639) {
> +	} else if (dev_id == 0x7925 || dev_id == 0x6639 || dev_id == 0x7935) {

This should be sorted in my opinion. Maybe add a commit before, and put 
the new id at the beginning.

>   		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
>   		if (err < 0)
>   			return err;
> @@ -1379,6 +1714,15 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>   	case 0x7668:
>   		fwname = FIRMWARE_MT7668;
>   		break;
> +	case 0x7935:
> +		/* Requires CBMCU firmware before BT firmware */
> +		err = btmtk_setup_cbmcu_firmware(hdev, btmtk_usb_hci_wmt_sync,
> +						 dev_id);
> +		if (err < 0) {
> +			bt_dev_err(hdev, "Failed to set up CBMCU firmware (%d)", err);
> +			return err;
> +		}
> +		fallthrough;
>   	case 0x7922:
>   	case 0x7925:
>   		/*
> @@ -1596,3 +1940,5 @@ MODULE_FIRMWARE(FIRMWARE_MT7922);
>   MODULE_FIRMWARE(FIRMWARE_MT7961);
>   MODULE_FIRMWARE(FIRMWARE_MT7925);
>   MODULE_FIRMWARE(FIRMWARE_MT7927);
> +MODULE_FIRMWARE(FIRMWARE_MT7928);
> +MODULE_FIRMWARE(FIRMWARE_MT7928_CBMCU);
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index c83c24897c95..6d3bf6b74a1d 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -9,6 +9,8 @@
>   #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
>   #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
>   #define FIRMWARE_MT7927		"mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin"
> +#define FIRMWARE_MT7928		"mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin"
> +#define FIRMWARE_MT7928_CBMCU	"mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin"
>   
>   #define HCI_EV_WMT 0xe4
>   #define HCI_WMT_MAX_EVENT_SIZE		64
> @@ -54,6 +56,7 @@ enum {
>   	BTMTK_WMT_RST = 0x7,
>   	BTMTK_WMT_REGISTER = 0x8,
>   	BTMTK_WMT_SEMAPHORE = 0x17,
> +	BTMTK_WMT_CBMCU_DWNLD = 0x58,
>   };
>   
>   enum {

