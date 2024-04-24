Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08548156F46
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996084; cv=none; b=Uqs2TWN+z47LzFn+o7EUQw/3JetUKDS4Wx727avmFG++SUDdIeFbmw84nwaEml38ME4RcgUhigV8AsG9ddL6Zi9xrrwx2OiOMG+yWR9UGLbuU8ppImd03s3oDVAX3kmRN2c4UoGhXfhsHZDHCTAUXJz9EdW2zBgqfeBwjbjjJQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996084; c=relaxed/simple;
	bh=IqXWrvySnnW0Zd7k0NFNn2ct0HS1XSy7dAS7pNfWT9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gx3e7ZrD45hxL1k2NY8yiWT6NDND+FeYVJh8aioJ44cOwhrfWPUbFEuW8toGnnPwIQSxupRzySH2Zhz5qUWuhDkI0YUErBtuNXYD2PP0Bw9LjoS+tSLuMBBy1g9Y5wmO4wifYZE8FZg7ZaU3hi/Q4MfUDVkssDeQ9OGPM46KbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=VVCAHnmX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="VVCAHnmX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e3c9300c65so3005585ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713996081; x=1714600881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sB+VS/wyDAPAusCDTHXLUrI6NwR8DPK8aFqLy1Xw/SE=;
        b=VVCAHnmX5IZn2yM5EK3DfDlJFgB2HJrW8/mT7s79s3/NgWzfIxlbGs8P7EHc3BspOx
         R3zTQADRCpyVxhtoEiPn+1JdcgPmniS+XxC4llfp3p0gJPxnh+FwdRbBggZ+BQJ2qXIm
         51utypW9/99QOBxurbwK61ZbGAMZS1Pwqsmy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713996081; x=1714600881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sB+VS/wyDAPAusCDTHXLUrI6NwR8DPK8aFqLy1Xw/SE=;
        b=X0wvjMlY0Q+ovDbYB2o8X18kieILVTfcI+mlvbgjTwD883qx+JILRsIB5L7PA/IjI7
         TaVCuNQRGBCj6we1GeQMJKMRRGwTO8USb+hmNlJYJgb/+J8hBGEe59+TW3+gC6qWWj9v
         p9eE096MOCjQ5Vs/w7NJFXhiMI4AewBro9ra0yE8R6ZiWOga5/rvwyCSVgZ/LoO8rRmJ
         d3qs595EUmLO2T0urj/x5jYIcQwVyX2JQsAjDJOtDJ238tFcqkeWVe7tb/htkLGj4nvg
         FdI75GG2VII1mDF2J7F9Lj7rZghvxGlLfdMsAthxF690wehArxRzGUHZ9k2kIxe1swHN
         OltA==
X-Gm-Message-State: AOJu0Yxkua/uTmjjtOOmSxdEqDDFkcvPR7InhDFXd9DS6UowNJvLtdBO
	KYc/ftaczm0iRM0v8mHv0gO+lsSJYr0U5hc0Tu/IhrJh5C2A3swiXdVt7z0n3Q==
X-Google-Smtp-Source: AGHT+IHphh/jDs4EOysHcsZZFXxFiZ/bOzSs55uoIIDoctH8OoFwMt1NsR3PGgoXOHIL1FY8wfmjqg==
X-Received: by 2002:a17:902:ecd2:b0:1ea:9596:11eb with SMTP id a18-20020a170902ecd200b001ea959611ebmr1846447plh.60.1713996080941;
        Wed, 24 Apr 2024 15:01:20 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id ba5-20020a170902720500b001e2b4f513e1sm12380328plb.106.2024.04.24.15.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 15:01:20 -0700 (PDT)
Message-ID: <c1632816-f754-42c6-8448-2daff8221b58@penguintechs.org>
Date: Wed, 24 Apr 2024 15:01:18 -0700
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
To: Krzysztof Kozlowski <krzk@kernel.org>,
 quic_zijuhu <quic_zijuhu@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 kernel@quicinc.com
References: <1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com>
 <af004bcd-0649-4a82-8f09-36d6addd0e1e@linaro.org>
 <0cba3838-917b-48af-ba8b-2ef60714943a@quicinc.com>
 <49cf0a3d-5f52-41a1-9858-692f48d06b88@kernel.org>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <49cf0a3d-5f52-41a1-9858-692f48d06b88@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 12:12 PM, Krzysztof Kozlowski wrote:
> On 24/04/2024 11:22, quic_zijuhu wrote:
>> On 4/24/2024 4:44 PM, Krzysztof Kozlowski wrote:
>>> On 24/04/2024 10:35, Zijun Hu wrote:
>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>> with gpiod_get_optional()") has wrong logic for below case:
>>>>
>>>> property enable-gpios is not configured for WCN6750 and WCN6855
>>>
>>> As I said before, bindings say this property is required. I already
>>> asked you to provide rationale describing hardware and update the
>>> bindings if they bindings are not correct.
>>>
>> 1)
>> you ever given below reply at below link
>> https://lore.kernel.org/linux-bluetooth/52394d97-04c3-4f77-aaae-f1e152cd5632@linaro.org/
>>
>> "The pin is required on 6750, 6855 and maybe others. You cannot not have
>> the GPIO"
>>
>> 2) for property enable-gpios, they are required for WCN6750 and WCN6855
>> in my opinion,  i am a member of BT team.
> 
> If they are required, then your commit msg is not precise and code looks
> incorrect.
> 
>>
>> 3) only care about the case property enable-gpios is not configured,
>> the original BT driver design logic indeed matches with binging spec's
>> requirements before bartosz's wrong change
> 
> What? There is no such case according to bindings. I told you already
> two times: Either change bindings or this is not valid.

@krzysztof, I'm curious. There is no entry in the binding specifically 
for qca6390. Should there be?

> 
>>
>> 4) please ask dts owner for help if you suspect current bindings spec
>> has something wrong. it is not my responsibility for providing such
>> info, that maybe involve CCI.
> 
> What?
> 
> What or who is DTS owner?
> 
> I do not suspect bindings are wrong. You are implying it. Anyway, if
> making driver correct according to bindings is not your responsibility,
> then this patch is just bogus.
> 
>>
>> 5) gentle reminder, please realize that there are many lunched products
>> already when you try to change some important logic, i don't suggest
>> change important logic or setting if there are no actual issue reported.
> 
> What?
> 
> Best regards,
> Krzysztof
> 

-- 
You're more amazing than you think!
