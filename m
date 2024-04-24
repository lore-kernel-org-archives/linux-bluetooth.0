Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F21156872
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937029; cv=none; b=PPmOMJB9xGZ2xp6XzTeTZmB7+DB75JdEMx4td0escGONeB1qhfvvckttnUd9DPV9TFZGJZBD9MkybGc4N97ZVV+qVnH1uB5VG7kuBo6ekInmH22+D7Urf5V2YeKOop4f/IXIHJXwmyghiD2CBeJnip9NWuzvUj46pv8iBxbtWEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937029; c=relaxed/simple;
	bh=QusuSqMHdPq6C/CJ3ENqNKHB+dHBtJZNmUPJB3+F3ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hST77zdld2HuSaBg3fZm29QDr4I4tenjH/cs6YFtfeBYG1Lj/OXw+l/f2Mu7VzKwMN2db55XykleoNFfJ5OlJhfUPXtHqsWcWe4fGnWIw6sJkowIfVYaDFnF8w5+kw4Mj4GUzO3MNqHmlpWr20wfbuLNJgV3g4oHRIzrBvnRlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Y060j1YV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Y060j1YV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3f17c64daso42277745ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713937027; x=1714541827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTYiowv/jO5SBd5fVNLzPl+KfQ4pn8ng6hL2RWoRcyc=;
        b=Y060j1YVoY0oMGq4Xy9OKmT8rK0Mjkrko2EKz+gYo9NiXZUzv//6iHvC3cGCpuhcfa
         FEUV+dOg4esHFsmciGt9HSkbkWMJ7v5CIo7Wz8mtG7Ygdp8BDefICOhUfSJs9h/dATdX
         xID+GCcWEjtPLLdYX9yWzyANwTow+b7ztKX+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713937027; x=1714541827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTYiowv/jO5SBd5fVNLzPl+KfQ4pn8ng6hL2RWoRcyc=;
        b=FL8fWtlWQCStqDmG9hqub9Yrtwd5WqtUf4a9XISu2QTEG+KU0VHM62sf/pY79uzSw+
         tOz6ePIyrPVL+JcqruA2N7AVbsQJDy/oA4dD5APmXybaGLKWbGnyKpembjCCLV2JMctI
         hFqtRddwwic5CKHaohZok+FL6VMwXnvgrigruqpLsYWKtPm0X8HVx9mN8e0RTCLhdT0+
         OqFPeMb1Wgb60MyMovFC7gzU0Zayv/4E5fisBqEQ4I4H3LWaD8LPUZLQaZpsUxcK31Ww
         B69hACfD7Ofh5TX0snblX+mszGFA2DqW6YxzElXN4OuoxU1r+GrOhsfd8MQZ/qnrzSHq
         dsiw==
X-Gm-Message-State: AOJu0YztxxY9mm0SczO32JaZpLdLN0D3o98YuxPRRjGBS0R/lHevE752
	jeE0x7+nBpKpeDimU/QWQFt+tpJ/KEEooWo5Y1j3asBzIxSn+iuzgNUpFxQFUQ==
X-Google-Smtp-Source: AGHT+IHWaFUsqgpzdbN3mUtXogHVXYFDI6iQLIQKcuSkE1sc+qTSw7nVcSVeClHYUFwnU537Babwgw==
X-Received: by 2002:a17:902:6f16:b0:1e7:b7a7:9f1f with SMTP id w22-20020a1709026f1600b001e7b7a79f1fmr1367840plk.2.1713937026707;
        Tue, 23 Apr 2024 22:37:06 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903209100b001e264b50964sm10990116plc.205.2024.04.23.22.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 22:37:06 -0700 (PDT)
Message-ID: <c1fc9c28-25df-4d41-9ae6-c5d079ea805d@penguintechs.org>
Date: Tue, 23 Apr 2024 22:37:04 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
Content-Language: en-US
To: quic_zijuhu <quic_zijuhu@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 regressions@lists.linux.dev, kernel@quicinc.com, gregkh@linuxfoundation.org,
 stable@vge.kernel.org
References: <1713932807-19619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713932807-19619-2-git-send-email-quic_zijuhu@quicinc.com>
 <a8a7e3df-44c6-4fa6-a576-da384c02e9ac@linaro.org>
 <067db05d-56bc-4ca3-aef1-bc3bae47667c@quicinc.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <067db05d-56bc-4ca3-aef1-bc3bae47667c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 10:02 PM, quic_zijuhu wrote:
> On 4/24/2024 12:30 PM, Krzysztof Kozlowski wrote:
>> On 24/04/2024 06:26, Zijun Hu wrote:
>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>> with gpiod_get_optional()") will cause below serious regression issue:
>>>
>>> BT can't be enabled any more after below steps:
>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>
>>> The commit wrongly changes flag @power_ctrl_enabled set logic for this
>>> case as shown by its below code applet and causes this serious issue.
>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>                                                 GPIOD_OUT_LOW);
>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>> + if (IS_ERR(qcadev->bt_en)) {
>>>    	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>> 	power_ctrl_enabled = false;
>>>    }
>>>
>>> Fixed by reverting the mentioned commit for QCA6390.
>>>
>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>> Cc: stable@vge.kernel.org
>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>> ---
>>> Changes:
>>> V6 -> V7: Add stable tag
>>
>> Stop sending multiple pathchsets per day. I already asked you to first
>> finish discussion and then send new version. You again start sending
>> something while previous discussion is going.
>> you concern is wrong and i am sure it don't block me sending new patch
> sets to solve other issue. so i send this v7.
> 
> i have give reply for Bartosz' patch.
> 
> i hop you as DTS expert to notice my concern about DTS in the reply.

Are you saying here (1) that you identified a problem in the DTs that 
you hope Krzysztof notices or (2) that you want Krzysztof to notice how 
your description of way that DT declares the gpio as required affects 
your proposed change. As a native American English speaker, I am finding 
your text hard to follow.

I think you are saying #2.

I just want to make sure I am following the discussion here.

wt
-- 
You're more amazing than you think!
