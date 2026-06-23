Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32F3264CB;
	Tue, 23 Jun 2026 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226139; cv=none; b=mow7eWZamcO0yasC2R+qTaKpcEs7Gj6kLSbW638ijw8cQVzLvzd/oB0U1qF1e0tVh6d3M7MeFgrcfhbmbvvCtaOZpL97CsQNN3umWSjUgLifw+4Z0f3/WEdJJr7U3ss8EQHw3NknZ/NksMs333xjArUYQqVo4tw7D4BJ6STj2NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226139; c=relaxed/simple;
	bh=JaYdx0sMW59IqcuLc04S1nP3D1TPWrJdlYx+F2ys94g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ysfn8Zrm4mwka55xd0V/B5daEEX9hz+PsXsWry1tsM2BNH9xa/gZszog2rNblAjC0DCThpQOHWMX0fECQe+uoNb3trikPYeH2ukxGis7YGUiZBfWaaZm0E8qZkRhjp3joXCvNmLwzSaYGL+vQ9au3EUo8LRTMzosECRrKcmdyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BBC274C2C37D5A;
	Tue, 23 Jun 2026 16:48:47 +0200 (CEST)
Message-ID: <14bafb2e-2d12-4022-a6f9-8fff962b82dd@molgen.mpg.de>
Date: Tue, 23 Jun 2026 16:48:47 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add IMC Networks MT7922 device
 0x13d3:0x3625
To: Gustavo Evgucci <monesss315@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260623114937.6385-1-monesss315@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260623114937.6385-1-monesss315@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Gustavo,


Thank you for your patch. Just a note to add all listed MAINTAINERS 
entries to the receivers (`scripts/get_maintainer.pl 
drivers/bluetooth/btusb.c`).

Am 23.06.26 um 13:49 schrieb monesss315:
> From: Gustavo Evgucci <monesss315@gmail.com>
> 
> The IMC Networks MT7922 Bluetooth adapter with USB ID 13d3:3625 is not
> recognized as a MediaTek device because it is missing from the btusb
> device ID table. As a result, btmtk firmware loading is never triggered
> and the HCI reset command times out with -ETIMEDOUT.
> 
> Add the device with BTUSB_MEDIATEK | BTUSB_WIDEBAND_SPEECH flags,
> consistent with the neighboring 13d3:3627, 13d3:3628 and 13d3:3630
> entries which use the same chip.
> 
> Tested on: MediaTek MT7922 (Wi-Fi 6E combo card, IMC Networks BT USB
> interface), kernel 7.0.11-arch1-1.

It’s common to add the output of `/sys/kernel/debug/usb/devices` to the 
commit message, cf `git log drivers/bluetooth/btusb.c`.

> Signed-off-by: Gustavo Evgucci <monesss315@gmail.com>
> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -755,6 +755,8 @@ static const struct usb_device_id btusb_table[] = {
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x13d3, 0x3613), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x13d3, 0x3625), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x13d3, 0x3627), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x13d3, 0x3628), .driver_info = BTUSB_MEDIATEK |

Feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
