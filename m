Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F913B284
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008660; cv=none; b=tYG+Y27PX8/RnnmO+P/uoR23IB/ORZs+4lGtSpPCqA9TP+beCe4vsiBg3+n3XVa8HLfL5KVZ0jNO4VNROgx1mBUW/Pj1VMEzPbHAOmBRYEKDgB9f33/a+r9HCeY0kgmifVzN49gASdjE9/BRwhhdwn2TyC3JJpUYQG0YSvltbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008660; c=relaxed/simple;
	bh=4RbcfayKdnKH3L3jPRMwL0MZm90eH3B5hNj6Rkwgj1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SR173WxEmTddqgEPfAViXHYDQeQX8qpytgCucK2yb8dEzWj6UVz/3xoUVRik8c1njjPb7DRRBc79tWrnls/uPT+wxVTT4wcOkboqS/K5cPMujS6Ty9JgJIqzhYfQ/PdRzCciHZ9BLvjvExZOchigMmvImAHKcHBhEfRZ41eq7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B6rtfej7; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B6rtfej7"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83a94a60379so14290539f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729008657; x=1729613457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnmsgX2S26Coo2y0EAeBt15/nTOUhtLVYSc0LBXy8PU=;
        b=B6rtfej7Sj6TrWQX4nU0+X6V10tIVXB9Dx8Tim7t3xHLfm0pAFj+nqsALKHeMZJz3Y
         DXcW/N8sYsVYHAFu7d2yo5PGtuXmEYrF9eNO3NzTBFul9T4VSNl5XTf4U3hZKoz2Sc4Y
         wn8sC1VoaXT0zQXtaTEu1Vu74X4VP27geCivI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008657; x=1729613457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnmsgX2S26Coo2y0EAeBt15/nTOUhtLVYSc0LBXy8PU=;
        b=iSN6+Jvpv0tkLoqIpqLxJKXEmY9cHAQkam2xhwWhqizyJL+1Hh+TSj99TNep6Fd8Og
         sS/7gRKoTf2uZcJIALF3A/KM0zhIyIQmVmd72F2DZ4RUWavDp2MMB5/tYbB2igYNvoEI
         ESv80OLr+AVYdVEqp8qNaQBK3YywXfiY6ENzHw0zeTOGIGblbnZrPe+W6jiNdnQHrqQ0
         G3Hw1sRRscCBq+chWjJm/2gluqJOnFDbKf9bTJXdbKPhrpkjv6saNbwWb+II6JCEGI9N
         4eezm+9hKKA+gUOhEARwE3YHam7z1ROTh6mUy4TYn3086EXtVseZME7UhRrcpYLBiJrO
         +qLw==
X-Forwarded-Encrypted: i=1; AJvYcCW5oDhMgv8uZkHGGG+ICR/KSrA46Hq/DfJSa28h/hXIz+XzKUjG3wYNMBoKYF3bxzGDQZxe25xBfMkZR0wCH0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Pv0zzTJhwMa0kZGNo//6HY0nEsczklXDGleevArmgttXJRvc
	0dfL077v1AE+UPAiU5QZO4du3xRt6c1FUJmMQDdjedBFsfh3iWlp3Q9tcRL7o6s=
X-Google-Smtp-Source: AGHT+IHEnL+EgYGO8lX6dxU/xMmZOk3FtuBB48kIhLw61o4UybSaO0l3EEGWCUwwVU4D9lkw4wAa1A==
X-Received: by 2002:a05:6602:1503:b0:82b:40f:63c6 with SMTP id ca18e2360f4ac-83a64d161a3mr1402302339f.4.1729008657256;
        Tue, 15 Oct 2024 09:10:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9b0e8esm384747173.49.2024.10.15.09.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 09:10:56 -0700 (PDT)
Message-ID: <5a90f092-6836-421c-b25c-2ef5b5233655@linuxfoundation.org>
Date: Tue, 15 Oct 2024 10:10:56 -0600
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2][next] Bluetooth: btintel_pcie: Remove structually
 deadcode
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, marcel@holtmann.org,
 luiz.dentz@gmail.com, kernel-janitors@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241015045843.20134-1-everestkc@everestkc.com.np>
 <8a4a8915-d59a-407d-9f93-f047370cca62@stanley.mountain>
 <43eff9c9-9a23-46ac-9015-dbee35562848@linuxfoundation.org>
 <CAEO-vhFO9-htOazTzUKA_xMS8S+a5MAZpOi40GPF38m66a+89A@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAEO-vhFO9-htOazTzUKA_xMS8S+a5MAZpOi40GPF38m66a+89A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/24 10:08, Everest K.C. wrote:
> On Tue, Oct 15, 2024 at 10:01 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> Hi Shuah,
>> On 10/15/24 03:48, Dan Carpenter wrote:
>>> The subject has a typo.  s/structually/structurally/
>>>
>>>> The intel bluetooth module was successfully built after the change
>>>> without any errors.
>>>>
>>>
>>> Delete this sentence.  It should just be assumed that changes don't break the
>>> build.  You can put that code isn't tested under the --- cut off line, if you
>>> want to put a warning message.  But we don't need this in the permanent git log.
> 
> Should I remove the line that says the module was successfully built
> after the change,
> as Dan suggested ?

Yes - please.

> 
>>>
>>>> This issue was reported by Coverity Scan.
>>>> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709
>>
>> Restating what I said in your other coverity patch, include
>> the coverity warning. This link requires login and no use
>> for people who don't have coverity account.
> 
> The coverity scan dashboard no longer has the issue. So,I don't have
> access to the coverity
> warning.

Remove this from the log in that case.

> 
>> In the future don't include link that require login in the
>> commit logs.
> Got it.
>>>>
>>>> Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
>>>> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
>>>> ---
>>>     ^^^
>>> Cut off line.
>>>
>>> regards,
>>> dan carpenter
>>>
>>

thanks,
-- Shuah

