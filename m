Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951EB19CC29
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750491608; cv=none; b=kkkBfcFwi4RqbU7KpHjlwgsUKSIN8JyLs1W6RkVmj3NzLG9PlQNqw8mNQWHiVGGfPFnmYe9mTfmC52f7dwxlvh7/1ITVLS4a/LMVMjCDA9xzS1OsX2oQaEWq9/NMRbVSGAeiFQPMFY6CpJeJ2d3ZCMSj0viY+E8bKjqoELp3rNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750491608; c=relaxed/simple;
	bh=86eEb+pTVYjoWV516xDM7e5Z1gbcb4SoelogF8ZpkDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeAv8QAPLmvRUYuvVKYg7ZN9CF6MKagsy6xM8sI+/XWO47S76IzHhEbHno6dSc/B1ENtW4xg5Aeyerg2Wh1FNzpcLXX5hUfEAFU/SPeog3dIY7kdkF8rOhQgAFdEAh3PGisQLWDXLg+Y6j2RwLdq0WbizW0mR5dsmLag6Ps9GYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.111] (p5dc5536f.dip0.t-ipconnect.de [93.197.83.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2F12D61E64787;
	Sat, 21 Jun 2025 09:30:51 +0200 (CEST)
Message-ID: <ddd4bdb1-e461-4fdf-bddd-9709c45d60d1@molgen.mpg.de>
Date: Sat, 21 Jun 2025 09:30:50 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btintel_pcie: Add support for device 0x4d76
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 aluvala.sai.teja@intel.com
References: <20250621064631.781861-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250621064631.781861-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for the third iteration of your patch. Sorry to comment once more.

As this is Wild Cat Lake, please add WCL to the summary too, and mention 
Wild Cat Lake in the commit message body.

Am 21.06.25 um 08:46 schrieb Kiran K:
> lspci -v -k -d  8086:4d76
> 00:14.7 Bluetooth: Intel Corporation Device 4d76
>          Subsystem: Intel Corporation Device 0011
>          Flags: fast devsel, IRQ 255, IOMMU group 12
>          Memory at 13013328000 (64-bit, non-prefetchable) [disabled] [size=16K]
>          Capabilities: [c8] Power Management version 3
>          Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
>          Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>          Capabilities: [80] MSI-X: Enable- Count=32 Masked-
>          Capabilities: [100] Latency Tolerance Reporting
>          Kernel driver in use: btintel_pcie
>          Kernel modules: btintel_pcie
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v3:
> - Fix indendtation issue in commit message
> 
>   drivers/bluetooth/btintel_pcie.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index cb3cf2b9acea..1113a6310bd0 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -35,6 +35,7 @@
>   
>   /* Intel Bluetooth PCIe device id table */
>   static const struct pci_device_id btintel_pcie_table[] = {
> +	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) },
>   	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
>   	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
>   	{ 0 }

Searching for 0x4D76, it’s also present in 
`drivers/net/wireless/intel/iwlwifi/pcie/trans.c` added in commit 
9673c35486d4 (wifi: iwlwifi: implement product reset for TOP errors):

		/* on integrated we have to look up by ID (same bus) */
		static const struct pci_device_id bt_device_ids[] = {
#define BT_DEV(_id) { PCI_DEVICE(PCI_VENDOR_ID_INTEL, _id) }
			BT_DEV(0xA876), /* LNL */
			BT_DEV(0xE476), /* PTL-P */
			BT_DEV(0xE376), /* PTL-H */
			BT_DEV(0xD346), /* NVL-H */
			BT_DEV(0x6E74), /* NVL-S */
			BT_DEV(0x4D76), /* WCL */
			BT_DEV(0xD246), /* RZL-H */
			BT_DEV(0x6C46), /* RZL-M */
			{}
		};

Could you add the names as comments in a follow-up commit, and maybe all 
the other id’s?


Kind regards,

Paul
