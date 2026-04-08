Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F893570C8;
	Wed,  8 Apr 2026 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638029; cv=none; b=QBGu809J0pAPDhEfFSq4GcMAnm5meRj9sGIU+UIry2aQZL5h138cxTmG9WHienoT5eafp+zG37TrowRedeNxbDCCSZQgamd14l61L2gV67Pu5yRwYEsHYh98J9QZeaDCNp+GwH1zBg9AXFCAAgP0ESqQxdnepVErpHvylKl3z4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638029; c=relaxed/simple;
	bh=hWf9dg0SMXEoJ4IJEvb8dXNrYuMmBytrwAUbVmgQNMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dp8s6odK5qYeo1+ISRh+2UA7QfaIGH/p0oe5zRFpDV8eykxmuAOC7U2bPNeVxn7427Cqm/uQOPzYnk1glXZyt1AgOp7rK/9OKb/aoHFiDer+cKyRU5d7BaQ77v3tb99Ou8jA5styPj2HlZdcE98McLvGuYWhfRhjgSjapa/LODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B85774C2C37F0A;
	Wed, 08 Apr 2026 10:46:25 +0200 (CEST)
Message-ID: <16bbcee4-2908-4eec-a03f-b847353b8bda@molgen.mpg.de>
Date: Wed, 8 Apr 2026 10:46:24 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: Add Synaptcis 4384 Chip Support
To: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: marcel@holtmann.org, luiz.von.dentz@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kaihsin Chung <kaihsin.chung@synaptics.com>
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kaihsin,


Thank you for your patch.

Am 08.04.26 um 10:32 schrieb kaihsin:

Please add an elaborate commit message.

> Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>

Please configure to use the full name:

     git config --global user.name "Kaihsin Chung"
     git commit --amend --author="Kaihsin Chung 
<kaihsin.chung@synaptics.com>" -s

Then please re-roll as v2 (`git format-patch -v2 …`).

> ---
>   drivers/bluetooth/btbcm.c   | 2 ++
>   drivers/bluetooth/hci_bcm.c | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index f9a7c790d7e2..21ef875d6aa7 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -515,6 +515,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
>   	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
>   	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
>   	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
> +	{ 0x2128, "BCM4384A0_AP6684P" },/* 001.001.040 */
> +	{ 0x4119, "BCM4384B0_AP6684PL"},/* 002.001.025 */
>   	{ }
>   };
>   
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 874d23089b39..972685e83b8a 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1609,7 +1609,8 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
>   	{ .compatible = "brcm,bcm4335a0" },
>   	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
>   	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
> -	{ },
> +	{ .compatible = "brcm,bcm4384-bt" },
> +	{ },

Any idea, why the empty element is shown as changed?

>   };
>   MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
>   #endif


Kind regards,

Paul
