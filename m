Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948151DEFE8;
	Tue,  2 Jun 2026 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437842; cv=none; b=kb/ydQ3+n6AG+PdXjH28bKIJ7tUyIKCHt0OtRK9du4e/e2tJWWqiVaL9yFbh0WArXTugYd5A57xVDKMb0JehBrAGnlj2r3gx7aaCGqg5BYdfCRm2QU57EJNegn97qvgM4vZNcXzemmWXJtcsLpVVcFhkeSXqTIa/0Xcv6cbBQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437842; c=relaxed/simple;
	bh=CFpv1O20FVkw88uDWgFDldrx4rP602XqtCgOdR5d7bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrVYqG3016ldWDlPK0VfJDI0I7GyH65kTUdTFi9ejGu+FI00JAVOxh3rKjR6ard30SmVCjcM7jGrJN6fqTgWXRQweaNjpO4i+Yzw3U4E9HS+HpCgW36sabGZfqobQ9Mii+Bav1YCevTsgUpqHEQIaZ3F51yvsd9fLNp164q/Nxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af118.dynamic.kabel-deutschland.de [95.90.241.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BBF824C1A4F36E;
	Wed, 03 Jun 2026 00:03:54 +0200 (CEST)
Message-ID: <37658214-8e22-40ae-81b8-3eab87b43735@molgen.mpg.de>
Date: Wed, 3 Jun 2026 00:03:53 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add support for TP-Link TL-UB250
To: Cris <cxs1494089474@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602135419.3092500-1-cxs1494089474@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260602135419.3092500-1-cxs1494089474@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Cris,


Thank you for your patch.

Am 02.06.26 um 15:54 schrieb Cris:
> Add USB ID 2357:0607 for TP-Link TL-UB250.
> 
> This is a Realtek RTL8761BUV based Bluetooth adapter.
> 
> Without this entry the device is picked up by the generic Bluetooth USB
> class match and exposes hci0, but the Realtek setup path is not used and
> rtl8761bu firmware/config are not loaded.
> 
> The controller reports Realtek Semiconductor Corporation as the
> manufacturer and LMP subversion 0x8761. With this entry added, btusb
> loads rtl_bt/rtl8761bu_fw.bin and rtl_bt/rtl8761bu_config.bin
> successfully.
> 
> Use the same flags as the existing TP-Link 2357:0604 entry.

Please add the relevant part of `/sys/kernel/debug/usb/devices` to the 
commit message [1]

> Cc: stable@vger.kernel.org
> Signed-off-by: Cris <cxs1494089474@gmail.com>

If possible, a full name would be nice.

> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3aef21d4c..3cbb3c22e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -831,6 +831,8 @@ static const struct usb_device_id quirks_table[] = {
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x2357, 0x0607), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |

With the commit message improved, please feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


[1]: 
https://lore.kernel.org/linux-bluetooth/20260530123934.4583-1-nils.helmig@web.de/
