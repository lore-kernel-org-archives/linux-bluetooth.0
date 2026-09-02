Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB6470EB9;
	Wed,  2 Sep 2026 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347257; cv=none; b=K4VfjEQkXaj7YkPLg1ti2F0BdYxcQUeIhSj6u82NOMEynNP/37+QfY2/5VEAg8//ksId9NH1i4E7XDcKtesApmGRIyxFS9AXmrDmNFyB8FxT4fINw5HV/Ux8F2gAvL3kQJtmsiqBRU86EipoVkwzq6uRed65zXpOmUqGEqqEPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347257; c=relaxed/simple;
	bh=fqit+St4HXrBLSSIPkC+htYvTHmxnF3m6buDmqfLYqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKKIULjlP9/e4CjE/vpxYTS8nrBNG8jpB4bv9G1TragpbJwRdqOVqZidrIX9pHuNZxdT/ar2ohRO6KI6DBqY+8PpR9JnJnbSR7AkO5oQokGiVjnA4T1Nh3PsVpxK9305rHeun/hKK4icOocyF1yrEAZun+NZ/+gphtQCobGCR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.14.62] (v062.vpnx.molgen.mpg.de [141.14.14.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4934C4C2C37F0B;
	Wed, 02 Sep 2026 13:07:12 +0200 (CEST)
Message-ID: <c02e3bfb-dd46-4c58-96e4-8f8bb5ca3508@molgen.mpg.de>
Date: Wed, 2 Sep 2026 13:07:11 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btusb: Add support for Intel Otter Peak2
 (OrP2)
To: Catherine L <catherine.l@intel.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kiran.k@intel.com, L@web.codeaurora.org
References: <20260902160407.257899-1-catherine.l@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260902160407.257899-1-catherine.l@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Catherine,


Thank you for your patch.

Am 02.09.26 um 18:04 schrieb Catherine L:
> From: "L, Catherine" <catherine.l@intel.com>

Please use the format without comma: Catherine L.

> $ lsusb
> Bus 003 Device 003: ID 8087:0043 Intel Corp.
> 
> $ cat /sys/kernel/debug/usb/devices
> T:  Bus=03 Lev=01 Prnt=01 Port=09 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=8087 ProdID=0043 Rev= 0.00
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> 
> Signed-off-by: L, Catherine <catherine.l@intel.com>

Ditto.

> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 03039ceaa77d..a4fdf6549127 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -488,6 +488,8 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x8087, 0x0037), .driver_info = BTUSB_INTEL_COMBINED },
>   	{ USB_DEVICE(0x8087, 0x0038), .driver_info = BTUSB_INTEL_COMBINED },
>   	{ USB_DEVICE(0x8087, 0x0039), .driver_info = BTUSB_INTEL_COMBINED },
> +	/* Otter Peak2, Wildcat Lake */
> +	{ USB_DEVICE(0x8087, 0x0043), .driver_info = BTUSB_INTEL_COMBINED },

Please sort and put the comment on the same line as below.

>   	{ USB_DEVICE(0x8087, 0x0040), .driver_info = BTUSB_INTEL_COMBINED }, /* Lizard Peak 2 */
>   	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
>   	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |


Kind regards,

Paul
