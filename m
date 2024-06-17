Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798E17F5;
	Mon, 17 Jun 2024 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613169; cv=none; b=aXaTE0/WBaNct6+MDht+11eLaNtAGdaQlxoX9WXnUZ8Ti4580HLWfOCuWLcAHcMOtgrYVQ+zwsVMaLnUjrlFSY26ppcszmUTBo0UYhCj9CzB5ep41K2rQ+s9qIhZ6N3QXBDTgKePgU10uiTtvJUQYkDRM6RP+UG+fTG7AjdUvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613169; c=relaxed/simple;
	bh=Y1tg7x8oh3i/tSbVstpypVuDjoXGzBLMNJxjDwo2pWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSoM552De0rcbnFbzqTOKnhWy07EA8hfamUz1mJtLra5jbjTZs8Ij+CEZJ2iEX9GuJSoUTQhLlfB5R7sx4XigcC4lzSDwcuR6ctviw+dYm5UxTlkc8+i/BfwE6m/uQYCuUCkWTqaOC6hCRUXJkybhZPtyTeISnY/cgiHPjtRgxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aeabd.dynamic.kabel-deutschland.de [95.90.234.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8D1FE61E5FE3A;
	Mon, 17 Jun 2024 10:32:19 +0200 (CEST)
Message-ID: <04d3dc7d-8266-4d2d-9efb-e9993af9548b@molgen.mpg.de>
Date: Mon, 17 Jun 2024 10:32:18 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add RTL8852BE device 0489:e125 to
 device tables
To: Hilda Wu <hildawu@realtek.com>, marcel@holtmann.org
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex_lu@realsil.com.cn, max.chou@realtek.com,
 kidman@realtek.com
References: <20240617082101.3237350-1-hildawu@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240617082101.3237350-1-hildawu@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hilda,


Thank you for your patch.

Am 17.06.24 um 10:21 schrieb Hilda Wu:
> Add the support ID(0489:e125) to usb_device_id table for

Please add a space before (.

> Realtek RTL8852B chip.
> 
> The device info from /sys/kernel/debug/usb/devices as below.

[…]

> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 79aefdb3324d..2d7d47f9d007 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -555,6 +555,8 @@ static const struct usb_device_id quirks_table[] = {
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x13d3, 0x3572), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe125), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },

Please put it at the beginning of the list for the 8852BE devices to 
kind of sort it.

>   
>   	/* Realtek 8852BT/8852BE-VT Bluetooth devices */
>   	{ USB_DEVICE(0x0bda, 0x8520), .driver_info = BTUSB_REALTEK |


Kind regards,

Paul
