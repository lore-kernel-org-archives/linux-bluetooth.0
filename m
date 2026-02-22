Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E62561A2
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Feb 2026 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771773674; cv=none; b=YvxmanBrovRrp/RNKvCw/h/lEEWq+yrh6YKfZ2Ovl5V4bZR7bMJ6BjdH4F/R0hdHbwzBYWoLEtubqPjlB+R9AmYs6Wd2z2AN/8/OESkXm/UNLyln8cx/MGzl3Ru3ZxkRsZWE8hYuVcKXGd75aWpYfUcrQhLVluavbYo9bRgbMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771773674; c=relaxed/simple;
	bh=Pv9gLueYpUaOwiDFrfQJjWpfMCsz3229Z+y7138bfXc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tpz0Rm+nBE5Bk2Rpy+NDadMlkp+RhjHvHyNDGCEagMQaPhLUiLuluPQqO3wjreZ+XDGKLlIFNZoQSOwwQkup6v3MqAp+wGvHCM2zStg2YBMP81LZCSOubNELF8Tc2F5Ty2v+lZLw7uOJRo9baUJbkZW7uNa6ayBVLPbZe6xLKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDjkh9cj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDjkh9cj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48375f1defeso25185795e9.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Feb 2026 07:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771773671; x=1772378471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwMyY8SrnHU2z32vgoGv2ovly9AsWZ9ieYYoE4/CChA=;
        b=UDjkh9cjdC65+jauDA/UUrDOjpTJ6h1jdDC5QyJ7zwQQmGLe6ijnb/ioIjOjFe8CIy
         6Inmhd7D9wRYE9NzSbXEWNb15W1tBzs2hZEiPiLTA4z7er2/NetKZ/owiusj/I8oNVZF
         m1r+svhUR7TLy0UAOYAZIg4Ej0EHn0sJD5r1hteyMZO1q9XcBQfa4nJIQ7J08LI/my7q
         qY8d12tkeN8uC5fM9E7QVAeGHw/IhDdMJG8YL00ra1v5ISTXqTorNEFSbHCaluLnfO4g
         g/T0BsrZb+5UyOkhLUOGQOgs3ND95/59qlnt5InZbZAnzaDSX2JlvePEWOyTawEqJ8cd
         K7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771773671; x=1772378471;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwMyY8SrnHU2z32vgoGv2ovly9AsWZ9ieYYoE4/CChA=;
        b=Qko5KDuvUgFWUAsR/dQXpOHfnOdeKLcs2gl9xjy2kyis18kXo66mk6ovMeDW9PQdiF
         F2GGcvcxCYdnawRAfqOVCgKpvAmv1flO9hi8r4j8vRnbIAvgC0iRXPQaee7qMHD9za2P
         1twGYAm0+ANmNXa28d227ytmi7CSNVfRwynpkmgfjo4dLf64bqjUJy7++a6NAkzaq6MQ
         3Ujt2oExxdb/HaJofqc7+xuw27AWS4Z6RDLLQwaj9OkK2cGT3dB4ANqP1jpBdSMBLkpg
         t2LbqvjzRrj7rLuaqvnR0Q7/u6jR36Bb3UwjV6I3yRALsQtdlPj1zPR7u8dGfN5VbkfQ
         khVg==
X-Gm-Message-State: AOJu0YwZE7loOnSDg/77SyGSflFoRlc+D33fZ4vqj1EJJRwS+sflPN4H
	s9wrBBfEy+Erbh7t92N3Ou+M+K1nyekaMOMt0jqDgFUWR4BAZqTtlezH
X-Gm-Gg: AZuq6aIeWa9G7MsstLVvbsflkO743lrU8768dJoHsiyujQRV0RjcI33lis0UHnS7Zop
	4RET9Jd1A4FBxLa8OM2nVJJaA1YTdGXYrkKzdBKkAiRr3bf62lRXj3CPRJYRCB3kp7PkcjJKqkQ
	guGgpsqOqR8xWvqTNTEz76jKH4H8JBA3J9gXIcQWGtH4LY+FBc/BtNV1yvfwX3t4R9iS51gc5LU
	LiI2fi+kkW7EGC9yxVJc4rBJbdGHwFuPPoRE8KSJwq6PuFO04pDeO4qHTzBTEUv8M19pfcCkM3E
	kOeI3nVB/kkkacvgXqNiXheQuS79U9Ib6ztGEts4IbwNIpkJKKl3U48k45qITsyi4swte3L2Grr
	U+JzzzEVQnE0PBMe2fTxXF5r10itadC48vwMW/+O3viYX0ldmYfZVfil8NhI0DXEbx0oVmRdrGh
	kMmCcrZcwZhXDok81x0l3AbOXpHlLMNw==
X-Received: by 2002:a05:600c:4fd5:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483a9637a61mr79460125e9.26.1771773670964;
        Sun, 22 Feb 2026 07:21:10 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31f0330sm177582775e9.9.2026.02.22.07.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 07:21:10 -0800 (PST)
Message-ID: <11ad2bab-deb7-4a8d-966a-75ffd2bb8e71@gmail.com>
Date: Sun, 22 Feb 2026 17:21:06 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: btusb: Add new VID/PID 13d3/3579 for
 MT7902
To: Sean Wang <sean.wang@kernel.org>, marcel@holtmann.org,
 luiz.dentz@gmail.com, ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-mmc@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
References: <20260219231624.8226-1-sean.wang@kernel.org>
 <20260219231624.8226-3-sean.wang@kernel.org>
Content-Language: en-US
In-Reply-To: <20260219231624.8226-3-sean.wang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2026 01:16, Sean Wang wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add VID 13d3 & PID 3633 for MediaTek MT7922 USB Bluetooth chip.
> 

Hi, there is a copy paste error.

> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=04 Dev#=  7 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3579 Rev= 1.00
> S:  Manufacturer=MediaTek Inc.
> S:  Product=Wireless_Device
> S:  SerialNumber=000000000
> C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
> A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
> I:* If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/bluetooth/btusb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 247d6aff5e79..c8c50daec967 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -671,7 +671,8 @@ static const struct usb_device_id quirks_table[] = {
>  						     BTUSB_WIDEBAND_SPEECH },
>  	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
>  						     BTUSB_WIDEBAND_SPEECH },
> -
> +	{ USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH },
>  	/* MediaTek MT7922 Bluetooth devices */
>  	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
>  						     BTUSB_WIDEBAND_SPEECH },

My MT7902 card bought from Aliexpress has a different USB ID: 0e8d 1ede.

    T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  4 Spd=480  MxCh= 0
    D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=0e8d ProdID=1ede Rev= 1.00
    S:  Manufacturer=MediaTek Inc.
    S:  Product=Wireless_Device
    S:  SerialNumber=000000000
    C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
    A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
    I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
    E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
    I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
    I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
    I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
    I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
    I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
    E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
    I:* If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
    E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

