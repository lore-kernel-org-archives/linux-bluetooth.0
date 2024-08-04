Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2E2F2E
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Aug 2024 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722751878; cv=none; b=fUxLH3AVZzKArP62Bz+Ekwvm3G5z6JvcRuK96zSNE50i2f2uxFxae2fXnRaeJpXmdU0hrtvEdhKLmWVbE4gJnVvz5aJr7LQkxVuKl9w9LCrOH8a8qCexBnrBu9iPBo8jlwOuDzf1iPg7Z+EpfFVHM1dfMGpQeWmHoW/S0de3adE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722751878; c=relaxed/simple;
	bh=5PmdURzfBfWaqH2ku0TkI0RR73SH/wGO/Vfwnx78Gaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=r+cz34njQD7bjif37fQf6g5MZXaSGtg/RIfT3EmiunC0T3+VBZ5GhuGUPJz/cvKNy8JKJ6ljMEJa94KQJEfFuUv+1X8juQPWvn4xZn8Aia0Txt54ou8RMPtzsaLPRL7RwUkZGCyojbeiVSdhvrXSiW6U1GVuE/7i0X+eXfLjzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af0e0.dynamic.kabel-deutschland.de [95.90.240.224])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EF55061E5FE05;
	Sun,  4 Aug 2024 08:11:01 +0200 (CEST)
Message-ID: <5c82f430-a32d-40fb-8c64-643be3cddf0d@molgen.mpg.de>
Date: Sun, 4 Aug 2024 08:11:00 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Bluetooth: btusb: add 13d3/3608 VID/PID for MT7925
To: Nuclear Sunshine <kernel-2024-q3@nuclearsunshine.com>
References: <a2cd95d91354168876eab963bb7e1cfa1b31e985.camel@nuclearsunshine.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <a2cd95d91354168876eab963bb7e1cfa1b31e985.camel@nuclearsunshine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Nuclear,


Thank you for the patch.

Am 03.08.24 um 23:44 schrieb Nuclear Sunshine:
> The VID/PID are as seen for this chipset in the Asus Zenbook S 16
> (UM5606), and have been successfully tested with the mt7925e driver.

I think it’s common to include the output of 
`/sys/kernel/debug/usb/devices`.

> Signed-off-by: Nuclear Sunshine <kernel-2024-q3@nuclearsunshine.com>
> ---
>   drivers/bluetooth/btusb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index acdba5d77694..fccefa57506a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -696,6 +696,9 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x13d3, 0x3603), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH |
>   						     BTUSB_VALID_LE_STATES },
> +	{ USB_DEVICE(0x13d3, 0x3608), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },
>   
>   	/* Additional Realtek 8723AE Bluetooth devices */
>   	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },


Kind regards,

Paul
