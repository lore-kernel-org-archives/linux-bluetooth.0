Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9E1E521E;
	Wed, 12 Mar 2025 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761626; cv=none; b=In269keQTGRztQk+KTVTxwlefHe4+08lDmEscz7WC4JGVOIGfrDbagkv70bITXQslTHK/QTwS9MI646sZhF+xIe0gr/x94B+XKJGHkqv87CLmO0eIe7yB8yIW9r5yIrmF9Hff9I4WmkiD02e7q5qJQleLjY5C9mYr0KFEDWdDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761626; c=relaxed/simple;
	bh=W0yrlDxUmG/ptS0/KM4gL5LJxNYGF17jnWcNxriVLbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlkIw27sf2gknUHnPPPqrZKpaMP0GShNXkGyEsLSdgm81LDJ6FFSCUQiTSHAJ9Ou1XjFOqDoPqXpT1uQudpupzITkyBwmLqhIZShKPmbXtTcNG/cHOHi77T92kKHYLSUaZPygWxRkbLqs2T2j5dftk1HA7nap409PBjFmkRp1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae865.dynamic.kabel-deutschland.de [95.90.232.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 391EE61E646F9;
	Wed, 12 Mar 2025 07:39:48 +0100 (CET)
Message-ID: <24204a3f-836d-4767-a9ec-08b22a27b76b@molgen.mpg.de>
Date: Wed, 12 Mar 2025 07:39:46 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btmtk: delay usb_autopm_put_interface until
 WMT event received
To: Sean Wang <sean.wang@mediatek.com>, Yake Yang <yake.yang@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250311231630.35255-1-sean.wang@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250311231630.35255-1-sean.wang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Sean, dear Yake,


Thank you for the patch.

Am 12.03.25 um 00:16 schrieb sean.wang@kernel.org:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Delay calling usb_autopm_put_interface until the WMT event response is
> received to ensure proper synchronization and prevent premature power
> management actions.

Do you have a reproducer? It’d be great if you could add that to the 
commit message.


Kind regards,

Paul


> Co-developed-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   drivers/bluetooth/btmtk.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 68846c5bd4f7..01832bc6a259 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -620,17 +620,14 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
>   
>   	if (err < 0) {
>   		clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
> -		usb_autopm_put_interface(data->intf);
> -		goto err_free_wc;
> +		goto err_pm_put;
>   	}
>   
>   	/* Submit control IN URB on demand to process the WMT event */
>   	err = btmtk_usb_submit_wmt_recv_urb(hdev);
>   
> -	usb_autopm_put_interface(data->intf);
> -
>   	if (err < 0)
> -		goto err_free_wc;
> +		goto err_pm_put;
>   
>   	/* The vendor specific WMT commands are all answered by a vendor
>   	 * specific event and will have the Command Status or Command
> @@ -646,18 +643,18 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
>   	if (err == -EINTR) {
>   		bt_dev_err(hdev, "Execution of wmt command interrupted");
>   		clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
> -		goto err_free_wc;
> +		goto err_pm_put;
>   	}
>   
>   	if (err) {
>   		bt_dev_err(hdev, "Execution of wmt command timed out");
>   		clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
>   		err = -ETIMEDOUT;
> -		goto err_free_wc;
> +		goto err_pm_put;
>   	}
>   
>   	if (data->evt_skb == NULL)
> -		goto err_free_wc;
> +		goto err_pm_put;
>   
>   	/* Parse and handle the return WMT event */
>   	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
> @@ -700,6 +697,8 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
>   err_free_skb:
>   	kfree_skb(data->evt_skb);
>   	data->evt_skb = NULL;
> +err_pm_put:
> +	usb_autopm_put_interface(data->intf);
>   err_free_wc:
>   	kfree(wc);
>   	return err;

