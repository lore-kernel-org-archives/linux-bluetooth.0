Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B25155C82;
	Sun, 31 Aug 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637861; cv=none; b=iHuSO2p4zD3JmmK2bl+8430rgIvbKwQt5L91Y9/pSUmImjSyM9rTT2DWslWYFfJYepydJHXYcCEJlPdzvZp5DuIU3VigYVy1kNfIam6oIPDeWJYw7aVJrmfBhoqXd4d8JaOUhwj9D4yRGgfd/3uM14OaKMVkVyWLwSroi7vLLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637861; c=relaxed/simple;
	bh=7I/zKGdibjpLrai/riJum7CU+tVh0qF1rSsygLIC03Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rV730//OFmwMjlWW+Z32M5S0mmzvlLHPJEt/aKJ63RFbugr/zKxktnfqKV3w0PV+l7DjDH6L3aPYlaqW4HTq8ePlLQ+zACXzg9W4W4GDVrPybj2abaaMzZoMUbeJj8WqgJ0yAEcgJcyYjLtFq4BxoLttI/EpubiMmWfgRV889Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af79b.dynamic.kabel-deutschland.de [95.90.247.155])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7CDEB60288278;
	Sun, 31 Aug 2025 12:57:25 +0200 (CEST)
Message-ID: <a80e0cb6-0c2a-4b83-9461-5e2dfc7f6d29@molgen.mpg.de>
Date: Sun, 31 Aug 2025 12:57:25 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add support for Mercusys MA530
 Bluetooth adapter
To: elespink@gmail.com
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
References: <12b048b5-aadd-4b06-a9a7-8480f27c65af@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <12b048b5-aadd-4b06-a9a7-8480f27c65af@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear lespink,


Thank you for your patch.

Am 31.08.25 um 12:50 schrieb 3:
>  From becb0b090d9783afddf7d43d739ee69b82fbb32a Mon Sep 17 00:00:00 2001
> From: lespink <lespinks9@gmail.com>
> Date: Sun, 31 Aug 2025 12:35:47 +0200
> Subject: [PATCH] Bluetooth: btusb: Add support for Mercusys MA530 Bluetooth adapter

Please use `git send-email` or `b4` to send the patch, as currently it’s 
not formatted correctly.

> Add support for a Realtek-based Mercusys MA530 Bluetooth 5.3 USB dongle
> which works with USB ID 2c4e:0115. This device was not recognized by the

… having the id 2c4e:0115.

(Maybe add that id to the summary/title too.)

> kernel with the original device list and thus was non-functional.

According to `git log drivers/bluetooth` it’s common to paste the 
information from `/sys/kernel/debug/usb/devices` to the commit message.

> Signed-off-by: lespink <lespinks9@gmail.com>
> ---
>   drivers/bluetooth/btusb.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8085fabadde8..84ebeb317dda 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -593,6 +593,10 @@ static const struct usb_device_id quirks_table[] = {
>       { USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
>                                BTUSB_WIDEBAND_SPEECH },
> 
> +    /* Mercusys MA530 Adapter */
> +    { USB_DEVICE(0x2c4e, 0x0115), .driver_info = BTUSB_REALTEK |
> +                             BTUSB_WIDEBAND_SPEECH },
> +
>       /* Realtek Bluetooth devices */
>       { USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
>         .driver_info = BTUSB_REALTEK },
> -- 
> 2.51.0

The diff looks fine.


Kind regards,

Paul
