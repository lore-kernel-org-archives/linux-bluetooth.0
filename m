Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7004A32
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768139168; cv=none; b=o6kCZG0TWFYnsUVSWun8WyBbzfJTn1Pm7UnfdRJ0f9WG4suZrYR2d0ulqMjGGYwvcyru+FF5viY8c3sxDElXgh/H50An7jXqwgHpMt0njHO3iLck7U/qocSo4bvPXhpXbyFnhJCYh5DDXp5Qwu/jnkXtktq0bdOct4RW8bRG/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768139168; c=relaxed/simple;
	bh=yaZpo+o8BBEIdDybdWB+9/kCGxSK3bE/hOK0sLku0k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OX9wB9/faRpvCQslGzMJMk7Pfa7H4sF7BR/QMtIQNx3x70ZRgOo3U5MBRQcwTbRKuEo9vvlJvLuTcQaV0PWKU+V09N6RCSjw95f6AFpvnNR/9ETxgmXIUjKgqzqtwhuCUoQwUmGdWOpw3O00JzPVUyWa8scYC6PVcrnmfCZSjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.111] (unknown [185.238.219.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 529972369EC4F;
	Sun, 11 Jan 2026 14:45:52 +0100 (CET)
Message-ID: <ac098207-aeea-412f-86c9-15b12d1c5184@molgen.mpg.de>
Date: Sun, 11 Jan 2026 14:45:47 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add support for Mercusys MA530
 Bluetooth adapter
To: Santiago Cruz <santiagocr@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org
References: <20260111073748.105957-1-santiagocr@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260111073748.105957-1-santiagocr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Santiago,


Thank you for your patch. Some minor comments. For the summary, I suggest:

Bluetooth: btusb: Add id of RTL8761BU based Mercusys MA530 adapter

Am 11.01.26 um 08:37 schrieb Santiago Cruz:
> Add support for the Realtek-based Mercusys MA530 Bluetooth 5.3 USB dongle.
> 
> The device with USB ID 2c4e:0115 was not recognized by the kernel and
> thus was non-functional. This patch adds the device to the quirks table
> with BTUSB_REALTEK and BTUSB_WIDEBAND_SPEECH flags, enabling full
> functionality.
> 
> Tested on:
> - Fedora 43, kernel 6.18.3-200.fc43.x86_64
> - Device: Mercusys MA530 Adapter (USB ID 2c4e:0115)
> - Firmware: rtl8761bu

Which version?

It’s common to add the relevant output of 
`/sys/kernel/debug/usb/devices`. See `git log drivers/bluetooth/` for 
examples.

> Signed-off-by: Santiago Cruz <santiagocr@gmail.com>
> ---
>   drivers/bluetooth/btusb.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 1234567..abcdefg 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -560,6 +560,10 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x0489, 0xe122), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> 
> +	/* Mercusys MA530 Adapter */
> +	{ USB_DEVICE(0x2c4e, 0x0115), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },
> +

Should the new entry be sorted according to the id?

>   	/* Realtek 8852BE Bluetooth devices */
>   	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },


Kind regards,

Paul
