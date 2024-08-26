Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9477119
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696828; cv=none; b=WT5QrldFBasL4616R0B7lF8ySZ/nBWtvPQZjA9Z9rec1MGopLn9jRCxkWr4mAOtk1YSgek7bwU8zFgwUjwk5BtlnR7AheJup0Ev08V2K13we9KsHQH277BSmFtxWThCxohXaH7bVLrZOr5kR357zbp7CVRd0jvcNFZ7l8FHXblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696828; c=relaxed/simple;
	bh=eSQDQvjlwwdSwJVtlBeyHg3v4HurkNdFui4LMHEjq30=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=dxz8XzspNYKvlGEPA6/lxswz+2R5U9uTIN+aR5HO1RJ22kHuJ6UOMHyUiAPcnx+OJBjxFr/AFsZpR66DHbQ/M9BEP4L4ENBzMF6QmMmAaRb1njE9TgNvINC1L+TBhDW4gVFOFTYZeWa+INFh9KLgK8BdAeZbT40gH+M0yRwhtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aead7.dynamic.kabel-deutschland.de [95.90.234.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9BB3961E5FE05;
	Mon, 26 Aug 2024 20:26:48 +0200 (CEST)
Message-ID: <b959f876-bfbb-43bf-9105-914f21dcd18a@molgen.mpg.de>
Date: Mon, 26 Aug 2024 20:26:48 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth: btusb: Add USB HW IDs for MT7925
To: Michael Burch <me@michaelburch.net>
References: <SN6PR01MB50705B846790BE05B92FDE7CA58B2@SN6PR01MB5070.prod.exchangelabs.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org, Jiande Lu <jiande.lu@mediatek.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <SN6PR01MB50705B846790BE05B92FDE7CA58B2@SN6PR01MB5070.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Michael,


Thank you for your patch. Adding Jiande to Cc. You could make the commit 
message slightly more specific:

Add 2 USB HW IDs for MT7925

or

Add 2 USB HW IDs for MT7925 (0xe118/e)

Am 26.08.24 um 20:06 schrieb Michael Burch:
> Add HW IDs for wireless module specific to ASUS
> notebook model to ensure proper recognition and functionality.
> These HW IDs are extracted from Windows driver inf file.

Please add the URL to the commit message.

Were you able to test this on a device? If yes, please document that too.

(I’d also re-flow the commit message, so the first line is longer.)

> Signed-off-by: Michael Burch <me@michaelburch.net>
> ---
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 51d9d4532dda..d712f5acc338 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -690,6 +690,12 @@ static const struct usb_device_id quirks_table[] = {
>      { USB_DEVICE(0x0489, 0xe113), .driver_info = BTUSB_MEDIATEK |
>                               BTUSB_WIDEBAND_SPEECH |
>                               BTUSB_VALID_LE_STATES },
> +   { USB_DEVICE(0x0489, 0xe118), .driver_info = BTUSB_MEDIATEK |
> +                            BTUSB_WIDEBAND_SPEECH |
> +                            BTUSB_VALID_LE_STATES },
> +   { USB_DEVICE(0x0489, 0xe11e), .driver_info = BTUSB_MEDIATEK |
> +                            BTUSB_WIDEBAND_SPEECH |
> +                            BTUSB_VALID_LE_STATES },
>      { USB_DEVICE(0x13d3, 0x3602), .driver_info = BTUSB_MEDIATEK |
>                               BTUSB_WIDEBAND_SPEECH |
>                               BTUSB_VALID_LE_STATES },
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
