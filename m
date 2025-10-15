Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857F223DEA
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560122; cv=none; b=qJt/0SmljBsDzNkqmmP8B8nHXuC0CABb55M/jT+NpyzLFO5aKpIK0vWOQWv8bG1HX54fYMm7edWD6VBWaFXaxWj2aHZLlKde1OJveaGZp/aF75xbf/u+PB7tjftaQhtD4RNnI3f+fpeTq/QUJK8kQJj/Vr0ktZ8Axy5JvpYoIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560122; c=relaxed/simple;
	bh=wBmpLOp63/GtJn0niIeRp5e+luDBwVuNO0F5JohPX1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzPGUD1rPOColzrqDTf+GLFZn/3mjbUrKep+VJXDxhFYdX8kVAApqrv/JbYNTb0vI41pOhGSjsGpAfy2nNKH2t6WIQ9f02DtMg4qBSKbbZCuoI6KW7ME3cefPqvVEDDAH+4Id+sdckekagiBf04eacnbk1c4AQp4K36QbUUFock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.33.25] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B7D3A60213AEE;
	Wed, 15 Oct 2025 22:28:18 +0200 (CEST)
Message-ID: <c31398c7-4476-4e3e-b773-0143e53bd301@molgen.mpg.de>
Date: Wed, 15 Oct 2025 22:28:12 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Fix event packet loss issue
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com,
 Sai Teja Aluvala <aluvala.sai.teja@intel.com>
References: <20251015101436.2579377-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251015101436.2579377-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kiran,


Thank you for the patch.

Am 15.10.25 um 12:14 schrieb Kiran K:
> In the current btintel_pcie driver implementation, when an interrupt is
> received, the driver checks for the alive cause before the TX/RX cause.
> Handling the alive cause involves resetting the TX/RX queue indices.
> This flow works correctly when the causes are mutually exclusive.
> However, if both cause bits are set simultaneously, the alive cause
> resets the queue indices, resulting in an event packet drop and a
> command timeout. To fix this issue, the driver is modified to handle all
> other causes before checking for the alive cause.

Please share a test case.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> ---
>   drivers/bluetooth/btintel_pcie.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 6d3963bd56a9..a075d8ec4677 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1467,11 +1467,6 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
>   	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1)
>   		btintel_pcie_msix_gp1_handler(data);
>   
> -	/* This interrupt is triggered by the firmware after updating
> -	 * boot_stage register and image_response register
> -	 */
> -	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0)
> -		btintel_pcie_msix_gp0_handler(data);
>   
>   	/* For TX */
>   	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0) {
> @@ -1487,6 +1482,12 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
>   			btintel_pcie_msix_tx_handle(data);
>   	}
>   
> +	/* This interrupt is triggered by the firmware after updating
> +	 * boot_stage register and image_response register
> +	 */
> +	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0)
> +		btintel_pcie_msix_gp0_handler(data);
> +
>   	/*
>   	 * Before sending the interrupt the HW disables it to prevent a nested
>   	 * interrupt. This is done by writing 1 to the corresponding bit in

The diff looks good.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
