Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE893AE199
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532597; cv=none; b=nH0FGN37CrSUqU0bAJQcVNW9QWEO1kKdxZIJKpA6wupllgc8kFRVxoZynyh/f83ms1o6hgXMFX93Sr4mKjHyGjJPHUgLAl3b+h41j2hurlX7jFqWKHI57gmisl9kxXlXQjSuCkxh0Yma2KrlQhzntfOhCW5rs/Ufx+UVD0el5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532597; c=relaxed/simple;
	bh=V0e0wj/fIwCOV02nq/BZgW9FFKxEV6xa+5Pi6Xeq4Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEKK7LGP3OuYNF9+xYj6cBR6Sv234u1JDykVo5JEPbiUH+edqPgguQnstnztLPK0V9uE3XCMMAto2ny/dkG0YzguNJbkcgVqQs44K5gefWyUrrLZJMW+8Zj+9D1sc89DFqS6NKZtn9yegBEwpLKWznn8x6dfBb7nwnzsGMhZfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af765.dynamic.kabel-deutschland.de [95.90.247.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 624EF4C1511A17;
	Mon, 11 May 2026 22:49:39 +0200 (CEST)
Message-ID: <58a3bb31-a730-49b1-9c80-930f4099b0e8@molgen.mpg.de>
Date: Mon, 11 May 2026 22:49:38 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Reset controller before
 configuring MSI-X
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, aluvala.sai.teja@intel.com
References: <20260511132711.1216139-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260511132711.1216139-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your patch.

Am 11.05.26 um 15:27 schrieb Kiran K:
> From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> 
> Perform the shared hardware reset in btintel_pcie_probe() before
> configuring MSI-X so the controller starts from a known clean state.

Did you run into problems with the current ordering?

> While here, move btintel_pcie_config_msix() out of
> btintel_pcie_config_pcie() and into the probe sequence, and propagate
> errors from btintel_pcie_reset_bt() so probe fails cleanly if the
> shared HW reset does not complete.

“While here” also sounds to me to split the commit into two. But your call.

Please add a paragraph how to test it. (Maybe what log messages to look 
out for.) Is there a way to force `btintel_pcie_reset_bt()` to fail?

> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index fda474406003..6ff08de9ec78 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1646,9 +1646,6 @@ static int btintel_pcie_config_pcie(struct pci_dev *pdev,
>   	if (err)
>   		return err;
>   
> -	/* Configure MSI-X with causes list */
> -	btintel_pcie_config_msix(data);
> -
>   	return 0;
>   }
>   
> @@ -2659,6 +2656,14 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>   	if (err)
>   		goto exit_error;
>   
> +	err = btintel_pcie_reset_bt(data);
> +	if (err) {
> +		dev_err(&pdev->dev, "Bluetooth shared HW reset failed (%d)\n", err);

What is “shared HW reset”?

> +		goto exit_error;
> +	}
> +
> +	/* Configure MSI-X with causes list */
> +	btintel_pcie_config_msix(data);
>   	pci_set_drvdata(pdev, data);
>   
>   	err = btintel_pcie_alloc(data);


Kind regards,

Paul
