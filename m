Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E381591E8;
	Tue, 22 Oct 2024 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585422; cv=none; b=ntZ/wBxWHq21VKUc4u6zhJk6zyGV7KSCsy2vkVRjWgjIvpPmyst+C9pXg4zCHCF7LVSg0GsUOmE4JOxjK1OT2HjeHP5LktjAC8Qmet+Fj0XF3T7/2yzdcXh4BQ5zV9seAy+HcqYHgKPPk4Uir7Mq0ZtGYRAkOqe3yz5H00D7KNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585422; c=relaxed/simple;
	bh=Mp6oY9iFBjKTrbRDjHpbclWZ0T/5GgrVM/Hw/ucbepw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RR/IPlY+/xI9drNU4x7qQD4GlBvs24HREtF9+wrSLJoo8R9nMaQhtsuURF1j01U+T2ZKyAcmhAD31yl8t99LLCLyw1IQl7XGINwpXiyf6mJC69IPgPDappcj122RKKO2OvgmW6KkTVAugKrbyfzWHgROF/MnWqHAfMhVCjeU5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUU0Asrs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUU0Asrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DFFC4CEC3;
	Tue, 22 Oct 2024 08:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729585422;
	bh=Mp6oY9iFBjKTrbRDjHpbclWZ0T/5GgrVM/Hw/ucbepw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nUU0Asrsy+9MA0eNCLJ3dn6oGfWJIS+YgCp67QoY1sf27OCmwDkpp1cH7Q0Fd2JXG
	 hT1Od70xOpNo7OPFM6CWA+9a5SDtneeY/UdMd2WBSI60eh91lpbwA8+vY/FolGveGt
	 3D8FWLpfdxFoOr8HLx1xOsPnWGe+8g0xTpos3tOMiEJFMat0PRuujAycP0RZlhRCQk
	 3skmLHharQoU8CkhM9K4+LX9cKDlCVzrURQVB19MWngkj5PeyTnZ253E+/fPZ1ALK5
	 5CwRw9oNUhH41h/R8rpawku2KgCj/bZcEY5dulIWqyGwy9miJM672D35WylgCIYPau
	 VUapFZWTBm9LQ==
Message-ID: <9c7b0e22-1d15-45a2-a263-9b03348adb45@kernel.org>
Date: Tue, 22 Oct 2024 10:23:35 +0200
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
References: <3fa35cd2-e52c-4873-8a7f-db459b016a97@kernel.org>
 <2b7f61a8-e91a-4b32-be1d-753a19e4d81f@leica-geosystems.com>
 <0d460226-4ea7-4a9b-a119-468343727996@kernel.org>
 <20241021064129.trchqa2oickna7pc@pengutronix.de>
 <bb34f4ae-92b3-48b7-b0d6-5937756cdbb9@kernel.org>
 <20241021102558.rfnz7nxcg5knibxs@pengutronix.de>
 <e7a1622e-6406-478f-bd3e-08a8490d4db0@kernel.org>
 <20241022071208.lgk2rpl2c2qpytfa@pengutronix.de>
 <66d33097-37ed-4e89-a356-285eda743a5c@kernel.org>
 <a11cf72d-3878-4af1-89c5-c66d55794ea6@kernel.org>
 <20241022081304.d2tpnn4eyf3adxg2@pengutronix.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241022081304.d2tpnn4eyf3adxg2@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2024 10:13, Marco Felsch wrote:
