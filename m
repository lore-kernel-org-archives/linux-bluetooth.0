Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB11109
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722837467; cv=none; b=rcLhs8XZfnEsd4J8xS4hOTWqz3bg+CnHem1i3A9YbQcD8mnTavOhSzu9yla7G9Qow6ChX3sEX38eekyG4PlHajOSnCx94Z38se7QUWlBlmypyiP0Jc/cIaGWQeYTRQTQQwrox4PX1E2bANiOfS26hTlJYqAJpROLjU/8mesqkek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722837467; c=relaxed/simple;
	bh=V32I50FtNfnjVyOG36bvNCQzTNYVY5m4YoZWhmaDb5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhEZm3gbqpCa0mPWTXBqUQO2MPxHibjeU8Acvqj/TGXhwHHUFIvqFoZ41hw0pWaoJXXbfNeG8s8ZLEF7rjF3dbH5AFpYzXF/qmWEKCkJqfywmlmAjrBd7nrXsNufs/V3deNdLa9WZHDw4rwMOIhj6HbrgAzUuYwrWRHDhFDht2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeb91.dynamic.kabel-deutschland.de [95.90.235.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3D89161E646D5;
	Mon,  5 Aug 2024 07:57:30 +0200 (CEST)
Message-ID: <b6dde53d-d897-4175-ac25-40398a6e721a@molgen.mpg.de>
Date: Mon, 5 Aug 2024 07:57:23 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add USB HW ID for ASUS Zenbook S 16.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org,
 Nuclear Sunshine <kernel-2024-q3@nuclearsunshine.com>
References: <20240804195319.3499920-1-bas@basnieuwenhuizen.nl>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240804195319.3499920-1-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Bas,


Thank you for your patch. I’d mention Mediatek and remove the dot at the 
end in the commit message summary/title.


Am 04.08.24 um 21:53 schrieb Bas Nieuwenhuizen:
> Variant UM5605WA,  which uses MT7925 with this device. With

Just use one space after the comma?

> this patch I was able to pair my earbuds. I don't know what
> other testing is needed here.

I think it’s common to include the output of 
`/sys/kernel/debug/usb/devices`.

> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>   drivers/bluetooth/btusb.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 789c492df6fa..b5fdc0f3c341 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -695,6 +695,10 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x13d3, 0x3603), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH |
>   						     BTUSB_VALID_LE_STATES },
> +	{ USB_DEVICE(0x13d3, 0x3608), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },
> +
>   
>   	/* Additional Realtek 8723AE Bluetooth devices */
>   	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },

I just noticed that Nuclear Sunshine sent the same diff [1].


Kind regards,

Paul


[1]: 
https://lore.kernel.org/all/53ccc7377341b64ff3fbdde3df28cbd14f245340.camel@nuclearsunshine.com/
