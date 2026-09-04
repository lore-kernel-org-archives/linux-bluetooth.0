Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2D541D21E
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502492; cv=none; b=KjW4yGGph3UlsztwX5yVBxW9z5nYK9sIdzXZs3sfa8RVYggeQkfSvTRhtBxaXxhDbwKQUyxmZJ7VowCqfl4gYIg9lIIGR2i/kYMKHXBA40Z0Fvu2XziwHCcxTCoXJpmtD1GRuOSyvW9I3Fi1CpG4UY4zMKks97OR1xHPL5FZEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502492; c=relaxed/simple;
	bh=ou1eWaYHVdhjyaTj1aObDM14aShFO/tLyrJzydc4RqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgg+K3EwrgXeMZUNpRHxkhuWFvNp156b1wG2AL1MKPSHHYX//UBuZEtEi+gEgzqfdlmfzca5k2IsoZUffS1LQdVJSCw8i1dnN1cOJXJK1JZ2GMqmxS/3C0/avoY/ysHXvGwL7jCrPASgpjFpNKwrvCAmNl04vqf9223PhZgBVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.230] (p5dc55087.dip0.t-ipconnect.de [93.197.80.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0AA684C2C37F09;
	Fri, 04 Sep 2026 08:14:24 +0200 (CEST)
Message-ID: <a771d0fe-dd2b-46b2-9d48-9ae70a9ebd33@molgen.mpg.de>
Date: Fri, 4 Sep 2026 08:14:22 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: btintel_pcie: fix tx_handle bounds
 off-by-one
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com
References: <20260903145102.54675-1-kiran.k@intel.com>
 <20260903145102.54675-2-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260903145102.54675-2-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your patch.

Am 03.09.26 um 16:51 schrieb Kiran K:
> Valid indices into txq->urbd0s/tfds/bufs are 0..txq->count-1, so
> tfd_index == txq->count is already out of range. Change the guard in
> btintel_pcie_msix_tx_handle() from '> txq->count' to '>= txq->count'.
> 
> This issue was reported by Claude Mythos.
> 
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v2:
> - Update commit message
> 
>   drivers/bluetooth/btintel_pcie.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 281dc5261c74..e02f8ae8d8d9 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1423,7 +1423,7 @@ static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
>   
>   		urbd0 = &txq->urbd0s[cr_tia];
>   
> -		if (urbd0->tfd_index > txq->count)
> +		if (urbd0->tfd_index >= txq->count)
>   			return;
>   
>   		cr_tia = (cr_tia + 1) % txq->count;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: I must be blind, but I can’t find this on sashiko.dev [1].


[1]: https://sashiko.dev/#/?list=org.kernel.vger.linux-bluetooth
