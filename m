Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152DE44CF4A;
	Tue, 31 Mar 2026 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980873; cv=none; b=cs7234QqzfdwjoAMjirM2Cjk7/G+cZ15TtUmkVSW41XNFPqz9P/QRlBT3T2BGONayO51vy+OW2juQY9V21gU2hY7qh/MqxPld/VV9VTIe2M2kQLrTB/9al+mfhTst8pka11YP3/WJKicVgqmtNH2ju7QcpvnwJMEr7TJ0l1u7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980873; c=relaxed/simple;
	bh=rFLs6K0p6BMUuvOeR/nvOXIG5PrTQaLSMkfBIS5MkGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfOJB0e1yoUZUlS4jVWPC64+w8AfeUgFJ3N3HxQqF/1HZW+k56dhjAP4VCyyOlMln5MkHT6MCFW1qQQgzk66/TUbDYYsB4UO6PVOXQqV31SWJc1gLDkLF/fsjd4vvJKoz1/ZeBC/KgtrTZob001bJ7GoCY3ELuO/ZirDYxokEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5b13a713.dip0.t-ipconnect.de [91.19.167.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 957A74C2C37D47;
	Tue, 31 Mar 2026 20:13:52 +0200 (CEST)
Message-ID: <11effdbc-4eff-4430-a22f-3320f84859fb@molgen.mpg.de>
Date: Tue, 31 Mar 2026 20:13:46 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] Bluetooth: btusb: Add MT7927 ID for ASUS X870E /
 ProArt X870E-Creator
To: Javier Tia <floss@jetm.me>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>,
 Ivan Lubnin <lubnin.ivan@gmail.com>
References: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>
 <20260331-mt7927-bt-support-v5-8-6f31b4342daa@jetm.me>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260331-mt7927-bt-support-v5-8-6f31b4342daa@jetm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Javier,


Thank you for the patches and your persistence on improving them. I 
noticed one more thing, just in this one:

Am 31.03.26 um 19:09 schrieb Javier Tia:
> Add USB device ID 13d3:3588 (IMC Networks/Azurewave) for the MediaTek
> MT7927 (Filogic 380) Bluetooth interface found on the ASUS ROG STRIX
> X870E-E GAMING WIFI and ASUS ProArt X870E-Creator WiFi motherboards.
> 
> Note: boards with this USB ID expose only one ISO alternate setting
> (alt 0). Without the fix in patch 2/8 ("btmtk: fix ISO interface
> setup for single alt setting"), this caused ~19 second initialization
> delays. With the fix applied, initialization completes in ~2.6
> seconds.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3588 Rev= 1.00
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
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221096
> Link: https://github.com/openwrt/mt76/issues/927
> Signed-off-by: Javier Tia <floss@jetm.me>
> Tested-by: Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>
> Tested-by: Ivan Lubnin <lubnin.ivan@gmail.com>
> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 55a000540439..45ef0d008bce 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -761,6 +761,8 @@ static const struct usb_device_id quirks_table[] = {
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x0489, 0xe116), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x13d3, 0x3588), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH },

This is not sorted. Is there a reason to place it here?

>   	{ USB_DEVICE(0x0489, 0xe14e), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x0489, 0xe14f), .driver_info = BTUSB_MEDIATEK |
> 


Kind regards,

Paul
