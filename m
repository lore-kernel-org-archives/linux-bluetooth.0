Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C51415667A
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937780; cv=none; b=jGaCjqkNpEaSzilpgyiNaWvJ6g8dj3/o35AnCJjJMYNOES5+8wG+afhlxBnrlDT4C5DLh3Eb4KwbajckbVwr2iJO4jvfw1OSB9b+Qq0mEckzK0xXzvTEYIyiWuROA1fJNpJ1EwAAS+8u9RtwCVaD8p0/3mOL9hDJjrlJ5ypeYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937780; c=relaxed/simple;
	bh=l5OkF8AxOS3Gjpu7NZAPcOi4s1zEXCpAB4RaachyQ80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pro8jztE6sZP+7nlkjfF4ull4ytptBC4pS/j+702cV9R2nLzGgRKkNbGXZmZ15hPtCF0qGTvgdgC47BN/VXF74HrqaT1KffsAhxSN3trPfCz1HYfhx2mtbpIohSwOBT/6fjrheDTlO40WvPMKGCJFoU1Abd8ZX9kMxejYwuKUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=AVf+6Ef3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="AVf+6Ef3"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-60585faa69fso322430a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 22:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713937779; x=1714542579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JySSannFKBpwWTIuXl9VxiTFqW9a99otiT1KAh1oTHQ=;
        b=AVf+6Ef3VO2HMvR03CYZZuj4Vm3Tx+rrdrUEIGoDtXj0w0jOjOvFUWQyZdSztHupNy
         7Bq4zn9X/Lc/yip9RqY+sl+0NmjDk8+H7gJxe5M/C8bM34drb+Yj1cVIyctvhVTt5CJx
         nF9Az6IxKHQYJyyRv7DhWI50S+KTg4xbo8STg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713937779; x=1714542579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JySSannFKBpwWTIuXl9VxiTFqW9a99otiT1KAh1oTHQ=;
        b=sQTKamjmogd5nPHZnjrv1bhgmA60wfwI22L9we4tYZnx4LCgAeD7/PVJUqeSXYzwfv
         6DJ4bOqhQnkRsN8Vv559zcHr2loEcqpR+TW99tEIhCVk60zvYopARI5CAWsIa6WED7/f
         lRV0lp38CdPRygfiT7ti5J5bBe6GWtFgpAKsyWkS6EVD0l/SW4WwhvGwPIVMOgEBeFoF
         XrTAzijQsRAzKvPeHvZ5DPiF3twIfG7AOI41gdvj28Yp7GV+VAxbnSQWrzGQcHCtCP8k
         QNhURuO6bxTE6zRR0MW9gx7mW5YJUUizv1/aKdE9peXLIvVbA0Wjx062xRB2EfvbTgKC
         J9gQ==
X-Gm-Message-State: AOJu0YweduH8MtRfOOsKnhEaPjv4w7/mlO2EYR9at1ERgvzE3FoakE+u
	QWAlE2yiamd/to7gIbn22urw5UJ0KFN66VIHZX1WigT5enqhHaPCBfNM+jexjQWduEvkLSIa4QW
	2fO1h
X-Google-Smtp-Source: AGHT+IG7J5EB+OS4bWsTGY9svXpYszeCkk2/xau38sXpHgJgzIf77MOWp4CGayS20E3eDvHRIaZDuQ==
X-Received: by 2002:a05:6a21:3282:b0:1a3:bd97:4cab with SMTP id yt2-20020a056a21328200b001a3bd974cabmr6867656pzb.6.1713937778549;
        Tue, 23 Apr 2024 22:49:38 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id x1-20020a63b201000000b005e838b99c96sm10342348pge.80.2024.04.23.22.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 22:49:38 -0700 (PDT)
Message-ID: <c9bf22a3-2549-4cf1-898e-8a9adcd2f0f6@penguintechs.org>
Date: Tue, 23 Apr 2024 22:49:36 -0700
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
 <c1fc9c28-25df-4d41-9ae6-c5d079ea805d@penguintechs.org>
 <0db77c30-5be2-41b5-adf0-fb4436b9107b@quicinc.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <0db77c30-5be2-41b5-adf0-fb4436b9107b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/23/24 10:46 PM, quic_zijuhu wrote:
> On 4/24/2024 1:37 PM, Wren Turkal wrote:
>> On 4/23/24 10:02 PM, quic_zijuhu wrote:
>>> On 4/24/2024 12:30 PM, Krzysztof Kozlowski wrote:
>>>> On 24/04/2024 06:26, Zijun Hu wrote:
>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>> with gpiod_get_optional()") will cause below serious regression issue:
>>>>>
>>>>> BT can't be enabled any more after below steps:
>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>>
>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for this
>>>>> case as shown by its below code applet and causes this serious issue.
>>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>>                                                  GPIOD_OUT_LOW);
>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>>         dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>      power_ctrl_enabled = false;
>>>>>     }
>>>>>
>>>>> Fixed by reverting the mentioned commit for QCA6390.
>>>>>
>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>> with gpiod_get_optional()")
>>>>> Cc: stable@vge.kernel.org
>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>> Link:
>>>>> https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>> ---
>>>>> Changes:
>>>>> V6 -> V7: Add stable tag
>>>>
>>>> Stop sending multiple pathchsets per day. I already asked you to first
>>>> finish discussion and then send new version. You again start sending
>>>> something while previous discussion is going.
>>>> you concern is wrong and i am sure it don't block me sending new patch
>>> sets to solve other issue. so i send this v7.
>>>
>>> i have give reply for Bartosz' patch.
>>>
>>> i hop you as DTS expert to notice my concern about DTS in the reply.
>>
>> Are you saying here (1) that you identified a problem in the DTs that
>> you hope Krzysztof notices or (2) that you want Krzysztof to notice how
>> your description of way that DT declares the gpio as required affects
>> your proposed change. As a native American English speaker, I am finding
>> your text hard to follow.
>>
> 1) is my purpose. i have given my concern about DTS for Bartosz' patch
> and hope DTS expert notice the concern.
> 
> my change don't have any such concern about DTS usage. that is why i
> changed my fix from original reverting the whole wrong commit to now
> focusing on QCA6390.

Let me try to parse this. If #1 is the correct interpretation, does that 
mean that the DTs are wrong and need to be changed? Do you expect K to 
do that since he's the "DTS expert"?

>> I think you are saying #2.
>>
>> I just want to make sure I am following the discussion here.
>>
>> wt
> 

-- 
You're more amazing than you think!
