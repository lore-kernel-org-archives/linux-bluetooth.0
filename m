Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98ADDA3;
	Mon, 22 Apr 2024 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765173; cv=none; b=oOxh8tqgd5rXwTvmimChpM5fUM5gMovHQ057OxMMt952Y6OFNy9xiS7Sp7M0e72xsk9dRvWRBchxCLdX/IBWaQxIPf4LaSzKOcq7ND01RTSeTgtNHLqzuNFXpS9qFDGEs6B+DVdyXeHPA3A8SM9yS2pe20DMZPxmAfYi0a8Ffd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765173; c=relaxed/simple;
	bh=4O2jlXHsWYrDuABM02Eg1uO1xVYLZkgO343EIzuTYVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVQwxQGM66EoP4JYizDNuOykn+ZcAt8Zz+j0Xb3m57wed3FuvRmizK7cPNDec8CntH11TobgVqQQ1sn2CiqWAbOxGdytDw3H0e5yXLOu3kMUwvoUaOHNYCgBn0OQAqfZRsiXDCrbPYyJJTNTvDvGkuFnxVQf+qVAoxSFEFxjOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMLqaWBz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMLqaWBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE44C113CC;
	Mon, 22 Apr 2024 05:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713765172;
	bh=4O2jlXHsWYrDuABM02Eg1uO1xVYLZkgO343EIzuTYVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SMLqaWBzv+ulDAYwBBBIRgdmy6uo+URoiKqtvcdrAWc0McNQmTQAXV04+7nbaJ9H2
	 x216i5AIaU+xtu8zrRi00+4aTdGbo0yPLpb9dfVX4tz2uQUlfm1YZ2eVVVqHmRTtzi
	 gFNBFyeLLxrqIj+ORXi3jY2wrcecP/mMUSj+Cnc7CvNjUuNwVeEo+WWcPtZg5vdwkw
	 rbrIC88b9bssSOBaF3liXOnnVvIgyaAqdYv7lc7JkDok/V+kwMQYrloeDcZSFBBGAe
	 pySbmBl0394jH8iVqtGnkG54d1D09bYyQ+VRD+vlkBgsO6znr1ZpYWErVnv5nVBRKG
	 olyKb79QEG6Hw==
Message-ID: <2bd1f1bf-f867-4430-8ce5-c691485665e1@kernel.org>
Date: Mon, 22 Apr 2024 07:52:47 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix two regression issues for QCA controllers
To: quic_zijuhu <quic_zijuhu@quicinc.com>, Wren Turkal <wt@penguintechs.org>,
 luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 regressions@lists.linux.dev
References: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
 <369512e2-f091-4370-bce5-9ac32178dc4d@penguintechs.org>
 <a6ae69ad-b602-4cfc-9f76-8932f357d30b@kernel.org>
 <c0f7036d-c129-400b-85a2-1414ec3d2622@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <c0f7036d-c129-400b-85a2-1414ec3d2622@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 02:14, quic_zijuhu wrote:
> On 4/22/2024 2:41 AM, Krzysztof Kozlowski wrote:
>> On 21/04/2024 09:44, Wren Turkal wrote:
>>> On 4/20/24 3:06 PM, Zijun Hu wrote:
>>>> This patch series are to fix below 2 regression issues for QCA controllers
>>>> 1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
>>>> 2) BT can't be enabled after disable then warm reboot for QCA_QCA6390
>>>
>>> @Zijun @Krzysztof and @Bartosz Would it be helpful for me to test these 
>>> to ensure they fix the issues I reported?
>>>
>>
>> I look forward to someone testing these on other hardware, not yours. On
>> the hardware where the original issues were happening leading to this
>> changes, e.g. RB5.
>>
>> Anyway, the problem here is poor explanation of the problem which did
>> not improve in v3 and v4. Instead I receive explanations like:
>>
>> "this is shutdown of serdev and not hdev's shutdown."
>> Not related...
>>
> this is the reply for secondary issue. i believe i have given much
> explain for my fix for the 2nd issue as shown by below links.

No, you did not.

> let me add a bit more explanation within the ending "For the 2nd issue"
> section, supposed you known much for generic flag
> HCI_QUIRK_NON_PERSISTENT_SETUP, otherwise, see header comment for the
> quirk. also supposed you see commit history to find why
> qca_serdev_shutdown() was introduced for QCA6390.
> https://lore.kernel.org/all/fe1a0e3b-3408-4a33-90e9-d4ffcfc7a99b@quicinc.com/

