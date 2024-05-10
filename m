Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB79EAC0
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368444; cv=none; b=ptd2hErwa6bBJQbkC1D+P84rcJ/ZKZf/zB7fbv158gi1aP98O2JFsTDLptaJ5f9eCULdOoOTLzw+qghNJrB5a5Gbrt1eRYWvgdERsiITe7ii1FHLxZUtBbj9l8wMZLWaOxm4GW3dVABcrUEqrL93bG2O65Ndts1rcGF62ayGWLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368444; c=relaxed/simple;
	bh=2HVxt79531612LIMbbeh7ZuktYpI2oIzB9557n+c4JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B96OUYnseABlQQt10a7oxL7f/+JybqVsd0Kei+NTpxSdDr2Oi4oVLTcluYTItkPKR1UAfYA3G7Luz9J1dIDFHdkBgt6Zq47UsNe7HAk39MFR1nufHPJVGXYdnj5WZC7Zfe/qA3tHifHICDg379DnzgEIASAzKdgL3Y+qKqxoX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=AeMdMQex; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="AeMdMQex"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4178aec15so2150728b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1715368441; x=1715973241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CHXGXA0IVIBC4Ca74LUG8yr/KUUTpqMoG+NixzgkY2c=;
        b=AeMdMQexWBFOYAXztZsweRldkXd1AOU2RKZJk49wOseCQ+fLq8eeacdexayf+v/tv3
         zCCkIoMhmkFb5qugaDOnAKqfdXG0UADLAFe4WyLSE9GqEuky6wNybDnYqFLE0qVpRNQ2
         YfvUrcxXKnf2jc+jHtZ2P/Kuw6vRJAoUAqmh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368441; x=1715973241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHXGXA0IVIBC4Ca74LUG8yr/KUUTpqMoG+NixzgkY2c=;
        b=pOG46+6+BMCK4SA6yeDeH/OHOAHrUEUi2hhenHNrSBZ2l4pM6pRZynULSUXyxN1Cnq
         bsdpqOWlAWCZHerv647AXmdUK0E8kPR30p4OPW0Qt8C5oOKtUb7fo1f3OndmBSJJwIkT
         MN7cylG18ZQSh2hadybUIksRqri1YzFYoclt+y1G6MX9p1ZrAuC3Nxh+WY6MpjRwX9nP
         JceOmFPsji98zMzo4Kja2MeP9PCSNmQF7oh6ADzk6jRaA+Wr755MhpyRzvWMlZoM0BrM
         RzL2eVFuv/IVMuxIrTt4kyysOtuS2gnmjiCw6rZUQcyTGuV63Jxmfxsb4MmWAT1hdj6x
         +yVw==
X-Gm-Message-State: AOJu0YyGNtcn6osKi24PS3D+wby07uO/pCAiuGSdvj0yAUtZ/QbUQLkD
	c16I9c7nThe0qU3T/s3jyVNsjLtTnAG4182S2jioXLLCjMqMJjYFxbIg3TMl1Q==
X-Google-Smtp-Source: AGHT+IG/A6HMKu6MeX4G7JOD3ZH02YShWgwwubSRhxxZzngujiXDtKIsgVrcLBR7fRcl1BeNYiyWDw==
X-Received: by 2002:a05:6a20:1012:b0:1af:51d1:eab6 with SMTP id adf61e73a8af0-1afde1c5540mr3340413637.45.1715368441107;
        Fri, 10 May 2024 12:14:01 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340bf1741csm2986374a12.27.2024.05.10.12.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 12:14:00 -0700 (PDT)
Message-ID: <560c5c03-563a-4f1c-abc1-1372ca73c421@penguintechs.org>
Date: Fri, 10 May 2024 12:13:59 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: path to landing patch to fix warm boot issue for qca6390
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
 <CABBYNZ+FBwFtrqg1Hj72Q7_6f8hDSwVTNtkofP0XgEd98DRf9A@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CABBYNZ+FBwFtrqg1Hj72Q7_6f8hDSwVTNtkofP0XgEd98DRf9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/24 12:49 PM, Luiz Augusto von Dentz wrote:
> Hi Wren,
> 
> On Mon, May 6, 2024 at 3:24 PM Wren Turkal <wt@penguintechs.org> wrote:
>>
>> Krzysztof,
>>
>> I am reaching out to you as you had the most important objections to the
>> change to fix qca6390 for the warm boot/module reload bug that I am
>> experiencing.
>>
>> For context, the problem is that the hci_uart module will send specific
>> vendor specfic commands during shutdown of the hardware under most
>> situations. These VSCs put the bluetooth device into a non-working state
>> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
>>
>> Zijun's proposed fix is to not send these commands when it's not
>> appropriate for the hardware. The vendor commands should be avoided when
>> the hardware does not have persistent configuration or when the device
>> is in setup state (indicating that is has never been setup and should
>> not be sent the VSCs on the shutdown path). This is what Zijun's patch
>> implements.
>>
>> In addition, Zijun's change removes the influence of both
>> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun asserts
>> that those flags should not influence the sending of the VSCs in the
>> shutdown path. If I understand KK's objections properly, this is where
>> his objection is stemming from. KK, is this correct?
>>
>> Zijun's proposed fix can be seen here:
>> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/
>>
>> I'm wondering if we can resolve this impasse by splitting the change
>> into two changes, as follows:
>>
>> 1. Change that removes the influence of the QCA_BT_OFF and HCI_RUNNING
>> flags in the shutdown path.
>> 2. Add the quirk from Zijun's patch that fixes my hardward configuration.
>>
>> I'm hoping that better clearer descriptions for #1 can help get that
>> landed since the logic current appears to be at odds with how the
>> hardware works.
>>
>> Also, I am happy to split the patches into the two patches, or (maybe
>> more ideally) just modify the commit message to better indicate the
>> reason the change. I just need guidance from maintainers so that
>> whatever work I do leads to something acceptable for y'all.
>>
>> So, please help me get this done. I am just a user with broken hardware
>> and a fondness for Linux. I would love to help do what's needed to get
>> this fix landed.
> 
> Ive also objected to that change, in fact the whole shutdown sequence
> is sort of bogus in my opinion and the driver shall really have some
> means to find out what mode it is in when it reboots, regardless if
> cold or warm boot, since otherwise we are in trouble if the user is
> booting from another OS that doesn't do the expected shutdown
> sequence.

This criticism makes a ton of sense. I'm sorry I missed it before. There 
were a lot of threads moving in parallel. However, I am curious. Given 
that the patch improves the situation for users (like me). Is there any 
way we can separate the redesign of the shutdown sequence and the UX 
improvement that comes with this patch?

Here's my concern. I am happy to do the work to redesign this. However, 
I don't think I have the information needed to do this since I don't 
have access to the technical docs for the qca6390. I am worried that not 
accepting some form of this patch is letting perfect be the enemy of the 
good. And I am not sure how I personally can help with that. If you 
think it's possible for me to do this without the docs for the hardware, 
I am willing to give it a shot if I can get some guidance. Honestly, I 
wish I had the skill to be confident about a change like this, but I don't.

Any ideas on how to move forward would be greatly appreciated.

And just to be perfectly clear, I have tested this patch on my laptop. 
It greatly enhances my ability to use my hardware since I can reboot the 
machine without having to make sure to power cycle the laptop. This is 
not a theoretical improvement.

Thanks,
wt
-- 
You're more amazing than you think!
