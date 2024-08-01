Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F611581FC
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498804; cv=none; b=qz9XHh8b8kYzQWIuD7oVjDG4YUPQZoVHARRS3b4sXRFXWpXbhWvmVgEWTRmAgXjwHPwR2u+hSyWNO+nZPQZPGTuUfYDhv0ambsDwywLry4qwvgkXC8z6ODCXa0xpYdTTfQRMALc5ZlNC2l9mOEWA2SUP3UdPU2U9lYKCXp59914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498804; c=relaxed/simple;
	bh=1vMAoAs0mZsaXqJKrSidydDhDckA/Xhiuk4iUkA+y3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VATFjq+5cXGTTtdrXCu4Be7v2h49Z+VaFDVNSo+X2UWpTeRcQk/jl4hrPpG3QaVlCKdMAOgToQaQT6Rbp3vUaynV4tKir3XPUWTJF8t1nc8M55bzQ6FT/2p2juFHU69ufxsR5Go8pp3TG1HfoYl1Egk6k4yRZxxxbxr76jyK69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=evGYxoMu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="evGYxoMu"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d150e8153so1263330b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 00:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722498802; x=1723103602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGB/2XQq/7ZCXGPIPBVqSmNziWCjEOy2DmhtcCr21Vk=;
        b=evGYxoMu3OMIr+StLNJhHwMgjmq2bago84sI9urZp7BBHvRvEyZluULCuDOFKfH241
         w6GTtx6FBH57I8cfY/Q08g13SXV/t3iDkrWpH5nWViGZ7gYln17vydHyAv9LKKZADiSQ
         OD+ugJv52iM5ow/5qLJ1X7HF8UVGJ/CbNnDEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722498802; x=1723103602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGB/2XQq/7ZCXGPIPBVqSmNziWCjEOy2DmhtcCr21Vk=;
        b=C0go+OjtNqqSbPMr8dU8/6y71lQ/uwj5jH6adWAmOAHUdqqh2hu+/bCGIw599nQODB
         X62Y22CL/GZ+kzLnX2ymB/kPP4mw9y3TSFUllRhRW4soqwLA3r7OOoN48HgxGnVlB2A5
         /Cgx2S4X2bgs2/gvQY7iglS6YenSH2juJ+TiaPCE52T8T+LASYV6h9ZDepJfCd6gxz9v
         xRD1YN+ulYaRbQxpY7S31XKvohEOKrHZDNpj+dbRWtSkP27dpQ+rlwGUwLRdXFNhzn12
         JIiHx8CHu9p7gQs0Avu4ymymn4PNtZ+pF75SNbjwSc7vzQhlMZXMSTlDaR0NN0MR5l+Y
         bPQA==
X-Gm-Message-State: AOJu0YzTjAqCrK2aTcbd54yavKXf9tfvxuKUSMsYV9jFE+voI8X3iXY9
	tsgQVonegTnMvc6cFkf7Sr9Nx0q9XdMz75kmboYGtFGGSW1nbT3hfa7p0OGkow==
X-Google-Smtp-Source: AGHT+IFmZgorEuoJtBDUjF73dk7CdEGsO2rlcI03MN5SDR9x3EtpO2YEO0tLSB0swdVkb18+aia+GQ==
X-Received: by 2002:a05:6a00:1302:b0:70d:26cd:9741 with SMTP id d2e1a72fcca58-71065ec3947mr891818b3a.12.1722498801831;
        Thu, 01 Aug 2024 00:53:21 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead715733sm10977195b3a.84.2024.08.01.00.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 00:53:21 -0700 (PDT)
Message-ID: <9fd98bc2-d19a-4ad2-9f0a-02baae89ac08@penguintechs.org>
Date: Thu, 1 Aug 2024 00:53:19 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
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
 <1ff58133-7322-47fc-b3db-6fe4a697aefe@penguintechs.org>
 <7e447839-4976-4d3b-aee5-c0961637deb5@penguintechs.org>
 <3996ac6a-4b9b-4049-83e7-530eb49616de@icloud.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <3996ac6a-4b9b-4049-83e7-530eb49616de@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Zijun,

