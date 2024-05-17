Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD002E403
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940741; cv=none; b=EOWWwRDF0p1EmBP9wSv+Mx00rG28f7w2u0s9J38YCVu1mtbddxuTsI+Zv4ghYncURt35lZmkA8cIIfkF58syVpm0Z2sRQvceCQ65yARryf42rDnKhug7S79H8FYHDXYQ3OCwUjK2iW7YCJ83/Bc9IDimLKDMdNwgbJBQ0auMrq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940741; c=relaxed/simple;
	bh=RZeauON6bQ1FQmQFEdel7cWVV65AuJvMQAQRzF7Wlxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcKo86DAfAKlnxKgbSBXcXydMbrrl6VR2BE0tnp8BAj2XTY5qNLwPYUxozr4c0C9z6hYD2WRVlvPXY/mzExvnYvP1H09JRHrHOHHPm1eon7BW3/f8YzA7SyhnvBDqADxJt+J1OSd9cvYgLhxsvniHi4XVarieVG/cUFvFgHTl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.56] (g56.guest.molgen.mpg.de [141.14.220.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 170E061E5FE01;
	Fri, 17 May 2024 12:12:06 +0200 (CEST)
Message-ID: <69ebe55f-0c2a-472a-bb4c-17731e48bffe@molgen.mpg.de>
Date: Fri, 17 May 2024 12:12:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] Bluetooth: btintel_pcie: Fix irq leak
To: Kiran K <kiran.k@intel.com>
Cc: ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com, vijay.satija@intel.com,
 linux-bluetooth@vger.kernel.org
References: <20240517095447.956132-1-kiran.k@intel.com>
 <20240517095447.956132-2-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240517095447.956132-2-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kiran,


Thank you for your patch.

Am 17.05.24 um 11:54 schrieb Kiran K:
> Free irq before releasing irq vector.

Can the leak be detected somehow? How did you detect it?

> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> Signed-off-by: Kiran <kiran.k@intel.com>

Just a note, that your surname is missing too.

> ---
>   drivers/bluetooth/btintel_pcie.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 8d282ee2322c..d8f82e0f6435 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1329,6 +1329,12 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
>   	data = pci_get_drvdata(pdev);
>   
>   	btintel_pcie_reset_bt(data);
> +	for (int i = 0; i < data->alloc_vecs; i++) {
> +		struct msix_entry *msix_entry;
> +
> +		msix_entry = &data->msix_entries[i];
> +		free_irq(msix_entry->vector, msix_entry);
> +	}
>   
>   	pci_free_irq_vectors(pdev);


Kind regards,

Paul
