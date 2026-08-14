Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6DC377AB6;
	Fri, 14 Aug 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700239; cv=none; b=qfwPrttfaeugKz/HuogKbGXBubaFwsH/T9gfzWNNpdkeHCMS149lL+Anjt0LrDA3ME5RCrpe4ImOb22ZEZS3NDOk5C4EiGhyHdL1Ru5rECeTgI+mdnTbeKivIcbkF61pVbj9GoGJwE/uoHicdilhb5SmgcEKB9GU059z+jEpNHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700239; c=relaxed/simple;
	bh=K/KaXCeoHfu/hBWvIMCEnINZxokCzjLOdlg+nxQgSuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAojU9UiyhoaAITWgLUrw/LK85z6abtd7+K+D//DZm7vE1A4IoAZVF3uAOaqmXKoBQsWOtHyuyXldXyIAVNgKKURV1pvaNppbOdADUg+4XWLwHhMx+BEp1naJYcNvj4S6ktOpLk4VL3IT0UFqwjfhe4lSDAWGEwVtk0O6Gkovos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 81DB44C28871AD;
	Fri, 14 Aug 2026 11:36:59 +0200 (CEST)
Message-ID: <080b7ab7-15ac-403f-9997-3dfb85c8efbf@molgen.mpg.de>
Date: Fri, 14 Aug 2026 11:36:58 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel: Bound exception info print to the
 received length
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260814080123.902388-1-ali@iusegentoo.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260814080123.902388-1-ali@iusegentoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Ali,


Thank you for your patch.

Am 14.08.26 um 10:01 schrieb Ali Ahmet Memis:
> btintel_hw_error() validates that the Intel exception info response is
> exactly 13 bytes, and then prints the 12 bytes following the status byte
> with a plain "%s". Nothing validates that those 12 bytes contain a NUL,
> so the conversion can run past the end of the received response and into
> whatever follows it in the skb.
> 
> Bound the conversion to the length that was actually received.
> 
> Fixes: 973bb97e5aee ("Bluetooth: btintel: Add generic function for handling hardware errors")
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
> ---
>   drivers/bluetooth/btintel.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index bf567b7c5f00..4112f39f251f 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -288,7 +288,9 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
>   		goto unlock;
>   	}
>   
> -	bt_dev_err(hdev, "Exception info %s", (char *)(skb->data + 1));
> +	/* The exception info field is not guaranteed to be NUL terminated */
> +	bt_dev_err(hdev, "Exception info %.*s", (int)(skb->len - 1),
> +		   (char *)(skb->data + 1));
>   
>   	kfree_skb(skb);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: gemini/gemini-3.1-pro-preview found also other occurrences [1].


[1]: 
https://sashiko.dev/#/patchset/20260814080123.902388-1-ali%40iusegentoo.com
