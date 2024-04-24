Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31C15ADB4
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961463; cv=none; b=hT3gZwpEcqB9sAs5eebAX/FsDy6GZKR6AXwiLXmdZhuUaNFdsz1Koezycc1998nSzo2us+gxA/wOAhVqxK72hy/8VXlNPvOZf3fcJeiJlqlCm01hG6wKTn/te8UX5p0mhbCML7EBy4Y7jRHxyaZWei+TJjAE3ltlJT2M8C/COKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961463; c=relaxed/simple;
	bh=OV4z9H/8jN31+y9NLiVEFvEC6g7Cwn7+9a6Tolz17Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BItQ/dzEubZSegtUijgxnHe+IvlXQwDYEqdFscc/Dl2DKN2FGJO/k/DpaFTZlzu5blkaYDgwT25H7RnGAeW/PAxyd6KJIcgH/aFGMqYwBvD8JuHne/uKUhz7KmOvZdhBXOX6Vo98Ri/7FD9hNCjvAZcI9s6Y7UdxWCntPMsW6ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Q/WNuSAF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Q/WNuSAF"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso4671159b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713961461; x=1714566261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m65mAQtZimqYlg0bcPSAClAiSSNqZnRhkYk00l0dswc=;
        b=Q/WNuSAFjXZ05I6U6sNrR/UoCeMfnxD983y2CAk4H0fAg8L0KrhbFZwy+webqzg0VG
         PUUIPFPu6dqD2zRXBD5p31OzDmiril86kXheuDs3KDwD2rlKAmr1go9D3K8LsK2g+3OI
         3JgkrIQSipoT2aJG75/o8np8KQ0r7iBhFRzhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961461; x=1714566261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m65mAQtZimqYlg0bcPSAClAiSSNqZnRhkYk00l0dswc=;
        b=h3ckvBPC72Lhn6b5TtpNtSV4xIOh3Ptu6Tqd4hQqxO/hFBzUNpOuW8J6t4g2Ljho0M
         WXh6UC1SGNDc+ed6zE53+fMbSKSrUR8iUL6465w0F3oUj4u+AbgOvvFVIwJS6lqhITKA
         EOmzZZVyD5+a4Yb+o52vdBDXeOYtY6HvTTM7qhAOB0MwbQw5ykxteovsZ/yaQdsy613S
         wJlBI6Qz+8hu3xbNZmT7g1hO9xIYgZa9tpxx+3bjrnIWgzgTC+CRfFupFufDCxfd23Dd
         Dqegr+dI/NLV4/K2nVHkwBZbL88jkBstIXUiRJYckBN6yS3c5v8QxYeeNEvyx85t4Bns
         twzg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5T/AFEFRzNpRAVJt5bjEUihrnh9lKoZE7K6Ae/qWAEZq8Zy7i8RcYRi8OgiyG2as8xSMZLlc9fL+ODTMKhCid+HZ3k7oqGONzvLv4ibg
X-Gm-Message-State: AOJu0YwAem9+WVEYrZnbjXnu3o7OD8BdZZUYOjAFc5IgidfQ0RL3BCqo
	xeal26LLQxEstA7MWByVjBt0AKVjbMw9zesnGF/An6V+MMBIJvzfls+RDBiAUA==
X-Google-Smtp-Source: AGHT+IH91n9dgk1Hm+qCswARATtS9J+jv73AeRC8e6JkXGXxi6OAt1xUX6DGWhmlmThGws2rSLAL4w==
X-Received: by 2002:a05:6a00:815:b0:6e6:ac71:8b38 with SMTP id m21-20020a056a00081500b006e6ac718b38mr2862570pfk.22.1713961461333;
        Wed, 24 Apr 2024 05:24:21 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id r84-20020a632b57000000b00601df0a973dsm4361475pgr.48.2024.04.24.05.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:24:20 -0700 (PDT)
Message-ID: <4c33304a-5dbc-450a-b874-e04ba9e93150@penguintechs.org>
Date: Wed, 24 Apr 2024 05:24:19 -0700
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
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
 <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
 <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org>
 <CACMJSeunUaj0cxLaN4MpFmX5vTOx_vnWjBN4Y2FavdQoQxFRkg@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CACMJSeunUaj0cxLaN4MpFmX5vTOx_vnWjBN4Y2FavdQoQxFRkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 5:20 AM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 at 14:17, Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 4/24/24 4:56 AM, Bartosz Golaszewski wrote:
>>> On Wed, Apr 24, 2024 at 1:53 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>
>>>> On 4/24/24 4:16 AM, Wren Turkal wrote:
>>>>> On 4/24/24 2:04 AM, Bartosz Golaszewski wrote:
>>>>>> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal<wt@penguintechs.org>
>>>>>> said:
>>>>>>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
>>>>>>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>>>>>>
>>>>>>>> Any return value from gpiod_get_optional() other than a pointer to a
>>>>>>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>>>>>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth:
>>>>>>>> hci_qca:
>>>>>>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>>>>>>> power_ctrl_enabled on NULL-pointer returned by
>>>>>>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on
>>>>>>>> errors.
>>>>>>> Nack. This patch does fixes neither the disable/re-enable problem nor
>>>>>>> the warm boot problem.
>>>>>>>
>>>>>>> Zijun replied to this patch also with what I think is the proper
>>>>>>> reasoning for why it doesn't fix my setup.
>>>>>>>
>>>>>> Indeed, I only addressed a single issue here and not the code under the
>>>>>> default: label of the switch case. Sorry.
>>>>>>
>>>>>> Could you give the following diff a try?
>>>>>
>>>>> I had a feeling that was what was going on. I'll give the patch a shot.
>>>>>
>>>>> wt
>>>>
>>>> Considering this patch is basically equivalent to patch 1/2 from Zijun,
>>>> I am not surprised that is works similarly. I.e. on a cold boot, I can
>>>> disable/re-enable bluetooth as many time as I want.
>>>>
>>>
>>> Zijun didn't bail out on errors which is the issue the original patch
>>> tried to address and this one preserves.
>>>
>>>> However, since this patch doesn't include the quirk fix from Zijun's
>>>> patchset (patch 2/2), bluetooth fails to work after a warm boot.
>>>>
>>>
>>> That's OK, we have the first part right. Let's now see if we can reuse
>>> patch 2/2 from Zijun.
>>
>> I'm compiling it right now. Be back soon.
>>
> 
> Well I doubt it's correct as it removed Krzysztof's fix which looks
> right. If I were to guess I'd say we need some mix of both.

Patch 2/2 remove K's fix? I thought only 1/2 did that.

To be specific, I have applied your patch and Zijun's 2/2 only.

> Bart
> 
>>>> @Zijun, this patch looks more idiomatic when I look at the surrounding
>>>> code than your patch 1/2. Notice how it doesn't use the "else if"
>>>> construct. It does the NULL test separately after checking for errors.
>>>>
>>>> --
>>>> You're more amazing than you think!
>>>
>>> Bart
>>
>> --
>> You're more amazing than you think!

-- 
You're more amazing than you think!
