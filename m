Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7413DFC68;
	Wed, 15 Apr 2026 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267652; cv=none; b=TFBfZ64FAwNuGzOds4KguB8aXnsj1dhuDqAZORLtZTo3cHBGPrU3Fz60+gYrHwkxgpOZtP4smutskyamI7QNFFrsTkymxDzUxp5h5e2beKF7FSgtllyR/WM1jSWWcIrv1aHEPH5oy7D2+onNNO8g0bPmbWiuf3FfjZgQ/pRNI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267652; c=relaxed/simple;
	bh=N17xW04UJmA10Dpzmff6+9w/5AH2/3wkXcoENu3EjA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7ejZB8FNC7IG9Hge81d68XZG8WSt1odVXLAp3f8jRNVNO7qq5D6chsB9F+tIspFghB1XfPm7J7JpgEoTnRY70vbIijh7xKrmT7STS/SS+hQERKuEZ0aFI0ARgnuBsTIlYj3s32/lFQT3PY9C1QEf/IRL0OXb+9/u1BaTARw2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 83DC94C2C37F01;
	Wed, 15 Apr 2026 17:40:27 +0200 (CEST)
Message-ID: <ff4dac48-2417-49c1-ac02-e6dfac3bf928@molgen.mpg.de>
Date: Wed, 15 Apr 2026 17:40:25 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add Mercusys MA530 HWID 0x2c4e/0x0115
 for Realtek 8761BUV
To: =?UTF-8?Q?Kry=C5=A1tof_Korb?= <krystof@korb.cz>,
 Michal Piernik <mprnk@o2.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250225155825.1504841-1-mprnk@o2.pl>
 <C27221DE-E632-41C9-A15E-B393B6D314EB@korb.cz>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <C27221DE-E632-41C9-A15E-B393B6D314EB@korb.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kryštof, dear Michal,


Am 15.04.26 um 16:47 schrieb Kryštof Korb:
> Tested-by: Kryštof Korb <krystof@korb.cz>
> 
> Confirmed working on a device reporting as "MERCUSYS Bluetooth Adapter"
> (USB ID 2c4e:0115, bcdDevice 2.00), retail product Mercusys MA550H.
> Same RTL8761BU chipset, identical firmware load sequence.
> 
> Seems the USB ID 2c4e:0115 covers at least two distinct retail
> products (MA530 and MA550H) from the same vendor.
> 
> /sys/kernel/debug/usb/devices excerpt:
> P:  Vendor=2c4e ProdID=0115 Rev= 2.00
> S:  Manufacturer=
> S:  Product=MERCUSYS Bluetooth Adapter
> S:  SerialNumber=088AF177D360
> 
> dmesg:
> Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
> Bluetooth: hci0: RTL: rom_version status=0 version=1
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
> Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
> Bluetooth: hci0: RTL: fw version 0xdfc6d922
> 
>> 25. 2. 2025 v 16:58, Michal Piernik <mprnk@o2.pl>:
>>
>> /sys/kernel/debug/usb/devices:
>> T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
>> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=2c4e ProdID=0115 Rev= 2.00
>> S:  Manufacturer=
>> S:  Product=Mercusys MA530 Adapter
>> S:  SerialNumber=30169D905719
>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>
>> dmesg:
>> [11106.761376] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
>> [11106.762370] Bluetooth: hci0: RTL: rom_version status=0 version=1
>> [11106.762374] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
>> [11106.762554] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
>> [11106.762579] Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
>> [11106.910393] Bluetooth: hci0: RTL: fw version 0xdfc6d922
>> [11106.977569] Bluetooth: MGMT ver 1.22
>>
>> Signed-off-by: Michal Piernik <mprnk@o2.pl>
>> ---
>> drivers/bluetooth/btusb.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index f5609110f..0fc1dde8f 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -739,6 +739,8 @@ static const struct usb_device_id quirks_table[] = {
>> 	{ USB_DEVICE(0x2ff8, 0xb011), .driver_info = BTUSB_REALTEK },
>>
>> 	/* Additional Realtek 8761BUV Bluetooth devices */
>> +	{ USB_DEVICE(0x2c4e, 0x0115), .driver_info = BTUSB_REALTEK |
>> +						     BTUSB_WIDEBAND_SPEECH },
>> 	{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
>> 						     BTUSB_WIDEBAND_SPEECH },

The list is unsorted anyway, but I’d add it at second position.

>> 	{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
>> -- 
>> 2.34.1

Could one of you please resend the patch with Kryštof’s information 
added, so it gets picked up from Patchwork again.


Kind regards,

Paul
