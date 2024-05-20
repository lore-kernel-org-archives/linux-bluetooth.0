Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D24412B73;
	Mon, 20 May 2024 05:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716181975; cv=none; b=IeXZVU5DKo/x2i2pDNehVU3YKY3tpubJvVw46KvALionpAyN2IYN1J8ff2/CdHMoTSH/CKTR3xtKRg6zujyVItk1VmfG1Ygew8k5L1cbmojqZjEqpbn8g7GcRKVBAeHWb5V91IJkDh/DOMERvXiI54uN3cXbMof2TKf0D6c3X5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716181975; c=relaxed/simple;
	bh=E9qDEFQY1grBMvG2pLW44IhOXhR0mVV6WnchLTdLq6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGBQv09KtSVIeIrJIRbssRa42TM61/MhaEFoQiKpEEAfrT5gjMRllgVCjV1IsVfRtxJzACZRSO9pl4/tozLU19BptIuenvXyF10fibbOYvggf9v35x20XNnFaHT0ypMplzBbt4Rh0Lo1zifjPWT/JN2pzBXhPbCx52ImhEsKD64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af1d0.dynamic.kabel-deutschland.de [95.90.241.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CADD861E5FE06;
	Mon, 20 May 2024 07:12:09 +0200 (CEST)
Message-ID: <28196c54-3c65-4646-84f6-76da79368f8e@molgen.mpg.de>
Date: Mon, 20 May 2024 07:12:09 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Bluetooth: btintel: remove useless code in
 btintel_set_dsm_reset_method
To: Su Hui <suhui@nfschina.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
References: <20240520021625.110430-1-suhui@nfschina.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240520021625.110430-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Su,


Thank you for your patch. Some minor comments.


Am 20.05.24 um 04:16 schrieb Su Hui:
> Clang static checker(scan-build) warning:

Please add a space before (. Noting the version of scan build would also 
be nice.

> drivers/bluetooth/btintel.c:2537:14:
> Value stored to 'handle' during its initialization is never read.
> 
> No need to repeatedly assign values to 'handle'. Remove this useless
> code to save some space.

The plural “values” is misleading to me. Maybe just remove the sentence, 
and say:

Remove this unused assignment.

For the summary, “useless code” could also be more specific:

Bluetooth: btintel: Remove unused assignement in 
btintel_set_dsm_reset_method()

Maybe also add a Fixes: tag.

> Signed-off-by: Su Hui <suhui@nfschina.com>


Kind regards,

Paul


> ---
>   drivers/bluetooth/btintel.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 0c855c3ee1c1..f1c101dc0c28 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2542,8 +2542,6 @@ static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
>   		RESET_TYPE_VSEC
>   	};
>   
> -	handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
> -
>   	if (!handle) {
>   		bt_dev_dbg(hdev, "No support for bluetooth device in ACPI firmware");
>   		return;
