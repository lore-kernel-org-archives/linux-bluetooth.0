Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CFA34BA50;
	Fri,  3 Oct 2025 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759479158; cv=none; b=S0jIKipipP74T5iGgRN8NasoKGNcDRWxxuFMj9K1Ek/KT4cHVf2PiXR62q1iHTcceI/XYMMbl7NCGu/lfxVtqcMH7X+twH3A1Rh9vnM4uvEeM7Trz00ye3yq5Pxjt8czeijwDcGn2D9YK8IZQimNaS/nJzlPBl/8ukjJ8u6Zsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759479158; c=relaxed/simple;
	bh=qqEqYyj01vPEy6rlnSUg16aepbrB2abnhZWAKu69scI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wxa8SfYZO53lkbTLbKImcn/JubhAj1AHhQaQbIRga+ZIPLxfa4URValAShyqyZflzvxfRPzUHFKlu3d9CVFFxt1tUfnYPCZ5gNzJ43+NUikMHeTIHM0Ld3HccDzOIwjpJwNXIa/m3CKz1dB54d7Qsl2izcwZ6QpcQ+0vg0ZFWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p5dc550fa.dip0.t-ipconnect.de [93.197.80.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6D97D60213C84;
	Fri, 03 Oct 2025 10:11:54 +0200 (CEST)
Message-ID: <1e8173de-8a48-4707-b276-2e1d6cfff96d@molgen.mpg.de>
Date: Fri, 3 Oct 2025 10:11:51 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btmtksdio: Add pmctrl handling for BT
 closed state during reset
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Will Lee <will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>,
 Steve Lee <steve.lee@mediatek.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20250930053933.1685847-1-chris.lu@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250930053933.1685847-1-chris.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Chris,


Thank you for your patch.


Am 30.09.25 um 07:39 schrieb Chris Lu:
> This patch adds logic to handle power management control when the
> Bluetooth function is closed during the SDIO reset sequence.
> 
> Specifically, if BT is closed before reset, the driver enables the
> SDIO function and sets driver pmctrl. After reset, if BT remains
> closed, the driver sets firmware pmctrl and disables the SDIO function.
> 
> These changes ensure proper power management and device state consistency
> across the reset flow.

How can your patch be verified on a running system?


Kind regards,

Paul


> Fixes: 8fafe702253d ("Bluetooth: mt7921s: support bluetooth reset mechanism")
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
>   drivers/bluetooth/btmtksdio.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index 50abefba6d04..62db31bd6592 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -1270,6 +1270,12 @@ static void btmtksdio_reset(struct hci_dev *hdev)
>   
>   	sdio_claim_host(bdev->func);
>   
> +	/* set drv_pmctrl if BT is closed before doing reset */
> +	if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state)) {
> +		sdio_enable_func(bdev->func);
> +		btmtksdio_drv_pmctrl(bdev);
> +	}
> +
>   	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
>   	skb_queue_purge(&bdev->txq);
>   	cancel_work_sync(&bdev->txrx_work);
> @@ -1285,6 +1291,12 @@ static void btmtksdio_reset(struct hci_dev *hdev)
>   		goto err;
>   	}
>   
> +	/* set fw_pmctrl back if BT is closed after doing reset */
> +	if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state)) {
> +		btmtksdio_fw_pmctrl(bdev);
> +		sdio_disable_func(bdev->func);
> +	}
> +
>   	clear_bit(BTMTKSDIO_PATCH_ENABLED, &bdev->tx_state);
>   err:
>   	sdio_release_host(bdev->func);