> On 24-10-22, Krzysztof Kozlowski wrote:
>> On 22/10/2024 09:30, Krzysztof Kozlowski wrote:
>>> On 22/10/2024 09:12, Marco Felsch wrote:
>>>> On 24-10-22, Krzysztof Kozlowski wrote:
>>>>> On 21/10/2024 12:25, Marco Felsch wrote:
>>>>>> On 24-10-21, Krzysztof Kozlowski wrote:
>>>>>>> On 21/10/2024 08:41, Marco Felsch wrote:
>>>>>>>> On 24-10-07, Krzysztof Kozlowski wrote:
>>>>
>>>> ...
>>>>
>>>>>>>>> Based on earlier message:
>>>>>>>>>
>>>>>>>>> "For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which means
>>>>>>>>> that both wifi and BT controller will be powered on and off at the same
>>>>>>>>> time."
>>>>>>>>>
>>>>>>>>> but maybe that's not needed. No clue, I don't know the hardware. But be
>>>>>>>>> carefully what you write in the bindings, because then it will be ABI.
>>>>>>>>
>>>>>>>> We noticed the new power-sequencing infrastructure which is part of 6.11
>>>>>>>> too but I don't think that this patch is wrong. The DT ABI won't break
>>>>>>>> if we switch to the power-sequencing later on since the "reset-gpios"
>>>>>>>> are not marked as required. So it is up to the driver to handle it
>>>>>>>> either via a separate power-sequence driver or via "power-supply" and
>>>>>>>> "reset-gpios" directly.
>>>>>>>
>>>>>>> That's not the point. We expect correct hardware description. If you say
>>>>>>> now it has "reset-gpios" but later say "actually no, because it has
>>>>>>> PMU", I respond: no. Describe the hardware, not current Linux.
>>>>>>
>>>>>> I know that DT abstracts the HW. That said I don't see the problem with
>>>>>> this patch. The HW is abstracted just fine:
>>>>>>
>>>>>> shared PDn          -> reset-gpios
>>>>>> shared power-supply -> vcc-supply
>>>>>>
>>>>>> Right now the DT ABI for the BT part is incomplete since it assume a
>>>>>> running WLAN part or some hog-gpios to pull the device out-of-reset
>>>>>> which is addressed by this patchset.
>>>>>>
>>>>>> Making use of the new power-sequencing fw is a Linux detail and I don't
>>>>>> see why the DT can't be extended later on. We always extend the DT if
>>>>>> something is missing or if we found a better way to handle devices.
>>>>>
>>>>> Sure, although I am not really confident that you understand the
>>>>> implications - you will not be able to switch to proper power-sequencing
>>>>> with above bindings, because it will not be just possible without
>>>>> breaking the ABI or changing hardware description (which you say it is
>>>>> "fine", so complete/done). I am fine with it, just mind the implications.
>>>>
>>>> Sorry can you please share your concerns? I don't get the point yet why
>>>> we do break the DT ABI if we are going from
>>>
>>> Not necessarily breaking ABI, but changing the description.
>>>>
>>>> bt {
>>>> 	reset-gpios = <&gpio 4 0>;
>>>> 	vcc-supply = <&supply>;
>>>> };
>>>>
>>>> to
>>>>
>>>> bt {
>>>> 	vcc-supply = <&pmu_supply>;
>>>
>>> ...because you just removed reset-gpios which is a property of this device.
> 
> An optional property. That beeing said, dropping the *-gpios was the
> solution for the Qualcomm DTS as well:
> 
> bd37ce2eeb84 ("arm64: dts: qcom: qrb5165-rb5: add the Wifi node")

True, the difference is I think that we came with proper PMU model only
recently while above device is supported for few years.

This is not the case here: you can choose now hardware description which
will be both accurate and solve power sequencing issues.

> 
>>>> };
>>>>
>>>> or:
>>>>
>>>> bt {
>>>> 	pmu = <&pmu>;
>>
>> Ah, and I forgot here: this also might not be correct, because if you
>> have PMU, then the PMU consumes VCC, not the Bluetooth. Therefore both
>> of above two solutions might be inaccurate description if you decide to
>> go with PMU.
>>
>>>> };
>>>>
>>>> Of course the driver need to support all 2/3 cases due to backward
>>>> compatibility but from DT pov I don't see any breakage since we already
>>>> need to define the power handling properties (gpio & supply) as
>>>> optional.
>>>
>>> Either existing binding is complete or not. Not half-done.
> 
> As I remember DT ABI must be backward compatible. I understand this as
> followed: In our current use-case the dt-bindings don't describe any
> required hw resource so we need to mark them as optional to be backward
> compatible.
> 
> Regarding your above comment: "complete or not. Not half-done". Do you
> see the current dt-bindings for this particular device as complete or
> not? In other words can we mark the reset-gpios and vcc-supply
> properties as required albeit this would break the DT ABI since all
> current users don't specify it?

It is not about required property. Does this device has reset lines or
not? If yes, then please do not come in 2 years removing it from DTS.
Because this breaks all of DTS users.

> 
>>>> That beeing said I don't see the need for a PMU driver for this WLAN/BT
>>>> combi chip which is way simpler than the Qualcomm one from Bartosz. Also
>>>> there is physically no PMU device which powers the chip unlike the
>>>> Qualcomm one. I'm not sure if you would accept virtual PMU devices.
>>>
>>> Virtual PMU, of course not. I would like to have complete hardware
>>> description, not something which matches your current driver model.
> 
> Okay so PMU is no option and we don't have to consider this idea any
> longer. So reset-gpios and vcc-supply it is :) and I don't expect this
> to change.

Ack.

Best regards,
Krzysztof

