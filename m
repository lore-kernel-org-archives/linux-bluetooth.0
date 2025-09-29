Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE02F25E3;
	Mon, 29 Sep 2025 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759142418; cv=none; b=hvx/02m+6YQI6tYIAmdO6vAImy32Y6rk1KRyBUrvdn7V+sAefiypz63ccwNwL2F4YY68kGOORy7uk0uMD+gqfmCY1+wDRn5iAS1JYW1q7UU655GHV9XcbDSPLla0/jZw7K73l6DirWJ3FEcAEQnJcG1X5xfwPVoAJOogQqwfTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759142418; c=relaxed/simple;
	bh=0kI3z5jnXsX50u7C+dYu2XbJMJJdY8pO/o1CTtd6aQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpM+ZKgnJ5v9VqcJvBURGVu5rCdsGQyN1a0x9Hh8JzRj2Zfqf2Y+QvaZg4XtmH2+33MKl+gz07M5vM41XtsHBF7lvsnFCxtAEZAiiZRrgLRE61V86JHPVbeIo2UmXm+OA8OEG3DrBPMkqXuL96SlsjKckRECDQfJh+8ULagKGm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=koMCUusu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="koMCUusu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759142414;
	bh=0kI3z5jnXsX50u7C+dYu2XbJMJJdY8pO/o1CTtd6aQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=koMCUusuubgdt7IMtzx8p4D57u8l8PCpnwqdv4Shr7BKxyKSxJt4JO3eo/fmZtovN
	 KcHli9iY5nL5Vt7e1M1vVVB+pxAj3X4HHqe6p7COEapeQjcBGA8awgDYFtNNb7dLd2
	 CMetegd7vdGT+xjGhNftZTB6BnltJ8kWLg0HMyn9pD4CBaqlmwZJVXlTTXe4/0exnh
	 5EWI9/hfIltSBEFxgZnlwHqNWqZInBuyHuqL4qLOg/7+2yd8RrvEacnNMcJ5yesJ69
	 T5hUCVBzmKN2jrFuGnIFusCrmdaC0GotjnE2tZXuTJqUX2lvFJT5UW5L9vj5vSxlmQ
	 h5mriaKBkPknQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 326DE17E003B;
	Mon, 29 Sep 2025 12:40:14 +0200 (CEST)
Message-ID: <46d6132c-c4e8-40e3-9ee0-cee7436797ee@collabora.com>
Date: Mon, 29 Sep 2025 12:40:13 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] Bluetooth: mediatek: add gpio pin to reset bt
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sean Wang
 <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
 Chris Lu <chris.lu@mediatek.com>, Hao Qin <Hao.qin@mediatek.com>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20250926101046.26559-1-ot_zhangchao.zhang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250926101046.26559-1-ot_zhangchao.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/09/25 12:10, Zhangchao Zhang ha scritto:
> Support the platform Bluetooth to be reset by hardware pin,
> when a Bluetooth exception occurs, attempt to reset the
> Bluetooth module using the hardware reset pin, as this
> method is generally more stable and reliable than a
> software reset. If the hardware reset pin is not specified
> in the device tree, fall back to the existing software
> reset mechanism to ensure backward compatibility.
> 
> Co-developed: Sean Wang <Sean.Wang@mediatek.com>
> Co-developed: Hao Qin <hao.qin@mediatek.com>
> Co-developed: Chris Lu <chris.lu@mediatek.com>
> Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
> 

The changelog should come after the "---" otherwise this will get included
into the commit message.

My only complaint is about the changelog, really, so after moving it, you
can add my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> V8-->V9 modifications:
> -Corrected the if judgment in the patch from data->rest_gpio
>     to data->reset_gpio.
> 
> V7-->V8 modifications:
> -Currently, the universal reset GPIO can be found by configuring DTS.
>     USB bus can get the device node and reset GPIO in the probe phase.
>     It is fully compatible with other vendors' methods of getting reset
>     GPIO. Therefore, the previous complex methods of adding the compatible
>     string in btmtk.c to get GPIO is discarded. Abi files and yaml files
>     are no longer needed. When a Bluetooth exception occurs, the existence
>     of GPIO will be determined first. This change improves the robustness
>     of Bluetooth recovery on platforms that support hardware reset, while
>     maintaining support for platforms that do not.
> 
> V6-->V7 modifications:
> -Change the gpio_direction_output interface to the gpiod_set_value_cansleep
>     and gpiod_put interface.
> -Remove the schedule_delayed_work asynchronous operation.
> -Delete the #gpio-cell attribute in the yaml file, remove the #gpio-cell
>     in the required field, and simplify the contents of the descriptions.
> 
> V5-->V6 modifications:
> -Add specific revisions in the changes from v4 to v5.
> -Add hardware pin title and descriptions to dt-binding submission
>     information.
> -Modify the title descriptions in the dt-binding file.
> -Add 7925 what is it.
> -Wrap the descriptions of MT7925 chip uses the USB bus appropriately.
> -Change the compatible string to mediatek,mt7925-bluetooth in
>     the dt-binding file and driver code.
> -Drop gpio-controlelr properties in the dt-binding file.
> -Modify the descriptions of the reset-gpios
>     properties in the dt-binding file.
> -Change the node information of reset-gpios in bluetooth
>     from high level valid to low level valid.
> 
> V4-->V5 modifications:
> -Correct the spelling error of word provides mentioned in V1.
> -Drop the xhci0 node and status property in the dt-binding file.
> -Modify the bt_reset tag node to bluetooth in the dt-binding file.
> -Add #gpio-cell descriptions to properties, nodes and requests.
> -Make a separate patch for the changes to dt-binding.
> 
> V3-->V4 modifications:
> -Modify submission information why use hardware pin to reset Bluetooth.
> -Write historical commit information into the cover letter.
> -Modify dt binding format information and
>     the explanation text in the dt-binding file.
> 
> V2-->V3 modifications:
> -Changed the capitalization of co-developer names,
>     using the correct capitalization of abbreviations and full
>     name, and corrected obvious spelling errors.
> -Add a revision history.
> -Remove the "BT Driver" in the prefix.
> -Add the bt-binding document, include inforamtion related to reset
>     pin and compatibility matching.
> -Add a comment before the schedule_delayed_work function call,
>     although schedule_delayed_work is asynchronous, there is no risk.
>     Even if it is not completed within 200ms, it will only postpone
>     the subsequent probe and will not have any impact.
> -Add a comment before the btmtk_reset_by_gpio function call,
>     if the compatibility filed or pin cannot be found in the dts
>     files, it can still reset bluetooth using software reset.
> 
> V2 modifications:
> -Modify gpio to GPIO, SW to software,
>     and fix other obvious spelling errors.
> ---

(changelog goes here)

Regards,
Angelo

>   drivers/bluetooth/btusb.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ef44817cad34..f972332840f5 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2745,6 +2745,19 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
>   	btusb_stop_traffic(data);
>   	usb_kill_anchored_urbs(&data->tx_anchor);
>   
> +	/* Toggle the hard reset line. The MediaTek device is going to
> +	 * yank itself off the USB and then replug. The cleanup is handled
> +	 * correctly on the way out (standard USB disconnect), and the new
> +	 * device is detected cleanly and bound to the driver again like
> +	 * it should be.
> +	 */
> +	if (data->reset_gpio) {
> +		gpiod_set_value_cansleep(data->reset_gpio, 1);
> +		msleep(200);
> +		gpiod_set_value_cansleep(data->reset_gpio, 0);
> +		return 0;
> +	}
> +
>   	err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
>   
>   	usb_queue_reset_device(data->intf);