On 7/30/24 6:28 PM, Zijun Hu wrote:
> On 2024/7/31 04:12, Wren Turkal wrote:
>> Zijun,
>>
>> On 7/30/24 12:48 PM, Wren Turkal wrote:
>>> Zijun,
>>>
>>> On 7/30/24 12:26 PM, Wren Turkal wrote:
>>>> On 7/29/24 9:25 AM, Zijun Hu wrote:
>>>>> On 2024/7/27 03:25, Wren Turkal wrote:
>>>>>> On 7/26/24 11:52 AM, Wren Turkal wrote:
>>>>>>> On 7/25/24 1:47 PM, Wren Turkal wrote:
>>>>>>>> On 7/25/24 1:35 PM, Luiz Augusto von Dentz wrote:
>>>>>>>>> Hi Wren,
>>>>>>>>>
>>>>>>>>> On Thu, Jul 25, 2024 at 2:35 PM Wren Turkal <wt@penguintechs.org>
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> Hello BT folks,
>>>>>>>>>>
>>>>>>>>>> Just so y'all know, the QCA6390 bluetooth hardware appears to be
>>>>>>>>>> broken
>>>>>>>>>> at least since commit 720261cfc732.
>>>>>>>>>>
>>>>>>>>>> The KDE and Gnome bluetooth control panels appear to think
>>>>>>>>>> there is no
>>>>>>>>>> bluetooth hardware. Rolling back to 6.10 appear to function.
>>>>>>>>>>
>>>>>>>>>> I have a Dell XPS13 9310.
>>>>>>>>>>
>>>>>>>>>> I will attempt to capture some kernel logs in a bit.
>>>>>>>>>
>>>>>>>>> git show 720261cfc732
>>>>>>>>> fatal: ambiguous argument '720261cfc732': unknown revision or
>>>>>>>>> path not
>>>>>>>>> in the working tree.
>>>>>>>>
>>>>>>>> I gave you the sha for the built fedora rawhide kernel package,
>>>>>>>> not a
>>>>>>>> mainline sha. Sorry about that. I thought it was a mainline sha.
>>>>>>>> I am
>>>>>>>> trying to bisect the problem. Hopefully, I can get a mainline git
>>>>>>>> sha
>>>>>>>> for you soon.
>>>>>>>>
>>>>>>>> If it helps, the build date of the kernel is 2024-07-19.
>>>>>>>>
>>>>>>>> Sorry about the confusion. Hope this helps track down the problem.
>>>>>>>
>>>>>>> I have managed to get the following commit id range for the issue:
>>>>>>> 80ab5445da6235..e2f710f97f35
>>>>>>
>>>>>> Narrowed to 80ab5445da6235..586f14a6a182
>>>>>>
>>>>> i feel a little sad that QCA6390 of your machine are broken again.
>>>>> i find out a doubtful point by checking recent changes.
>>>>>
>>>>> you maybe have a attempt for below change if you would like to do that.
>>>>> https://patchwork.kernel.org/project/bluetooth/patch/20240730-
>>>>> qca6390_fix-v1-1-e0340a511756@icloud.com/
>>>>>
>>>>> thanks
>>>>>
>>>>>
>>>>
>>>> Yeah, I am sad that my bluetooth is broken again as well. I am trying
>>>> your patch now to see if it gets my hardware working. Will reply back
>>>> soon.
>>>>
>>>> wt
>>>
>>> This patch does not fix the problem. The first broken commit is
>>> 9a15ce685706e73154. This patch effectively reverts only one part of
>>> that patch.
>>>
>>> FTR, I applied this patch on top of the parent commit of the first
>>> broken commit. I will try it on the tip of mainline as well.
>>
>> This patch doesn't appear to apply cleanly to the current tip of
>> bluetooth-next/master, so I can't really go further in testing it right
>> now.
>>
> 
> my aim is to known which commit cause this issue ASAP since i very care
> about QCA6390, now i got it, so don't need any further actions any more.
> 
>> Also, so you know, Bartosz has said that he is aware of the regression
>> and is working on it.
>>
> 
> i did not notice above info before my last reply, i did not see such
> info in this discussion thread until your reply as well.
> 
> BTW, you maybe add relevant link if you are referring something from
> another discussion thread.

The discussion was in a another branch on this thread. I think I added 
you to the discussion there.

>> Zijun, you should talk the folks at qualcomm and see if there is any
>> appetite for getting closer to the Linaro folks with regard to this
>> stuff. You have been very eager to jump in, and I see that Bartosz and
>> Luis also seem interested in fixing this. I do wonder if there a way to
>> take advantage of that to build a better working relationship in this
>> bluetooth space with qualcomm and the linux kernel devs.
>>
> 
> you maybe ignore that all my reply come from icloud.com, so you maybe
> not associate it with qualcomm, it is the first time for icloud.com to
> join BT relevant discussion. (^^)

I'm sorry. I didn't realize you weren't associated with Qualcomm here. 
Apologies.

>> If qualcomm would be interested in hiring a tech person to help with
>> this stuff. I am definitely interested in helping in this area.
>>
>> Thanks,
>> wt
> 

-- 
You're more amazing than you think!

