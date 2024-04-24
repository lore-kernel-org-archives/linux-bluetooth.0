Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B415ADBD
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961065; cv=none; b=QL54SKnh+jLby/LzGreygPctEIDRHI4fR/avS94j9HtfM6TDP6fxWICRNr6ZQDUKXyA6rq9pI8Db/d5KTDEkN93daXNdCIk4y+R2ZQKQ/tIjRm+w1gmpzAUSyeqCvFQklvK8Ip0dC3rXJjbgY5x6pASCX1GwdceIFuglyJoW3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961065; c=relaxed/simple;
	bh=PxQ+wYkcEmeQVwBCgLwFCF/d6G+Ti5It4I4uaWx1W0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAYhBLdzQucPABGXEjXjtdHBdZg0t81AxZ8gVJ1N3fXtO/JhsvCv0/dB43AMqYpax30/ReCnWuSJnDR8Rlp9sF/eUZZZx9TeSehWhK2+aKgD3STso41g9iwzej2SQYvgSgPKEawCoANoOTGWs28g4fR3YIFfzF+uEH+5qsyU8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=X+ojHJ96; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="X+ojHJ96"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e9320c2ef6so29444395ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713961063; x=1714565863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIBkvQVMMmmWfMpfrnBMQsoHy1wIAPYh1MyN9fB34kg=;
        b=X+ojHJ96VlzgI77GVwkkp7qq8lGbRLYxexOMUki2Aux7CB7Helyzae5LplM3j+26Sd
         9LyzMAtY88fnLtf+d+ZKs0kXYoEiGZA1q1HV+5ym29hC6OdipX0S3A7C8gUA/9Cip3bC
         N6DF4L+qA4n0QtmHi8rEzRzthnvR8Tw0EyEvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961063; x=1714565863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIBkvQVMMmmWfMpfrnBMQsoHy1wIAPYh1MyN9fB34kg=;
        b=v11UJrt9WgDylcciDJ+NPdGSTqsLOHyPVpNEBHcz8NGa0OKZRRV4VTJ25LbYNtTpNm
         QfoFETbFA9rFGWZQGO/vxTW7ET1GMGJWEHWcA2oqC1HZIkfHqCpHsS1MRJWVW4+MppUF
         2C5Daqq1MXTPXKTcTSd+17ws86f5fjQczv6EJrutBG9A9wwTYgzo0PMFedbiD05NKBjl
         iyAOUE51FAr9zacQtAymzoIsppXXCM8PXqyV39/6X1z0wcRFi5tjxWeCdOWyhMxG5pzh
         PCJwn8Gn4QzzDXE8QvkV2J8DuyuaDeSIkbT35UurBnTWkLuYlikYuxDORDieMBoJ8Qtn
         A/CA==
X-Gm-Message-State: AOJu0YwONQTPzNwcvAaP+lkBaE4EFBdB/QOLjJ9b9ZKhvw/ZjfkPpygI
	2p7V9ZYKzRDI958p7vufe2+XSuabSCyp+pifXVZCh2Ne/UqtSTlbkNNlGVxoNI4a8PcUbCiOpJo
	hcqk8
X-Google-Smtp-Source: AGHT+IFIxPfddfQhuY9GSa7z70gpc6/K91NbvwPtqxZMuz80dAHQ4TeIKP6XwnHXuGVukijr/kjbaw==
X-Received: by 2002:a17:902:c405:b0:1e6:36cc:5c65 with SMTP id k5-20020a170902c40500b001e636cc5c65mr2937321plk.0.1713961062928;
        Wed, 24 Apr 2024 05:17:42 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001e3e09690c6sm12000465pll.199.2024.04.24.05.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:17:42 -0700 (PDT)
Message-ID: <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org>
Date: Wed, 24 Apr 2024 05:17:39 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
 <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 4:56 AM, Bartosz Golaszewski wrote:
> On Wed, Apr 24, 2024 at 1:53 PM Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 4/24/24 4:16 AM, Wren Turkal wrote:
>>> On 4/24/24 2:04 AM, Bartosz Golaszewski wrote:
>>>> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal<wt@penguintechs.org>
>>>> said:
>>>>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
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
>>>>> Nack. This patch does fixes neither the disable/re-enable problem nor
>>>>> the warm boot problem.
>>>>>
>>>>> Zijun replied to this patch also with what I think is the proper
>>>>> reasoning for why it doesn't fix my setup.
>>>>>
>>>> Indeed, I only addressed a single issue here and not the code under the
>>>> default: label of the switch case. Sorry.
>>>>
>>>> Could you give the following diff a try?
>>>
>>> I had a feeling that was what was going on. I'll give the patch a shot.
>>>
>>> wt
>>
>> Considering this patch is basically equivalent to patch 1/2 from Zijun,
>> I am not surprised that is works similarly. I.e. on a cold boot, I can
>> disable/re-enable bluetooth as many time as I want.
>>
> 
> Zijun didn't bail out on errors which is the issue the original patch
> tried to address and this one preserves.
> 
>> However, since this patch doesn't include the quirk fix from Zijun's
>> patchset (patch 2/2), bluetooth fails to work after a warm boot.
>>
> 
> That's OK, we have the first part right. Let's now see if we can reuse
> patch 2/2 from Zijun.

I'm compiling it right now. Be back soon.

>> @Zijun, this patch looks more idiomatic when I look at the surrounding
>> code than your patch 1/2. Notice how it doesn't use the "else if"
>> construct. It does the NULL test separately after checking for errors.
>>
>> --
>> You're more amazing than you think!
> 
> Bart

-- 
You're more amazing than you think!
