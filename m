Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C418CC01
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368936; cv=none; b=QvNyEjeEFOIsLFgy12z18fcE2kjcFsz2LtiXp8iOLfPOHBcNxXQUXRcwXrbZ3lUWXBDnzBI5hEZpbL2Dbn9Zb+LPlsOEl9VVyFtW4F+rRPpFkCJXQXO4XPR+GLZav1FkbHuT4IBZi3DLh0edvonp7PL3R2xY0fKh70oScrUgWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368936; c=relaxed/simple;
	bh=OXu4MibL4JredU/PNwNqIGdiLxd/4iWXMnITBO3/gu4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RJJsmWHrnzxAD/qwF5jB4sazjGEEOPLjtPzLnaI6Ug+IGeXhXqohQ4Angr2T6aqbHIYDFt1UlgUL1eCB29fgEbeAvD39dTCcglKbID/CrRTvE+7Tm963p1u/qGwS9seqavsBQSxGmQBGkxrZAaM1mbIca/fgy0c3wBBNJHY4maI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Jt5J6xQg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Jt5J6xQg"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d19d768c2so3715759b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722368934; x=1722973734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c9EkhHDAPH3EY2x4sYEJYBBnr14AvRj62l4IGCGKO5A=;
        b=Jt5J6xQgckgx6HdvtE2TBcCN1Isl+ZUKn3+/y6Ncj9LRDOFuqID2YsbAIfHD4xuvS7
         5j7s9ho/U2KtxA/lHKb51icr0WNVgE/O5KaP+YpfGNvhNpLz17rSdaB3HBHgnVyUlU4D
         zyViheBs1QF+3lWiMGOLc+8uZUFPnah9KNxpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368934; x=1722973734;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9EkhHDAPH3EY2x4sYEJYBBnr14AvRj62l4IGCGKO5A=;
        b=wnsL85ejMQ7fpjnPD1FoZK9NayvNNpb25sEjLb345BY4920oUuezDE5zXBLwzk/VBa
         mby60lv5Qzrp/uMqbzFMFJigQdJG8SFhKaCDcUZLiDM3nayuT1V6mdE4ahKluTY7Rngc
         irsoE3KvRfv08Ec0WNh41RbykxSGCDiFDdm6QA5nL8FMNopXVWOqRkBacMWMgcbNLZiy
         fFUkZYtM0irIWchCmGRivFd6SAyvnrGcz7zeLmBDQn9Qb+zA5Ny2BtVwmdkUQKchVDu1
         7WYxSWwnRg2dZhFQ6HVoI/i8l1w8VobjVH1pdYD4augd3fV1LSarIH0uy3U1CSJP1aTi
         kbXQ==
X-Gm-Message-State: AOJu0YwkmboeymOxXdYP4/TLbgk3xuyI4ou2s55b9UzhYVHIgTMHADIc
	QgcXuOBft3Dpd+K8CuoKrt3Dl8SayAiAoIcIrkSoSjQUIVhQsfRSaUyBF48Gdw==
X-Google-Smtp-Source: AGHT+IESMFG7TMqZ8KvnM0uOd8+NR/Y9WY4gRiEXGGsXw6F29eUbRL8YprJYY7XiR2lm7b4JXyD7cQ==
X-Received: by 2002:a05:6a21:e91:b0:1c4:dfa7:d3ce with SMTP id adf61e73a8af0-1c4dfa7d655mr3491303637.17.1722368933807;
        Tue, 30 Jul 2024 12:48:53 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f884c166sm9310838a12.49.2024.07.30.12.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 12:48:53 -0700 (PDT)
Message-ID: <1ff58133-7322-47fc-b3db-6fe4a697aefe@penguintechs.org>
Date: Tue, 30 Jul 2024 12:48:51 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
From: Wren Turkal <wt@penguintechs.org>
To: Zijun Hu <zijun_hu@icloud.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
 <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org>
 <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
 <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org>
 <09962266-9b55-408b-8b5d-d2387c871eef@icloud.com>
 <0940abda-fe74-4009-9a83-7384bb8cf103@penguintechs.org>
Content-Language: en-US
In-Reply-To: <0940abda-fe74-4009-9a83-7384bb8cf103@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Zijun,

On 7/30/24 12:26 PM, Wren Turkal wrote:
> On 7/29/24 9:25 AM, Zijun Hu wrote:
>> On 2024/7/27 03:25, Wren Turkal wrote:
>>> On 7/26/24 11:52 AM, Wren Turkal wrote:
>>>> On 7/25/24 1:47 PM, Wren Turkal wrote:
>>>>> On 7/25/24 1:35 PM, Luiz Augusto von Dentz wrote:
>>>>>> Hi Wren,
>>>>>>
>>>>>> On Thu, Jul 25, 2024 at 2:35 PM Wren Turkal <wt@penguintechs.org>
>>>>>> wrote:
>>>>>>>
>>>>>>> Hello BT folks,
>>>>>>>
>>>>>>> Just so y'all know, the QCA6390 bluetooth hardware appears to be
>>>>>>> broken
>>>>>>> at least since commit 720261cfc732.
>>>>>>>
>>>>>>> The KDE and Gnome bluetooth control panels appear to think there 
>>>>>>> is no
>>>>>>> bluetooth hardware. Rolling back to 6.10 appear to function.
>>>>>>>
>>>>>>> I have a Dell XPS13 9310.
>>>>>>>
>>>>>>> I will attempt to capture some kernel logs in a bit.
>>>>>>
>>>>>> git show 720261cfc732
>>>>>> fatal: ambiguous argument '720261cfc732': unknown revision or path 
>>>>>> not
>>>>>> in the working tree.
>>>>>
>>>>> I gave you the sha for the built fedora rawhide kernel package, not a
>>>>> mainline sha. Sorry about that. I thought it was a mainline sha. I am
>>>>> trying to bisect the problem. Hopefully, I can get a mainline git sha
>>>>> for you soon.
>>>>>
>>>>> If it helps, the build date of the kernel is 2024-07-19.
>>>>>
>>>>> Sorry about the confusion. Hope this helps track down the problem.
>>>>
>>>> I have managed to get the following commit id range for the issue:
>>>> 80ab5445da6235..e2f710f97f35
>>>
>>> Narrowed to 80ab5445da6235..586f14a6a182
>>>
>> i feel a little sad that QCA6390 of your machine are broken again.
>> i find out a doubtful point by checking recent changes.
>>
>> you maybe have a attempt for below change if you would like to do that.
>> https://patchwork.kernel.org/project/bluetooth/patch/20240730- 
>> qca6390_fix-v1-1-e0340a511756@icloud.com/
>>
>> thanks
>>
>>
> 
> Yeah, I am sad that my bluetooth is broken again as well. I am trying 
> your patch now to see if it gets my hardware working. Will reply back soon.
> 
> wt

This patch does not fix the problem. The first broken commit is 
9a15ce685706e73154. This patch effectively reverts only one part of that 
patch.

FTR, I applied this patch on top of the parent commit of the first 
broken commit. I will try it on the tip of mainline as well.

wt

-- 
You're more amazing than you think!

