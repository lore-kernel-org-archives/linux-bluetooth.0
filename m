Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944D2EC55D;
	Tue, 11 Nov 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851938; cv=none; b=TQ65VublFtj/h/QLHUkl2Cpiylts3cSpkSpAvQlf9ftPYCt34JADFpOWRE6RK6jSx4GdOkg3bzB2LyCeE/PWMJN5j1FS3q0fGJj2T1GclzYRZvdQtrRWw8WYVODUrpKDtvzVlwdtvEhics0j7QU3ar0yvOyvzOgxW/gXeTW+tp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851938; c=relaxed/simple;
	bh=fAvVC9eVF9dhF3dkG3sDy3mPZGnLbG+UdkFF3DtuZJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGzHaQdZnR1IUquSaaiy6NdPd6Gh4Ej1NeYj0VMcGcaRjnIavrqsmvKZ15NoRz3ZGTC+7bXHrf+NEFf8JHNbiUKRoV4A5nEtJxrato0/NCKtHofz7Z1zHck+u8+1xbc1NUL++i/WkiwKMwKlfu3ILXR1wiIUxTGJD/NeNtav1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de [141.14.13.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B9AE061B4847B;
	Tue, 11 Nov 2025 10:05:09 +0100 (CET)
Message-ID: <981b322f-7b36-43dd-bc75-7154ca50cedb@molgen.mpg.de>
Date: Tue, 11 Nov 2025 10:05:08 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btrtl: Avoid loading the config file on
 security chips
To: Max Chou <max.chou@realtek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hilda Wu <hildawu@realtek.com>, alex_lu <alex_lu@realsil.com.cn>,
 niall_ni@realsil.com.cn, KidmanLee <kidman@realtek.com>
References: <20251105120204.458231-1-max.chou@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251105120204.458231-1-max.chou@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Max,


Thank you for your patch. I respond despite your patch already been 
committed.

Am 05.11.25 um 13:02 schrieb Max Chou:
> For chips with security enabled, it's only possible to load firmware
> with a valid signature pattern.
> If key_id is not zero, it indicates a security chip, and the driver will
> not load the config file.
> 
> - Example log for a security chip.
> 
> Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000a
>    lmp_ver=0c lmp_subver=8922

No linebreak needed for pasted lines.

> Bluetooth: hci0: RTL: rom_version status=0 version=1
> Bluetooth: hci0: RTL: btrtl_initialize: key id 1

Maybe you could send a follow-up to make that line more informative by 
also printing, that this chip runs in security mode.

> Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_fw.bin
> Bluetooth: hci0: RTL: cfg_sz 0, total sz 71301
> Bluetooth: hci0: RTL: fw version 0x41c0c905
> 
> - Example log for a normal chip.
> 
> Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000a
>    lmp_ver=0c lmp_subver=8922
> Bluetooth: hci0: RTL: rom_version status=0 version=1
> Bluetooth: hci0: RTL: btrtl_initialize: key id 0
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_fw.bin
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_config.bin
> Bluetooth: hci0: RTL: cfg_sz 6, total sz 71307
> Bluetooth: hci0: RTL: fw version 0x41c0c905
> 
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Signed-off-by: Nial Ni <niall_ni@realsil.com.cn>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
> Changes in V2:
> - Print key_id at INFO level
> - Update commit information for key_id based on review suggestions
> ---
>   drivers/bluetooth/btrtl.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 8290932b8f7b..5603b282f9bc 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -50,7 +50,7 @@
>   
>   #define	RTL_CHIP_SUBVER (&(struct rtl_vendor_cmd) {{0x10, 0x38, 0x04, 0x28, 0x80}})
>   #define	RTL_CHIP_REV    (&(struct rtl_vendor_cmd) {{0x10, 0x3A, 0x04, 0x28, 0x80}})
> -#define	RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0x0D, 0x00, 0xb0}})
> +#define	RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0xAD, 0x00, 0xb0}})
>   
>   #define RTL_PATCH_SNIPPETS		0x01
>   #define RTL_PATCH_DUMMY_HEADER		0x02
> @@ -544,7 +544,6 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
>   {
>   	struct rtl_epatch_header_v2 *hdr;
>   	int rc;
> -	u8 reg_val[2];
>   	u8 key_id;
>   	u32 num_sections;
>   	struct rtl_section *section;
> @@ -559,14 +558,7 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
>   		.len  = btrtl_dev->fw_len - 7, /* Cut the tail */
>   	};
>   
> -	rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
> -	if (rc < 0)
> -		return -EIO;
> -	key_id = reg_val[0];
> -
> -	rtl_dev_dbg(hdev, "%s: key id %u", __func__, key_id);
> -
> -	btrtl_dev->key_id = key_id;
> +	key_id = btrtl_dev->key_id;
>   
>   	hdr = rtl_iov_pull_data(&iov, sizeof(*hdr));
>   	if (!hdr)
> @@ -1081,6 +1073,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>   	u16 hci_rev, lmp_subver;
>   	u8 hci_ver, lmp_ver, chip_type = 0;
>   	int ret;
> +	int rc;
> +	u8 key_id;
>   	u8 reg_val[2];
>   
>   	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
> @@ -1191,6 +1185,14 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>   		goto err_free;
>   	}
>   
> +	rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
> +	if (rc < 0)
> +		goto err_free;
> +
> +	key_id = reg_val[0];
> +	btrtl_dev->key_id = key_id;
> +	rtl_dev_info(hdev, "%s: key id %u", __func__, key_id);
> +
>   	btrtl_dev->fw_len = -EIO;
>   	if (lmp_subver == RTL_ROM_LMP_8852A && hci_rev == 0x000c) {
>   		snprintf(fw_name, sizeof(fw_name), "%s_v2.bin",
> @@ -1213,7 +1215,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>   		goto err_free;
>   	}
>   
> -	if (btrtl_dev->ic_info->cfg_name) {
> +	if (btrtl_dev->ic_info->cfg_name && !btrtl_dev->key_id) {
>   		if (postfix) {
>   			snprintf(cfg_name, sizeof(cfg_name), "%s-%s.bin",
>   				 btrtl_dev->ic_info->cfg_name, postfix);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
