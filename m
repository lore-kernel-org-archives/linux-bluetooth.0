Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B12780E6
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297907; cv=none; b=NruTSkd216YIEFxZkbXauYQDHAYBcF7SGvj3j2PDBhH2wbHr8h4AHUJ3xxqSKeI5T+lg3D8Vl+gbd1VqJFdp9Af1ED3kxt4+u8B8pQKvOZPTr8t8Vw+wQra3B/0WRHt7W362QG9sMpQxLIce7e634hyEIjbX8QwSG0L+dNVvaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297907; c=relaxed/simple;
	bh=Jee3WRAF9kAjj5to7p91VrN9WPEinvMXbAiGV/UjAz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Utk8IorJ3ZpA+ForjJOE07tG4+LtABqhemfbp9O6sABg2EW1+vA234ddbwoDg9y4M8ic3UZTYvqXvci9iz6W+J7m8DEX65DmJrvvfmfAfSE78uP78xF8uULqommdn1Ceir9HRFEocZ7W8QMn6PyUD9TRmiktDCBTfK0CSVeMCps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af049.dynamic.kabel-deutschland.de [95.90.240.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E070461E64782;
	Thu, 06 Mar 2025 22:51:31 +0100 (CET)
Message-ID: <e656e627-44e8-46a5-b5f5-1377573538eb@molgen.mpg.de>
Date: Thu, 6 Mar 2025 22:51:31 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pci: Fix build warning
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250306213846.704638-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250306213846.704638-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch. Maybe be more specific in the summary/title. 
Maybe:

Bluetooth: btintel_pci: Remove unused btintel_pcie_in_rom()

Am 06.03.25 um 22:38 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following warning:
> 
> drivers/bluetooth/btintel_pcie.c:695:20: warning: unused function 'btintel_pcie_in_rom' [-Wunused-function]
>    695 | static inline bool btintel_pcie_in_rom(struct btintel_pcie_data *data)
>        |                    ^~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index f3ab5b41b050..9114be1fc3ce 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -685,20 +685,6 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>   	return 0;
>   }
>   
> -/* BIT(0) - ROM, BIT(1) - IML and BIT(3) - OP
> - * Sometimes during firmware image switching from ROM to IML or IML to OP image,
> - * the previous image bit is not cleared by firmware when alive interrupt is
> - * received. Driver needs to take care of these sticky bits when deciding the
> - * current image running on controller.
> - * Ex: 0x10 and 0x11 - both represents that controller is running IML
> - */
> -static inline bool btintel_pcie_in_rom(struct btintel_pcie_data *data)
> -{
> -	return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ROM &&
> -		!(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_IML) &&
> -		!(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW);
> -}
> -
>   static inline bool btintel_pcie_in_op(struct btintel_pcie_data *data)
>   {
>   	return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
