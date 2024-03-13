Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208817564
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710314352; cv=none; b=U9R+1ZJydhTYrPViEyel7EYQgH1CCIWbHBLzxVIDXILZF28Qi3/JEudNeyHJtd5snuFKZ5+CeS+eelAUzf1ScJWV7vBryfNLDYWwH7h53nhlcCTDNAgjbgEY3dy9cXA5/rdGdoJejatxr77eiDW1qHyJfMYatX5Gx0gXv4pXrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710314352; c=relaxed/simple;
	bh=31Cdqf0mZ65Vmn9sPC0zEmcr4XIyeM8pMqKvkAqqNrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tp2JUgVYTVK6+0mAMLP0M6k9xl4UF9NNcZUaoY0rAOiA79h5+i9ZZJqJnKuGrJY/YWO8lMiFh1EcvRWgLymhtN1xp2YVpYY1NN3vFMxZ9p8Np8g7KmiR6SszwtwDNm0vi+Fl6msEQqS9cJ0pidd3xPZ2XX74Ch9Ggg5064HkR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aedb6.dynamic.kabel-deutschland.de [95.90.237.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D50C261E5FE06;
	Wed, 13 Mar 2024 08:18:58 +0100 (CET)
Message-ID: <877ebea0-1fc3-46d0-bebb-7f990e824931@molgen.mpg.de>
Date: Wed, 13 Mar 2024 08:18:56 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V1] Bluetooth: btusb: Add return error code
Content-Language: en-US
To: Youwan Wang <youwan@nfschina.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org
References: <20240313051102.424926-1-youwan@nfschina.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240313051102.424926-1-youwan@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Youwan,


Thank you for your patch. In the commit message summary/title maybe be 
more specific:

Bluetooth: btusb: Set error code in btusb_mtk_hci_wmt_sync()

Am 13.03.24 um 06:11 schrieb Youwan Wang:
> Add return error code

Could you please elaborate and describe the problem?

> Signed-off-by: Youwan Wang <youwan@nfschina.com>
> ---
>   drivers/bluetooth/btusb.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b8e9de887b5d..ec6bdc9687b1 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2826,8 +2826,10 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
>   		goto err_free_wc;
>   	}
>   
> -	if (data->evt_skb == NULL)
> +	if (data->evt_skb == NULL) {
> +		err = -ENOBUFS;
>   		goto err_free_wc;
> +	}
>   
>   	/* Parse and handle the return WMT event */
>   	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;


Kind regards,

Paul
