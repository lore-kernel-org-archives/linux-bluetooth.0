Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E027447
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966028; cv=none; b=i9Ru4NHHiXK962SroU8UnChCHAOQ0E2KSww+04XMMzaonzUDDfBZm3zAtd17ssX7VxY9BYkcxHP8ijnqJWp4EAjhtQskeoF4BeKSiSOH+SoqM4CQaIPL80TdXThSMExTfr80H24KgFAztOTdfcxNhCzaVZxFqheL9WHqoZtrFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966028; c=relaxed/simple;
	bh=I2A//Dk/vBjLl7T5iGDpWDK7BZkYUxkQfGgZDceQaWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaT33LedRj6JYB29jrXman4aF6yhySfvV0oNPvXx4ZJSKn9tESBYgLNr87QFNqRvYUtaKgARzHG3uIM9hj+pqFwfW5+PHy3OQGFgqA5uLjRaMyP7vX0qV2xcU64uHCK8am73JfCl4RBx29zrv7jjfjh8OyrZKvDHZzxP3K0JI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=NNnxgOV+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="NNnxgOV+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ee0642f718so718463b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713966026; x=1714570826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJTr0pS0+pBhQrdYz+DCxZJiknMJew6US2gBKZp5jg0=;
        b=NNnxgOV+b+upddHwUfn7evO7ClnwTgs3JZ3Q5wzDKWkUV7xA1PMZWwcljvAxsHws3k
         I/upEc1C/4ZmH6y3WuE+V5X0kymi4MX9torosH5D9uQ9kDH5BiC8L/3Axz5bHigmam4C
         GBAYf2Ux3ME8SqRik4Tv9wEpwDxhyCLV+qIzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966026; x=1714570826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJTr0pS0+pBhQrdYz+DCxZJiknMJew6US2gBKZp5jg0=;
        b=YQV6/zRjmBO6ONqS7PXyyHVhzQ1WHAJR4L8N7gPOfWKvoVOX80W2ZHBOnyfCAWhhGj
         mU5IpI6tH67l2pfACPjOyw3+yQ1t3S3vUCrWeRpyHpxNsPZoUziHKm1cQuh77vCbGarX
         kEvtPT5+1/QJVdgbBfs7JNeg5e5u1y9ll6puZ67Xelgolh8TCgjK5SmG87aiDk3O7jGk
         qKQufDJodEnbctaZzsIIrN4S7XMyt4XoYrj82/xeoFkHc2LH7PDsXOuvQatcAK6XPL0z
         d3EenaAZqU4bVKBeVTqfGKDCwC27u275hKQe4AyGuldQgOMY9vyrrrRgVHUnb1SDJ0/M
         qh9g==
X-Forwarded-Encrypted: i=1; AJvYcCWjLCAKl/xOzPLw8VNXR/qBzNRUZtfUfuHTbtOgzw+6fa9F54R/cBlMlAb9wzJkfhPpp2Gz2q+hMKJBSGL9TvK655GwjlADEbbiunbOokUq
X-Gm-Message-State: AOJu0Yyl46HVbrA7TwCDjPu6YHKuOGapivamFX7h+ftOIo17hn+vd7Eo
	dG6RbTpRpTaGT9rH/dpDnDPetTQ9mzjsW+zYyVtm0udyr06Uil4yEpnOwROIng==
X-Google-Smtp-Source: AGHT+IFIfpJMclSpyaqVixt8fNkXf3bVerhtpzCCQCYHw9tn9Ap8cn8nMs6xRuG89HGr3IACEMEtcw==
X-Received: by 2002:a05:6a00:4f86:b0:6ed:41f4:1886 with SMTP id ld6-20020a056a004f8600b006ed41f41886mr3516900pfb.8.1713966025910;
        Wed, 24 Apr 2024 06:40:25 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id m2-20020a638c02000000b005e857e39b10sm11258888pgd.56.2024.04.24.06.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:40:25 -0700 (PDT)
Message-ID: <854acf89-43a4-42f8-b8ea-8f0c108f3aec@penguintechs.org>
Date: Wed, 24 Apr 2024 06:40:24 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
Content-Language: en-US
To: quic_zijuhu <quic_zijuhu@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240424122932.79120-1-brgl@bgdev.pl>
 <ba9b0e6e-3601-4460-ab5c-a02eb7708a4f@penguintechs.org>
 <CACMJSesZqCG=fdWe5C31a0iOFJ-ZpPRr70T_1TNLn7xqChZ4Sg@mail.gmail.com>
 <0e6bc9af-71f2-46b5-8b92-5da674b44ad7@quicinc.com>
 <a45016e9-1668-40eb-83a1-7a62162e319a@penguintechs.org>
 <97ecc6fc-6b0e-4028-ac06-1952f133bd2a@quicinc.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <97ecc6fc-6b0e-4028-ac06-1952f133bd2a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 6:36 AM, quic_zijuhu wrote:
> On 4/24/2024 9:31 PM, Wren Turkal wrote:
>> On 4/24/24 6:22 AM, quic_zijuhu wrote:
>>> On 4/24/2024 9:18 PM, Bartosz Golaszewski wrote:
>>>> On Wed, 24 Apr 2024 at 15:10, Wren Turkal <wt@penguintechs.org> wrote:
>>>>>
>>>>> On 4/24/24 5:29 AM, Bartosz Golaszewski wrote:
>>>>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>>>>
>>>>>> Any return value from gpiod_get_optional() other than a pointer to a
>>>>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>>>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth:
>>>>>> hci_qca:
>>>>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>>>>> power_ctrl_enabled on NULL-pointer returned by
>>>>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on
>>>>>> errors.
>>>>>> While at it: also bail-out on error returned when trying to get the
>>>>>> "swctrl" GPIO.
>>>>>>
>>>>>> Reported-by: Wren Turkal<wt@penguintechs.org>
>>>>>> Reported-by: Zijun Hu<quic_zijuhu@quicinc.com>
>>>>>> Closes:https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use
>>>>>> IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>>>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>>>>>> Signed-off-by: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>>>
>>>>> Tested-by: "Wren Turkal" <wt@penguintechs.org>
>>>>>
>>>>>
>>>>> Like this?
>>>>
>>>> Yes, awesome, thanks.
>>>>
>>>> This is how reviewing works too in the kernel, look at what Krzysztof
>>>> did under v1, he just wrote:
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>>>>
>>> v1 have obvious something wrong as i pointed and verified.
>>> so i think it is not suitable to attach v1's review-by tag to v2 anyway.
>>
>> @Zijun, your concern is that current DTs may not define the gpio and
>> this will cause the bluetooth not to work?
>>
>> Would that not more appropriately be fixed by machine-specific fixups
>> for the DT?
>>
> for lunched production, it is difficult or not possible to change such
> config.

I am not talking about the DT in the device. I am talking about the 
mechanism the kernel has for applying fixups to DTs.

If a dev builds a new kernel for a dev and finds it not to work, the 
kernel would then have a fixup added, like described here: 
https://docs.kernel.org/devicetree/usage-model.html#platform-identification

> 
>>>
>>>> And mailing list tools will pick it up.
>>>>
>>>> Bartosz
>>>
>>
> 

-- 
You're more amazing than you think!
