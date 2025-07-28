Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3D1E379B
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709837; cv=none; b=mGlw8Zd8EBs4CUXETMROT6RaZ0/+XN8a7tUVqoltjuskr8qifYAz0U0UqNElMNlzbro/yn826lqdOkgPI9ueHwciyYcEHRtlEfTfAMK6fKPFXAE+uBUGfrfad/EU0UbTqL42x8uA7oWOx5nCBmFnyVfoiUy9BMh2J6lFbn812Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709837; c=relaxed/simple;
	bh=4mGPhdo7aZurjutobDgcRhJ5gLfuKxxg6jrM3G2qvtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=beKFM7x9VUElaZLf1tYAOlXfKqYccoB7t7yN5FjhnNExNSmh+bLqqn8VEphae0fkjR6T8DN0DLMud6Uk71assgKNJifoLHA9bI0SCuGSUMapuNneE8/r4pqYjB/yYCuSb1CJ039ZDdE52C7lgT2pc1cw4YbVVyfZKK3oUSC2O7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E978961E64850;
	Mon, 28 Jul 2025 15:37:01 +0200 (CEST)
Message-ID: <80683fab-a4a5-4f49-ab66-d69cae30a1aa@molgen.mpg.de>
Date: Mon, 28 Jul 2025 15:37:01 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: btintel_pcie: Add support for device
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com
References: <20250728090554.1425120-1-kiran.k@intel.com>
 <20250728090554.1425120-2-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250728090554.1425120-2-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your patch.

Am 28.07.25 um 11:05 schrieb Kiran K:
> sudo lspci -v -k -d 8086:e376
> 00:14.7 Bluetooth: Intel Corporation Device e376
>          Subsystem: Intel Corporation Device 0011
>          Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 14
>          Memory at 14815368000 (64-bit, non-prefetchable) [size=16K]
>          Capabilities: [c8] Power Management version 3
>          Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
>          Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>          Capabilities: [80] MSI-X: Enable+ Count=32 Masked-
>          Capabilities: [100] Latency Tolerance Reporting
>          Kernel driver in use: btintel_pcie
>          Kernel modules: btintel_pcie

I’d be great if you added the name to the summary:

Bluetooth: btintel_pcie: Add id of Scorpious, Panther Lake-H484

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v2:
>      - No change
> 
>   drivers/bluetooth/btintel_pcie.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 8f02c27bc544..c0c3e17a4fa4 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -37,6 +37,7 @@
>   static const struct pci_device_id btintel_pcie_table[] = {
>   	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) }, /* BlazarI, Wildcat Lake */
>   	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) }, /* BlazarI, Lunar Lake */
> +	{ BTINTEL_PCI_DEVICE(0xE376, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H484 */
>   	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H404 */
>   	{ 0 }
>   };

The diff looks good.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
