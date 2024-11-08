Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5146F1494D4;
	Fri,  8 Nov 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055707; cv=none; b=Tgft7olZJ4RU2sSwdzMF/siM7P71WMtgObgreqhiV41lpn4HCv/LJyE+Ux2yBYNOI+1uXICF6JnEp9PZf2OcPZrrLTkFf3h7TsytYvCy+YeTeA7ltuDX/LjEXeORKro8RvLQvqgOijUVJ5ZHclQko4yWln7s5DDpZYW9wBaWkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055707; c=relaxed/simple;
	bh=fvL5CHASmGCjOWDiI/Vz5tpjyDRRlvg/zS8kNUNqQyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGIO4L2AKyydr+yE8eKW8ir9Y3KPuXroTXtBr1r1C3UGdVfwTLsTZm0xFek+qf4rYmQk07U7lUkmoepV8hIq8WaEjmbF6hdsWco7WJ6aRVuViw8QUjY6/ivLkm2IToLr1JoMFkcF+TzbJ58jDoCAmtrUV4UsTj3UnNKgAnog3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (unknown [95.90.242.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 13754600AA6A5;
	Fri, 08 Nov 2024 09:48:01 +0100 (CET)
Message-ID: <9954d66f-7e1c-4df3-a600-f82139ea9e5b@molgen.mpg.de>
Date: Fri, 8 Nov 2024 09:48:00 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btusb: Add MT7925 support for ID
 0x13d3:0x3608
To: wangyuli@uniontech.com, hello@felixjara.me
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 matthias.bgg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, guanwentao@uniontech.com,
 zhanjun@uniontech.com, aaron.ma@canonical.com
References: <D3E1285F7DBFAB3E+20241108082418.187499-1-wangyuli@uniontech.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <D3E1285F7DBFAB3E+20241108082418.187499-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Wang, dear Félix,


Am 08.11.24 um 09:24 schrieb WangYuli:
> From: Félix Jara <hello@felixjara.me>
> 
> Add compatibility Bluetooth device MT7925 for Asus UM5606 with
> ID 13d3:3608.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3608 Rev= 1.00
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
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
> I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
> E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us
> 
> Tested in Asus Zenbook S 16 UM5606XA
> 
> Co-developed-by: Félix Jara <hello@felixjara.me>
> Signed-off-by: Félix Jara <hello@felixjara.me>
> Tested-by: Félix Jara <hello@felixjara.me>
> Link: https://github.com/openSUSE/kernel/pull/10
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Should there be a space in your name: Wang Yuli?

> ---
>   drivers/bluetooth/btusb.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e9534fbc92e3..2175a09e21be 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -645,6 +645,11 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x13d3, 0x3608), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH },
>   
> +	/* MediaTek MT7925 Bluetooth devices */
> +	{ USB_DEVICE(0x13d3, 0x3608), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES },

There is already an entry for 13d3:3608. Should only 
BTUSB_VALID_LE_STATES be added? Please update the commit message 
(summary and body) accordingly.

> +
>   	/* Additional Realtek 8723AE Bluetooth devices */
>   	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
>   	{ USB_DEVICE(0x13d3, 0x3394), .driver_info = BTUSB_REALTEK },


Kind regards,

Paul
