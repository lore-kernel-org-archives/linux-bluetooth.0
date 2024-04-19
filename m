Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB57128806
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534549; cv=none; b=pfl10qEGzHnWrK+K7uzcmliRjMb2jZek32Wfg8ldAOgJ4xzAxuHPLd6wF6EF62TQ/9CBdtfyjNR+ih6IvjjbW6Qron5ZuDEkr2MoOQcqJEyf6aGhJxzDEHyG4YyMArKFD/2rWcwcQakGs5SRfcEwmWm4zINIFZKEZEP+eZNvddQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534549; c=relaxed/simple;
	bh=oKI5BPdqkG1DZG8TVjm2NPRvUK4SdH1iObqxn2kk388=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTJTUVgvAwEB5xJaHmCbOC2IRj1waEn5yREUyMCzeBc6G9TwnZkcpRm+bmpR7EM/VptTgZdkWtt6LsjaqEdji5Oar9bHoqWJlfi9fdvNV4NWvOLiMPGoxLIsb2AfY3z9hYXcDeiUQqR7bA92PkmwTWu1E3pe6i9tOsjObmEmzoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7tOJ3gt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7tOJ3gt"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e5b6e8f662so16892725ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713534547; x=1714139347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oKI5BPdqkG1DZG8TVjm2NPRvUK4SdH1iObqxn2kk388=;
        b=d7tOJ3gty2cye+RoZM3Yw3HFJDiJioIP6CC3r8KLQiqkkGvYG/V23EY5Jab7A2s/Ip
         QIVnmL7KyaI6TqxXq8M5CZbUqcS9EX0dtN/ArGbLHIPYcgS+ausPiFuw9QmLWvOHbROI
         DBJH8rgAKtBwCy7UGqQufA1QvsKCXotrEtFefRkWeh/3SDbR50MeM886Isu9bs43Rm+B
         Vvi4tS9BW8E3aH4N7wxJnx6FPBuDWT1aiqeu/IrsPWyvV4JTG8qo4E4Fb4Dut7CqewTv
         BkcJjaikx+Btdu5hwF3xeTrAPYf0S8pBElZ97Z2MUYFkWxclz88rXYR3pBIqfDX8thSn
         GStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534547; x=1714139347;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKI5BPdqkG1DZG8TVjm2NPRvUK4SdH1iObqxn2kk388=;
        b=oFLnN4VfRtXwRaYe1ZrnM9nIFgNBONR+PzlItEUNaq1n1J3gU4MkaIRzUtAdLUG08M
         qAro4Q2Mc2L5RvbqVDtiyjjoF2uhzqCgB0PHJ31pYmvCd/h4ToNQ7fZALfrFvyn7PS6G
         4aYWp2dR5hv4hAdFmb3hhA74gt6aEOCEYaQT70TLiUxE/qd6WcUNUn13VuQsYyUaZ1Ej
         liskOha9rqgySqgo3juL1ZisKtB5FRvoP/lfGgs2eGQmgF5GzxvmA6JqDWOb+Z9/Buwd
         lNdWaXqraCjNbRILWlyVu/voeGD6zoRXPtF1iWeT6qZJnxpMhmBLeBDmpMFRMgUOohiR
         aXJw==
X-Gm-Message-State: AOJu0Ywx5Q+y86XIkS9209AggGwBNOFt7esxDgfhE/yZ1C/GWCQ2pZvp
	d7nUK26qjUwTH3ytzcO8Zo5I3a/E9Nesy1Oha46RfjWUAO7isQwIoNldVr6OY2w=
X-Google-Smtp-Source: AGHT+IFISYmZ1F/vS7Q+Jj+R0w2wCwak1topZK69IHmjxIROV5qfqY1xUj15D74iodSYcRqG/YHUBA==
X-Received: by 2002:a17:902:d2d0:b0:1e8:32ed:6f6d with SMTP id n16-20020a170902d2d000b001e832ed6f6dmr2329377plc.39.1713534547363;
        Fri, 19 Apr 2024 06:49:07 -0700 (PDT)
Received: from [172.20.9.36] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm3336342plt.261.2024.04.19.06.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 06:49:07 -0700 (PDT)
Message-ID: <4e4d8ee0-fbbe-4dc7-b40b-b983f9f39539@linaro.org>
Date: Fri, 19 Apr 2024 15:49:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: quic_zijuhu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 bartosz.golaszewski@linaro.org
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <83a1c837-e403-4da2-83c6-ee3dedbc1fe0@linaro.org>
 <7c5b85ca-e897-4798-97e7-955478c57d12@quicinc.com>
 <52394d97-04c3-4f77-aaae-f1e152cd5632@linaro.org>
 <0dca7c9b-6a97-4171-9b0c-5b806a4e8a60@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0dca7c9b-6a97-4171-9b0c-5b806a4e8a60@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/04/2024 01:17, quic_zijuhu wrote:
> On 4/19/2024 6:37 AM, Krzysztof Kozlowski wrote:
>> On 18/04/2024 23:16, quic_zijuhu wrote:
>>> On 4/19/2024 12:52 AM, Krzysztof Kozlowski wrote:
>>>> On 18/04/2024 16:06, Zijun Hu wrote:
>>>>> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
>>>>>
>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>> with gpiod_get_optional()") will cause serious regression issue for
>>>>> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
>>>>
>>>> The pin is required on 6750, 6855 and maybe others. You cannot not have
>>>> the GPIO.
>>>>
>>>> This is no correct fix. You provide wrong DTS and, instead fixing it,
>>>> try to revert kernel code.
>>>>
>>>> No, fix your DTS first.
>>>>
>>> no. your point is not right.
>>>
>>> 1) do you have any evidence that the hci_qca driver must use reset GPIO?
>>
>> I think we talk here about enable-gpios, right? Then the evidence are
>> bindings.
>>
> yes. properties within bindings only means driver supporting it, don't means user must
> config it. the gpio is got by devm_gpiod_get_optional() variant. that means it is optional
> about if user need to config it.

No. Read writing bindings and other presentations explaining what are
Devicetree bindings.

You miss entirely the point and use downstream narrative. This won't
work and it was told so many times, that I expect you to do the homework
first.

Use "go/upstream" before posting more on this topic.


>>> 2) why does original design do error return when get GPIO error if GPIO is mandatory?
>>
>> If GPIO is mandatory, then it is expected to return error. What is the
>> problem here?
>>
> sorry, i miss a NOT for my question. my question is that
> 2) why does original design NOT do error return when get GPIO error if GPIO is mandatory?
>>
>>> 3) i meet many customer cases that BT are working fine without hci_qca operating the GPIO,
>>> there is why HCI_QUIRK_NON_PERSISTENT_SETUP are introduced.
>>
>> Bindings tell different story and nothing in the commit msg explained
>> this. You did not correct bindings either.
>>
> don't need to correct bindings. i believe bindings does not say enable gpio
> must be configured.

They say. Read the bindings. Test your DTS. Or better: upstream your DTS
and prove to us that dtbs_check allows lack of enable-gpios.


>>
>>> 4) does the reverted change solve the issue your mentioned ?
>>
>> ??? I did not mention any issue. I am saying that your rationale is
>> either not complete or not correct.
>>
> do you suggest about how to make it complete?

Yes, read what are bindings and then describe your change including
that: what is the issue, how it can be reproduced, what is the hardware,
why the bindings are not correct (if they are not correct) etc.


Best regards,
Krzysztof

