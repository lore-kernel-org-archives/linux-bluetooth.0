Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24753AD;
	Mon, 17 Jun 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622307; cv=none; b=T1lESjUqblshVe/FEwAUff2GyuBm2FCH3GzMi+oIa3Wtl6LxDXzVieA4rXSq+GUSrZExxEDBTqbYZLwRPe3U4kRcXd9lRxfGb85Tv6Ya3Wh6uOtzDnY8jm/TdOi7RrUSI0mlaDkvCSGzxxG0zx3k3pC2etO4Er6e1Yd4ejS6rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622307; c=relaxed/simple;
	bh=Q79od1Lh7jvTfIrQQIEkuQ+6kkEvrLnF7aIETi5sx50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GU3FZ1uYxn/E0BJeuHhGvLvm3GMufIjsrciZfudnfdKs+GBCPUegyxo0gRh24/HeEuqAX24tykROcYJ0RIetHg3/AN+TrtXHwjkqqsNciediD3VBV6YRGW16/jAWrfe5X7WbmdSWOidvy/vwxUVKeoS2tUpRbSiVdbEVWaSyCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9CE6C61E5FE01;
	Mon, 17 Jun 2024 13:04:41 +0200 (CEST)
Message-ID: <f7405ee9-cb89-41e2-a2d8-4751fafa31d1@molgen.mpg.de>
Date: Mon, 17 Jun 2024 13:04:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btrtl: Set MSFT_EXT_ADDRESS_FILTER quirk for
 RTL8852B
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com
References: <20240617105020.3246015-1-hildawu@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240617105020.3246015-1-hildawu@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hilda,


Am 17.06.24 um 12:50 schrieb Hilda Wu:
> Set HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER quirk for RTL8852B.

Is that documented in some errata? If so, can you please reference it?

It’d be great, if you also documented your test setup.

> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
>   drivers/bluetooth/btrtl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index f2f37143c454..baa0c6119b51 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1297,6 +1297,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
>   			btrealtek_set_flag(hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP);
>   
>   		if (btrtl_dev->project_id == CHIP_ID_8852A ||
> +		    btrtl_dev->project_id == CHIP_ID_8852B ||
>   		    btrtl_dev->project_id == CHIP_ID_8852C)
>   			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);


Kind regards,

Paul
