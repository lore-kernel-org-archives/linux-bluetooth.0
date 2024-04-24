Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C711598E6
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960350; cv=none; b=WF6Y1oBQYhPPeBtcYXQhyO8XFM71WArblQ+jQf09wC0N/+baCMmeBxTyOF/NmuAI2wS2k5MUXIxr7Yjh9p9ZvqhmMUTNBEfdh2p2cO6tHwhLol17zdEIuZ+n0Fsie3a9YCQAimuosdIZJEUu997DKNWRqLPQZJtAzsdpO4v9XVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960350; c=relaxed/simple;
	bh=O9Y9XW9Bf8tQwBetsJd8cr2rhoDDnWiPSv3Wv8RVtfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKXjTRUxpIUheaeagfDN7l8E7hF8IJ+8rTt+j5Z62XPehjZJxcz2gn3pvThPIwtCHe5jKHrh4J3ZmDsnQePAlDm4Wme68BpfvhEu7r61KzgXBnZC+R8u6PPOdO4p4XGHOE/Orc4otgxo4B04epspxAJBG7w2cDsuTItusMD6rPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=ks8YkGwZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="ks8YkGwZ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed32341906so6503036b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713960347; x=1714565147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+FykyxhMPJPKFfFxIzTojGiVzkxju+/n6mO5lG++54=;
        b=ks8YkGwZ9WesyzVattAimXAcqCXuDwuIXOeyFFfXrHFX1VP/HoVeKcvg3OpNMJsZNX
         8ZQFqtSmLbqNcchZooELgEkTRGJK5r5wiiBUYVPJ16vLJea4DBLGAELveKrAvORdNW1S
         TuH42TSmw7tZSRsAdjOtXOZeqG2FiyV6rxQIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960347; x=1714565147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+FykyxhMPJPKFfFxIzTojGiVzkxju+/n6mO5lG++54=;
        b=gHhotpeVIBs46UbvxrEs4yL3E/KXPuMLQQ1FnwsWykOAAVpKqZOD/VevFGsxtVDDnz
         mJlt6aGVrUwMQvz6L/+DsFBseR4mJoRQ0fadZEF2nu9AQDItuCmvmvhIge4MSakrzLEl
         bE2r1gzhaDViw30BcDB/23iuvxVZ72pJwNquEP8SZlXE4zq+/+v/DTPDff20XWI78anh
         dG9K+CqGx16bTV7SPheSwrJFfetOGuCFcYraRnvIjrOSPvvf8sEXSp8fPpkDmM+4h6ku
         R2YgG7vk36H5l0wkQ7twTKZiNZQiMFzDyC+AadS4EPAydIvRxhhKg+SLArk7XGH92chb
         zXxA==
X-Forwarded-Encrypted: i=1; AJvYcCU4zJ1R5Uc/Ynwe7jee4RmxLCXcnJNIq3i8WuGKqVefPXL/XROT+n1nJnk636upqD9hIzCrBz845N/W3S1X67PY2F4tTsf0KZvKCp0tJZUY
X-Gm-Message-State: AOJu0YwzAinNbaC70jdqSbDwc0xn1AJnY6lp1UylAYGDZfYmmz4ReP+f
	7bWqh7ko6Y198IzQFA48mad6PETRFwEMu/YT/n2otzy3R1EQBPj1MnQTvuBR4A==
X-Google-Smtp-Source: AGHT+IEXVBByB7qMgyM2JwnpcF1ugnJgAAgMtOW169Er0h+ZLNEaK8zxB1N1x9RTjArZnauZ8RRf7A==
X-Received: by 2002:a17:902:e809:b0:1e3:e137:d3af with SMTP id u9-20020a170902e80900b001e3e137d3afmr2745775plg.9.1713960347458;
        Wed, 24 Apr 2024 05:05:47 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001e435350a7bsm11722255plp.259.2024.04.24.05.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:05:46 -0700 (PDT)
Message-ID: <51a660cc-4562-42d7-a6fa-0f6f7e3f47b6@penguintechs.org>
Date: Wed, 24 Apr 2024 05:05:45 -0700
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
 <06217256-8a13-4ebf-a282-9782a91793e4@penguintechs.org>
 <CAMRc=Mfwa2WSOLaUMaEM1czTcx31jynGqgxzLdCh7ROktQ_Vag@mail.gmail.com>
 <6433c145-a448-45dd-a982-8b5df0ca5c16@penguintechs.org>
 <CACMJSetnNDwVuRksjE2k=OJYoaa0i89kWxd1WB9RmTcpz78haA@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CACMJSetnNDwVuRksjE2k=OJYoaa0i89kWxd1WB9RmTcpz78haA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 5:01 AM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 at 13:59, Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 4/24/24 4:53 AM, Bartosz Golaszewski wrote:
>>> This must be your email client wrapping lines over a certain limit.
>>> Try and get the diff from lore[1], it should be fine.
>>>
>>> Bart
>>>
>>> [1]https://lore.kernel.org/lkml/CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com/
>>
>> I don't think it's my client. The extra newlines are right there in the
>> lore link.
>>
>> Look at the line that starts with "@@". That line is wrapped. The
>> following line ("serdev_device *serdev)") should be at the end of the
>> previous line. The same thing happened on the second "@@" line as well.
>>
> 
> Indeed. I just noticed that it applies fine with git apply and figured
> the output must be right. Anyway, this is not a proper patch, I will
> send one once I adapt Zijun's code.
> 
> Bart

Weird. Git apply failed for me. That's how I noticed it.

 From my terminal:
➜  linux git:(my_master) ✗ git apply ../blah.diff
error: corrupt patch at line 6


FWIW, I also tried pasting it into stdin by running `git apply` as well.

wt
-- 
You're more amazing than you think!
