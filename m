Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE8154C0F
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935056; cv=none; b=TZaKgLi4EuqA+dnuSwESycLWoENmf+2vkEbV8ALj9W311lzQYQHBLa/gc2P7/ieHw5UIxYq++KNH8/jd9KtIL0tqV4nVj2fLWAQzAFO2AeRzV47nv9Kvrcg8mDKVW332PPcfPflgcGC8nBTpUrtcI7++uZz+Utpv7zGl05doTpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935056; c=relaxed/simple;
	bh=U1ARLhMFcK3m3ruXDOi0DDT9cekDrxtc59CZX0YpZzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XitXmRRrDLcExGXzxF/ew7C0YA26sot4nacaJQyypJWQKWMuyIslDCxA2ufMF1O1Xb/iNiNFiDdQIKitlpqEpb7c78jskNUftXwMa1Hu7IsfgkRiD5KRWNlsQaCuruCyt4c4dUh11wybApOQx4IpugtF7S+1TIYQqTZgdPipahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=hEL0hlEp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="hEL0hlEp"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso5125699b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 22:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713935054; x=1714539854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1feEMujVLYWXFEcLN0xYo+2RjYfHkXYrzmA2/Kalls=;
        b=hEL0hlEpN4e6Xcgf5hM+ly14PmXtMLeofJpY4lJp3tF0lnINg8FToEXUTEBmQD3uZZ
         rPT+oyrcLm0oLo119W/4BVrZ9sXl1W49QAK8zdB9wlfdoZpIYuRxrlHBFI2aTSH/VQ/1
         fYTJBRWlb8c4SJ0Y2ewcjGqKezDkcbO5FDWgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713935054; x=1714539854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1feEMujVLYWXFEcLN0xYo+2RjYfHkXYrzmA2/Kalls=;
        b=YmEvnRGzi54ifSqZ0x1/OXztRLfzLhxOMlTNi7SqZV9kkiyn4EatomnfHg8GIaHe6C
         SfwJs1/Tn579KJI284YaUQWgzA24QOg+Qb6ECZk2qDjt5OQ8fOFcVRDRL5pP8Kochk1l
         ho+Bgr9ng/7+yBku53tiTVtwpk88tdmj97ZeIpm1JCNHMpVL30vTXhPm5EkfTJvHJk3c
         Hf3hJw3v6oLUE5pJ8FNHLIhbES5AmGCIcx59gmQW5XNqx2KokBN8Aog+tdtuHz6tinpz
         qLEvInMjMSorVcdLuptbI7siruP7SUDC9dX/B0zcYMdQNRtmQjZnIU1ib8wNGGdZPYc/
         TUkQ==
X-Gm-Message-State: AOJu0YzAno0ZPMS08Pz1FbASq+74c6hwGdYSjaAXcG956GA2DGbxME2f
	HWKdFoFM8sqvWzCZqoZe87AWLu6O50OLHwGEWpZEsdww/oNpG5f9rJF9B0w2qw==
X-Google-Smtp-Source: AGHT+IG5BavmqqE/YMGkRoIZQpkX6ocJF4GE/OpC9ej5tR2Ea5KrmRgZpPTfVQwNsoZneAizERffcQ==
X-Received: by 2002:a05:6a20:12cb:b0:1a6:b689:8c29 with SMTP id v11-20020a056a2012cb00b001a6b6898c29mr1562397pzg.61.1713935053825;
        Tue, 23 Apr 2024 22:04:13 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78818000000b006f319bdcfbesm3348472pfo.132.2024.04.23.22.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 22:04:13 -0700 (PDT)
Message-ID: <2020a858-c3d9-48a7-ad59-3691c6b98fb2@penguintechs.org>
Date: Tue, 23 Apr 2024 22:04:11 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 quic_zijuhu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 regressions@lists.linux.dev, kernel@quicinc.com
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org>
 <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
 <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org>
 <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
 <5e363318-c6e4-4874-8026-7940b434d583@linaro.org>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <5e363318-c6e4-4874-8026-7940b434d583@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 9:31 PM, Krzysztof Kozlowski wrote:
> On 24/04/2024 06:18, quic_zijuhu wrote:
>> On 4/24/2024 12:10 PM, Krzysztof Kozlowski wrote:
>>> On 24/04/2024 06:07, quic_zijuhu wrote:
>>>> On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
>>>>> On 24/04/2024 02:46, Zijun Hu wrote:
>>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>> with gpiod_get_optional()") will cause below serious regression issue:
>>>>>>
>>>>>> BT can't be enabled any more after below steps:
>>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>>>
>>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for this
>>>>>> case as shown by its below code applet and causes this serious issue.
>>>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>>>                                                 GPIOD_OUT_LOW);
>>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>>>    	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>> 	power_ctrl_enabled = false;
>>>>>>    }
>>>>>>
>>>>>> Fixed by reverting the mentioned commit for QCA6390.
>>>>>>
>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>>
>>>>> No, Bartosz' patch should go.
>>>>>
>>>> what is Bartosz' patch.
>>>
>>> Srsly? You were Cc'ed on it. How many upstream patches on upstream
>>> mailing lists do you receive that you lost track of them?
>>>
>> Bartosz' patch have basic serious mistook and logic error and have no
>> any help for QCA6390, and it is not suitable regarding DTS usage.
> 
> Really? Why you did not respond with comments then? Considering how
> imprecise and vague you are in describing real issues, I have doubts in
> your judgment here as well.

Please slow down here. Zijun's patch works and Bartosz's patch does not. 
I don't think Zijun means any ill intent. I am replying to Bartosz's 
patch right now.

> 
> Best regards,
> Krzysztof
> 

-- 
You're more amazing than you think!
