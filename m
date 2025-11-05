Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72186154BF5;
	Wed,  5 Nov 2025 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329522; cv=none; b=ZWnFGlLmlTRndHHspaVVo6GLewvkMFRkmBUmgoO1PdcW9IwOS5ZY+o8JHJ4rgtXMODzsSCgctkf3OdsfOTWZbOrm+20FaNNDANwR0IchnEQgPC30+U/RtsJuf1KzbRgoKGtHLllpGjD4mTbOfMUMxYNCSvm9tghsVIBSZlpwY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329522; c=relaxed/simple;
	bh=Syh8dDnBg61J/SEPoYaxYPBxwlEOZnpJNQRe+g/f6UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4QCTdzWt2b61COXQ9JFjfRB/jtzHlyS7kCJMHJpoIx1G9u92/gencG/+iZmpwWQ7p3dpHo/JsNa+9Ti++bxm0HxOsBTqOoe0hXSUSPT2pMEyPGZ+S1TcUDpTDuMSXKqoGzi4bDQdQZnTaY3KrprCU0RWHRkxSQKcUOJlbF+62U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af0d3.dynamic.kabel-deutschland.de [95.90.240.211])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AD4DD61B48447;
	Wed, 05 Nov 2025 08:58:13 +0100 (CET)
Message-ID: <08601ca9-e038-45a7-bd98-4ab24013a84f@molgen.mpg.de>
Date: Wed, 5 Nov 2025 08:58:12 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btrtl: Avoid loading the config file on
 security chips
To: Max Chou <max.chou@realtek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hilda Wu <hildawu@realtek.com>, alex_lu <alex_lu@realsil.com.cn>,
 niall_ni@realsil.com.cn, KidmanLee <kidman@realtek.com>
References: <20251105063736.456618-1-max.chou@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251105063736.456618-1-max.chou@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Max,


Thank you for your patch.

Am 05.11.25 um 07:37 schrieb Max Chou:
> For chips with security enabled, it's only possible to load firmware
> with a valid signature pattern.

How can security be enabled?

What is currently logged? An error?

Please go into the changes. What is the vendor command 0xAD over 0x0D?

> - Example log for a security chip.
> 
> Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000a
>    lmp_ver=0c lmp_subver=8922
> Bluetooth: hci0: RTL: rom_version status=0 version=1
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_fw.bin
> Bluetooth: hci0: RTL: cfg_sz 0, total sz 71301
> Bluetooth: hci0: RTL: fw version 0x41c0c905
> 
> - Example log for a normal chip.
> 
> Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000a
>    lmp_ver=0c lmp_subver=8922
> Bluetooth: hci0: RTL: rom_version status=0 version=1
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_fw.bin
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_config.bin
> Bluetooth: hci0: RTL: cfg_sz 6, total sz 71307
> Bluetooth: hci0: RTL: fw version 0x41c0c905
> 
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Signed-off-by: Nial Ni <niall_ni@realsil.com.cn>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
>   drivers/bluetooth/btrtl.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 8290932b8f7b..f6fccc6fdf22 100644
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
> +	rtl_dev_dbg(hdev, "%s: key id %u", __func__, key_id);
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

So on non-security enabled chips, key_id is 0? It’d be great if that 
could be made clear in the commit message.

>   		if (postfix) {
>   			snprintf(cfg_name, sizeof(cfg_name), "%s-%s.bin",
>   				 btrtl_dev->ic_info->cfg_name, postfix);


Kind regards,

Paul
