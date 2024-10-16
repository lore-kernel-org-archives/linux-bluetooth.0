Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0860B8A
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053668; cv=none; b=KUrv1sYVSmnBjettwNR4ZKgRE1MuoDAQRVB5YpmlLAy5RYuaRJG/YR5TDYT4ReTRPzFWVPhIJyM5yZ7YUKE+kXEFjRKFmSa/m8hG2Qz0SuhBVFTwK7NnIThKcZsB3aXUTb4L3+2qK2Jp8alU2V8dTFN/C+rZzmvE7by2kroxx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053668; c=relaxed/simple;
	bh=OGl/TWTcZS2rwynoOq7h6okkfHZv1IAjkdrm0m+qlCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=AFwZ38/XQ7+xLNgmszzcIAT7x76u+wUATvChyJpqUo/xVxHH+WgNb8q81AkpcBVvgHqohmyXKO+6T3s/yyMten/T7OQmETSO71wcQ1eGvjq126oHbbKWyy8KYzb2YNi7eVloPHOSa3iINvYNY0FEfivwSr27jvg9UgK9D0r2v30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae84f.dynamic.kabel-deutschland.de [95.90.232.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0325D61E5FE05;
	Wed, 16 Oct 2024 06:41:00 +0200 (CEST)
Message-ID: <69fb4d7c-9319-4dc5-8680-c151d25ea8a0@molgen.mpg.de>
Date: Wed, 16 Oct 2024 06:40:59 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btusb: Fix regression with CSR controllers
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20241015153719.497388-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241015153719.497388-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Thank you for the patch, and fixing the regression. Could 
short-transfers be mentioned in the summary/title to make it more specific?


Am 15.10.24 um 17:37 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> CSR controllers don't seem to handle short-transfer properly which cause
> command to timeout.

The verb is spelled with a space: time out.

Could you elaborate more? Why is starting a quirk list the right thing 
to do? It’s unlikely more controllers are affected? For people using 
`git log --grep` the product name would be nice to have in the commit 
message:

Product: BT DONGLE10
Bus 001 Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth 
Dongle (HCI mode)

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219365
> Fixes: 7b05933340f4 ("Bluetooth: btusb: Fix not handling ZPL/short-transfer")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   drivers/bluetooth/btusb.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c0b6ef8ee5da..f72218c1037e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1366,10 +1366,15 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
>   	if (!urb)
>   		return -ENOMEM;
>   
> -	/* Use maximum HCI Event size so the USB stack handles
> -	 * ZPL/short-transfer automatically.
> -	 */
> -	size = HCI_MAX_EVENT_SIZE;
> +	if (le16_to_cpu(data->udev->descriptor.idVendor)  == 0x0a12 &&
> +	    le16_to_cpu(data->udev->descriptor.idProduct) == 0x0001)
> +		/* Fake CSR devices don't seem to support sort-transter */

s*h*ort

> +		size = le16_to_cpu(data->intr_ep->wMaxPacketSize);

A warning would be nice to have so motivated users could bug Cambridge 
Silicon Radio to fix/improve their devices.

> +	else
> +		/* Use maximum HCI Event size so the USB stack handles
> +		 * ZPL/short-transfer automatically.
> +		 */
> +		size = HCI_MAX_EVENT_SIZE;
>   
>   	buf = kmalloc(size, mem_flags);
>   	if (!buf) {

Is Intel going to get such a device to add to a test lab?


Kind regards,

Paul
