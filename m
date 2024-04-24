Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2515CD4A
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965490; cv=none; b=Q6imAKBJqpDXJoO9R/VW3RdIHR6tFi6CviuentClnHOpyecot5Pe1AeXsJ+BFYYfUcOVrVxki7LGXqsvbw1RaPVBZqTtpyW+D1J3c9iX99Bn7qnAsGTKAN2MMwspOAodb8eZ4EK1cLT7+U1IFrohbHS5p76aBUlSVivrM+gLXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965490; c=relaxed/simple;
	bh=FpHiSHBWa8hB2HJQSr1l8XXavuoYgmWzEF+4GcYtiAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrQSpaf1S2P6qPULS1LMpgIiBjOFxAHir2CACKC0hrNSykqeekW1fhUYJ6xwk0VZ2M83DoqkI3hKdMGmUZmmTjAzCoeArriMrOrhcNvfX0Ilzl7NuKKWhalrc2m8n8OEX11WA3695l9cI6oPVxriP+sP2STJWI5SJxUv+nNree0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=lMqcUYE0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="lMqcUYE0"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ff57410ebbso2818873a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713965488; x=1714570288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/b8ogQ/U9sYw/jA9bb3B0UZYA0pUdk6VhPqnMD1gH8=;
        b=lMqcUYE0T2BWwq4gaONxaK6EgSfM2QU8h8v9CwrzXtaW7j5WvBHwjAVTYVBIDV1BUC
         P3lQ3T8fIlGA7png23wetddzMh4EFB+zAyUIZfSGd3E91uVpjZTXHZCLmOYkNVbLNCXJ
         3M/zaQYFyxOxAENKVp+vo2hqjAsCjJbzbiWXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713965488; x=1714570288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/b8ogQ/U9sYw/jA9bb3B0UZYA0pUdk6VhPqnMD1gH8=;
        b=tdTFLmP0wIIgHlAApEdFglVIHwePE0h/S87Eb0OTCITHlW9tfkHywyWbuLW8KDXyEN
         nxS4vZ9wZfbJuGq/O5hwoBl9VONxsG3W3IbfuTNlzF1b7Nkb+sHJI9zXl/ed6/Idxwvp
         3yEGtzUN/wYawCJPXgMjuTGsCN1IiG4Dk5kJBIhtSpyxRzs49Txh9w9H/ZG5FtCGq/5V
         YBDDRezQhd6txhdz0easn0VAenmeZO50iM9YeS/wQepxkyYdTwEgdLjImQha4UZhKM+K
         aoyYUuoFpHzG+2/UWO/nW8b5ZRQwPzIX4oSgqjh8+MCtjVVz+Wee3lIGijxdwMh3waXU
         BG3A==
X-Forwarded-Encrypted: i=1; AJvYcCW182p5c/nktDMIEaKEWuQlvbc2cneBbLD6KZBH2LXy/B308ljje6BCZQDWQmZ7uNHq9vSj4YfqfHgA0wmrqE80Jz4rGkIzw9R2iM4q+eR1
X-Gm-Message-State: AOJu0YwPG+xnQnics5dZTOO+gXxlnNl22XV1Rd/Fh5ttKc1+l1C+Tiqo
	GAGGv6r3EDJz8E8FFdNy6V73Vd1ejjSvGBtHYpv/ZYU5IEGemaABVvIjVXq4AA==
X-Google-Smtp-Source: AGHT+IGH7s1htY4bnhpUcO/UHqZ1cpJJEM+XrRLcwpP2Rpw4w8ZfrdQIrJWw5R3gurRxzfEK7Pnt/Q==
X-Received: by 2002:a05:6a20:9c8f:b0:1a7:6262:1dd1 with SMTP id mj15-20020a056a209c8f00b001a762621dd1mr2623876pzb.51.1713965488406;
        Wed, 24 Apr 2024 06:31:28 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id c18-20020a63d512000000b005dc49afed53sm11268374pgg.55.2024.04.24.06.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:31:27 -0700 (PDT)
Message-ID: <a45016e9-1668-40eb-83a1-7a62162e319a@penguintechs.org>
Date: Wed, 24 Apr 2024 06:31:26 -0700
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
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <0e6bc9af-71f2-46b5-8b92-5da674b44ad7@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 6:22 AM, quic_zijuhu wrote:
> On 4/24/2024 9:18 PM, Bartosz Golaszewski wrote:
>> On Wed, 24 Apr 2024 at 15:10, Wren Turkal <wt@penguintechs.org> wrote:
>>>
>>> On 4/24/24 5:29 AM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>>
>>>> Any return value from gpiod_get_optional() other than a pointer to a
>>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>>> power_ctrl_enabled on NULL-pointer returned by
>>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>>>> While at it: also bail-out on error returned when trying to get the
>>>> "swctrl" GPIO.
>>>>
>>>> Reported-by: Wren Turkal<wt@penguintechs.org>
>>>> Reported-by: Zijun Hu<quic_zijuhu@quicinc.com>
>>>> Closes:https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>>>> Signed-off-by: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>
>>> Tested-by: "Wren Turkal" <wt@penguintechs.org>
>>>
>>>
>>> Like this?
>>
>> Yes, awesome, thanks.
>>
>> This is how reviewing works too in the kernel, look at what Krzysztof
>> did under v1, he just wrote:
>>
>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>>
> v1 have obvious something wrong as i pointed and verified.
> so i think it is not suitable to attach v1's review-by tag to v2 anyway.

@Zijun, your concern is that current DTs may not define the gpio and 
this will cause the bluetooth not to work?

Would that not more appropriately be fixed by machine-specific fixups 
for the DT?

> 
>> And mailing list tools will pick it up.
>>
>> Bartosz
> 

-- 
You're more amazing than you think!
