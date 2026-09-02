Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E87080D;
	Wed,  2 Sep 2026 05:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327342; cv=none; b=uOBB2besqVzi5WqVGcfUjf9B8kYhqWXESHo6+3l9M7ZJFxPWcCDbLh+r+efA07t1tzMUQaJhy5dd4F6jK7LbmMXZ8yATwO/ZunhdsxY0vXbbH4JKSmdxtdU97PyQ2V820HQuAbO/G0RPGtKfNw7DbO6gcQ6GJZrZxzMn2NSl11c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327342; c=relaxed/simple;
	bh=4+fGFZO7R/SZ/oplryGl0/EYOfdyqwfnq8RkseYQiCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKs06N6ODUzXaFmJdjMKRjCOB/10PRRVNjYnXAFE2naRS3uhD9yyhtT0zBiRnFyOHknyrIJlOrZfNYNGL5kVi1UdyzXG5vcZVq/pAVWievVV0xd1xlN+E/4FBBt9/4ArWrHibTrQy3F8Zy79jvQteK5YkFuuYsB/PxadX++N8J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.14.124] (v124.vpnx.molgen.mpg.de [141.14.14.124])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 395AB4C2C37D61;
	Wed, 02 Sep 2026 07:35:05 +0200 (CEST)
Message-ID: <d633b7ee-0afa-4fa1-8340-3d7616f429d2@molgen.mpg.de>
Date: Wed, 2 Sep 2026 07:35:02 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix stale cache in set_dxstate
 fallback check
To: "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sergey Lebedev <lsa.uz@pm.me>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Kiran K <kiran.k@intel.com>
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com>
 <20260901203818.112189-2-vladimirkondratyev2@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260901203818.112189-2-vladimirkondratyev2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: +Chandrashekar, +Kiran]

Dear Vladimir,


Thank you for your patch.

Am 01.09.26 um 22:37 schrieb Vladimir V. Kondratyev:
> btintel_pcie_set_dxstate() falls back to checking the controller state via
> btintel_pcie_in_d3/d0() when the alive interrupt is missed. However, these
> helpers read boot_stage_cache, which is only updated by the interrupt
> handler. As such, if the interrupt was missed, the cache is stale and the
> fallback check always fails, exhausting all retries and returning -EBUSY,
> causing suspend to abort.

Can you reproduce this on real hardware?

> The fix involves re-reading the hardware register before the fallback state
> check, consistent with btintel_pcie_resume().
> 
> Fixes: e57362f4911b ("Bluetooth: btintel_pcie: Add support for _suspend() / _resume()")
> 
> Signed-off-by: Vladimir V. Kondratyev <vladimirkondratyev2@gmail.com>
> Tested-by: Sergey Lebedev <lsa.uz@pm.me>
> ---
>   drivers/bluetooth/btintel_pcie.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index fda474406003..7fca8eea6e01 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2778,9 +2778,13 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
>   					  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
>   
>   		/* A hardware bug may cause the alive interrupt to be missed.
> -		 * Check if the controller reached the expected state and retry
> -		 * the operation only if it hasn't.
> +		 * Refresh boot_stage_cache from hardware since it is only
> +		 * updated by the interrupt handler, then check if the
> +		 * controller reached the expected state and retry the
> +		 * operation only if it hasn't.

Re-flow for less lines?

>   		 */
> +		data->boot_stage_cache = btintel_pcie_rd_reg32(data,
> +							       BTINTEL_PCIE_CSR_BOOT_STAGE_REG);

To me it sounds strange, that a register name *boot stage* should change 
after the boot. ;-)

>   		if (dxstate == BTINTEL_PCIE_STATE_D0) {
>   			if (btintel_pcie_in_d0(data))
>   				return 0;


Kind regards,

Paul