You did not answer my questions.

Let's quote:

"i don't explain much since these HCI_QUIRK_NON_PERSISTENT_SETUP and
HCI_SETUP is generic flag."

Srsly, what is such answer?





>> "now. you understood why your merged change as shown link of 4) have
>> problems and introduced our discussed issue, right?"
>>
> this is the reply for the first issue as shown by below link. it almost
> have the same description as the following "For 1st issue:" section.
> i believe it have clear illustration why the commit have bugs.
> https://lore.kernel.org/all/2166fc66-9340-4e8c-8662-17a19a7d8ce6@linaro.org/
>> No. I did not understand and I feel I am wasting here time.
>>> Code could be correct, could be wrong. Especially second patch looks
>> suspicious. But the way Zijun Hu explains it and the way Zijun Hu
>> responds is not helping at all.
>>
>> Sorry, with such replies to review, it is not worth my time.
>>
>> Best regards,
>> Krzysztof
>>
> Hi luiz,marcel
> 
> it is time for me to request you give comments for our discussion
> and for my fixes, Let me explain the 1st issue then 2nd one.

You keep pushing and pushing even though I stated my remarks.


> 
> For 1st issue:
> 1) the following commit will cause serious regression issue for QCA
> controllers, and it has been merged with linus's mainline kernel.
> 
> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
> with gpiod_get_optional()").
> 
> 2) the regression issue is described by [PATCH v4 1/2] commit message
>   as following:
>   BT can't be enabled after below steps:
>   cold boot -> enable BT -> disable BT -> warm reboot -> BT enable
> failure if property enable-gpios is not configured within DT|ACPI for
> QCA_QCA6390.
>   i will verify and confirm if QCA_QCA2066 and QCA_ROME also are impacted.
> 
> 3) let me explain the bug point for commit mentioned by 1), its
>    commit message and bug change applet are shown below.
> 
> The optional variants for the gpiod_get() family of functions return
> NULL if the GPIO in question is not associated with this device. They
> return ERR_PTR() on any other error. NULL descriptors are graciously
> handled by GPIOLIB and can be safely passed to any of the GPIO consumer
> interfaces as they will return 0 and act as if the function succeeded.
> If one is using the optional variant, then there's no point in checking
> for NULL.
> 
>  		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>  					       GPIOD_OUT_LOW);
> -		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> +		if (IS_ERR(qcadev->bt_en)) {
>  			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>  			power_ctrl_enabled = false;
>  		}
>    3.1) we only need to discuss how to handle case "qcadev->bt_en ==
> NULL" since this is only difference between the commit and BT original
> design.
>    3.2) BT original design are agree with the point of above commit
> message that case "qcadev->bt_en == NULL" should not be treated as
> error, so BT original design does not do error return for the case and
> use dev_warn() instead of dev_err() to give.
>    3.3) the commit misunderstands BT original design and wrongly think
> BT original design take "qcadev->bt_en == NULL" as error case,
> so change the following flag power_ctrl_enabled set logic and cause
> discussed issue.
> 
> For the 2nd issue:
> 1) the following commit will cause below regression issue for QCA_QCA6390.
> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>     serdev")
> 
> 2) the regression issue is described by [PATCH v4 2/2] commit message
>   as following:
>   BT can't be enabled after below steps:
>   cold boot -> enable BT -> disable BT -> warm reboot -> BT enable
> failure if property enable-gpios is not configured within DT|ACPI for
> QCA_QCA6390.

You did not address original issue of crash during shutdown and did not
clarify my questions.

> 
> 3) qca_serdev_shutdown() is serdev's shutdown and not hdev's shutdown()
> it should not and also never get chance to be invoked even if BT is
> disabled at above 2) step.  qca_serdev_shutdown() need to send the VSC
> to reset controller during warm reset phase of above 2) steps.

Anyway, any explanation providing background how you are fixing this
issue while keeping *previous problem fixed* is useful but should be
provided in commit msg. I asked about this two or three times.

BTW, provide here exact kernel version you tested this patches with.
Also the exact hardware.


Best regards,
Krzysztof

