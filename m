Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779461E515
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777025930; cv=none; b=lkdLsz+Hsq3lmdFztv9bj9HHIwyqUZlDXir7f3Vq3C34fFRufvaXUEwpP7e8UtN1UU48fgdfKBDf5KQsEIgzMxCEkNA4goxUYcajgSywyJDWbJfCEYvI7SvKRPs3BxPke1uy3lXa9F1JvFL1b401qN81xi9nuJ9xOADA6pGR0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777025930; c=relaxed/simple;
	bh=si8XtgCa8xrEBnD405WXdpB+Cp3kZkb9YIoPj4DbCm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iptCKzSPjpn2BplfqA7608nsUUDmnQnzjNYqQMNZfuwClahpivauCFUMvNgpqyz1nXJW75MjVARj/ILpew/yeleveKD2knELsWk2OCgYqIq4fGyqZK5gz2NlRXFD7cWgbnSnfGo+FR94SD4PFC2Fplx1KfuNH7knm1aI6xUKxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6FF8B4C2C37D61;
	Fri, 24 Apr 2026 12:17:37 +0200 (CEST)
Message-ID: <d5cda0fa-e159-46b8-8a3e-660f8214c7cb@molgen.mpg.de>
Date: Fri, 24 Apr 2026 12:17:36 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek RTL8922AE support ID
 0x0bda:0xd922
To: zhangchen200426@163.com
Cc: luiz.von.dentz@intel.com, chris.lu@mediatek.com, floss@jetm.me,
 sean.wang@mediatek.com, en-wei.wu@canonical.com, Zijun.Hu@oss.qualcomm.com,
 chharry@chromium.org, ceggers@arri.de, johan@kernel.org,
 linux-bluetooth@vger.kernel.org, zhangchen01@kylinos.cn
References: <20260424100003.357700-1-zhangchen200426@163.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260424100003.357700-1-zhangchen200426@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chen,


Thank you for your patch.

Am 24.04.26 um 12:00 schrieb zhangchen200426@163.com:
> From: Zhang Chen <zhangchen01@kylinos.cn>

Please note, in English, normally the given name comes first. (Sorry, if 
that’s already the case.)

> Add the support ID (0x0bda, 0xd922) to usb_device_id table for
> Realtek RTL8922AE.

“support ID” is probably not a very common term. Maybe vendor/product ID 
(as used in the output below)?

> The device info from /sys/kernel/debug/usb/devices as below.
> 
> T:  Bus=10 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=d922 Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Radio
> S:  SerialNumber=00E04C885A01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> 
> Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>
> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a0a7da498466..278999ed9883 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -607,6 +607,8 @@ static const struct usb_device_id quirks_table[] = {
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0bda, 0xd922), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },

I’d “sort” (at least group) it according to the vendor id at the very 
beginning:

         /* Realtek 8922AE Bluetooth devices */
         { USB_DEVICE(0x0bda, 0x8922), .driver_info = BTUSB_REALTEK |
  
BTUSB_WIDEBAND_SPEECH }

>   
>   	/* Realtek Bluetooth devices */
>   	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),

With the fixes above, feel free to add to v2 (`git format-patch -v2 …`):

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
