Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8206476CF5;
	Thu,  3 Sep 2026 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430114; cv=none; b=q1TLQcOtSE9SYtaVHotUk0woX3LW/aq1r9s/qiXldHNZngYA/DOADN60nNmbzgBWTBLnyaXTINpAaUmPEaWAYnDLn82IGD75XdgmD31kC/+uzHX54TEPPl39AJyXpYYSiZcEierSGxteIz6cX1iTQtY0blODET1V50v9imHZxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430114; c=relaxed/simple;
	bh=QZsfHa72Cpk3s7EFAMIH9DXhSWSczgSjTM8D7XweYlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJ+pMkO/BTvFjZ4k3VxijonTVmKxQutAIZ/UYfjCBebDx3xPJlcUVmZqifAvpEiG16BYnqiXTs5A9zCNS9hhMrBXlz9cTBWcVi2vIm6xcHyK8U0Ru3+9eGH4JP/w7vZBRdSV7BSKQyeQRoT1hfkLK6Mx2tcDdSRhmxh1a097qmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 84F2B4C2C37F38;
	Thu, 03 Sep 2026 12:08:06 +0200 (CEST)
Message-ID: <75085755-5be4-4623-86e9-27826ef96e2e@molgen.mpg.de>
Date: Thu, 3 Sep 2026 12:08:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add device ID for MediaTek MT7925
 (13d3:3631)
To: Samuel Alhovuori <samuel.alhovuori@pm.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7Lm0MbvHvV4KTuQVikJfyHTljM3ozGSBICPx7mcV3jvMSuZw8zx_jHkWn2wuhpZnaUhJgEpgHG22crnJMxLVX_1TRzBT4ME5WPZVtcDpBJg=@pm.me>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <7Lm0MbvHvV4KTuQVikJfyHTljM3ozGSBICPx7mcV3jvMSuZw8zx_jHkWn2wuhpZnaUhJgEpgHG22crnJMxLVX_1TRzBT4ME5WPZVtcDpBJg=@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Samuel,


Thank you for your patch.

Am 03.09.26 um 10:15 schrieb Samuel Alhovuori:
>  From a4e37604a8a8e7e282739a72d1a34b9477449df0 Mon Sep 17 00:00:00 2001
> From: Samuel Alhovuori <samuel.alhovuori@pm.me>
> Date: Thu, 3 Sep 2026 11:00:27 +0300
> Subject: [PATCH] Bluetooth: btusb: Add device ID for Mediatek MT7925
>   (13d3:3631)

It looks like you pasted the output of `git format-patch` in the email 
body. Best use `git send-email` or remove the double header.

> Add the USB ID 13d3:3631 for the MediaTek MT7925 Bluetooth module
> found on AzureWave / Mercusys MA37BE PCIe Wi-Fi 7 cards.

Please follow the other commit messages and add the relevant parts from 
`/sys/kernel/debug/usb/devices`.

> Signed-off-by: Samuel Alhovuori <samuel.alhovuori@pm.me>
> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 03039ceaa..11c62ef1f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -816,6 +816,8 @@ static const struct usb_device_id quirks_table[] = {
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x13d3, 0x3630), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x13d3, 0x3631), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x2c7c, 0x7009), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH },

The diff looks good. With my comments addressed in PATCH v2, feel free 
to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
