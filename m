Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C14757E1
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036487; cv=none; b=edVbPZYGLOAQCvb/TrfREmSExXXX2g9Wv+QJ9oavem7V6n3lFo4ncXm43Ys6usR/zYsz9v8cJ1kQdYuElSPOnBLr90KgAqAWEuF7CnaLUpe4Q86Za1wbRnzC6/b8i97nwH3cmpuabwNPDLf3bV7WC5jqmCaJV5ZE4EZ5ixf624g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036487; c=relaxed/simple;
	bh=w8vkJ13wQnR6P5vkZuaf65m9YP32eb8GUkuIYdr5qs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V40mi4ncmgbppvBALXMC9rjfz3puzqWITiz7wz+HbjIwfYC28KWQUxu1opTsxRYUYUiStI+kCscu17MpTY9h1iw8Tjtq4zb5ZqsgI1xqQhNKZNEauHxczPu9yh1X+p/dpPm2GjDXcZSJm7iR7dd3Hv38RjMCH/kXDT/exmOu53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=daV4t5AK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="daV4t5AK"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso6240795e9.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714036484; x=1714641284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aMFlUt03OrSGQ9jcV4gNJQ98yi8IaKLhIUTcQkXPpi0=;
        b=daV4t5AKBKZPlqDQajBo+dI1VfzRn+wT/YoTSMajsaOPWPJusI8d45WnuyMoF6H/yx
         twe9O6/zBWKY/7YGFMEiudg5D6u+4WqZbAkhJ5MJlcFBSl2jYFuHN3A3F/cO0sodJgMa
         Jw8BsSIRq243DmYVHOLrtUU7XYuZcxXEUbZHGCoPLcZ+SozXSms8eYNk0I6SW+G+NaZB
         hIE4MIiKLDKuwiZJ/78XgyepZu5j4R0mXTJgNTCAToWXKXW8s+aTBWQl/V2MfMRUBEb2
         KkRGneE0b9XJ6S/woQ5FUn2CjHiKCX5tMobWCOaD6yVzoaWBKi6GYM88dZ/kjc0NS0Z1
         ufXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714036484; x=1714641284;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMFlUt03OrSGQ9jcV4gNJQ98yi8IaKLhIUTcQkXPpi0=;
        b=xEwgUXeDdKGZZBl1aCuRjm83MCEmFNRM58uhQ2+CRH6RM/3ds+uDY4CtElzf8L9Yo/
         eagwL/3aBCwEVu7iOX/OCv0rjwSKKrfxuvEhFNAvGRm4b1Q6Zbr+2SuYHOo70dFHfejA
         k40T6cPDlzQ4RGhavlDIT65zZHn+y8L9G82F5HI/3bFhth7WX05FFSFFtFeQYs7nWqUi
         wykHsV2KDeou4m8GkxNGpbQub/Z9qW6aa8EHXvw3GmnKa9SyELK5HBBi1ucXIhsVw3h7
         nfJNy7HGBevP7l6U48Eu53tjoRVGHc6UQBV2COkaUPsSesXT+KG+lB/ZAN8dG2nLX/1o
         2Ouw==
X-Forwarded-Encrypted: i=1; AJvYcCU+j25GtafOHp79JdrduoM+Fl8dzYmt0HiyYP8HrSr2KBkvk0nCkhbyr9DMNq5q274Ld3kAiu3Ef6pXz7gS5pe5XKyUWCr2p7J4tejj1k6x
X-Gm-Message-State: AOJu0Yz6UlIGK7vnc8Rhympr1/4nLDsyApGeWEIs7mBBuBpQGO/9300d
	w0KDlTnVE8Xyg72pA9BvRJaavZiMd8JeGSqVKwSkxpfPIw9/chxoIyO2vSotizg=
X-Google-Smtp-Source: AGHT+IEh9vN416an1viEDE+3BBMNVgorLOiQmy4wGxaJBs/xQnJfsWwMxxA42W9kbiXKVB10awJzYQ==
X-Received: by 2002:a05:600c:4590:b0:418:f991:713f with SMTP id r16-20020a05600c459000b00418f991713fmr3793864wmo.23.1714036484262;
        Thu, 25 Apr 2024 02:14:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b0041aa79f27a0sm9676218wmo.38.2024.04.25.02.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 02:14:43 -0700 (PDT)
Message-ID: <d4c65299-d3af-4741-adc8-aafc1ab34369@linaro.org>
Date: Thu, 25 Apr 2024 11:14:42 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Correct property enable-gpios handling
 logic for WCN6750 and WCN6855
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Wren Turkal <wt@penguintechs.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 quic_zijuhu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, kernel@quicinc.com
References: <1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com>
 <af004bcd-0649-4a82-8f09-36d6addd0e1e@linaro.org>
 <0cba3838-917b-48af-ba8b-2ef60714943a@quicinc.com>
 <49cf0a3d-5f52-41a1-9858-692f48d06b88@kernel.org>
 <c1632816-f754-42c6-8448-2daff8221b58@penguintechs.org>
 <368e70e0-edc2-44fd-a9a2-72efa0d9f864@linaro.org>
 <f372c661-d82a-4f6f-b2de-8dd241d6b107@penguintechs.org>
 <CACMJSesk+DYFDwM7hUoPs9Xy+i1q8w+5CFu4_RdreUXudk18zw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CACMJSesk+DYFDwM7hUoPs9Xy+i1q8w+5CFu4_RdreUXudk18zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 10:30, Bartosz Golaszewski wrote:
> On Thu, 25 Apr 2024 at 08:30, Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 4/24/24 11:05 PM, Krzysztof Kozlowski wrote:
>>> On 25/04/2024 00:01, Wren Turkal wrote:
>>>>>>
>>>>>> 3) only care about the case property enable-gpios is not configured,
>>>>>> the original BT driver design logic indeed matches with binging spec's
>>>>>> requirements before bartosz's wrong change
>>>>>
>>>>> What? There is no such case according to bindings. I told you already
>>>>> two times: Either change bindings or this is not valid.
>>>>
>>>> @krzysztof, I'm curious. There is no entry in the binding specifically
>>>> for qca6390. Should there be?
>>>
>>> qca6390 is documented in the bindings, but you are right that it lacks
>>> if:then: entry narrowing/choosing specific supplies and pins. It should
>>> have one, indeed.
>>
>> Would creating an entry for the qca6390 hardware fix the issue you are
>> worried about?
>>
>> Again, sorry for all the, what I assume are, basic questions. I am so
>> far out of my depth here. I am just trying to figure out how to move
>> forward. I really do appreciate your guidance here.
>>
> 
> Wren, Krzysztof: I cannot stop you from doing this but I'm afraid this
> will complicate the power sequencing work unnecessarily. The QCA6390
> PMU bindings I'm proposing[1] are consumers of the BT enable GPIOs. In
> my series I also create an entry for QCA6390 Bluetooth[2] but without
> enable-gpios and with the inputs from the PMU, not host. Please
> consider that if you decide to go with this.

I don't have a near plan to describe QCA6390 supplies and pins, so don't
worry. I also don't think Qualcomm BT understand what are bindings, so I
don't expect patches from them.

Best regards,
Krzysztof

