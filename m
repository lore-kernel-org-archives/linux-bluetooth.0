Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858311848
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778742; cv=none; b=rlK7kMmpxlExj164fi1qh4PGmIjtYz0APn6+G06NejOCTIkJiYXid0LkxZtVYd4vodWcd6xoM9HnhpBmCnDn/HH+ndycxOrkSUSSiJMD9cKTmGdvM/u6yXOYX+RmlnOVRqanRlmRtgX+ek3tVNvIJsPMJ6l3uc5vtXpU1aVxjrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778742; c=relaxed/simple;
	bh=/CE85kBwIPLHtr+h4WT1/Y82AQ4pono3L+SEBetU2Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=H3DutRDsFS0XCN4TFb+AmEj2dbBnXdYwNDe5j1t/ypwA/ZUZWlBlDH2hxhFVY+DrFF82fvm/lqCkKTerLapGZ9Kyc4Np0Q8yJcGMq4xflvnTdcyHIgDWbd96oYt5dWbxcZVJDDxgPxDp4GSNJwOgCUh40VEdq7pExT39NARHENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4b4.dynamic.kabel-deutschland.de [95.90.244.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1D0BE61E5FE01;
	Wed, 19 Jun 2024 08:23:46 +0200 (CEST)
Message-ID: <c4b15ce6-f31f-496f-b3c1-f96801fa4511@molgen.mpg.de>
Date: Wed, 19 Jun 2024 08:23:45 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bluetooth/btusb.c: Add extra mediatek btusb target
To: Alexander Hall <bearodark@gmail.com>
References: <20240619052300.233657-4-bearodark@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org, Jiande Lu <jiande.lu@mediatek.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240619052300.233657-4-bearodark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Alexander,


Thank you for the patch, and welcome to the Linux kernel!

Fore the summary, I’d use:

Bluetooth: btusb: Add USB HW id 0x3604 for MediaTek MT7925B22M

Am 19.06.24 um 07:23 schrieb ultrabear:
> From: Alexander Hall <bearodark@gmail.com>
> 
> This patch fixes bluetooth support on the MediaTek MT7925 WiFi 7 +
> BT 5.3 M.2 chipset that I purchased from aliexpress (and which
> arrived today). The PCB states that it is an MT7925B22M.
> 
> I tested that this patch did fix my problem; bluetooth now works.
> 
> The chipset was purchased from here, though the storefront image does
> not match the PCB that was recieved:

rec*ei*ved

> https://www.aliexpress.com/item/3256806821207897.html

Maybe save on archive.org and reference that.

Please also add the output of `/sys/kernel/debug/usb/devices` to the 
commit message as done in other commits (`git log 
drivers/bluetooth/btusb.c`).

> Signed-off-by: Alexander Hall <bearodark@gmail.com>
> ---
> This is my first submitted patch to the linux kernel, apologies if I
> have misunderstood any portion of the process.

Welcome! For this subsystem, your patch is going to be checked by a bot. 
It will probably ask you to use `Bluetooth:` as the prefix. Also, you 
should Cc: the maintainers. It can be integrated in git [1].

>   drivers/bluetooth/btusb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e384ef6ff..2ea46a0e6 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -691,6 +691,9 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x13d3, 0x3603), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH |
>   						     BTUSB_VALID_LE_STATES },
> +	{ USB_DEVICE(0x13d3, 0x3604), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },
>   
>   	/* Additional Realtek 8723AE Bluetooth devices */
>   	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },

You can amend the commit message with `git commit --amend`, and then do 
`git format-patch -v2` to get *v2* into the subject/title.

I am looking forward to more Linux contributions! ;-)


Kind regards,

Paul


[1]: https://www.marcusfolkesson.se/blog/get_maintainers-and-git-send-email/
