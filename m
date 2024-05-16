Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DCA11CA0;
	Thu, 16 May 2024 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715838317; cv=none; b=G6gX3kp9VCo0jVRhCnuGD1g4UuaBqRhkfm1OGxZmqTECOqRFAW1NzTFCMpLFfuwYhBqQv9LUJQ3BP2aWEHuwQT0oG8awxbj2yzpuz0LI2tASlm0isyeSFxxcXPJpyHCiBLrfposcdkB0sa+chvJ5jhCmMOomDCLNwpfnQgC0MSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715838317; c=relaxed/simple;
	bh=kNqTM4bX8IampPJrP/pQJTOVJFaoMRwaXGjYsBwVtiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=blYisxr30EWbwy6xR8TYmnAMfCVO0aoO9CCUqf8a5e0DJSC3o6HLYjHXLpy/Ld7dJH9hnLMtBgqDDVMveISCXmU4OKZSFbklII38psVbqylCNZeF+lISnTOZ0iHcgqtJIcFGQ/HwWXML93f8dQwbbqih5ZilDYlkSkJa3OpZCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aefc6.dynamic.kabel-deutschland.de [95.90.239.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D4D4161E5FE01;
	Thu, 16 May 2024 07:44:46 +0200 (CEST)
Message-ID: <5aa68ee5-dd84-4ac2-9fd1-36160358fdcf@molgen.mpg.de>
Date: Thu, 16 May 2024 07:44:44 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bluetooth: btintel_pcie: nonsense error recording in irq
To: Oliver Neukum <oneukum@suse.com>, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kiran K <kiran.k@intel.com>
References: <20240516045118.18552-1-oneukum@suse.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240516045118.18552-1-oneukum@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +Kiran]

Dear Oliver,


Thank you for the patch. I have two minor comments. Could you please 
word the summary as a statement by adding a verb (in imperative mood). 
Maybe:

 > Fix nonsense …

or

 > Remove unused `ret` assignment

Am 16.05.24 um 06:50 schrieb Oliver Neukum:
> Either you return an error or you ignore it.
> Recording it but then overwriting it makes no sense.
It’d be great if you added a Fixes: tag.

> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 590c188a4bb3..c507422d6b1b 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -498,19 +498,15 @@ static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status
>   	rfh_hdr = buf;
>   
>   	len = rfh_hdr->packet_len;
> -	if (len <= 0) {
> -		ret = -EINVAL;
> +	if (len <= 0)
>   		goto resubmit;
> -	}
>   
>   	/* Remove RFH header */
>   	buf += sizeof(*rfh_hdr);
>   
>   	skb = alloc_skb(len, GFP_ATOMIC);
> -	if (!skb) {
> -		ret = -ENOMEM;
> +	if (!skb)
>   		goto resubmit;
> -	}
>   
>   	skb_put_data(skb, buf, len);
>   	skb_queue_tail(&data->rx_skb_q, skb);


Kind regards,

Paul
