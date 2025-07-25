Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A419475
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753450461; cv=none; b=ewX/mTvG7rOHQljbuszHfL0n92s6S1AlLt7VNQNX+dXt1r2df/UH6tG0D8seypFIg2I9PG5grTBIgthL9r+bRmNu1GBs7OQOpe7BlUad1g9kmbWOnyDyzbanAR05Do/lfmFaFZiqEOGeisEvbUfnw375fF1TtNIso83t/7ZkR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753450461; c=relaxed/simple;
	bh=IuGjQdnFfyT4j4x6zK18RxBUbgjooAlKDpFwCr/shgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDqu4gJRCN9dZStwbfXJgtUezdIYWjRwYXqjwhxWIZdpBPGpJnd56kdq79w0A955HpTVFuUUAIALSWhHCckNfkFQvl/YeO4MejALZ2hVqb9aRP9KeudMM/lsYlvzTZL4GwCPrTFgjkSmXJoFmN2Q2ZbSDGAPA47sY7Fi2rTvk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 08BA761E647A8;
	Fri, 25 Jul 2025 15:34:00 +0200 (CEST)
Message-ID: <e3fa9472-4707-4eea-b19c-de2e939c44f3@molgen.mpg.de>
Date: Fri, 25 Jul 2025 15:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add Bluetooth core and
 platform details
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com
References: <20250725033134.1351301-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250725033134.1351301-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your patch.

Am 25.07.25 um 05:31 schrieb Kiran K:
> Add Bluetooth CNVi core and platform details to the PCI device table
> for each device ID.

It’d be great if you made it more clear that comments are added. Maybe:

Bluetooth: btintel_pcie: Add core/platform names as comments

Add Bluetooth CNVi core and platform names to the PCI device table
for each device ID as a comment.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 9792a49886ff..14d59d1353cd 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -35,9 +35,9 @@
>   
>   /* Intel Bluetooth PCIe device id table */
>   static const struct pci_device_id btintel_pcie_table[] = {
> -	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) },
> -	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
> -	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
> +	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) }, /* BlazarI, Wildcat Lake */
> +	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) }, /* BlazarI, Lunar Lake */
> +	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H */

Why not add H484 at the end right away from the patch 2/2?

>   	{ 0 }
>   };
>   MODULE_DEVICE_TABLE(pci, btintel_pcie_table);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
