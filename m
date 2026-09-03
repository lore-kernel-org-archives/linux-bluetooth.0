Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE394A0EE4;
	Thu,  3 Sep 2026 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446240; cv=none; b=p1y4PpJ8VKo2xK4c2ZFhG7pFSMZ+IVtT02ZvfEvxLnSWYDa148pq4loskDLVK/28a0MAZsHYskjtbf4Y2ewLSTUYBYM3z1/O9r9DWzUGDYNVWUbpkmxn0Mk0t8M+AGFsr62LT9CHFqlnq8APSuI353OczjN9hbnyBVIN6J9adS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446240; c=relaxed/simple;
	bh=6l3kTpYJB9nV1y3oriqGvUG6wb/nHI6/HnJy0q90A4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=stxKS5EKSbo+10l1RTU5/2Y50qGAu9ptafS857yhOdjKcTBliiOKuL2F7/KP+76zMNBkoRBjzlQAY3LOz2zxwg/ASjznafuXWFgE1TFxodr9zY7c7h7RbMYJdagIgO1hXH09/rApiCLzxSoHrgDWP/F6bNZNyWhj7C8yGK1f9j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 33CE24C2C37D6E;
	Thu, 03 Sep 2026 16:36:41 +0200 (CEST)
Message-ID: <ff049c69-1575-4a10-91e2-cd0371c98c0d@molgen.mpg.de>
Date: Thu, 3 Sep 2026 16:36:40 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btintel_pcie: fix stale cache in
 set_dxstate fallback check
To: "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com>
 <20260903142911.125301-2-vladimirkondratyev2@gmail.com>
Content-Language: en-US
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 chandrashekar.devegowda@intel.com, arnd@arndb.de, kiran.k@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, lsa.uz@pm.me
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260903142911.125301-2-vladimirkondratyev2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Vladimir,


Thank you for the third patch iteration.

Am 03.09.26 um 16:29 schrieb Vladimir V. Kondratyev:
> btintel_pcie returns -16 (EBUSY) during suspend, causing the entire suspend
> operation to abort on Intel Lunar Lake hardware. The system immediately resumes
> after every suspend attempt:
>    Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0
>    Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 1
>    Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 2
>    btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend [btintel_pcie] returns -16
>    btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_suspend returns -16
>    btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
>    PM: Some devices failed to suspend, or early wake event detected
> 
> btintel_pcie_set_dxstate() falls back to checking the controller state via
> btintel_pcie_in_d3/d0() when the alive interrupt is missed. However, these
> helpers read boot_stage_cache, which is only updated by the interrupt
> handler. As such, if the interrupt was missed, the cache is stale and the
> fallback check always fails, exhausting all retries and returning -EBUSY,
> causing suspend to abort.
> 
> The fix involves re-reading the hardware register before the fallback state
> check, consistent with btintel_pcie_resume().
> 
> Fixes: e57362f4911b ("Bluetooth: btintel_pcie: Add support for _suspend() / _resume()")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221481
> Link: https://lore.kernel.org/linux-bluetooth/20260830151550.44687-1-lsa.uz@pm.me/
> Signed-off-by: Vladimir V. Kondratyev <vladimirkondratyev2@gmail.com>
> Tested-by: Sergey Lebedev <lsa.uz@pm.me>
> ---
>   drivers/bluetooth/btintel_pcie.c | 8 +++++---
>   drivers/bluetooth/btintel_pcie.h | 1 +
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index fda474406003..e13631e94214 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2777,10 +2777,12 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
>   					  BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
>   					  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
>   
> -		/* A hardware bug may cause the alive interrupt to be missed.
> -		 * Check if the controller reached the expected state and retry
> -		 * the operation only if it hasn't.
> +		/* A hardware bug may cause the alive interrupt to be missed. Refresh
> +		 * boot_stage_cache from hardware, since only the interrupt handler
> +		 * updates it. Finally retry only if the state check still fails.
>   		 */
> +		data->boot_stage_cache = btintel_pcie_rd_reg32(data,
> +							       BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
>   		if (dxstate == BTINTEL_PCIE_STATE_D0) {
>   			if (btintel_pcie_in_d0(data))
>   				return 0;
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index 2db85f71b2f8..f287d1ff8e27 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -53,6 +53,7 @@
>   #define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_HALTED	(BIT(14))
>   #define BTINTEL_PCIE_CSR_BOOT_STAGE_MAC_ACCESS_ON	(BIT(16))
>   #define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE		(BIT(23))
> +/* Reflects live D-state. Updated by hardware on every D-state transition. */
>   #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY	(BIT(24))
>   
>   /* Registers for MSI-X */

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

