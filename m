Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F335975
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 05:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748151898; cv=none; b=LQNGnF6zctFJRgNN+A9rEGflOSuDKjJrIu/5vzcz3zUi25+iQuij1+qXX8ee042Ere/2c8wVUmhMOeRwB0YyuCs1KY9s5axYumTuSwRylVzaEx9ZYUDoSwp0LIfzoY/V+xhJ1ZcXpvj4QHyYCLpDBteP2CbM+76V2/jsEqqAGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748151898; c=relaxed/simple;
	bh=dsgoA8oz/AShtmdwvxVvmOiSxJ2ygKI1CHVVSrSitJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfIxLyMH8IqrOg2Gj13ioVndnLz4QyrDu5ajjPe9aonZo0xZvQ/zSFqDTAbXAKkohACfMVQA3X/xhLM2FTvdoTLLocpj3GTenUPPMvFAWKQOUQTqga2Pw7Gv3R5ySs2c59UJ0VefYGg91MEBu9MeMh6SBaROqIWOgWaWbc6Aimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.107] (p5b13a30a.dip0.t-ipconnect.de [91.19.163.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BAC3561E64783;
	Sun, 25 May 2025 07:44:49 +0200 (CEST)
Message-ID: <921c6c41-ca94-4833-a095-12162e70f90a@molgen.mpg.de>
Date: Sun, 25 May 2025 07:44:48 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] Bluetooth: btintel_pcie: Reduce driver buffer
 posting to prevent race condition
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, vijay.satija@intel.com
References: <20250525053940.520283-1-kiran.k@intel.com>
 <20250525053940.520283-3-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250525053940.520283-3-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chandrashekar, dear Kiran,


Thank you for the patch.

Am 25.05.25 um 07:39 schrieb Kiran K:
> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> 
> Modify the driver to post 3 fewer buffers than the maximum rx buffers
> (64) allowed for the firmware. This change mitigates a hardware issue
> causing a race condition in the firmware, improving stability and data
> handling.

Interesting. Please elaborate, which firmware versions are affected, and 
if a fix is going to be expected, and how to reproduce the issue, so it 
can be tested without and with your patch.

Is the errata published? Why three buffers less and not two or four?

Out of curiosity: Does the Microsoft Windows driver do the same?

> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 03f13de4a723..14f000e08e1e 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -398,7 +398,10 @@ static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
>   	int i, ret;
>   	struct rxq *rxq = &data->rxq;
>   
> -	for (i = 0; i < rxq->count; i++) {
> +	/* Post (BTINTEL_PCIE_RX_DESCS_COUNT - 3) buffers to overcome the
> +	 * hardware issues leading to race condition at the firmware.

If you had an errata, it’d be great to document it here to.

I’d remove *the*.

> +	 */
> +	for (i = 0; i < rxq->count - 3; i++) {
>   		ret = btintel_pcie_submit_rx(data);
>   		if (ret)
>   			return ret;


Kind regards,

Paul
