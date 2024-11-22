Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA15156F3F
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264740; cv=none; b=NhStxAWmptBH/AaKLHGH7JB2eews3f1J8fAGArD0cgiRlt6myFaj6bKbn5eVZfFmM70HohlEuVjW0wJ1SOzkwO8+sTlvksj1gFptMeD5w9o5nknYXevIo1sd8OR1LwGKiuXSHWafj4Plsiot0OM5DlF9bU5a3JPxlIvujUopbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264740; c=relaxed/simple;
	bh=H/h+2FVqo5tleemtua1RZLVJsD/WqKpZWKO+BhnZGKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLnbeR2f3hZMElIUtxfQEuyEgrwXKsAQW6vW96Z2Bcp96RvBHa46CxJLg1dq0fsRPiv1QfnLe44x9MbfHKdXsiOXuwRo7zpQywIcsXApz0H3LmESGIwLSQZcqA02f21Ymz7J84HU2YPZhrpvTBuo/p+JBxQTtCLdbX4X6eTbooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aed53.dynamic.kabel-deutschland.de [95.90.237.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 34AC561E5FE05;
	Fri, 22 Nov 2024 09:29:01 +0100 (CET)
Message-ID: <8e793382-f058-4f88-92b3-bb99b1deaffc@molgen.mpg.de>
Date: Fri, 22 Nov 2024 09:29:00 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Ignore Nintendo Wii module
To: Alan Jones <j.alan.jones@pm.me>
Cc: linux-bluetooth@vger.kernel.org
References: <HMjPEtiPDMAaCAIwvxGbpGc-F-pWc_xtxbsY_c8hA6_BLJjW8UJYvD2Znd2q8P21P3O2C4kkrei1ISdn4wBT5FIxf6tO1lr3EVcaFmZJjv4=@pm.me>
 <20241122051947.716313-1-j.alan.jones@pm.me>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241122051947.716313-1-j.alan.jones@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Alan,


Thank you for your patch.

Am 22.11.24 um 06:20 schrieb Alan Jones:
> The Nintendo Wii uses a BCM2045 module running proprietary firmware.
> This adapter is typically managed by emulation software via the raw
> interface, and is incompatible with standard Bluetooth devices.
> 
> Attempting to initialize this adapter breaks synchronization with all
> previously connected Wii Remotes, requiring applications to
> re-synchronize the remotes on each usage.
> 
> Fix Wii Remote re-synchronization issues with the official Nintendo Wii
> Bluetooth module by ignoring this adapter.

Out of curiosity, is anything logged by Linux?

> Signed-off-by: Alan Jones <j.alan.jones@pm.me>
> ---
>   drivers/bluetooth/btusb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e9534fbc92e3..11c9ea182ea4 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -185,6 +185,9 @@ static const struct usb_device_id quirks_table[] = {
>   	/* Broadcom BCM2045 devices */
>   	{ USB_DEVICE(0x0a5c, 0x2045), .driver_info = BTUSB_BCM2045 },
>   
> +	/* Broadcom BCM2045 with Nintendo Wii firmware */
> +	{ USB_DEVICE(0x057E, 0x0305), .driver_info = BTUSB_IGNORE },

Could you please write the ids lowercase? Also, sort it above 0x0a5c?

The comment above the existing entry suggests it’s for all BCM2045 
devices. Could you explain, where the difference in the vendor id comes 
from?

> +
>   	/* Atheros 3011 with sflash firmware */
>   	{ USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
>   	{ USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },


Kind regards,

Paul
