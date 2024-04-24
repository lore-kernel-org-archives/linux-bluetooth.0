Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAFF15A484
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957375; cv=none; b=Q/8l8zkzmXAwaGuYOaGb9LW7L/f9ucCWhjijynAYkK/IaFf+dM05ctucrpEzh3vyZMQH3P4Lrrv3RLSaHpXtjRJ0MDo4fDmf3Fiew+38SwcQbPRA/vG28kQbGIf35SiQPC9+sg1uST+HesEn1xv3811Y7TAM9SjPcvNS8DhfZ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957375; c=relaxed/simple;
	bh=9XHCMO60oCNxGiy+aJY/UaGzplEcfyIlLZJ/a6H4YN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwr4OnTLA2fjqTaS+pJODZt0tLEveNiOe6MuV69uBe09zGO7P8j47KHjSc+Kx0lUsBXaJLw19B0LIONlOteu1fJBs9lC/5EN9ij/uZb8oFBgB6C08JhbP4uuLabqZPX5gCyLwZDw46p4YzEyQQKZS93gy4R815jGrENH14pXDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Xi44prbF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Xi44prbF"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso6162085b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713957373; x=1714562173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZqKceRFYOcv5tkimj0+X+feVM7EViq3jSO9S9mspto=;
        b=Xi44prbFHKy+GTEHgCVbfuGU3E/PbxuMcpB57V/PcoSR+oMTEY366Q84BG2HGM+J07
         gIuZO02CGbQB6fqEJ7N0cNmf7FpYZDbk5O9peB/WIEstaX9n+fEa8wZNPu5q4b0xnAQF
         A0L84rbUAWT74gpTqLHF9MMn/JwsrzSGwPj98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713957373; x=1714562173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZqKceRFYOcv5tkimj0+X+feVM7EViq3jSO9S9mspto=;
        b=uYcxzqm4JMiElIycG62lxoKcgykS0h4tyhUXPGyaCAjlsfNjFDkMEJ7MJqmFASHbb+
         RGZ6WRATBlO4jjjf31eYdZHvbJjHtAiiqZTXSyXInZlhz6Sup72S/fkcZ7nQ2c1i7kYm
         QNkGJMCJJJgDghyfA4hA2jsw0Cs0w89egEiQtVi1wn0oNDxX/PhAllyp/8Q2BItZlEL0
         /uOKZ8CK80XuorxSbRwkX58G0nTTT/pEqQce9vcAIIuBLMn3ten87fBY9URx0OHYHE09
         bg+YOqyNcOgLp7954ceMegzgqM6md6NweAAtg2Hv/J7OBme/iQDzrgyI+ApU8vD/MoUO
         YFBg==
X-Gm-Message-State: AOJu0YwptOFoVdre1n+AUnAe2jU/9ttdpsQCXk8VLGIIYZtIeRE52QY/
	Wm9kYjU/wR9NuZMxxno4zumgF7bnz2Y7YJGdH5bQWyVE7ke4nW35YfJrpCXU6Q==
X-Google-Smtp-Source: AGHT+IGrEd3S6crIeK6r7Gp9adxGZnS0C7zjoRAQn5SAuUYk5YRuc5UPhbyXdjw5UaDq1xnx7S60+A==
X-Received: by 2002:a05:6a20:9756:b0:1a7:bc31:933b with SMTP id hs22-20020a056a20975600b001a7bc31933bmr2178455pzc.47.1713957372652;
        Wed, 24 Apr 2024 04:16:12 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id j22-20020a056a00235600b006ea7d877191sm11216997pfj.2.2024.04.24.04.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:16:11 -0700 (PDT)
Message-ID: <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
Date: Wed, 24 Apr 2024 04:16:09 -0700
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
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 2:04 AM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal<wt@penguintechs.org>  said:
>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>
>>> Any return value from gpiod_get_optional() other than a pointer to a
>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>> power_ctrl_enabled on NULL-pointer returned by
>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>> Nack. This patch does fixes neither the disable/re-enable problem nor
>> the warm boot problem.
>>
>> Zijun replied to this patch also with what I think is the proper
>> reasoning for why it doesn't fix my setup.
>>
> Indeed, I only addressed a single issue here and not the code under the
> default: label of the switch case. Sorry.
> 
> Could you give the following diff a try?

I had a feeling that was what was going on. I'll give the patch a shot.

wt
-- 
You're more amazing than you think!
