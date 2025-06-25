Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4320F800;
	Wed, 25 Jun 2025 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750831007; cv=none; b=IYieR6me3FX0E5bLaq5QS71WR4jbRaO0UA6dZZH5sh7EBlyFCK0Y2/eOlsIMbscHvOvgdGKZ2houfA1ug35b+6oC/w1D3gPaWMPLKvMFciTCftkDjqivmsSuWjclJnoBnk9Pxy/Z+IY/Z4sEvQy9wPCMylIlwbX0bH+Mxo5zSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750831007; c=relaxed/simple;
	bh=YA1ozCMuYti5QEdip6k9laQ+KcsaNWJ5rntjqPHCYU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsuUKgvNOlR5AqcynFKQ2/Z7UGBaQScvMIo3UyVQ2zigIEvIeUmKbpFOGSHT7MW+ZjVQ5bZZsrcApC2F4pE+1uPpSMaXEOQzPyXy5WIWEQ3oiP5jxEA8xZVJw2L+wH/svUv9o2/utGRQtvF11MpGqd30/1AdUyq5ehSd1MzX0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXuCn4Q2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXuCn4Q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B834BC4CEEA;
	Wed, 25 Jun 2025 05:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750831006;
	bh=YA1ozCMuYti5QEdip6k9laQ+KcsaNWJ5rntjqPHCYU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qXuCn4Q2RTMz3giK2JvThxshgOCfV3PWLgbGFfDb6qehZaZIP4RfusIze9jVDRFsS
	 xV/fHXbE54U33NZnTCClOZhROfugQHaXt06QtzYT+a6r6rs/SiNrwdoKahBaw3dkJc
	 NZItuqDOcJtlJp9hG+irPXDvEQdL4U8MP3Q/b7qWKkxfI8YAH+XveXQXkBHowMe2vB
	 1ldQCcLirFj1y+7a8XQDBJZtT+8qa9cLJFvPLnYF9wkHhVKWnkFmA9wM6bNN0v8+V0
	 QTr8MPiQ/NAIr2+0XyPc4pJmTnvdLjlfJDvIy7bDaOYKCyd3Fc3jy72+XpaC14IiDd
	 SZV+4KjzP3Q+A==
Message-ID: <4a938da3-a26b-4794-8545-b4dde7f44b86@kernel.org>
Date: Wed, 25 Jun 2025 07:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: BT Driver: mediatek: add gpio pin to reset bt
To: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 =?UTF-8?B?WmhhbmdjaGFvIFpoYW5nICjlvKDotoUp?=
 <ot_zhangchao.zhang@mediatek.com>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
 "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
 "marcel@holtmann.org" <marcel@holtmann.org>
Cc: Sean Wang <Sean.Wang@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
 =?UTF-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20250528070323.14902-1-ot_zhangchao.zhang@mediatek.com>
 <5a430a69-6182-4a34-b5df-5fd557411b68@kernel.org>
 <451afb573ed6b218f2d8eeacdf1c3158c698c421.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <451afb573ed6b218f2d8eeacdf1c3158c698c421.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/06/2025 05:42, Chris Lu (陸稚泓) wrote:
> Hi Krzysztof,
> 
> Sorry for late reply. Some problem with Zhangchao's envrionment that he
> can't reply the mail. So I'll reply on his behalf.
> 
> Before submitting the next version, we'd like to discuss and confirm
> the questions you mentioned in v1 according to the suggestion from
> Bluetooth Maintainer Luiz.
> 
> On Wed, 2025-05-28 at 14:07 +0200, Krzysztof Kozlowski wrote:
>>
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> On 28/05/2025 09:03, Zhangchao Zhang wrote:
>>> +
>>> +static int btmtk_reset_by_gpio(struct hci_dev *hdev)
>>> +{
>>> +     struct btmtk_data *data = hci_get_priv(hdev);
>>> +     struct btmtk_reset_gpio *reset_gpio_data;
>>> +     struct device_node *node;
>>> +     int reset_gpio_number;
>>> +
>>> +     node = of_find_compatible_node(NULL, NULL, "mediatek,usb-
>>> bluetooth");
>>
>> There is no such compatible. Just git grep for it.
>>
>>> +     if (node) {
>>> +             reset_gpio_number = of_get_named_gpio(node, "reset-
>>> gpios", 0);
>>
>> Where is the ABI documented? Anyway, you should not pick GPIOs from
>> random devices.
>>
> In v1, we haven't prepared yaml file about dts setting yet. Does your
> question above referring to the same thing?
> 
> Zhangchao will add it in the next submission and run it through
> "dt_binding_check" according to the Kernel's document.
> 
No, because this does not explain what you send in v2 and why now you
sent again v1!

Nothing here makes sense, not only mediatek,usb-bluetooth which does not
exist and has 1% chances of acceptance anyway.

Best regards,
Krzysztof
