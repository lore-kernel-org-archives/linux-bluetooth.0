Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076E142E70
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963449; cv=none; b=RnhtL+n+zeehH9dpL8+V575ImrXlu2oA2rk3ewGvZTv5KMr9LRTBsK98lGu6YNJuXERJMkLHSg4KuwDapg59cR41lUAZ9d3Og3T1Arn7LLvYZ7AXJYphwp0vNJCBjoctAsDLUCFPLT0olK88QzTwX7DmXvBX36QQVs4We2OWn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963449; c=relaxed/simple;
	bh=Gtc1aJgBH1a4DIcb5evcZfVHBPHJM/4X8FE/P01Ngmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opgirn79rr9sQvXtYyHHeN9629ip2LOvsECMJd/pVccgcAsmv9QZtU4/OJWH2nmKbG9b6pEKTaM50hv0NTXfl7uwyrfhCnvx4FiTNQp5PX9p1I7tUQ4mMeRhXyuAnvsPUBy1Ar7jOAmmasfbRwNkJFdl8IDYta9o+CjTZ43Sdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=T3lzf99f; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="T3lzf99f"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f00f24f761so5766266b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713963448; x=1714568248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gwfag+4QyqDwX4tmQGtCvcYSxBxdidTO2gJviq/hKo=;
        b=T3lzf99f6Rz2JRdBWMAf+kEozjsD7pA2qNVcdVL6hJRBV4LjHbcBlw7DI2Ji2e0F4u
         HoY+gmUrd9biSCsd3qCwgEVMTXeL1XVMrYAD69Pp3uhIf4VH84AER9ouMNNOjHlOJW0U
         fHpzZTT14vhmrerAvryFfM+Fz5eizWZWXygfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963448; x=1714568248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gwfag+4QyqDwX4tmQGtCvcYSxBxdidTO2gJviq/hKo=;
        b=D3yd7uUL1grJ4kFrmsKtWHBVmBRmOQ8tOPqqAlJsuMkwBfG4JSh0ZbLu5VHUpalE5g
         RRsPNBKvtIoFw09jLFg4lfuDKFeMpMWuvc9xgPT2urtZZstCR7hF2UG2s5uQ0jme2J1r
         wBiYEU5U40w1LqK8HOM6vNccrDQYJxmTdy0en5T07UrO+F3NtN8/zoqMZFUQfhotHVxc
         pluVicRzOTJvgt6AcgEPxD/svAWqUUdKj6aQHdz5kiOEmTtHbF8Stqmbh7vg3p6qTHID
         s16x3iQIppmc6vPdE7pTOtZSgH8vGxdvQhXR3EA0+41PVFfDrIB0/0WC1V6ThmhmUqTt
         OXEA==
X-Forwarded-Encrypted: i=1; AJvYcCU48BmUVdrQduK672r6whA/OLTi1LnB2GzYEsVTWFGkgg1HRFNM0/crNFBzRSLi8qIaxFOJJUacotvmur4IYrA8ZHlQNQ8hl1m6jXyW4XKu
X-Gm-Message-State: AOJu0Yw3COKUYqdbqdX+5ZCEZwB2ves4ae1dOL017q60tcNojCSE3YC9
	6N1uCP6zFbCm9e22e44iidgGGmo8n0Og4sGhCB7sg8zUOoHgKiTHD7PYmzAYBA==
X-Google-Smtp-Source: AGHT+IEkAT9vI5DsYZNYnqMmKkCrzGQHAOccq6w2ISCl9vB4mEY/C0HXAZt2j/LW9q+YCqmshsAqeQ==
X-Received: by 2002:a05:6a00:22c3:b0:6ec:e726:b6f5 with SMTP id f3-20020a056a0022c300b006ece726b6f5mr2977352pfj.26.1713963446382;
        Wed, 24 Apr 2024 05:57:26 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id a186-20020a6366c3000000b005e2b0671987sm11101820pgc.51.2024.04.24.05.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:57:25 -0700 (PDT)
Message-ID: <1e9dfe9b-5eb5-437e-8f33-d30ee67cd6d2@penguintechs.org>
Date: Wed, 24 Apr 2024 05:57:23 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
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
 <4c33304a-5dbc-450a-b874-e04ba9e93150@penguintechs.org>
 <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 5:27 AM, Bartosz Golaszewski wrote:
> On Wed, Apr 24, 2024 at 2:24 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>>
>>>>> That's OK, we have the first part right. Let's now see if we can reuse
>>>>> patch 2/2 from Zijun.
>>>>
>>>> I'm compiling it right now. Be back soon.
>>>>
>>>
>>> Well I doubt it's correct as it removed Krzysztof's fix which looks
>>> right. If I were to guess I'd say we need some mix of both.
>>
>> Patch 2/2 remove K's fix? I thought only 1/2 did that.
>>
>> To be specific, I have applied your patch and Zijun's 2/2 only.
>>
> 
> No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
> Krzysztof's changes and replaces them with a different if else. This
> patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
> Krzysztof handle it.

Hey there. So, applying Zijun 2/2 on top of your patch does fix the warm 
boot problem for me. I can't speak about whether it's the right fix.

@Krzysztof Is the correct just add the conditional return for the quirk 
without reverting your earlier change?

wt
-- 
You're more amazing than you think!
