Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680663090E4;
	Tue,  3 Feb 2026 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108979; cv=none; b=FTbxLbQ4aZUuhnBeC2i2Sr1IR3eWQA7QCcVnRzdOYu9+9R3qXoEB++1B2FbmvLptj9xKJ3R885R0la+CFT/vEsqs3qmiBnTRnhhyNOUb1mAB0Fe1WqBJZt4ez/nRxJfWFdCqMcXiX4bEPyhBQTd1EAi/N3DmJd3/GLhK+vRq6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108979; c=relaxed/simple;
	bh=YhGN1tpfZ10X46JV19w6EZSV8Pmy9NK+NVulfMGpRi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLWxVwCaY7YCe3dwRF6vheVCz8m0eeeWpPfySuoS8SgahsRqqdco36HZYLPx2vaJqp2e18bOBqWM58NekT4EGDrNRPiHXS5fRupXfzOddsVJT8JyxrXatKKR0q6qBV3fnuHZpTVp913m7PkynHkDb//dtzVIrMFUUcZ/vbGr+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.59.18.202] (p57a7a2e8.dip0.t-ipconnect.de [87.167.162.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 217D44C442FB16;
	Tue, 03 Feb 2026 09:55:29 +0100 (CET)
Message-ID: <55b814a2-519b-431e-992b-12710e3cc0f6@molgen.mpg.de>
Date: Tue, 3 Feb 2026 09:55:07 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btbcm: remove done label in btbcm_patchram
To: Dongyang Jin <jindongyang@kylinos.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260203071048.1624461-1-jindongyang@kylinos.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260203071048.1624461-1-jindongyang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Dongyang,


Thank you for your patch.

Am 03.02.26 um 08:10 schrieb Dongyang Jin:
> There is no point in having the label since all it does is return the
> value in the 'err' variable. Instead make every goto return directly
> and remove the label.
> 
> Signed-off-by: Dongyang Jin <jindongyang@kylinos.cn>
> ---
>   drivers/bluetooth/btbcm.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index d33cc70eec66..dccfbeee4721 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -223,7 +223,7 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
>   		err = PTR_ERR(skb);
>   		bt_dev_err(hdev, "BCM: Download Minidrv command failed (%d)",
>   			   err);
> -		goto done;
> +		return err;
>   	}
>   	kfree_skb(skb);
>   
> @@ -242,8 +242,7 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
>   
>   		if (fw_size < cmd->plen) {
>   			bt_dev_err(hdev, "BCM: Patch is corrupted");
> -			err = -EINVAL;
> -			goto done;
> +			return -EINVAL;
>   		}
>   
>   		cmd_param = fw_ptr;
> @@ -258,7 +257,7 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
>   			err = PTR_ERR(skb);
>   			bt_dev_err(hdev, "BCM: Patch command %04x failed (%d)",
>   				   opcode, err);
> -			goto done;
> +			return err;
>   		}
>   		kfree_skb(skb);
>   	}
> @@ -266,8 +265,7 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
>   	/* 250 msec delay after Launch Ram completes */
>   	msleep(250);
>   
> -done:
> -	return err;
> +	return 0;
>   }
>   EXPORT_SYMBOL(btbcm_patchram);
>   

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: Do you have a device to test *btbcm*?
