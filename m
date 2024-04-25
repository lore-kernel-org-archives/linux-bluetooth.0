Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD4139B
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026659; cv=none; b=VXiHIsIn8RLLEZsHr8ZAi3b1SP0vWjHdQ4QGAc5FLmWB3BV51Kzg6QpGLC/HDbQzPpwVxpdSr1Na+N9Qfgu9y+VmQvZ6QJXHiY/dLaCp2ojmFc4gWQr5aMkN0FFUWZwu1t0/dWH2OZTF1DecKgwtDG3JPs/yHArJAMAcMGdMnVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026659; c=relaxed/simple;
	bh=fZySohFOzN8lvBGKvs2I8G7aMQM3CLhKmCqThfl/Osc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdfX2qjfpSTVSltfOjz1+/mFCA7pnKtADAnDp3EmPFBnxfP05VFAjr79bz1VY1TOIOlRxInHvEJVVC0CnDor9JUqJrMoreTGzS22lvGpe95JuQ/B2IsuJSqsSFMk5TCcvA5/SX8DRyE+xo4SYCjkcjdt6GQiROZwqtuvrXa64po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=C857dEAu; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="C857dEAu"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ae229e9176so595699a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 23:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1714026656; x=1714631456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJV9LN/GwonATrn269FCewxa9i0hjR59JrMNdw1xZpw=;
        b=C857dEAu77N5L1mVBYB1wtJ6qBg1gG/EbaqunB9n9ndjrBrGkMs8ZAz/fKVjlj/a2G
         mvK+PsZIGZ7e3+KIm4tCYIQHBruosYvWQ1WyooSxODrZYD0FDZBX3fiFm7wibXZYpS3s
         lDFhFpvwJmlHG61IQha2ZTkH97Obc6RCDPdLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714026656; x=1714631456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJV9LN/GwonATrn269FCewxa9i0hjR59JrMNdw1xZpw=;
        b=lTt97EeN6vSnbQydp380pA2tzLNPvml0BV0R6AJd75lI0oEsU6LA6jLSod/y7Egoo8
         lmZiaWvPopx9huhjpj2uT5T9HUUE2LvolM5I8TB7jHhvqeFVXffgYT9LYGwPacSySXqV
         ixHZkeSNxxXxL/3xq2l9bgWNpTHeOJODb1n3rNBfniWt6FSm0C93cLf3UL5y6D/fm139
         Akt6Tjzt5sFsaFGiWB0j/lu79hGhEh5vkQq7c3ttGveCRHJmCNm12OThabuwesNjrzY7
         5ypgj3BBdaUFt9DbxKYYqlA2tvyZnseCA20GQhef2+mlh8knMiSzoUEgYjz/PT8X+0Kc
         A4Gw==
X-Gm-Message-State: AOJu0YzDKRVhLyl6eDqJtooPpYtFZSCOxxKjmTQmRwLoPKbtdr/oW8zf
	qrK1itr6bPfitf0eRbV28YicTRlxMua8D/evp3iT+ulOjKkeNjRE5d+F8uxDEB+dGMt4+VC5+r6
	dF6hv
X-Google-Smtp-Source: AGHT+IGhJjr420trLgR9hJMFAM9Bru5zuMN5d4FeLGhKAHpQ2vB0UtlRJt8nsDxaWH6hpOVA7q5VEQ==
X-Received: by 2002:a17:90a:588e:b0:2b0:eb:f65a with SMTP id j14-20020a17090a588e00b002b000ebf65amr69895pji.16.1714026656219;
        Wed, 24 Apr 2024 23:30:56 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id qa2-20020a17090b4fc200b002abb8a187dbsm12503544pjb.4.2024.04.24.23.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 23:30:55 -0700 (PDT)
Message-ID: <f372c661-d82a-4f6f-b2de-8dd241d6b107@penguintechs.org>
Date: Wed, 24 Apr 2024 23:30:54 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Correct property enable-gpios handling
 logic for WCN6750 and WCN6855
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, quic_zijuhu
 <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
 marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 kernel@quicinc.com
References: <1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com>
 <af004bcd-0649-4a82-8f09-36d6addd0e1e@linaro.org>
 <0cba3838-917b-48af-ba8b-2ef60714943a@quicinc.com>
 <49cf0a3d-5f52-41a1-9858-692f48d06b88@kernel.org>
 <c1632816-f754-42c6-8448-2daff8221b58@penguintechs.org>
 <368e70e0-edc2-44fd-a9a2-72efa0d9f864@linaro.org>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <368e70e0-edc2-44fd-a9a2-72efa0d9f864@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 11:05 PM, Krzysztof Kozlowski wrote:
> On 25/04/2024 00:01, Wren Turkal wrote:
>>>>
>>>> 3) only care about the case property enable-gpios is not configured,
>>>> the original BT driver design logic indeed matches with binging spec's
>>>> requirements before bartosz's wrong change
>>>
>>> What? There is no such case according to bindings. I told you already
>>> two times: Either change bindings or this is not valid.
>>
>> @krzysztof, I'm curious. There is no entry in the binding specifically
>> for qca6390. Should there be?
> 
> qca6390 is documented in the bindings, but you are right that it lacks
> if:then: entry narrowing/choosing specific supplies and pins. It should
> have one, indeed.

Would creating an entry for the qca6390 hardware fix the issue you are 
worried about?

Again, sorry for all the, what I assume are, basic questions. I am so 
far out of my depth here. I am just trying to figure out how to move 
forward. I really do appreciate your guidance here.

-- 
You're more amazing than you think!
