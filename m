Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D471E0DD7;
	Mon, 21 Oct 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497051; cv=none; b=MpkfQMpArNzZxmBjfg4VYavDnABXILRfksulDBVrjdxBkNFu7EV7oLMqVlbekn5EYSFyS6R2uNVeEz44rzHFoT4xqZC5dDWjM7oNL8f71a57jYObtmApWp0meM4N/xceN6/AfdWyR4Y67YjrdaAgWhuT3H6N2hnfAm4j0r3Kjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497051; c=relaxed/simple;
	bh=5yG1wAUGt/ltY2yssfS8ZkIcj1BmS/igZ8q9ZvX+qCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lh9pO/vvn3o8y0W/nfJek/guCcLM2Zs7VQaRRRnlDu+KWa48ANAGw09/1gDyyn31PRlyEu8OeCeR6ONLiPJGyHlRvf2qyk9DghpRCPcCtWQPo8g3EKxuadVihq6dit2QC8fl6NITwWK7U/urojxQYe4pnixWw1WZJQMlWZA0SLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN4Rl7Jf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN4Rl7Jf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECA4C4CEC3;
	Mon, 21 Oct 2024 07:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729497051;
	bh=5yG1wAUGt/ltY2yssfS8ZkIcj1BmS/igZ8q9ZvX+qCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tN4Rl7JfV8AzD26b8U3sBe9Ud+AlD5PCsT1c/FiXxb9a3LsIVnLKfxbamrTl7f0ML
	 U3MBOVQCQH2rxywGWVk0acPs6qZyra1JAMtIpoxwHB9tb9Sr9vTSuG/7CpwZCYLa0H
	 L1x35Tnrx1y8X8DwUl9NgV3LOszGfQojQpaDrHj0uebncjy1SPqU50HIpo1rx2v1w6
	 F5F126ViY2CR0Ie5H+sxbfSJqoZbv4MQnDmvTFkqNTl1mCYaLJiP0q3WqlFDCWxF5T
	 mn/l+9+0I4xY90BHNfW8Wk/ybC2qE7uWKfaicHAbljDoTX4k9TRUWTr6g0s0/zEqhW
	 7VIuqXNZrQuog==
Message-ID: <bb34f4ae-92b3-48b7-b0d6-5937756cdbb9@kernel.org>
Date: Mon, 21 Oct 2024 09:50:42 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>,
 Sherry Sun <sherry.sun@nxp.com>, Amitkumar Karwar
 <amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
 <DB9PR04MB8429B4535422D3AE07D8EE79927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <3fa35cd2-e52c-4873-8a7f-db459b016a97@kernel.org>
 <2b7f61a8-e91a-4b32-be1d-753a19e4d81f@leica-geosystems.com>
 <0d460226-4ea7-4a9b-a119-468343727996@kernel.org>
 <20241021064129.trchqa2oickna7pc@pengutronix.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241021064129.trchqa2oickna7pc@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2024 08:41, Marco Felsch wrote:
> On 24-10-07, Krzysztof Kozlowski wrote:
>> On 07/10/2024 14:58, POPESCU Catalin wrote:
>>>>>>
>>>>>> +  vcc-supply:
>>>>>> +    description:
>>>>>> +      phandle of the regulator that provides the supply voltage.
>>>>>> +
>>>>>> +  reset-gpios:
>>>>>> +    description:
>>>>>> +      Chip powerdown/reset signal (PDn).
>>>>>> +
>>>>> Hi Catalin,
>>>>>
>>>>> For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which means that both wifi and BT controller will be powered on and off at the same time.
>>>>> Taking the M.2 NXP WIFI/BT module as an example, pin56(W_DISABLE1) is connected to the WIFI/BT chip PDn pin, we has already controlled this pin in the corresponding PCIe/SDIO controller dts nodes.
>>>>> It is not clear to me what exactly pins for vcc-supply and reset-gpios you describing here. Can you help understand the corresponding pins on M.2 interface as an example? Thanks.
>>>
>>> Hi Sherry,
>>>
>>> Regulators and reset controls being refcounted, we can then implement 
>>> powerup sequence in both bluetooth/wlan drivers and have the drivers 
>>> operate independently. This way bluetooth driver would has no dependance 
>>> on the wlan driver for :
>>>
>>> - its power supply
>>>
>>> - its reset pin (PDn)
>>>
>>> - its firmware (being downloaded as part of the combo firmware)
>>>
>>> For the wlan driver we use mmc power sequence to drive the chip reset 
>>> pin and there's another patchset that adds support for reset control 
>>> into the mmc pwrseq simple driver.
>>>
>>>> Please wrap your replies.
>>>>
>>>> It seems you need power sequencing just like Bartosz did for Qualcomm WCN.
>>>
>>> Hi Krzysztof,
>>>
>>> I'm not familiar with power sequencing, but looks like way more 
>>> complicated than reset controls. So, why power sequencing is recommended 
>>> here ? Is it b/c a supply is involved ?
>>
>> Based on earlier message:
>>
>> "For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which means
>> that both wifi and BT controller will be powered on and off at the same
>> time."
>>
>> but maybe that's not needed. No clue, I don't know the hardware. But be
>> carefully what you write in the bindings, because then it will be ABI.
> 
> We noticed the new power-sequencing infrastructure which is part of 6.11
> too but I don't think that this patch is wrong. The DT ABI won't break
> if we switch to the power-sequencing later on since the "reset-gpios"
> are not marked as required. So it is up to the driver to handle it
> either via a separate power-sequence driver or via "power-supply" and
> "reset-gpios" directly.

That's not the point. We expect correct hardware description. If you say
now it has "reset-gpios" but later say "actually no, because it has
PMU", I respond: no. Describe the hardware, not current Linux.

Best regards,
Krzysztof

