Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F7346A19;
	Tue, 31 Mar 2026 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977694; cv=none; b=UnfZFnjawkDeGnF36EUZ7VE4zc7cqGFyQxsdwZLk37trWsAQc8EZVkZHaJVBf5EnYdjK+vDi9Lopq3NYtM9EBazJSzuHimC6JiidMR+FIAzf8KygLt699XC6wAifGifkblEc03uymY5fBfiHQivk2E1+R655Y4JvW1YZ2CIwkzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977694; c=relaxed/simple;
	bh=rDzz9vh2osNlDXiOhRtapqXkVoTqwy6YqLrXZfFfDs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqYE/49pX9fg08YINWSXUNUzXDAewLzCFsRXK8iHMTcI39M8Rujg3HXE0c9wttpt9662DOmlGPqgkf2J5kq0hWb+gTfPHVxdtEmZJX1bsRsle32obtH7eULphmWfpfw/jn0mOTjl44Z1jYcWww4f9MAIg4C7nNnhSFCnZEXYBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af73b.dynamic.kabel-deutschland.de [95.90.247.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 513574C2C37F07;
	Tue, 31 Mar 2026 19:21:10 +0200 (CEST)
Message-ID: <fe34d404-89be-4b72-adbc-1928cf36d483@molgen.mpg.de>
Date: Tue, 31 Mar 2026 19:21:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add VID 0489 & PID e11d for MediaTek
 MT7922
To: Kamiyama Chiaki <nercone@nercone.dev>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260331144532.10697-1-nercone@nercone.dev>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260331144532.10697-1-nercone@nercone.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kamiyama,


Thank you for the patch. Please do not forget to send them to the 
maintainers directly too.

For the summary, I suggest:

Bluetooth: btusb: MediaTek MT7922: Add VID 0489 & PID e11d


Am 31.03.26 um 16:45 schrieb Kamiyama Chiaki:
> Add VID 0489 & PID e11d for MediaTek MT7922 USB Bluetooth chip.
> Found in Dynabook GA/ZY (W6GAZY5RCL).
> 
> The USB device information is as follows:
>    idVendor  = 0x0489 (Foxconn / Hon Hai)
>    idProduct = 0xe11d
>    Manufacturer: MediaTek Inc.
>    Product: Wireless_Device

The relevant output of `/sys/kernel/debug/usb/devices` is mostly pasted 
– cf `git log drivers/bluetooth/btusb.c`.

> Signed-off-by: Kamiyama Chiaki <nercone@nercone.dev>
> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5c535f3ab..dc7df146a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -697,6 +697,8 @@ static const struct usb_device_id quirks_table[] = {
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x0489, 0xe102), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe11d), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x0489, 0xe152), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x0489, 0xe153), .driver_info = BTUSB_MEDIATEK |

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
