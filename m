Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAA3CF4F
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025150; cv=none; b=mNHP2vfvyZGLAPCcPsDCx1qgKqakbO5y1+qTG6XwMdkgp0IgJgx1EugRTqzmyaMNip+9tmn1xNqbjb+TZxxz7LcyATAhkNV4qeNh2DbCx6F6Cv3CyS1f/DJhbb3gWQ/DbEyOUMtNSxUUgCtm1WdOr2ofSrX010WwO9uc5hKMQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025150; c=relaxed/simple;
	bh=neTQuJQ89NecPpfzURKmqe5mDPig+teSD8UUyLT0JVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nk5/k3ioyGoYG/ZAecYJ8Ys9uz9w6bT6CPuprGkReCRac28aikBA8Yyka6YqtbM1fmWT4wV9Ebzv84RPUnaemLMIVH8CN56H7tkk0yqa2G9Vs2qea3MfWlTCTLPF2uZEyfJj7ic/rBp7Vu+7UiWuSO//JBR4RSsqnmnHvJvrLKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wyAFR8S/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyAFR8S/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b0bc4ce39so6342145e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 23:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714025147; x=1714629947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1k2e5jqr+8MMKtuYJnCSDEYpxTVUSwzjqrx2qtl6a8U=;
        b=wyAFR8S/fmlNjiEHk8dqvD+vxXWqs7QisX162+zPF8+2xSTYFqFZqNkkay876Y69zU
         CIzvyBI5UBCJsRsoPQVThqRH2ri4ydylxkB7YJsXmCq9fabDNBJuGjmwTy8SPMkviATE
         NiRLIFHDeaL/FcAcO5mEjpeTfpmrYopr1qCjaaHukcG+hi4toZKNYvf3pqYvV+6X1pZ1
         S/yJZBITlFuCOQP3CiAJXnPRscYJjwCgfu6qyzKNT/RbkTTz2l7GdH51+pKMWsAaSvPY
         k6Yft32+ycaMCy7hknSqOjG7YK7B80IgLWwV++SuUo07SbE+iaTA4ymqS8LCz+WONEEU
         VJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714025147; x=1714629947;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1k2e5jqr+8MMKtuYJnCSDEYpxTVUSwzjqrx2qtl6a8U=;
        b=ctjZl/Hb+JOHWw6xaQUCvJgMejdIuoduBY5RE4cDKNraijFul2z81orf6qD8YYJEie
         QMKsPPWY+m4XBID1Zh3+9KXYHjwFD06/TOJoSnZoGKfVxCgMrnVmgxjjegMFLrksqhwz
         nclDRHfBPNf7yj7J/PJqZZsThcGoiZTD6JRWs9+vTq4/qpn5MlkRdcrBmNlf5Y48QTgG
         iSwJNMwhFITctyQr8pH+sCAQJTI8ksnGz2ylBMJt72QVLD4Viw958pqJ2UaGc+T1zQAQ
         4xMB3XBlIP/FGhYb/cIf0Ct+DBUeIAkGMfWXQYnt/9nQbR/2QHMJ+IKj8LYsp+6VP1TX
         2WUQ==
X-Gm-Message-State: AOJu0Yxb5ljit4U/xGjQ3jH8aXO10zlizQxZRKJMi9bBxunLCJgmxvTP
	FgMTECyva6lPGsmrYmbBthe9gDD8lA8JJ4qEf8IX2CDWK6zLhnEYR8Q52IO0DTk=
X-Google-Smtp-Source: AGHT+IGTN9fVZuY95Or173Z5fNcXKuQTLHc4Zg+pjq0/7QXnQ8x/tl2HBqroAPOUGNDVUveJFrcfUw==
X-Received: by 2002:a7b:c317:0:b0:41a:aad8:e3ad with SMTP id k23-20020a7bc317000000b0041aaad8e3admr4366510wmj.19.1714025147122;
        Wed, 24 Apr 2024 23:05:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bi14-20020a05600c3d8e00b0041b5944a197sm172578wmb.45.2024.04.24.23.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 23:05:46 -0700 (PDT)
Message-ID: <368e70e0-edc2-44fd-a9a2-72efa0d9f864@linaro.org>
Date: Thu, 25 Apr 2024 08:05:42 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Correct property enable-gpios handling
 logic for WCN6750 and WCN6855
To: Wren Turkal <wt@penguintechs.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 quic_zijuhu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 kernel@quicinc.com
References: <1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com>
 <af004bcd-0649-4a82-8f09-36d6addd0e1e@linaro.org>
 <0cba3838-917b-48af-ba8b-2ef60714943a@quicinc.com>
 <49cf0a3d-5f52-41a1-9858-692f48d06b88@kernel.org>
 <c1632816-f754-42c6-8448-2daff8221b58@penguintechs.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c1632816-f754-42c6-8448-2daff8221b58@penguintechs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 00:01, Wren Turkal wrote:
>>>
>>> 3) only care about the case property enable-gpios is not configured,
>>> the original BT driver design logic indeed matches with binging spec's
>>> requirements before bartosz's wrong change
>>
>> What? There is no such case according to bindings. I told you already
>> two times: Either change bindings or this is not valid.
> 
> @krzysztof, I'm curious. There is no entry in the binding specifically 
> for qca6390. Should there be?

qca6390 is documented in the bindings, but you are right that it lacks
if:then: entry narrowing/choosing specific supplies and pins. It should
have one, indeed.

Best regards,
Krzysztof

