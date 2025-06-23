Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDFF188CC9;
	Mon, 23 Jun 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679756; cv=none; b=Zi9R8cLGZ5/DbceQ0/M9XUWr6G5zlNvQfjmwnZCzaorZOrI4VcoEXuHoIlQ1V1xibk0YNC/Qk/s5LFUkJY9bhrRl65IQJWjHwC71v1z/FX6Fd8nEVaXq9SypInlp90a3//qm94vHg8KDhIajR6x/Atnq/inTPzqgeI40I8fDloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679756; c=relaxed/simple;
	bh=gmwcmHOxZpFVUxz9LtBvGtOcwxrdV7w393tCqoXHplU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzFlHm24c75qzQgX1QYxz/6icE4J7v5qhn6NOUm6sUltvCcwTMEi+W9ixLWTKo/eoZXM6huHptoN8/MGWX1e/UoJ+Z7HOrUzrFxrKGOVsPnGGwj90s+DpJVoErLGXtVnWIqMrspdbTPwOvYOV0imG5H154+B2aHEunYlzwt66zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKOBUzWQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKOBUzWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB6FC4CEEA;
	Mon, 23 Jun 2025 11:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750679756;
	bh=gmwcmHOxZpFVUxz9LtBvGtOcwxrdV7w393tCqoXHplU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZKOBUzWQvsmuFOViczK8Vb7yegdYpFcwTgu2XiZvziUfKt+qXWHqa+i+b5EpU0qiG
	 evvxeymdz3L7XgLQ6S1mIMM5qVGExLsdw4CGay8JBmwOlhDTZ342G+KpPomI/NHvTB
	 1EJhpM7bu7NzQvzwn2cg6Fld9JUDq3UTMJD0RG5udq/Puc0C2olYyM82fj4mlQTvHw
	 hKjq85P05bgtF7Ha2Sp31YD+T9FY6HuR+NawcdzK6zApniXnqtlRnq+Xm2jtEJTS9M
	 7XN3mSNW3MCG+7wtca6vlJnWVi0D0Anr8ANNPdb3XulOZ66q2qhQz7KbvmBXI6K4wW
	 uzLgCSgoMC2Tw==
Message-ID: <3df0b3f2-0d73-4116-8bbf-37020892e773@kernel.org>
Date: Mon, 23 Jun 2025 13:55:50 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] Bluetooth: mediatek: add gpio pin to reset bt
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
 Chris Lu <chris.lu@mediatek.com>, Hao Qin <Hao.qin@mediatek.com>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20250623102359.2684-1-ot_zhangchao.zhang@mediatek.com>
 <20250623102359.2684-2-ot_zhangchao.zhang@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250623102359.2684-2-ot_zhangchao.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/06/2025 12:23, Zhangchao Zhang wrote:
> Makes the platform Bluetooth to be reset by hardware pin,
> it provides two methods to do it for mediatek controller,
> and it has been tested locally many times and can reset normally.
> 
> When an exception occurs, resetting Bluetooth by hardware pin
> is more stable than resetting Bluetooth by software.
> If the corresponding pin is not found in dts,
> bluetooth can also be reset successfully.
> 
> Co-developed: Hao Qin <hao.qin@mediatek.com>
> Co-developed: Chris Lu <chris.lu@mediatek.com>
> Co-developed: Jiande Lu <jiande.lu@mediatek.com>
> Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
> ---
>  drivers/bluetooth/btmtk.c | 69 +++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btmtk.h |  5 +++
>  2 files changed, 74 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 4390fd571dbd..3e5f3ca6f0d5 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -6,6 +6,8 @@
>  #include <linux/firmware.h>
>  #include <linux/usb.h>
>  #include <linux/iopoll.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/unaligned.h>
>  
>  #include <net/bluetooth/bluetooth.h>
> @@ -109,6 +111,65 @@ static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
>  	}
>  }
>  
> +static void btmtk_reset_by_gpio_work(struct work_struct *work)
> +{
> +	struct btmtk_reset_gpio *reset_gpio_data =
> +			container_of(work, struct btmtk_reset_gpio, reset_work.work);
> +
> +	gpio_direction_output(reset_gpio_data->gpio_number, 1);
> +	kfree(reset_gpio_data);
> +}
> +
> +static int btmtk_reset_by_gpio(struct hci_dev *hdev)
> +{
> +	struct btmtk_data *data = hci_get_priv(hdev);
> +	struct btmtk_reset_gpio *reset_gpio_data;
> +	struct device_node *node;
> +	int reset_gpio_number;
> +
> +	node = of_find_compatible_node(NULL, NULL, "mediatek,usb-bluetooth");


Can you finally respond to the comments you got weeks ago at v1?

NAK and I will keep NAKing your patches because total disregard to
review is not going to make this patch accepted.


Best regards,
Krzysztof
